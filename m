From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/20] branch.c: use ref transaction for all ref updates
Date: Tue, 26 Aug 2014 17:32:42 -0700
Message-ID: <20140827003242.GK20185@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140826000354.GW20185@google.com>
 <xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
 <20140826221448.GY20185@google.com>
 <20140827002804.GA20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 02:32:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMRAR-0006YL-HQ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 02:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287AbaH0Acr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 20:32:47 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:44919 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756270AbaH0Acr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 20:32:47 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so23743402pdb.13
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 17:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Q1So+RO0JSm1QpzGbFZ89jJeJ4sxeeTK2U7iff4I9oI=;
        b=E+pr4OSRKmnbTLWLSIE9cCMO61fUlRMxV5BmPFs61ltBycq/BvgEnk8upYuAhuY6Mp
         kGUpsIuxNoXesN26WFtJHz1CeFsg4HjTKVMW5GP1xwg2utuy5lsYZDZqZFTjwJfuY1PL
         S+7sbV/06I80VlDaz/Ar0GtOIwVDmIq1sD5NXYi4IyiYiUfc9F5Ch+whhFf/SxFeWxGx
         ywYsm2GfWJ3WEavt5kEAZWAFakD9J841Uq/v9YDaLoKuvsWHS9huQLb2kgqiyTx0lLfg
         VlRjiQ2kr9902JdK/OvjFov8VJ2+INLmIPx0iQ+agHo3q14RCJcSnaPuFoVa/4nwBlNt
         8HLQ==
X-Received: by 10.69.20.97 with SMTP id hb1mr23254789pbd.150.1409099566726;
        Tue, 26 Aug 2014 17:32:46 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:4ba:9bd4:148:77e4])
        by mx.google.com with ESMTPSA id hp1sm4472509pbb.77.2014.08.26.17.32.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 17:32:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140827002804.GA20185@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255966>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 16 Apr 2014 16:21:53 -0700

Change create_branch to use a ref transaction when creating the new branch.

This also fixes a race condition in the old code where two concurrent
create_branch could race since the lock_any_ref_for_update/write_ref_sha1
did not protect against the ref already existing. I.e. one thread could end up
overwriting a branch even if the forcing flag is false.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 branch.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/branch.c b/branch.c
index 660097b..37ac555 100644
--- a/branch.c
+++ b/branch.c
@@ -226,7 +226,6 @@ void create_branch(const char *head,
 		   int force, int reflog, int clobber_head,
 		   int quiet, enum branch_track track)
 {
-	struct ref_lock *lock = NULL;
 	struct commit *commit;
 	unsigned char sha1[20];
 	char *real_ref, msg[PATH_MAX + 20];
@@ -285,15 +284,6 @@ void create_branch(const char *head,
 		die(_("Not a valid branch point: '%s'."), start_name);
 	hashcpy(sha1, commit->object.sha1);
 
-	if (!dont_change_ref) {
-		lock = lock_any_ref_for_update(ref.buf, NULL, 0, NULL);
-		if (!lock)
-			die_errno(_("Failed to lock ref for update"));
-	}
-
-	if (reflog)
-		log_all_ref_updates = 1;
-
 	if (forcing)
 		snprintf(msg, sizeof msg, "branch: Reset to %s",
 			 start_name);
@@ -301,13 +291,26 @@ void create_branch(const char *head,
 		snprintf(msg, sizeof msg, "branch: Created from %s",
 			 start_name);
 
+	if (reflog)
+		log_all_ref_updates = 1;
+
+	if (!dont_change_ref) {
+		struct ref_transaction *transaction;
+		struct strbuf err = STRBUF_INIT;
+
+		transaction = ref_transaction_begin(&err);
+		if (!transaction ||
+		    ref_transaction_update(transaction, ref.buf, sha1,
+					   null_sha1, 0, !forcing, &err) ||
+		    ref_transaction_commit(transaction, msg, &err))
+			die("%s", err.buf);
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
+	}
+
 	if (real_ref && track)
 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
-	if (!dont_change_ref)
-		if (write_ref_sha1(lock, sha1, msg) < 0)
-			die_errno(_("Failed to write ref"));
-
 	strbuf_release(&ref);
 	free(real_ref);
 }
-- 
2.1.0.rc2.206.gedb03e5
