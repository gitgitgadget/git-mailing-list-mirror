From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] pretty: Fix bug in truncation support for %>, %< and %><
Date: Sat, 27 Apr 2013 20:43:36 +0100
Message-ID: <517C2A68.4030802@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:47:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWB5u-0000w5-V0
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535Ab3D0Tre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:47:34 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:33199 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756498Ab3D0Trd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:47:33 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 6D8F9384081;
	Sat, 27 Apr 2013 20:47:32 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id ADC9438407C;
	Sat, 27 Apr 2013 20:47:31 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 27 Apr 2013 20:47:30 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222680>


Some systems experience failures in t4205-*.sh (tests 18-20, 27)
which all relate to the use of truncation with the %< padding
placeholder. This capability was added in the commit a7f01c6b
("pretty: support truncating in %>, %< and %><", 19-04-2013).

The truncation support was implemented with the assistance of a
new strbuf function (strbuf_utf8_replace). This function contains
the following code:

       strbuf_attach(sb_src, strbuf_detach(&sb_dst, NULL),
                     sb_dst.len, sb_dst.alloc);

Unfortunately, this code is subject to unspecified behaviour. In
particular, the order of evaluation of the argument expressions
(along with the associated side effects) is not specified by the
C standard. Note that the second argument expression is a call to
strbuf_detach() which, as a side effect, sets the 'len' and 'alloc'
fields of the sb_dst argument to zero. Depending on the order of
evaluation of the argument expressions to the strbuf_attach call,
this can lead to assigning an empty string to 'sb_src'.

In order to remove the undesired behaviour, we replace the above
line of code with:

       strbuf_swap(sb_src, &sb_dst);
       strbuf_release(&sb_dst);

which achieves the desired effect without provoking unspecified
behaviour.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 utf8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utf8.c b/utf8.c
index b1e1303..0d20e0a 100644
--- a/utf8.c
+++ b/utf8.c
@@ -463,8 +463,8 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
 		w += n;
 	}
 	strbuf_setlen(&sb_dst, dst - sb_dst.buf);
-	strbuf_attach(sb_src, strbuf_detach(&sb_dst, NULL),
-		      sb_dst.len, sb_dst.alloc);
+	strbuf_swap(sb_src, &sb_dst);
+	strbuf_release(&sb_dst);
 }
 
 int is_encoding_utf8(const char *name)
-- 
1.8.2
