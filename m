From: Tsugikazu Shibata <tshibata@ab.jp.nec.com>
Subject: [RFC/PATCH] fix "git diff" to create wrong UTF-8 text
Date: Wed, 02 Jan 2008 08:20:14 +0900 (JST)
Message-ID: <20080102.082014.02281301.tshibata@ab.jp.nec.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: tshibata@ab.jp.nec.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 02 00:55:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9qxA-0006qA-TV
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 00:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694AbYAAXzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 18:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755317AbYAAXzA
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 18:55:00 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:51285 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517AbYAAXy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 18:54:59 -0500
Received: from mailgate4.nec.co.jp (mailgate53.nec.co.jp [10.7.69.184])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m01NsvKp023505
	for <git@vger.kernel.org>; Wed, 2 Jan 2008 08:54:57 +0900 (JST)
Received: (from root@localhost) by mailgate4.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id m01NsvF08263 for git@vger.kernel.org; Wed, 2 Jan 2008 08:54:57 +0900 (JST)
Received: from saigo.jp.nec.com (saigo.jp.nec.com [10.26.220.6])
	by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id m01NsuI5010830
	for <git@vger.kernel.org>; Wed, 2 Jan 2008 08:54:56 +0900 (JST)
Received: from localhost ([10.19.71.63] [10.19.71.63]) by mail.jp.nec.com with ESMTP; Wed, 2 Jan 2008 08:54:55 +0900
X-Mailer: Mew version 4.2 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69448>

Hello,

I met a problem in patch text from "git diff" for UTF-8 text.
Patch text following to "@@" sometimes cut the string with max
80bytes. In case of UTF-8 text written in Japanese and English, most
of Japanese character are consist of 3 bytes for a character and also
ASCII character is single byte.
So, cut the string with 80bytes may cause cut off 1 or 2 byte for a
character at the bottom. This will cause the broken code of result of
"git diff".

It seems no problem to read such patch text for the patch command but
the problem is not readable for me. ie. Emacs cannot handle the
encoding for such file and show me octal numbers.

The patch below is my quick and dirty solution (but It works fine !)
I tested this patch with using Linux kernel document
(Documentation/ja_JP/HOWTO)
I believe this should be work for another language using UTF-8 and
solve this issue.

Please note that this is focused only for UTF-8 but we may need to
support another encoding.
So, How can we turn on this UTF-8 processing?
Any suggestions are welcome.

Thanks,

Sigined-off-by: Tsugikazu Shibata <tshibata@ab.jp.nec.com>
---

diff -upr git-1.5.3.7/xdiff/xutils.c git-1.5.3.7-dev/xdiff/xutils.c
--- git-1.5.3.7/xdiff/xutils.c	2007-12-02 06:21:12.000000000 +0900
+++ git-1.5.3.7-dev/xdiff/xutils.c	2007-12-31 01:30:51.000000000 +0900
@@ -332,6 +332,32 @@ long xdl_atol(char const *str, char cons
 }


+/* return utf character size of bytes */
+int utf8charsize(const unsigned char c) {
+	int l;
+	if ( c < 0x7f ) l = 1;
+	else if (( c > 0xc0) && ( c < 0xdf)) l=2;
+	else if (( c > 0xe0) && ( c < 0xef)) l=3;
+	else if (( c > 0xf0) && ( c < 0xf7)) l=4;
+	else if (( c > 0xf8) && ( c < 0xfb)) l=5;
+	else if (( c > 0xfc) && ( c < 0xfd)) l=6;
+	else l=1; /* fale safe */
+	return l;
+}
+
+int utf8width(const char *up, int len) {
+        int cs;
+        int l=len;
+        const char *p = up;
+        while ((l > 0) && (p[0] != '\0')) {
+		cs = utf8charsize(p[0]);
+		if (l >= cs) {
+			l -= cs; p += cs;
+		} else l=0; /* do not split multi byte char. */
+        }
+        return p-up;
+}
+
 int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
 		      const char *func, long funclen, xdemitcb_t *ecb) {
 	int nb = 0;
@@ -368,6 +394,7 @@ int xdl_emit_hunk_hdr(long s1, long c1,
 		buf[nb++] = ' ';
 		if (funclen > sizeof(buf) - nb - 1)
 			funclen = sizeof(buf) - nb - 1;
+		funclen = utf8width(func, funclen);
 		memcpy(buf + nb, func, funclen);
 		nb += funclen;
 	}
