From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/20] receive-pack.c: use a reference transaction for
 updating the refs
Date: Tue, 26 Aug 2014 17:33:28 -0700
Message-ID: <20140827003328.GM20185@google.com>
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
X-From: git-owner@vger.kernel.org Wed Aug 27 02:33:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMRBC-0006pV-DG
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 02:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904AbaH0Ade (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 20:33:34 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:42733 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318AbaH0Ade (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 20:33:34 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so24466150pab.28
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 17:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7eXPFideNsxFiRJkhcTkD1r54KaGxZwgUwDFBFYGHqo=;
        b=IWtdHIasoPciKtlnS1CpGKEMC8umo13Dr9dcGsBO/b0DdSNQqyID0C4rFUS9pHwzov
         s0n/4YD5Nm+1X6mPQOmFDjcooB7rczztlGlnmeMhMUcwAcJ2FpEfVE6Y2XkLdhX37Wrn
         4Qn4ld+4x/4Zx34ZeAwa1eT/ECtVCQMKQ8U0jPGa9efNTOyEeTf8gLzRWcgNsC8geMMo
         a7n3F5TR5SlgJvLutnDMHw/AtliLetHKAj/aQKtkwVSSmRKJTYX47iCHH6q2W01KLOj+
         +yYwgeJKM31fnBEc5fGWUG9iryhkr3aYL31+g15E8pxhTns9/5yVY8Cq9VlJvhTKlvmm
         eYHg==
X-Received: by 10.66.161.41 with SMTP id xp9mr24767589pab.120.1409099613794;
        Tue, 26 Aug 2014 17:33:33 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:4ba:9bd4:148:77e4])
        by mx.google.com with ESMTPSA id k1sm6960074pdj.8.2014.08.26.17.33.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 17:33:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140827002804.GA20185@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255968>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Mon, 28 Apr 2014 14:36:15 -0700

Wrap all the ref updates inside a transaction.

In the new API there is no distinction between failure to lock and
failure to write a ref.  Both can be permanent (e.g., a ref
"refs/heads/topic" is blocking creation of the lock file
"refs/heads/topic/1.lock") or transient (e.g., file system full) and
there's no clear difference in how the client should respond, so
replace the two statuses "failed to lock" and "failed to write" with
a single status "failed to update ref".  In both cases a more
detailed message is sent by sideband to diagnose the problem.

Example, before:

 error: there are still refs under 'refs/heads/topic'
 remote: error: failed to lock refs/heads/topic
 To foo
  ! [remote rejected] HEAD -> topic (failed to lock)

After:

 error: there are still refs under 'refs/heads/topic'
 remote: error: Cannot lock the ref 'refs/heads/topic'.
 To foo
  ! [remote rejected] HEAD -> topic (failed to update ref)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/receive-pack.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..224fadc 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -475,7 +475,6 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	const char *namespaced_name;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
-	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
@@ -576,19 +575,27 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		return NULL; /* good */
 	}
 	else {
+		struct strbuf err = STRBUF_INIT;
+		struct ref_transaction *transaction;
+
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si))
 			return "shallow error";
 
-		lock = lock_any_ref_for_update(namespaced_name, old_sha1,
-					       0, NULL);
-		if (!lock) {
-			rp_error("failed to lock %s", name);
-			return "failed to lock";
-		}
-		if (write_ref_sha1(lock, new_sha1, "push")) {
-			return "failed to write"; /* error() already called */
+		transaction = ref_transaction_begin(&err);
+		if (!transaction ||
+		    ref_transaction_update(transaction, namespaced_name,
+					   new_sha1, old_sha1, 0, 1, &err) ||
+		    ref_transaction_commit(transaction, "push", &err)) {
+			ref_transaction_free(transaction);
+
+			rp_error("%s", err.buf);
+			strbuf_release(&err);
+			return "failed to update ref";
 		}
+
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
 		return NULL; /* good */
 	}
 }
-- 
2.1.0.rc2.206.gedb03e5
