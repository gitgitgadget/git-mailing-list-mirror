Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 6750 invoked by uid 111); 26 Dec 2008 19:16:06 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 26 Dec 2008 14:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbYLZTPx (ORCPT <rfc822;peff@peff.net>);
	Fri, 26 Dec 2008 14:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbYLZTPx
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 14:15:53 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:38093 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752253AbYLZTPw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 14:15:52 -0500
X-Greylist: delayed 2275 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Dec 2008 14:15:49 EST
Received: from [192.168.0.130] (helo=tugrik2.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1LGHZC-0008PO-1x; Fri, 26 Dec 2008 21:37:46 +0300
Received: from kirr by tugrik2.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@mns.spb.ru>)
	id 1LGHa5-0003jl-Sc; Fri, 26 Dec 2008 21:38:41 +0300
From:	Kirill Smelkov <kirr@mns.spb.ru>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Kirill Smelkov <kirr@mns.spb.ru>, git@vger.kernel.org
Subject: [PATCH RFC] mailinfo: correctly handle multiline 'Subject:' header
Date:	Fri, 26 Dec 2008 21:38:41 +0300
Message-Id: <1230316721-14339-1-git-send-email-kirr@mns.spb.ru>
X-Mailer: git-send-email 1.6.1.rc1.4.gb8d17
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When native language (RU) is in use, subject header usually contains several
parts, e.g.

Subject: [Navy-patches] [PATCH]
	=?utf-8?b?0JjQt9C80LXQvdGR0L0g0YHQv9C40YHQvtC6INC/0LA=?=
	=?utf-8?b?0LrQtdGC0L7QsiDQvdC10L7QsdGF0L7QtNC40LzRi9GFINC00LvRjyA=?=
	=?utf-8?b?0YHQsdC+0YDQutC4?=

This exposes several bugs in builtin-mailinfo.c that I try to fix:


1. decode_b_segment: do not append explicit NUL -- explicit NUL was preventing
   correct header construction on parts concatenation via strbuf_addbuf in
   decode_header_bq. Fixes:

-Subject: Изменён список пакетов необходимых для сборки
+Subject: Изменён список па


Then

2. (hackish) do not emit '\n' after processing of every header segment. It
   seems we should emit previous part as-is only if it does not end with
   '=?='. Fixes:

-Subject: Изменён список пакетов необходимых для сборки
+Subject: Изменён список па кетов необходимых для сборки


Sorry for low-quality patch and description. I did what I could and don't have
energy and time dig more into MIME.

Please help.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>

---
 builtin-mailinfo.c  |   18 ++++++++++++++++-
 t/t5100-mailinfo.sh |    2 +-
 t/t5100/info0012    |    5 ++++
 t/t5100/msg0012     |    7 ++++++
 t/t5100/patch0012   |   30 +++++++++++++++++++++++++++++
 t/t5100/sample.mbox |   52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index e890f7a..d138bc3 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -436,6 +436,14 @@ static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
 			 * for now we just trust the data.
 			 */
 			c = 0;
+
+			/* XXX: the following is needed not to output NUL in
+			 * the resulting string
+			 *
+			 * This seems to be ok, but I'm not 100% sure -- that's
+			 * why this is an RFC.
+			 */
+			continue;
 		}
 		else
 			continue; /* garbage */
@@ -513,7 +521,15 @@ static int decode_header_bq(struct strbuf *it)
 		strbuf_reset(&piecebuf);
 		rfc2047 = 1;
 
