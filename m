From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] git-send-pack: don't consider branch lagging behind as errors.
Date: Thu, 19 Jun 2008 12:51:55 +0200
Message-ID: <1213872715-11182-1-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 12:53:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9HlH-0002Fc-Uu
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 12:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756439AbYFSKv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 06:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756519AbYFSKv6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 06:51:58 -0400
Received: from pan.madism.org ([88.191.52.104]:50307 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756243AbYFSKv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 06:51:57 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 5DDEA36F93;
	Thu, 19 Jun 2008 12:51:56 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5102E468C36; Thu, 19 Jun 2008 12:51:55 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc3.158.g1a80c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85469>

It's really painful to have git push error out when it's just that one of
your tracking branches isn't up to date with respect to a remote branch.

Let just add a new status: "lagging", always print it to screen when we're
lagging, but don't exit with a non 0 value, as it really alarms users.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  "lagging" is probably not a very nice name, and anyone is welcomed to use
  a better word for the concept.

  Another little glitch is that with this patch you can see:

	  $ git push
	  To {your-remote}
	   < [lagging]         {local-branch} -> {remote-branch}
	  Everything up-to-date

  The "Everything up-to-date" is slightly confusing, so maybe we should make it
  better like "Everything up-to-date or strict parent" or whatever.



 builtin-send-pack.c |   10 +++++++++-
 cache.h             |    1 +
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 8d1e7be..cfbc108 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -339,6 +339,9 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count)
 		print_ref_status('=', "[up to date]", ref,
 				ref->peer_ref, NULL);
 		break;
+	case REF_STATUS_LAGGING_BEHIND:
+		print_ref_status('<', "[lagging]", ref, ref->peer_ref, NULL);
+		break;
 	case REF_STATUS_REJECT_NONFASTFORWARD:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 				"non-fast forward");
@@ -390,6 +393,7 @@ static int refs_pushed(struct ref *ref)
 		switch(ref->status) {
 		case REF_STATUS_NONE:
 		case REF_STATUS_UPTODATE:
+		case REF_STATUS_LAGGING_BEHIND:
 			break;
 		default:
 			return 1;
@@ -568,7 +572,10 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		      || !ref_newer(new_sha1, ref->old_sha1));
 
 		if (ref->nonfastforward && !ref->force && !args.force_update) {
-			ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
+			if (ref_newer(ref->old_sha1, new_sha1))
+				ref->status = REF_STATUS_LAGGING_BEHIND;
+			else
+				ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
 			continue;
 		}
 
@@ -628,6 +635,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		switch (ref->status) {
 		case REF_STATUS_NONE:
 		case REF_STATUS_UPTODATE:
+		case REF_STATUS_LAGGING_BEHIND:
 		case REF_STATUS_OK:
 			break;
 		default:
diff --git a/cache.h b/cache.h
index 23f3b92..b9b32eb 100644
--- a/cache.h
+++ b/cache.h
@@ -673,6 +673,7 @@ struct ref {
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
 		REF_STATUS_EXPECTING_REPORT,
+		REF_STATUS_LAGGING_BEHIND,
 	} status;
 	char *remote_status;
 	struct ref *peer_ref; /* when renaming */
-- 
1.5.6.rc3.158.g1a80c.dirty
