From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Tech 'git-apply' that spaces before a tab are candidate for stripping
Date: Sat, 19 May 2007 18:44:33 +0200
Message-ID: <e5bfff550705190944y44cb57baiccb139b1d649face@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 18:44:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpS2s-0004xg-Av
	for gcvg-git@gmane.org; Sat, 19 May 2007 18:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845AbXESQoh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 12:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755669AbXESQoh
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 12:44:37 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:10117 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880AbXESQog (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 12:44:36 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1682006nza
        for <git@vger.kernel.org>; Sat, 19 May 2007 09:44:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gea9UD1lWIB2oOOQZhM9t2zdeIYv4oXj7kjAEimwCUArUNLQqv3MyLJjN0FWthIoJ2InLU+ZtwCLyqnSr9Zcw+tkvkKDX0UJyxleGGA4TySKhikA8+AtFGEkTZFAD3O3VJ888p/KBiwuLRdsRIyi3E2hEiVsiw2XwdOewexAq2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TPYR7A3wjXgp583eig0COAQb2oAbfNJ0IA3GRAeNxMqrfRX7xJimJ5CU9G7seOw4iJznN3TiAlFcKK23ruE+rib9g8DVlgSL7L1iwz0mER/mdCRTRNOSCU+Qo0zgLGKRWtL/9XjwKPkcydqgHxq8tU2MdOQL/cr3fkXRVUPfY0w=
Received: by 10.114.152.17 with SMTP id z17mr1519458wad.1179593075116;
        Sat, 19 May 2007 09:44:35 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sat, 19 May 2007 09:44:33 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47756>

Currently 'git-apply' identify as stealth space a line starting with
spaces followed by a tab.

This patch updates the algorithm to find spaces + tab also in the
middle of a line and not only at the beginning.

As example lines like

"#define MY_VALUE   \t 1"

are now identified and cleaned up if option '--whitespace=strip' is
used.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

There are a bunch of this type in current git tree.

  builtin-apply.c |   72 ++++++++++++++++++++++++++++++------------------------
 1 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index f17f838..9e82757 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1586,6 +1586,32 @@ static void remove_last_line(const char **rbuf,
int *rsize)
  	*rsize = offset + 1;
 }

+static int copy_line(char **output_ptr, const char *patch, int start, int len)
+{
+	char *output = *output_ptr;
+	int space_start = 0;
+	int i, end = start + len;
+
+	for (i = start; i < end; i++) {
+
+		char ch = patch[i];
+
+		if (ch == ' ' && !space_start)
+			space_start = i;
+
+		else if (space_start && ch != ' ') {
+			if (ch == '\t') {
+				*output_ptr = output - (i - space_start);
+				return space_start;
+			}
+			space_start = 0;
+		}
+		*output++ = ch;
+	}
+	*output_ptr = output;
+	return 0;
+}
+
 struct buffer_desc {
 	char *buffer;
 	unsigned long size;
@@ -1602,17 +1628,14 @@ static int apply_line(char *output, const char
*patch, int plen)
 	int i;
 	int add_nl_to_tail = 0;
 	int fixed = 0;
-	int last_tab_in_indent = -1;
-	int last_space_in_indent = -1;
-	int need_fix_leading_space = 0;
-	char *buf;
+	int space_start;
+	const char *old = output;

 	if ((new_whitespace != strip_whitespace) || !whitespace_error ||
 	    *patch != '+') {
 		memcpy(output, patch + 1, plen);
 		return plen;
 	}
-
 	if (1 < plen && isspace(patch[plen-1])) {
 		if (patch[plen] == '\n')
 			add_nl_to_tail = 1;
@@ -1621,44 +1644,29 @@ static int apply_line(char *output, const char
*patch, int plen)
 			plen--;
 		fixed = 1;
 	}
+	space_start = copy_line(&output, patch, 1, plen);
+	while (space_start) {

-	for (i = 1; i < plen; i++) {
-		char ch = patch[i];
-		if (ch == '\t') {
-			last_tab_in_indent = i;
-			if (0 <= last_space_in_indent)
-				need_fix_leading_space = 1;
-		}
-		else if (ch == ' ')
-			last_space_in_indent = i;
-		else
-			break;
-	}
-
-	buf = output;
-	if (need_fix_leading_space) {
-		/* between patch[1..last_tab_in_indent] strip the
-		 * funny spaces, updating them to tab as needed.
+		/* strip the funny spaces, updating them to tab as needed
+		 * strip is done one space sequence at time, until line end
 		 */
-		for (i = 1; i < last_tab_in_indent; i++, plen--) {
+		fixed = 1;
+		for (i = space_start; i < plen + 1; i++) {
+
 			char ch = patch[i];
 			if (ch != ' ')
-				*output++ = ch;
+				break;
 			else if ((i % 8) == 0)
 				*output++ = '\t';
 		}
-		fixed = 1;
-		i = last_tab_in_indent;
+		space_start = copy_line(&output, patch, i, plen + 1 - i);
 	}
-	else
-		i = 1;
-
-	memcpy(output, patch + i, plen);
 	if (add_nl_to_tail)
-		output[plen++] = '\n';
+		*output++ = '\n';
 	if (fixed)
 		applied_after_stripping++;
-	return output + plen - buf;
+
+	return output - old;
 }

 static int apply_one_fragment(struct buffer_desc *desc, struct
fragment *frag, int inaccurate_eof)
-- 
1.5.2.rc3.88.g4c3ba-dirty