-		if (in != ep) {
+		/* XXX: the follwoing is needed not to output '\n' on every
+		 * multi-line segment in Subject.
+		 *
+		 * I suspect this is not 100% correct, but I'm not a MIME guy
+		 * -- that's why this is an RFC.
+		 */
+
+		/* if in does not end with '=?=', we emit it as is */
+		if (in <= (ep-2) && !(ep[-1]=='\n' && ep[-2]=='=')) {
 			strbuf_add(&outbuf, in, ep - in);
 			in = ep;
 		}
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index fe14589..6825f99 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -11,7 +11,7 @@ test_expect_success 'split sample box' \
 	'git mailsplit -o. "$TEST_DIRECTORY"/t5100/sample.mbox >last &&
 	last=`cat last` &&
 	echo total is $last &&
-	test `cat last` = 11'
+	test `cat last` = 12'
 
 for mail in `echo 00*`
 do
diff --git a/t/t5100/info0012 b/t/t5100/info0012
new file mode 100644
index 0000000..ac1216f
--- /dev/null
+++ b/t/t5100/info0012
@@ -0,0 +1,5 @@
+Author: Dmitriy Blinov
+Email: bda@mnsspb.ru
+Subject: Изменён список пакетов необходимых для сборки
+Date: Wed, 12 Nov 2008 17:54:41 +0300
+
diff --git a/t/t5100/msg0012 b/t/t5100/msg0012
new file mode 100644
index 0000000..1dc2bf7
--- /dev/null
+++ b/t/t5100/msg0012
@@ -0,0 +1,7 @@
+textlive-* исправлены на texlive-*
+docutils заменён на python-docutils
+
+Действительно, оказалось, что rest2web вытягивает за собой
+python-docutils. В то время как сам rest2web не нужен.
+
+Signed-off-by: Dmitriy Blinov <bda@mnsspb.ru>
diff --git a/t/t5100/patch0012 b/t/t5100/patch0012
new file mode 100644
index 0000000..36a0b68
--- /dev/null
+++ b/t/t5100/patch0012
@@ -0,0 +1,30 @@
+---
+ howto/build_navy.txt |    6 +++---
+ 1 files changed, 3 insertions(+), 3 deletions(-)
+
+diff --git a/howto/build_navy.txt b/howto/build_navy.txt
+index 3fd3afb..0ee807e 100644
+--- a/howto/build_navy.txt
++++ b/howto/build_navy.txt
+@@ -119,8 +119,8 @@
+    - libxv-dev
+    - libusplash-dev
+    - latex-make
+-   - textlive-lang-cyrillic
+-   - textlive-latex-extra
++   - texlive-lang-cyrillic
++   - texlive-latex-extra
+    - dia
+    - python-pyrex
+    - libtool
+@@ -128,7 +128,7 @@
+    - sox
+    - cython
+    - imagemagick
+-   - docutils
++   - python-docutils
+ 
+ #. на машине dinar: добавить свой открытый ssh-ключ в authorized_keys2 пользователя ddev
+ #. на своей машине: отредактировать /etc/sudoers (команда ``visudo``) примерно следующим образом::
+-- 
+1.5.6.5
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 4bf7947..94da4da 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -501,3 +501,55 @@ index 3e5fe51..aabfe5c 100644
 
 --=-=-=--
 
+From bda@mnsspb.ru Wed Nov 12 17:54:41 2008
+From: Dmitriy Blinov <bda@mnsspb.ru>
+To: navy-patches@dinar.mns.mnsspb.ru
+Date: Wed, 12 Nov 2008 17:54:41 +0300
+Message-Id: <1226501681-24923-1-git-send-email-bda@mnsspb.ru>
+X-Mailer: git-send-email 1.5.6.5
+MIME-Version: 1.0
+Content-Type: text/plain;
+  charset=utf-8
+Content-Transfer-Encoding: 8bit
+Subject: [Navy-patches] [PATCH]
+	=?utf-8?b?0JjQt9C80LXQvdGR0L0g0YHQv9C40YHQvtC6INC/0LA=?=
+	=?utf-8?b?0LrQtdGC0L7QsiDQvdC10L7QsdGF0L7QtNC40LzRi9GFINC00LvRjyA=?=
+	=?utf-8?b?0YHQsdC+0YDQutC4?=
+
+textlive-* исправлены на texlive-*
+docutils заменён на python-docutils
+
+Действительно, оказалось, что rest2web вытягивает за собой
+python-docutils. В то время как сам rest2web не нужен.
+
+Signed-off-by: Dmitriy Blinov <bda@mnsspb.ru>
+---
+ howto/build_navy.txt |    6 +++---
+ 1 files changed, 3 insertions(+), 3 deletions(-)
+
+diff --git a/howto/build_navy.txt b/howto/build_navy.txt
+index 3fd3afb..0ee807e 100644
+--- a/howto/build_navy.txt
++++ b/howto/build_navy.txt
+@@ -119,8 +119,8 @@
+    - libxv-dev
+    - libusplash-dev
+    - latex-make
+-   - textlive-lang-cyrillic
+-   - textlive-latex-extra
++   - texlive-lang-cyrillic
++   - texlive-latex-extra
+    - dia
+    - python-pyrex
+    - libtool
+@@ -128,7 +128,7 @@
+    - sox
+    - cython
+    - imagemagick
+-   - docutils
++   - python-docutils
+ 
+ #. на машине dinar: добавить свой открытый ssh-ключ в authorized_keys2 пользователя ddev
+ #. на своей машине: отредактировать /etc/sudoers (команда ``visudo``) примерно следующим образом::
+-- 
+1.5.6.5
-- 
tg: (2292ebd..) t/mailinfo-multiline-subject (depends on: tmp)
