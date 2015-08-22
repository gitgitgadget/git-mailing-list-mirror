From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Fix `git rev-list --show-notes HEAD` when there are no notes
Date: Sat, 22 Aug 2015 17:14:39 +0200
Organization: gmx
Message-ID: <0LZlZ2-1Z1Zyn1mzk-00lZ3Z@mail.gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 22 17:14:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTAVP-0003w1-Eg
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 17:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbbHVPOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2015 11:14:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:64685 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455AbbHVPOq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 11:14:46 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Li1hG-1YynlD1lvm-00nC9P; Sat, 22 Aug 2015 17:14:41
 +0200
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:PyROnUDR5hKt+MQvfc1dBVvnEMteomp2Gd+h+eYm2kXIjgYJOXC
 NyImR8fORR1F8T6ZGLpHJUR1ZczzD1G3wCNA1dc+N0Di85jruMh26Qs5MT+87nElmLU400m
 RTi9JJBCqe/iz4CqOvuPUcFcJ+9suA16c+zwcM37hZRJn9TVzwF4WjNpbQGh8rOkW2OdQso
 GzsK7T5JrMur14KPFQntA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XvrHceNO7dA=:hiBzNBnIg6AiP5K7+rvq3e
 MD2N0xvAcOCvPug6JhQN48BtNP8xbHEVjInsyD5W6vjZ6jWr9CxCeCpbD/AkLJyPfIRrH4Q63
 Zz36jyjaPaxegR7NeHk23YqSvivJIXrA52+k5/LOlP9g28/xx+j99O7nWTbJGht/6aNh5xOSY
 4Os3AULFWDCMxw1RvCBQdzsOM1kJPVg1wurBvKrIaA8Eur4Q3o8l6dxuAUJa/zvno1jo6JPi5
 9TXgQwl8QvJZYYlqRx9cwGt628lCgpI1RPEWRV0GVseZUmII4Ek/Skv28Kymy+DbUE1eNfHNq
 dlbxSapipFnm4qczfWebURuPxSw+SxYk91gK8OPzAhlU8abSZhO2kt2ex0gWN4w3Vf4VWN92I
 bV50pWixl3ezN/xqURfgsZ0Btf4go+H9gHfYW3YSHS/+Quaecf8meIyhVDscrymka0EgS7nxU
 2j9SqEMIMX0jHTx/Elw2hg7ge2hH/oYVAajJEaCbbqfx7ayqVLqtC4xFXUgOAxTdf7tIOY7kb
 PlM2kHgDRnGVOWe3vUvGuN4KGZaShNsTgF4pTMzThF03JR1C/4Jt6CtlaSub8Ndk4YiCspe6Z
 iBxY3VKbUC//h5DfiJ6qmL3xi3xLy9ukSypguUfjACSK1kxqQZskxm5Zxj+Mgw32w/Qm9zfO8
 /cprt39HkHRTY8UMu9q6WevNtAVk69ipspZsAyYeQUL5aEzkmP92zL15CVszYBY1+KL4pkJf0
 efNC3s1EMgMO7rf/b+bFGqmW3/Wp85HHatssVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276389>

The `format_display_notes()` function clearly assumes that the data
structure holding the notes has been initialized already, i.e. that the
`display_notes_trees` variable is no longer `NULL`.

However, when there are no notes whatsoever, this variable is still
`NULL`, even after initialization.

So let's be graceful and just return if that data structure is `NULL`.

Reported in https://github.com/msysgit/git/issues/363.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 notes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/notes.c b/notes.c
index df08209..24a335a 100644
--- a/notes.c
+++ b/notes.c
@@ -1266,7 +1266,10 @@ void format_display_notes(const unsigned char *object_sha1,
 			  struct strbuf *sb, const char *output_encoding, int raw)
 {
 	int i;
-	assert(display_notes_trees);
+
+	if (!display_notes_trees)
+		return;
+
 	for (i = 0; display_notes_trees[i]; i++)
 		format_note(display_notes_trees[i], object_sha1, sb,
 			    output_encoding, raw);
-- 
2.3.1.windows.1.9.g8c01ab4
