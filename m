From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff-highlight: Fix broken multibyte string
Date: Fri, 3 Apr 2015 18:08:22 -0400
Message-ID: <20150403220821.GB11220@peff.net>
References: <1427730933-26189-1-git-send-email-eungjun.yi@navercorp.com>
 <20150330221635.GB25212@peff.net>
 <ffa56a1b1257732077c287a5cfdd138@74d39fa044aa309eaea14b9f57fe79c>
 <20150403012430.GA16173@peff.net>
 <CAFT+Tg8-tUBAvgX1bTni7joye_ZuZ_NOT_mmamnnm5GdWzEhrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Git List <git@vger.kernel.org>
To: "Yi, EungJun" <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 00:08:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye9lN-0003uG-LI
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 00:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911AbbDCWIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 18:08:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:42219 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752791AbbDCWIY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 18:08:24 -0400
Received: (qmail 13062 invoked by uid 102); 3 Apr 2015 22:08:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Apr 2015 17:08:24 -0500
Received: (qmail 26144 invoked by uid 107); 3 Apr 2015 22:08:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Apr 2015 18:08:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2015 18:08:22 -0400
Content-Disposition: inline
In-Reply-To: <CAFT+Tg8-tUBAvgX1bTni7joye_ZuZ_NOT_mmamnnm5GdWzEhrg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266740>

On Fri, Apr 03, 2015 at 11:19:24AM +0900, Yi, EungJun wrote:

> > I timed this one versus the existing diff-highlight. It's about 7%
> > slower. That's not great, but is acceptable to me. The String::Multibyte
> > version was a lot faster, which was nice (but I'm still unclear on
> > _why_).
> 
> I think the reason is here:
> 
> > sub split_line {
> >    local $_ = shift;
> >    return map { /$COLOR/ ? $_ : ($mbcs ? $mbcs->strsplit('', $_) : split //) }
> >           split /($COLOR)/;
> > }
> 
> I removed "*" from "split /($COLOR*)/". Actually I don't know why "*"
> was required but I need to remove it to make my patch works correctly.

Ah, OK, that makes more sense. The "*" was meant to handle the case of
multiple groups of ANSI colors in a row. But I think it should have been
"+" in that case, as we would otherwise split on the empty field, which
would mean character-by-character. And the second "split" in the map
would then be superfluous, which would break your patch (we've already
split the multi-byte characters before we even hit $mbcs->strsplit).

Kyle's patch does not care, because it tweaks the string so that normal
split works. Which means there is an easy speedup here. :)

Doing:

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index 08c88bb..1c4b599 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -165,7 +165,7 @@ sub highlight_pair {
 sub split_line {
 	local $_ = shift;
 	return map { /$COLOR/ ? $_ : (split //) }
-	       split /($COLOR*)/;
+	       split /($COLOR+)/;
 }
 
 sub highlight_line {

gives me a 25% speed improvement, and the same output processing
git.git's entire "git log -p" output.

I thought that meant we could also optimize out the "map" call entirely,
and just use the first split (with "*") to end up with a list of $COLOR
chunks and single characters, but it does not seem to work. So maybe I
am misreading something about what is going on.

-Peff
