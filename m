From: Jeff King <peff@peff.net>
Subject: Re: git-mailinfo doesn't stop parsing at the end of the header
Date: Wed, 18 Nov 2009 11:42:08 -0500
Message-ID: <20091118164208.GB15184@coredump.intra.peff.net>
References: <aa2993680911180620g151d8a07t11144d150cd6e29e@mail.gmail.com>
 <20091118155154.GA15184@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Philip Hofstetter <phofstetter@sensational.ch>
X-From: git-owner@vger.kernel.org Wed Nov 18 17:42:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAnbr-0008Ht-NG
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 17:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757809AbZKRQmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 11:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757783AbZKRQmH
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 11:42:07 -0500
Received: from peff.net ([208.65.91.99]:48080 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757731AbZKRQmG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 11:42:06 -0500
Received: (qmail 30989 invoked by uid 107); 18 Nov 2009 16:46:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Nov 2009 11:46:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Nov 2009 11:42:08 -0500
Content-Disposition: inline
In-Reply-To: <20091118155154.GA15184@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133190>

On Wed, Nov 18, 2009 at 10:51:54AM -0500, Jeff King wrote:

> So the problem is slightly less severe; the body of your commit message
> has to _start_ with "From:". Still, it is awfully ugly to hit a parsing
> ambiguity like this when you are trying to do something as simple as
> rebase.
> 
> Some solutions I can think of are:
> 
>   1. Improve the header-finding heuristic to actually look for something
>      more sane, like "From:.*<.*@.*>" (I don't recall off the top of my
>      head which other headers we handle in this position. Probably
>      Date, too).
> 
>   2. Give mailinfo a "--strict" mode to indicate that it is directly
>      parsing the output of format-patch, and not some random email. Use
>      --strict when invoking "git am" via "git rebase".

Solution (2) seemed like a lot of work, so here is the relatively small
solution (1). I think looking for <.*@.*> is too restrictive, as people
may be using:

  From: bare@example.com

which should remain valid. I just look for an '@' instead.

Note that this validation also applies to actual headers. Should we turn
it off for them? As it is, it breaks t3400, which uses a bogus email
address. I suppose we should probably preserve such bogosities if they
are in the official headers.

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index c90cd31..6d69ef3 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -275,6 +275,17 @@ static inline int cmp_header(const struct strbuf *line, const char *hdr)
 			line->buf[len] == ':' && isspace(line->buf[len + 1]);
 }
 
+static int validate_header(const char *header, const struct strbuf *data)
+{
+	if (!strcmp(header, "From"))
+		return !!strchr(data->buf, '@');
+	if (!strcmp(header, "Date")) {
+		char buf[50];
+		return parse_date(data->buf, buf, sizeof(buf)) >= 0;
+	}
+	return 1;
+}
+
 static int check_header(const struct strbuf *line,
 				struct strbuf *hdr_data[], int overwrite)
 {
@@ -289,8 +300,10 @@ static int check_header(const struct strbuf *line,
 			 */
 			strbuf_add(&sb, line->buf + len + 2, line->len - len - 2);
 			decode_header(&sb);
-			handle_header(&hdr_data[i], &sb);
-			ret = 1;
+			if (validate_header(header[i], &sb)) {
+				ret = 1;
+				handle_header(&hdr_data[i], &sb);
+			}
 			goto check_header_out;
 		}
 	}
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 0279d07..be06e0f 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -11,7 +11,7 @@ test_expect_success 'split sample box' \
 	'git mailsplit -o. "$TEST_DIRECTORY"/t5100/sample.mbox >last &&
 	last=`cat last` &&
 	echo total is $last &&
-	test `cat last` = 14'
+	test `cat last` = 16'
 
 check_mailinfo () {
 	mail=$1 opt=$2
diff --git a/t/t5100/info0015 b/t/t5100/info0015
new file mode 100644
index 0000000..c4d8d77
--- /dev/null
+++ b/t/t5100/info0015
@@ -0,0 +1,5 @@
+Author: A U Thor
+Email: a.u.thor@example.com
+Subject: check bogus body header (from)
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+
diff --git a/t/t5100/info0016 b/t/t5100/info0016
new file mode 100644
index 0000000..f4857d4
--- /dev/null
+++ b/t/t5100/info0016
@@ -0,0 +1,5 @@
+Author: A U Thor
+Email: a.u.thor@example.com
+Subject: check bogus body header (date)
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+
diff --git a/t/t5100/msg0015 b/t/t5100/msg0015
new file mode 100644
index 0000000..be5115b
--- /dev/null
+++ b/t/t5100/msg0015
@@ -0,0 +1,3 @@
+From: bogosity
+  - a list
+  - of stuff
diff --git a/t/t5100/msg0016 b/t/t5100/msg0016
new file mode 100644
index 0000000..1063f51
--- /dev/null
+++ b/t/t5100/msg0016
@@ -0,0 +1,4 @@
+Date: bogus
+
+and some content
+
diff --git a/t/t5100/patch0015 b/t/t5100/patch0015
new file mode 100644
index 0000000..ad64848
--- /dev/null
+++ b/t/t5100/patch0015
@@ -0,0 +1,8 @@
+---
+diff --git a/foo b/foo
+index e69de29..d95f3ad 100644
+--- a/foo
++++ b/foo
+@@ -0,0 +1 @@
++content
+
diff --git a/t/t5100/patch0016 b/t/t5100/patch0016
new file mode 100644
index 0000000..ad64848
--- /dev/null
+++ b/t/t5100/patch0016
@@ -0,0 +1,8 @@
+---
+diff --git a/foo b/foo
+index e69de29..d95f3ad 100644
+--- a/foo
++++ b/foo
+@@ -0,0 +1 @@
++content
+
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 13fa4ae..de10312 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -650,3 +650,36 @@ index b0b5d8f..461c47e 100644
  		convert_to_utf8(line, charset.buf);
 -- 
 1.6.4.1
+From nobody Mon Sep 17 00:00:00 2001
+From: A U Thor <a.u.thor@example.com>
+Subject: check bogus body header (from)
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+
+From: bogosity
+  - a list
+  - of stuff
+---
+diff --git a/foo b/foo
+index e69de29..d95f3ad 100644
+--- a/foo
++++ b/foo
+@@ -0,0 +1 @@
++content
+
+From nobody Mon Sep 17 00:00:00 2001
+From: A U Thor <a.u.thor@example.com>
+Subject: check bogus body header (date)
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+
+Date: bogus
+
+and some content
+
+---
+diff --git a/foo b/foo
+index e69de29..d95f3ad 100644
+--- a/foo
++++ b/foo
+@@ -0,0 +1 @@
++content
+
