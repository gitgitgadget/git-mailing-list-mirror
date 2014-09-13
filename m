From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH] mailinfo: do not treat ">From" lines as in-body headers
Date: Sat, 13 Sep 2014 17:25:05 -0400
Message-ID: <20140913212504.GA25190@peff.net>
References: <1410472786-14552-1-git-send-email-mark.einon@gmail.com>
 <1410472786-14552-5-git-send-email-mark.einon@gmail.com>
 <20140913093746.GD6600@mwanda>
 <20140913154556.GA12361@kroah.com>
 <20140913203645.GB24854@peff.net>
 <20140913204745.GA12291@msilap.einon.net>
 <20140913205751.GA17875@mwanda>
 <20140913210908.GG6549@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Einon <mark.einon@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
X-From: git-owner@vger.kernel.org Sat Sep 13 23:25:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSuom-000241-Ac
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 23:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbaIMVZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 17:25:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:47839 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752118AbaIMVZI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 17:25:08 -0400
Received: (qmail 11602 invoked by uid 102); 13 Sep 2014 21:25:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 16:25:08 -0500
Received: (qmail 10694 invoked by uid 107); 13 Sep 2014 21:25:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 17:25:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Sep 2014 17:25:05 -0400
Content-Disposition: inline
In-Reply-To: <20140913210908.GG6549@mwanda>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256981>

[-cc driver-devel list, as this is getting into git patches]

On Sun, Sep 14, 2014 at 12:09:08AM +0300, Dan Carpenter wrote:

> > > FYI it was 'git send-email' v2.1.0 that sent the mail, and I don't have
> > > the offending character in any versions of the mail I can see.
> [...]
> Piper mail has '>From'.
> http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2014-September/058299.html
> 
> but gmane gets it right.
> http://comments.gmane.org/gmane.linux.drivers.driver-project.devel/57684

Thanks both of you for following up. I did confirm that git-send-email
does not add such quoting. From your findings above, I'd agree that it's
the list-archive software munging it, and they are buggy IMHO (they
should de-quote on display).

Here's an RFC patch to help the "git am" side handle this case better.

-- >8 --
Subject: mailinfo: do not treat ">From" lines as in-body headers

Since commit 81c5cf7 (mailinfo: skip bogus UNIX From line
inside body, 2006-05-21), we have treated lines like ">From"
in the body as headers. This makes "git am" work for people
who erroneously paste the whole mbox entry:

  From 12345abcd...
  From: them
  Subject: [PATCH] whatever

into their email body. However, it also causes false
positives for people who really do have ">From" in the first
paragraph of their commit messages. In this case, we'll drop
the line completely, breaking the commit message.

We could try to make our checking more robust by doing one
or both of:

  - making sure the line looks like a git "From " line
    (40-hex sha1, date, etc).

  - seeing if the following lines are actually rfc2822
    headers

However, it's probably not worth the complexity. There are a
few reasons to think that this code is not actually
triggered very often. One, the patch was written in 2006,
when git was still relatively new, and people frequently
made mistakes in sending patches; these days we not see this
error much. And two, we check only the quoted ">From" form,
and not the regular "From". So whether it kicks in at all
depends entirely on how the mbox is saved by the user's MUA.
And in the intervening 8 years, nobody has complained about
the "From" case.

With this patch, we will simply treat such ">From" lines as
normal body lines (and stop in-body header parsing). Note
that we do _not_ unquote them into "From". Whether
from-quoting is in effect depends on the exact mbox format
being used, which depends on the MUA writing the file. We
cannot know for sure whether to unquote or not, so we leave
the line alone.

Signed-off-by: Jeff King <peff@peff.net>
---
I admit my arguments that it is not in use are a little flaky, and this
may just be me being lazy. Trying to match arbitrary "From" lines is
very hard and heuristic-filled, but if we are only trying to match
git-generated mbox lines, that's much easier. It would not hurt too much
to go that route.

I also tend to think we should unquote ">From" into "From". As discussed
above, we do know whether the author meant the literal former, or meant
the latter and it quoted into the former. But I'd guess that a literal
">From" is quite rare, so we'd probably serve more people by de-quoting.
That is really a separate issue for another patch, though.

 builtin/mailinfo.c         |  4 ----
 t/t5100-mailinfo.sh        |  9 +++++++++
 t/t5100/quoted-from.expect |  3 +++
 t/t5100/quoted-from.in     | 10 ++++++++++
 4 files changed, 22 insertions(+), 4 deletions(-)
 create mode 100644 t/t5100/quoted-from.expect
 create mode 100644 t/t5100/quoted-from.in

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index cf11c8d..0a08e44 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -328,10 +328,6 @@ static int check_header(const struct strbuf *line,
 	}
 
 	/* for inbody stuff */
-	if (starts_with(line->buf, ">From") && isspace(line->buf[5])) {
-		ret = 1; /* Should this return 0? */
-		goto check_header_out;
-	}
 	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
 		for (i = 0; header[i]; i++) {
 			if (!strcmp("Subject", header[i])) {
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 3e64a7a..578ff16 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -89,4 +89,13 @@ test_expect_success 'mailinfo on from header without name works' '
 
 '
 
+test_expect_success 'mailinfo on message with quoted >From' '
+	mkdir quoted-from &&
+	git mailsplit -oquoted-from "$TEST_DIRECTORY"/t5100/quoted-from.in &&
+	test_cmp "$TEST_DIRECTORY"/t5100/quoted-from.in quoted-from/0001 &&
+	git mailinfo quoted-from/msg quoted-from/patch \
+	  <quoted-from/0001 >quoted-from/out &&
+	test_cmp "$TEST_DIRECTORY"/t5100/quoted-from.expect quoted-from/msg
+'
+
 test_done
diff --git a/t/t5100/quoted-from.expect b/t/t5100/quoted-from.expect
new file mode 100644
index 0000000..8c9d48c
--- /dev/null
+++ b/t/t5100/quoted-from.expect
@@ -0,0 +1,3 @@
+>From the depths of history, we are stuck with the
+flaky mbox format.
+
diff --git a/t/t5100/quoted-from.in b/t/t5100/quoted-from.in
new file mode 100644
index 0000000..847e1c4
--- /dev/null
+++ b/t/t5100/quoted-from.in
@@ -0,0 +1,10 @@
+From 1234567890123456789012345678901234567890 Mon Sep 17 00:00:00 2001
+From: Author Name <somebody@example.com>
+Date: Sun, 25 May 2008 00:38:18 -0700
+Subject: [PATCH] testing quoted >From
+
+>From the depths of history, we are stuck with the
+flaky mbox format.
+
+---
+patch
-- 
2.1.0.373.g91ca799
