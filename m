From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff-highlight: Work for multiline changes too
Date: Tue, 14 Feb 2012 01:04:04 -0500
Message-ID: <20120214060404.GA25996@sigill.intra.peff.net>
References: <20120210213209.GA7582@sigill.intra.peff.net>
 <1328910433-2539-1-git-send-email-michal.kiedrowicz@gmail.com>
 <20120213222702.GA19393@sigill.intra.peff.net>
 <7v8vk6b7pq.fsf@alter.siamese.dyndns.org>
 <20120214002209.GA23171@sigill.intra.peff.net>
 <7vk43q9pp6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 07:04:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxBVA-0001Yt-Mu
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 07:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab2BNGEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 01:04:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34596
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367Ab2BNGEH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 01:04:07 -0500
Received: (qmail 4255 invoked by uid 107); 14 Feb 2012 06:11:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 01:11:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 01:04:04 -0500
Content-Disposition: inline
In-Reply-To: <7vk43q9pp6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190701>

On Mon, Feb 13, 2012 at 05:19:33PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I chose reverse because I like the way it looks, and because it should
> > Just Work if people have selected alternate colors (I never dreamed
> > somebody would use "reverse" all the time, as I find it horribly ugly.
> > But to each his own).
> 
> I also find it ugly, but I am on black-letters on white background window,
> and I do not see my terminal's red very well, so it is hard to tell the
> old from the context if I use the "diff.color.old=red" default; that is
> the primary reason for my setting.

I find black-on-white ugly, too, but I have heard some people find it
more readable. You might try setting color.diff.old to "bold red" to
make it more readable. Depending on your terminal, that may end up as a
brighter shade of red.

Configurable colors for diff-highlight would look like the patch below:

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index c4404d4..f43832b 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -2,11 +2,13 @@
 
 use warnings FATAL => 'all';
 use strict;
+use Git;
+
+my $repo = Git->repository;
+my $color_old = $repo->get_color('color.diff.highlightold', 'reverse');
+my $color_new = $repo->get_color('color.diff.highlightnew', 'reverse');
+my $color_end = $repo->get_color('color.diff.highlightend', 'noreverse');
 
-# Highlight by reversing foreground and background. You could do
-# other things like bold or underline if you prefer.
-my $HIGHLIGHT   = "\x1b[7m";
-my $UNHIGHLIGHT = "\x1b[27m";
 my $COLOR = qr/\x1b\[[0-9;]*m/;
 my $BORING = qr/$COLOR|\s/;
 
@@ -128,8 +130,8 @@ sub highlight_pair {
 	}
 
 	if (is_pair_interesting(\@a, $pa, $sa, \@b, $pb, $sb)) {
-		return highlight_line(\@a, $pa, $sa),
-		       highlight_line(\@b, $pb, $sb);
+		return highlight_line(\@a, $pa, $sa, $color_old, $color_end),
+		       highlight_line(\@b, $pb, $sb, $color_new, $color_end);
 	}
 	else {
 		return join('', @a),
@@ -144,13 +146,13 @@ sub split_line {
 }
 
 sub highlight_line {
-	my ($line, $prefix, $suffix) = @_;
+	my ($line, $prefix, $suffix, $highlight, $unhighlight) = @_;
 
 	return join('',
 		@{$line}[0..($prefix-1)],
-		$HIGHLIGHT,
+		$highlight,
 		@{$line}[$prefix..$suffix],
-		$UNHIGHLIGHT,
+		$unhighlight,
 		@{$line}[($suffix+1)..$#$line]
 	);
 }

However, there are two problems:

  1. Git's color-parsing support does not understand the "noreverse"
     attribute. There is no way to turn off attributes short of doing a
     whole "reset". But we don't want to do that here, because we want
     whatever other colors were in effect to continue after the
     highlight ends. The patch to teach "noreverse" is below (though it
     should probably also teach "normal" and "noblink", too).

  2. The Git.pm:get_color code requires that we have a repository
     object, which means we will die() if we are not in a git
     repository. Yet "git config" will do the right thing whether we are
     in a repository or not. I would have thought all of the _maybe_self
     stuff in Git.pm would handle "Git->get_color" properly, but it
     doesn't. That's probably a bug that should be fixed.

I don't especially care about this feature, as I won't use it. But if
you are interested in using diff-highlight and the lack of configurable
colors is blocking you, then I at least know there will be one user and
I don't mind putting a little bit of time into it.

Here's the patch for (1) above.

diff --git a/color.c b/color.c
index e8e2681..b0f53a7 100644
--- a/color.c
+++ b/color.c
@@ -47,9 +47,9 @@ static int parse_color(const char *name, int len)
 
 static int parse_attr(const char *name, int len)
 {
-	static const int attr_values[] = { 1, 2, 4, 5, 7 };
+	static const int attr_values[] = { 1, 2, 4, 5, 7, 27 };
 	static const char * const attr_names[] = {
-		"bold", "dim", "ul", "blink", "reverse"
+		"bold", "dim", "ul", "blink", "reverse", "noreverse"
 	};
 	int i;
 	for (i = 0; i < ARRAY_SIZE(attr_names); i++) {
@@ -128,7 +128,7 @@ void color_parse_mem(const char *value, int value_len, const char *var,
 			attr &= ~bit;
 			if (sep++)
 				*dst++ = ';';
-			*dst++ = '0' + i;
+			dst += sprintf(dst, "%d", i);
 		}
 		if (fg >= 0) {
 			if (sep++)
