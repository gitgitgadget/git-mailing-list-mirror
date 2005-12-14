From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Make git-send-pack exit with error when some refs couldn't be pushed out
Date: Wed, 14 Dec 2005 01:45:40 +0100
Message-ID: <20051214004540.15040.93518.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 01:47:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmKmJ-0006FV-AV
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 01:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbVLNApn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 19:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbVLNApn
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 19:45:43 -0500
Received: from w241.dkm.cz ([62.24.88.241]:7314 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030265AbVLNApn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 19:45:43 -0500
Received: (qmail 15058 invoked from network); 14 Dec 2005 01:45:40 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 14 Dec 2005 01:45:40 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13608>

In case some refs couldn't be pushed out due to an error (mostly the
not-a-proper-subset error), make git-send-pack exit with non-zero status
after the push is over (that is, it still tries to push out the rest
of the refs).

Cogito (0.17pre only, 0.16 is unaffected) needs to know that the push
failed so that it won't update its remote branch head pointer - otherwise
it gets out of sync, which can lead even to loss of commits on the local
side (this happenned to Jonas Fonseca - thanks for the report, BTW).
I sort of expected that git-send-pack would return an error in case
of a failure, so just applying this should magically fix Cogito.

I don't insist on this particular solution though - a fetch-pack-alike
approach where I get the list of changed refs on stdout is fine too
(currently I get something on stderr, but I'm reluctant to grab stderr
of GIT commands and try to heuristically mangle it).

At any rate, please consider this a major problem from Cogito perspective.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 send-pack.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index f61c15c..6ce0d9f 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -179,6 +179,7 @@ static int send_pack(int in, int out, in
 {
 	struct ref *ref;
 	int new_refs;
+	int ret = 0;
 
 	/* No funny business with the matcher */
 	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, 1);
@@ -232,6 +233,7 @@ static int send_pack(int in, int out, in
 				error("remote '%s' object %s does not "
 				      "exist on local",
 				      ref->name, sha1_to_hex(ref->old_sha1));
+				ret = -2;
 				continue;
 			}
 
@@ -245,12 +247,14 @@ static int send_pack(int in, int out, in
 				error("remote ref '%s' is not a strict "
 				      "subset of local ref '%s'.", ref->name,
 				      ref->peer_ref->name);
+				ret = -2;
 				continue;
 			}
 		}
 		memcpy(ref->new_sha1, ref->peer_ref->new_sha1, 20);
 		if (is_zero_sha1(ref->new_sha1)) {
 			error("cannot happen anymore");
+			ret = -3;
 			continue;
 		}
 		new_refs++;
@@ -267,7 +271,7 @@ static int send_pack(int in, int out, in
 	if (new_refs)
 		pack_objects(out, remote_refs);
 	close(out);
-	return 0;
+	return ret;
 }
 
 
