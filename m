From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] pretty.c: Fix a compiler warning
Date: Thu, 04 Oct 2012 19:06:37 +0100
Message-ID: <506DD02D.2060809@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:35:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtez-00033L-2N
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355Ab2JDSHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 14:07:40 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:34607 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750811Ab2JDSHj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 14:07:39 -0400
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 3E65718C449;
	Thu,  4 Oct 2012 19:07:37 +0100 (BST)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 4DD3F18C436;	Thu,  4 Oct 2012 19:07:36 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tch.inty.net (Postfix) with ESMTP;	Thu,  4 Oct 2012 19:07:33 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207012>


In particular, gcc complains thus:

        CC pretty.o
    pretty.c: In function 'format_commit_item':
    pretty.c:1282: warning: 'offset' might be used uninitialized in \
        this function

In order to suppress the warning we simply initialize the 'offset'
variable in it's declarartion.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Nguyen,

If you need to re-roll your 'nd/pretty-placeholder-with-color-option'
branch, could you please squash this (or something like it) into the
relevant commit. [commit f1da75df ("pretty: support padding placeholders,
%< %> and %><", 23-09-2012). NOTE: this patch is on top of pu@a78f4186]

An alternative solution looks like (this will probably break git-am):

--- >8 ---
diff --git a/pretty.c b/pretty.c
index deeacf2..25d8eb2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1292,6 +1292,8 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 			break;
 		case flush_left_and_steal:
 		case no_flush: /* to make gcc happy */
+		default:
+			offset = 0;
 			break;
 		}
 		/*
--- 8< ---

... but this disables the "enumeration value 'no_flush' not handled in switch"
type warnings.

[Actually, I would not bother with a switch at all; I find this:

	} else {
		int sb_len = sb->len, offset = 0;
		if (c->flush_type == flush_left)
			offset = padding - len;
		else if (c->flush_type == flush_both)
			offset = (padding - len) / 2;
		...

... much more readable. But that's just me ... :-D ]

Thanks!

ATB,
Ramsay Jones

 pretty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index deeacf2..d26428b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1279,7 +1279,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 		}
 		strbuf_addstr(sb, local_sb.buf);
 	} else {
-		int sb_len = sb->len, offset;
+		int sb_len = sb->len, offset = 0;
 		switch (c->flush_type) {
 		case flush_left:
 			offset = padding - len;
-- 
1.7.12
