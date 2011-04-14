From: Jeff King <peff@peff.net>
Subject: Re: [BUG] format-patch does not wrap From-field after author name
Date: Thu, 14 Apr 2011 18:18:09 -0400
Message-ID: <20110414221809.GA19222@sigill.intra.peff.net>
References: <BANLkTimruwojkq_HNMZeCDBV6K8_aFc_XQ@mail.gmail.com>
 <7v39lkiwoj.fsf@alter.siamese.dyndns.org>
 <20110414175034.GA23342@sigill.intra.peff.net>
 <BANLkTin+K46_RSDsYWHso3v7Gpe_k+0m8Q@mail.gmail.com>
 <20110414214230.GB7709@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:18:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAUrj-0002p5-Pi
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 00:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744Ab1DNWSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 18:18:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36116
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192Ab1DNWSO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 18:18:14 -0400
Received: (qmail 4428 invoked by uid 107); 14 Apr 2011 22:19:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Apr 2011 18:19:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2011 18:18:09 -0400
Content-Disposition: inline
In-Reply-To: <20110414214230.GB7709@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171565>

On Thu, Apr 14, 2011 at 05:42:30PM -0400, Jeff King wrote:

> > > Or we could just ignore it. AFAICS, this doesn't actually violate
> > > rfc2047, nor rfc5322. The 78-character limit is simply a SHOULD, and
> > > we have up to 998 for MUST. For a single-address header[1], this seems
> > > kind of unlikely to me.
> > 
> > True. But since the fix is as simple as it is, perhaps it's worth it
> > just for the clean conscience?
> 
> Fair enough. Patch to follow.

Here it is.

-- >8 --
Subject: [PATCH] format-patch: wrap email addresses after long names

We already wrap names in "from" headers, which tend to be
the long part of an address. But it's also possible for a
long name to not be wrapped, but to make us want to wrap the
email address. For example (imagine for the sake of
readability we want to wrap at 50 characters instead of 78):

  From: this is my really long git name <foo@example.com>

The name does not overflow the line, but the name and email
together do. So we would rather see:

  From: this is my really long git name
    <git@example.com>

Because we wrap the name separately during add_rfc2047, we
neglected this case. Instead, we should see how long the
final line of the wrapped name ended up, and decide whether
or not to wrap based on that. We can't break the address
into multiple parts, so we either leave it with the name, or
put it by itself on a line.

Test by Erik Faye-Lund.

Signed-off-by: Jeff King <peff@peff.net>
---
 pretty.c                |    9 +++++++++
 t/t4014-format-patch.sh |   15 +++++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/pretty.c b/pretty.c
index e1d8a8f..ba95de9 100644
--- a/pretty.c
+++ b/pretty.c
@@ -287,6 +287,7 @@ void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 	if (fmt == CMIT_FMT_EMAIL) {
 		char *name_tail = strchr(line, '<');
 		int display_name_length;
+		int final_line;
 		if (!name_tail)
 			return;
 		while (line < name_tail && isspace(name_tail[-1]))
@@ -294,6 +295,14 @@ void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 		display_name_length = name_tail - line;
 		strbuf_addstr(sb, "From: ");
 		add_rfc2047(sb, line, display_name_length, encoding);
+		for (final_line = 0; final_line < sb->len; final_line++)
+			if (sb->buf[sb->len - final_line - 1] == '\n')
+				break;
+		if (namelen - display_name_length + final_line > 78) {
+			strbuf_addch(sb, '\n');
+			if (!isspace(name_tail[0]))
+				strbuf_addch(sb, ' ');
+		}
 		strbuf_add(sb, name_tail, namelen - display_name_length);
 		strbuf_addch(sb, '\n');
 	} else {
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index c3cdb52..7d06716 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -793,4 +793,19 @@ test_expect_success 'format-patch wraps extremely long headers (rfc2047)' '
 	test_cmp expect subject
 '
 
+M8="foo_bar_"
+M64=$M8$M8$M8$M8$M8$M8$M8$M8
+cat >expect <<EOF
+From: $M64
+ <foobar@foo.bar>
+EOF
+test_expect_success 'format-patch wraps non-quotable headers' '
+	rm -rf patches/ &&
+	echo content >>file &&
+	git add file &&
+	git commit -mfoo --author "$M64 <foobar@foo.bar>" &&
+	git format-patch --stdout -1 >patch &&
+	sed -n "/^From: /p; /^ /p; /^$/q" <patch >from &&
+	test_cmp expect from
+'
 test_done
-- 
1.7.5.rc1.3.ga78bf
