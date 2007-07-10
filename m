From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Add for_each_remote() function, and extend remote_find_tracking()
Date: Tue, 10 Jul 2007 04:02:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707100401070.4131@racer.site>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
 <7vhcof2rur.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707081336020.4248@racer.site>
 <7vzm2620wp.fsf@assigned-by-dhcp.cox.net> <46919692.5020708@gnu.org>
 <7vhcoexqeh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707091228290.5546@racer.site>
 <7v4pkduw2f.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707092203100.5546@racer.site>
 <7vzm25tex6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 05:09:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I866k-0001Yx-KW
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 05:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761660AbXGJDJn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 23:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760874AbXGJDJn
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 23:09:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:35566 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760983AbXGJDJm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 23:09:42 -0400
Received: (qmail invoked by alias); 10 Jul 2007 03:09:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 10 Jul 2007 05:09:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18HBPQf4wEHzH8Zfb2MKUiTWasCXcJ92+WyCu2viY
	VLVi/tVTF4rUGP
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzm25tex6.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52034>


The function for_each_remote() does exactly what the name suggests.

The function remote_find_tracking() was extended to be able to search
remote refs for a given local ref.  You have to set the parameter
"reverse" to true for that behavior.

Both changes are required for the next step: simplification of
git-branch's --track functionality.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	You're right. I completely missed that functionality. Well, a
	few tweaks were needed. If this clashes too seriously with
	Daniel's work, I will gladly redo it after his changes are
	in "next".

 remote.c    |   42 ++++++++++++++++++++++++++++++++----------
 remote.h    |    7 ++++++-
 send-pack.c |    3 +--
 3 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/remote.c b/remote.c
index cf98a44..21adb0d 100644
--- a/remote.c
+++ b/remote.c
@@ -279,6 +279,26 @@ struct remote *remote_get(const char *name)
 	return ret;
 }
 
+int for_each_remote(each_remote_fn fn, void *priv)
+{
+	int i, result = 0;
+	read_config();
+	for (i = 0; i < allocated_remotes; i++) {
+		struct remote *r = remotes[i];
+		if (!r)
+			continue;
+		if (!r->fetch)
+			r->fetch = parse_ref_spec(r->fetch_refspec_nr,
+					r->fetch_refspec);
+		if (!r->push)
+			r->push = parse_ref_spec(r->push_refspec_nr,
+					r->push_refspec);
+		if ((result = fn(r, priv)))
+			break;
+	}
+	return result;
+}
+
 int remote_has_uri(struct remote *remote, const char *uri)
 {
 	int i;
@@ -289,34 +309,36 @@ int remote_has_uri(struct remote *remote, const char *uri)
 	return 0;
 }
 
-int remote_find_tracking(struct remote *remote, struct refspec *refspec)
+int remote_find_tracking(struct remote *remote, struct refspec *refspec,
+		int reverse)
 {
 	int i;
 	for (i = 0; i < remote->fetch_refspec_nr; i++) {
 		struct refspec *fetch = &remote->fetch[i];
+		const char *src = reverse ? fetch->dst : fetch->src;
+		const char *dst = reverse ? fetch->src : fetch->dst;
 		if (!fetch->dst)
 			continue;
 		if (fetch->pattern) {
-			if (!prefixcmp(refspec->src, fetch->src)) {
+			if (!prefixcmp(refspec->src, src)) {
 				refspec->dst =
-					xmalloc(strlen(fetch->dst) +
+					xmalloc(strlen(dst) +
 						strlen(refspec->src) -
-						strlen(fetch->src) + 1);
-				strcpy(refspec->dst, fetch->dst);
-				strcpy(refspec->dst + strlen(fetch->dst),
-				       refspec->src + strlen(fetch->src));
+						strlen(src) + 1);
+				strcpy(refspec->dst, dst);
+				strcpy(refspec->dst + strlen(dst),
+				       refspec->src + strlen(src));
 				refspec->force = fetch->force;
 				return 0;
 			}
 		} else {
-			if (!strcmp(refspec->src, fetch->src)) {
-				refspec->dst = xstrdup(fetch->dst);
+			if (!strcmp(refspec->src, src)) {
+				refspec->dst = xstrdup(dst);
 				refspec->force = fetch->force;
 				return 0;
 			}
 		}
 	}
-	refspec->dst = NULL;
 	return -1;
 }
 
diff --git a/remote.h b/remote.h
index 01dbcef..9ab7eb6 100644
--- a/remote.h
+++ b/remote.h
@@ -20,6 +20,9 @@ struct remote {
 
 struct remote *remote_get(const char *name);
 
+typedef int each_remote_fn(struct remote *remote, void *priv);
+int for_each_remote(each_remote_fn fn, void *priv);
+
 int remote_has_uri(struct remote *remote, const char *uri);
 
 struct refspec {
@@ -35,7 +38,9 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 
 /*
  * For the given remote, reads the refspec's src and sets the other fields.
+ * If reverse is 1, the given src is the local ref, and we want the remote.
  */
-int remote_find_tracking(struct remote *remote, struct refspec *refspec);
+int remote_find_tracking(struct remote *remote, struct refspec *refspec,
+	int reverse);
 
 #endif
diff --git a/send-pack.c b/send-pack.c
index fecbda9..9fdd7b4 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -305,8 +305,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 		if (remote) {
 			struct refspec rs;
 			rs.src = ref->name;
-			remote_find_tracking(remote, &rs);
-			if (rs.dst) {
+			if (!remote_find_tracking(remote, &rs, 0)) {
 				struct ref_lock *lock;
 				fprintf(stderr, " Also local %s\n", rs.dst);
 				if (will_delete_ref) {
-- 
1.5.3.rc0.2769.gd9be2
