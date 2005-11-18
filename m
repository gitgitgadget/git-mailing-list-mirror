From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Deal with binary diff output from (unknown version of) diff
Date: Thu, 17 Nov 2005 20:46:29 -0800
Message-ID: <7v1x1er2ai.fsf_-_@assigned-by-dhcp.cox.net>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
	<b0943d9e0511160311k725526d8v@mail.gmail.com>
	<7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
	<7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
	<81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>
	<7vy83ny450.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0511170236r28572db9i84dc271700ded79a@mail.gmail.com>
	<7vwtj7wn7n.fsf@assigned-by-dhcp.cox.net> <437D2D14.5080205@gmail.com>
	<7vfypur5jb.fsf@assigned-by-dhcp.cox.net> <437D4F57.9070303@gmail.com>
	<7vbr0ir387.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 05:48:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecy8x-0005fo-1Y
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 05:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbVKREqc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 23:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbVKREqc
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 23:46:32 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:46800 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751446AbVKREqc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 23:46:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118044601.LJYL20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 23:46:01 -0500
To: A Large Angry SCM <gitzilla@gmail.com>,
	John Benes <smartcat99s@gmail.com>
In-Reply-To: <7vbr0ir387.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 17 Nov 2005 20:26:16 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12198>

Some vintage of diff says just "Files X and Y differ\n", instead
of "Binary files X and Y differ\n", so catch both patterns.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

    Junio C Hamano <junkio@cox.net> writes:

    >> Files /dev/null and b/file3 differ
    >> diff --git a/file4 b/file4
    >> index edc575d..adb07b7 100644
    >> Files a/file4 and b/file4 differ
    >
    > Thanks.  I've seen enough.  I expected diff (GNU diffutils 2.8.1
    > is what I have handy) output which says "Binary files a/foo and
    > b/foo differ".
    >
    > Hmph.  Now I'd need to find a way to catch at least these two
    > cases...

    Could you two try this patch please?

diff --git a/apply.c b/apply.c
index 129edb1..50be8f3 100644
--- a/apply.c
+++ b/apply.c
@@ -893,12 +893,24 @@ static int parse_chunk(char *buffer, uns
 	patchsize = parse_single_patch(buffer + offset + hdrsize, size - offset - hdrsize, patch);
 
 	if (!patchsize) {
-		static const char binhdr[] = "Binary files ";
-
-		if (sizeof(binhdr) - 1 < size - offset - hdrsize &&
-		    !memcmp(binhdr, buffer + hdrsize + offset,
-			    sizeof(binhdr)-1))
-			patch->is_binary = 1;
+		static const char *binhdr[] = {
+			"Binary files ",
+			"Files ",
+			NULL,
+		};
+		int i;
+		int hd = hdrsize + offset;
+		unsigned long llen = linelen(buffer + hd, size - hd);
+
+		if (!memcmp(" differ\n", buffer + hd + llen - 8, 8))
+			for (i = 0; binhdr[i]; i++) {
+				int len = strlen(binhdr[i]);
+				if (len < size - hd &&
+				    !memcmp(binhdr[i], buffer + hd, len)) {
+					patch->is_binary = 1;
+					break;
+				}
+			}
 
 		/* Empty patch cannot be applied if:
 		 * - it is a binary patch and we do not do binary_replace, or
