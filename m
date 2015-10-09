From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] mailinfo: ignore in-body header that we do not care about
Date: Thu, 08 Oct 2015 18:43:25 -0700
Message-ID: <xmqqtwq0q0jm.fsf@gitster.mtv.corp.google.com>
References: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1444162070-22034-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<5614CDAE.6070604@ti.com> <20151007075338.GH3982@pengutronix.de>
	<20151007102822.GT23801@atomide.com>
	<20151008071728.GO3982@pengutronix.de>
	<xmqqvbahqhw1.fsf@gitster.mtv.corp.google.com>
	<20151008193707.GT3982@pengutronix.de>
	<xmqqio6hqg9a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 03:43:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkMid-0008A3-R8
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 03:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911AbbJIBna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 21:43:30 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36597 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbbJIBn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 21:43:28 -0400
Received: by pablk4 with SMTP id lk4so70577701pab.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 18:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type;
        bh=ibQk+7lKG7xzXD/Nsc6bxUMHzw3GwAD+uJnbeWNWoik=;
        b=Z7WOg4A4ESUt36aq7f7kKMdoc71S5wU0/bUKZzd2No2LxmFp8AY4/EpCJ6uRsVGFOv
         bqXYxHvgTEvoZ0sezvTLjjL8CK46aUp4JX0EJfZjTPjMt0kcWBHRNMT9hq5SXZTWwCkR
         jXXeqIHAV9llIlYqVn5tZvH8QT6vx39iqC293GXlS4Zsm4VaTQJ1psodvK+KcdV1CiWu
         RRxwuP3dz35vPZlWhuWS9wALfX1ObpQfVHhpUFfS8qGiHfZEURJOmrFB0Q7e/CegJYAa
         48qtXxWUFys/JXZtP4w+R8DO3Hr7alwXSDFbux1PGQnp0i474gHq6Uxkmh/xeO4RwEJ0
         zU2Q==
X-Received: by 10.68.103.194 with SMTP id fy2mr8651934pbb.120.1444355008328;
        Thu, 08 Oct 2015 18:43:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:6d9f:e45b:5c65:e644])
        by smtp.gmail.com with ESMTPSA id ci2sm20156732pbc.66.2015.10.08.18.43.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 08 Oct 2015 18:43:26 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279284>

"git mailinfo" (hence "git am") understands some well-known headers,
like "Subject: ", "Date: " and "From: ", placed at the beginning of
the message body (and the "--scissors" can discard the part of the
body before a scissors-mark).  However, some people throw other
kinds of header-looking things there, expecting them to be
discarded.

Finding and discarding anything that looks like RFC2822 header is
not a right solution.  The body of the message may start with a line
that begins with a word followed by a colon that is a legitimate
part of the message that should not be discarded.

Instead, keep reading non-blank lines once we see an in-body header
at the beginning and discard them.  Nobody will be insane enough to
reorder the headers to read like this:

    Garbage-non-in-body-header: here
    Subject: in-body subject

    Here is the body of the commit log.

