From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] teach diff machinery about --ignore-space-at-eol
Date: Wed, 14 Feb 2007 01:30:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702140125410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45D234C5.5090005@freescale.com> <7vhctpwvam.fsf@assigned-by-dhcp.cox.net>
 <45D23D68.6040004@freescale.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 01:30:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH82c-0000o5-Qk
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 01:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbXBNAac (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 19:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbXBNAab
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 19:30:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:32875 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751463AbXBNAab (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 19:30:31 -0500
Received: (qmail invoked by alias); 14 Feb 2007 00:30:29 -0000
X-Provags-ID: V01U2FsdGVkX1+IS4YwCKaIB5ydC1DrMvPovKZKl3yeH1GsPq243V
	afRg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45D23D68.6040004@freescale.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39602>


`git diff --ignore-space-at-eol` will ignore whitespace at the
line ends.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Tue, 13 Feb 2007, Timur Tabi wrote:
	
	> Junio C Hamano wrote:
	> 
	> > You could revert the change to the editor configuration and 
	> > rely on "git diff" before committing to point out the 
	> > whitespace breakage that you newly introduced to the file.  
	> > Then you would be sending out exactly what you changed.
	> 
	> Thanks, but I was hoping that git would make my life easier, not 
	> more difficult.

	Strictly speaking, you made life difficult on git by asking your 
	editor to edit text it should not edit.

	However, this was a nice late-night exercise.

 diff.c         |    2 ++
 xdiff/xdiff.h  |    3 ++-
 xdiff/xutils.c |   24 ++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index d712181..815a7a8 100644
--- a/diff.c
+++ b/diff.c
@@ -2059,6 +2059,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->xdl_opts |= XDF_IGNORE_WHITESPACE;
 	else if (!strcmp(arg, "-b") || !strcmp(arg, "--ignore-space-change"))
 		options->xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
+	else if (!strcmp(arg, "--ignore-space-at-eol"))
+		options->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
 	else if (!strcmp(arg, "--color-words"))
 		options->color_diff = options->color_diff_words = 1;
 	else if (!strcmp(arg, "--no-renames"))
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index fa409d5..e874a7c 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -31,7 +31,8 @@ extern "C" {
 #define XDF_NEED_MINIMAL (1 << 1)
 #define XDF_IGNORE_WHITESPACE (1 << 2)
 #define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
-#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE)
+#define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
+#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
 
 #define XDL_PATCH_NORMAL '-'
 #define XDL_PATCH_REVERSE '+'
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 1b899f3..3653864 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -215,6 +215,21 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 				return 0;
 		}
 		return (i1 >= s1 && i2 >= s2);
+	} else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL) {
+		for (i1 = i2 = 0; i1 < s1 && i2 < s2; ) {
+			if (l1[i1] != l2[i2]) {
+				while (i1 < s1 && isspace(l1[i1]))
+					i1++;
+				while (i2 < s2 && isspace(l2[i2]))
+					i2++;
+				if (i1 < s1 || i2 < s2)
+					return 0;
+				return 1;
+			}
+			i1++;
+			i2++;
+		}
+		return i1 >= s1 && i2 >= s2;
 	} else
 		return s1 == s2 && !memcmp(l1, l2, s1);
 
@@ -227,6 +242,7 @@ unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
 
 	for (; ptr < top && *ptr != '\n'; ptr++) {
 		if (isspace(*ptr) && (flags & XDF_WHITESPACE_FLAGS)) {
+			const char *ptr2 = ptr;
 			while (ptr + 1 < top && isspace(ptr[1])
 					&& ptr[1] != '\n')
 				ptr++;
@@ -235,6 +251,14 @@ unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
 				ha += (ha << 5);
 				ha ^= (unsigned long) ' ';
 			}
+			if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
+					&& ptr[1] != '\n') {
+				while (ptr2 != ptr + 1) {
+					ha += (ha << 5);
+					ha ^= (unsigned long) *ptr2;
+					ptr2++;
+				}
+			}
 			continue;
 		}
 		ha += (ha << 5);
