From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/22] receive-pack.c: use a reference transaction for
 updating the refs
Date: Tue, 2 Sep 2014 14:05:25 -0700
Message-ID: <20140902210525.GM18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140826000354.GW20185@google.com>
 <xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
 <20140826221448.GY20185@google.com>
 <20140827002804.GA20185@google.com>
 <20140902205841.GA18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 23:05:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvGf-0003nB-JX
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230AbaIBVFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:05:30 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:45139 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042AbaIBVF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:05:29 -0400
Received: by mail-pa0-f49.google.com with SMTP id kq14so15484327pab.22
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 14:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/e3/r1EvkPrQht1YRvW0YxEeEIt27OfbO4+UONASHHI=;
        b=fznqVeb0jvlF8/fbOCmzqLRAz65tOdpy9TRZo4h7Rt0+CmVrY+WYXvMnG9AqOWZd6Z
         hEAnH75yTexrheIhxjRk/wBD6RefuJLQVvkircvfA6Xk8/2W5OhZi+TcAyf+X5NICxbD
         tg58cFMYnMKsUuQel0SNAZtGXlbbrJub6vHe9vpK4k55OqT2/uSrPOJf2rNppveojvWv
         smCV+eRxNBvy/1tdVN2Oauh8EPSUBFSoVZoWRpNS6zvdsKjzGZ9+p5+vr/R5S4/FhOmY
         7Wy2GUqco9yZpgWDvxNhDLOFI6kruR712aheqCvP/TDexsZyn8TSKHMsUojSTDbemYv4
         OXMQ==
X-Received: by 10.70.128.195 with SMTP id nq3mr7606795pdb.158.1409691928853;
        Tue, 02 Sep 2014 14:05:28 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id h12sm6751618pdk.48.2014.09.02.14.05.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 14:05:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140902205841.GA18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256358>

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
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
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