but it is common for lazy or misguided people to leave non-header
materials in-body like this:

    From: Junio C Hamano <gitster@pobox.com>
    Date: Mon, 28 Sep 2015 19:19:27 -0700
    Subject: [PATCH] Git 2.6.1
    MIME-Version: 1.0

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 I think it is wrong for the in-body header codepath to pay
 attention to content-transfer-encodings and stuff, but that is a
 separate issue.

 Also if you remove the "does the line even look like a header?"
 check, some tests in t5100 starts failing.  E.g.

    From nobody Mon Sep 17 00:00:00 2001
    From: A U Thor <a.u.thor@example.com>
    Subject: check bogus body header (from)
    Date: Fri, 9 Jun 2006 00:44:16 -0700

    From: bogosity
      - a list
      - of stuff

 wants to make sure the list of two bulletted-items are in the
 commit log, and the in-body From: line gets used.

 So I dunno.  I am not entirely convinced that this is a good
 change.

 builtin/mailinfo.c  | 34 +++++++++++++++++++++++++++++++---
 t/t5100-mailinfo.sh |  3 ++-
 t/t5100/info0018    |  5 +++++
 t/t5100/msg0018     |  2 ++
 t/t5100/patch0018   |  6 ++++++
 t/t5100/sample.mbox | 18 ++++++++++++++++++
 6 files changed, 64 insertions(+), 4 deletions(-)
 create mode 100644 t/t5100/info0018
 create mode 100644 t/t5100/msg0018
 create mode 100644 t/t5100/patch0018

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 999a525..169ee54 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -787,18 +787,46 @@ static int is_scissors_line(const struct strbuf *line)
 
 static int handle_commit_msg(struct strbuf *line)
 {
+	/*
+	 * Are we still scanning and discarding in-body headers?
+	 * It is initially set to 1, set to 2 when we do see a
+	 * valid in-body header.
+	 */
 	static int still_looking = 1;
+	int is_empty_line;
 
 	if (!cmitmsg)
 		return 0;
 
-	if (still_looking) {
-		if (!line->len || (line->len == 1 && line->buf[0] == '\n'))
+	is_empty_line = (!line->len || (line->len == 1 && line->buf[0] == '\n'));
+	if (still_looking == 1) {
+		/*
+		 * Haven't seen a known in-body header; discard an empty line.
+		 */
+		if (is_empty_line)
 			return 0;
 	}
 
 	if (use_inbody_headers && still_looking) {
-		still_looking = check_header(line, s_hdr_data, 0);
+		int is_known_header = check_header(line, s_hdr_data, 0);
+
+		if (still_looking == 2) {
+			/*
+			 * an empty line after the in-body header block,
+			 * or a line obviously not an attempt to invent
+			 * an unsupported in-body header.
+			 */
+			if (is_empty_line || !is_rfc2822_header(line))
+				still_looking = 0;
+			if (is_empty_line)
+				return 0;
+			/* otherwise do not discard the line, but keep going */
+		} else if (is_known_header) {
+			still_looking = 2;
+		} else if (still_looking != 2) {
+			still_looking = 0;
+		}
+
 		if (still_looking)
 			return 0;
 	} else
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index e97cfb2..3ce041b 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -11,7 +11,8 @@ test_expect_success 'split sample box' \
 	'git mailsplit -o. "$TEST_DIRECTORY"/t5100/sample.mbox >last &&
 	last=`cat last` &&
 	echo total is $last &&
-	test `cat last` = 17'
+	test `cat last` = 18
+'
 
 check_mailinfo () {
 	mail=$1 opt=$2
diff --git a/t/t5100/info0018 b/t/t5100/info0018
new file mode 100644
index 0000000..ec671fc
--- /dev/null
+++ b/t/t5100/info0018
@@ -0,0 +1,5 @@
+Author: A U Thor
+Email: a.u.thor@example.com
+Subject: A E I O U
+Date: Mon, 17 Sep 2012 14:23:49 -0700
+
diff --git a/t/t5100/msg0018 b/t/t5100/msg0018
new file mode 100644
index 0000000..2ee0900
--- /dev/null
+++ b/t/t5100/msg0018
@@ -0,0 +1,2 @@
+New content here
+
diff --git a/t/t5100/patch0018 b/t/t5100/patch0018
new file mode 100644
index 0000000..35cf84c
--- /dev/null
+++ b/t/t5100/patch0018
@@ -0,0 +1,6 @@
+diff --git a/foo b/foo
+index e69de29..d95f3ad 100644
+--- a/foo
++++ b/foo
+@@ -0,0 +1 @@
++New content
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 8b2ae06..d7c5878 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -406,6 +406,7 @@ Subject: re: [PATCH] another patch
 
 From: A U Thor <a.u.thor@example.com>
 Subject: [PATCH] another patch
+
 >Here is an empty patch from A U Thor.
 
 Hey you forgot the patch!
@@ -699,3 +700,20 @@ index e69de29..d95f3ad 100644
 +++ b/foo
 @@ -0,0 +1 @@
 +New content
+From nobody Mon Sep 17 00:00:00 2001
+From: A U Thor <a.u.thor@example.com>
+Subject: Re: some discussion title
+Date: Mon, 17 Sep 2012 14:23:49 -0700
+
+Subject: A E I O U
+MIME-VERSION: 1.0
+Garbage: Not a valid in-body header
+
+New content here
+
+diff --git a/foo b/foo
+index e69de29..d95f3ad 100644
+--- a/foo
++++ b/foo
+@@ -0,0 +1 @@
++New content
-- 
2.6.1-296-ge15092e
