From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] contrib/diff-highlight: multibyte characters diff
Date: Wed, 12 Feb 2014 15:59:48 -0500
Message-ID: <20140212205948.GA4453@sigill.intra.peff.net>
References: <1392109750-47852-1-git-send-email-sugi1982@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yoshihiro Sugi <sugi1982@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 21:59:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDguS-0001fL-5I
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 21:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbaBLU7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 15:59:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:49393 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753956AbaBLU7u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 15:59:50 -0500
Received: (qmail 4249 invoked by uid 102); 12 Feb 2014 20:59:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Feb 2014 14:59:49 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Feb 2014 15:59:48 -0500
Content-Disposition: inline
In-Reply-To: <1392109750-47852-1-git-send-email-sugi1982@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242024>

On Tue, Feb 11, 2014 at 06:09:10PM +0900, Yoshihiro Sugi wrote:

> diff-highlight split each hunks and compare them as byte sequences.
> it causes problems when diff hunks include multibyte characters.
> This change enable to work on such cases by decoding inputs and encoding output as utf8 string.

Thanks for looking at this. I didn't consider multibyte characters at
all when I wrote the original.

Sadly, applying your patch seems to cause diff-highlight to take about
1.5x as much CPU (I just tried it on the complete output of "git log
--all -p" in my git.git repository, which went from ~60s to ~90s). That
is not necessarily a deal-breaker, as it is more important to be
correct. But I wonder if there is any way we can optimize it. From my
understanding, it may not be the encoding/decoding itself, but rather
that the utf8-aware text routines are slower. More on that below.

>  # Highlight by reversing foreground and background. You could do
>  # other things like bold or underline if you prefer.
> @@ -15,8 +16,9 @@ my @added;
>  my $in_hunk;
>  
>  while (<>) {
> +	$_ = decode_utf8($_);

What happens when the diff content is not utf8 at all? The default
failure mode for decode_utf8 seems to be to replace non-utf8 sequences
with a substitution character. Which means we would corrupt something
like iso8859-1, which works fine in the current code.

>  	if (!$in_hunk) {
> -		print;
> +		print encode_utf8($_);

And we have the opposite question here. We know that what we have in the
string is perl's internal format. But how do we know that what the
user's terminal wants is utf8?

I think in the most general case, we would need to auto-detect the
encoding for each string (since there is no guarantee that a file even
retains the same encoding through its history). And then probably punt on
highlighting when comparing two lines in different encodings, and if
they are in the same encoding, treat them as a sequence of code points
rather than octets when comparing.

That's probably way too slow and complicated to worry about. And
frankly, I am OK with making the tool work _best_ with UTF-8, as long as
it can fail gracefully for other encodings (i.e., if you can turn off
the utf8 magic when you have another encoding, and we will pass it
through blindly as octets).

Would it be enough to do something like the patch below? The specific
things I am shooting for are:

  - the only part of the code that cares about the sequence is the
    split/highlight bit, and most lines do not get highlighted at all.
    Therefore it tries to lazily do the decode step, which gets back our
    lost performance (I measured ~12% slowdown).

  - we try the utf8 decode and if it fails, fall back to treating it
    like a sequence of bytes. That doesn't help people with other
    multibyte encodings, but at least lets single-byte encodings besides
    utf8 continue to work.

I constructed a very simple test of:

  git init &&
  printf 'cont\xc3\xa9nt\n' >file &&
  git add file &&
  printf 'cont\xc3\xb6nt\n' >file &&
  git diff

and it seemed to work. Can you confirm that it does the right thing on
your more complicated cases?

-Peff

---
diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index c4404d4..9447ba2 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -2,6 +2,7 @@
 
 use warnings FATAL => 'all';
 use strict;
+use Encode qw(decode_utf8 encode_utf8);
 
 # Highlight by reversing foreground and background. You could do
 # other things like bold or underline if you prefer.
@@ -73,13 +74,23 @@ sub show_hunk {
 
 	my @queue;
 	for (my $i = 0; $i < @$a; $i++) {
-		my ($rm, $add) = highlight_pair($a->[$i], $b->[$i]);
-		print $rm;
-		push @queue, $add;
+		my ($a_dec, $encode_rm) = decode($a->[$i]);
+		my ($b_dec, $encode_add) = decode($b->[$i]);
+		my ($rm, $add) = highlight_pair($a_dec, $b_dec);
+		print $encode_rm->($rm);
+		push @queue, $encode_add->($add);
 	}
 	print @queue;
 }
 
+sub decode {
+	my $orig = shift;
+	my $decoded = eval { decode_utf8($orig, Encode::FB_CROAK) };
+	return defined $decoded ?
+	       ($decoded, sub { encode_utf8(shift) }) :
+	       ($orig, sub { shift });
+}
+
 sub highlight_pair {
 	my @a = split_line(shift);
 	my @b = split_line(shift);
