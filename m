From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Show peeled onion from upload-pack and server-info.
Date: Thu, 13 Oct 2005 23:03:53 -0700
Message-ID: <7v7jcgws6u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 14 08:04:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQIfm-0003RF-2c
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 08:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVJNGD4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 02:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVJNGD4
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 02:03:56 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:58066 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932207AbVJNGDz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 02:03:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051014060346.KSVL19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Oct 2005 02:03:46 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10099>

This updates git-ls-remote to show SHA1 names of objects that are
referred by tags, in the "ref^{}" notation.

This would make git-findtags (without -t flag) almost trivial.

    git-peek-remote . |
    sed -ne "s:^$target	"'refs/tags/\(.*\)^{}$:\1:p'

Also Pasky could do:

    git-ls-remote --tags $remote |
    sed -ne 's:\(	refs/tags/.*\)^{}$:\1:p'

to find out what object each of the remote tags refers to, and
if he has one locally, run "git-fetch $remote tag $tagname" to
automatically catch up with the upstream tags.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-fetch.sh  |    1 +
 server-info.c |    7 +++++++
 upload-pack.c |    8 ++++++++
 3 files changed, 16 insertions(+), 0 deletions(-)

applies-to: e03d0f32f8566817f50156b0c91972620b0f48fa
d6cc99156c5877a8d43df75b9f55a055f4d35e02
diff --git a/git-fetch.sh b/git-fetch.sh
index 7c05880..0cb1596 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -176,6 +176,7 @@ if test "$tags"
 then
 	taglist=$(git-ls-remote --tags "$remote" |
 		sed -e '
+			/\^{}$/d
 			s/^[^	]*	//
 			s/.*/&:&/')
 	if test "$#" -gt 1
diff --git a/server-info.c b/server-info.c
index 3c08a28..ba53591 100644
--- a/server-info.c
+++ b/server-info.c
@@ -9,7 +9,14 @@ static FILE *info_ref_fp;
 
 static int add_info_ref(const char *path, const unsigned char *sha1)
 {
+	struct object *o = parse_object(sha1);
+
 	fprintf(info_ref_fp, "%s	%s\n", sha1_to_hex(sha1), path);
+	if (o->type == tag_type) {
+		o = deref_tag(o);
+		fprintf(info_ref_fp, "%s	%s^{}\n",
+			sha1_to_hex(o->sha1), path);
+	}
 	return 0;
 }
 
diff --git a/upload-pack.c b/upload-pack.c
index 83f5a35..21b4b8b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "refs.h"
 #include "pkt-line.h"
+#include "tag.h"
+#include "object.h"
 
 static const char upload_pack_usage[] = "git-upload-pack <dir>";
 
@@ -165,7 +167,13 @@ static int receive_needs(void)
 
 static int send_ref(const char *refname, const unsigned char *sha1)
 {
+	struct object *o = parse_object(sha1);
+
 	packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname);
+	if (o->type == tag_type) {
+		o = deref_tag(o);
+		packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname);
+	}
 	return 0;
 }
 
---
@@GIT_VERSION@@
