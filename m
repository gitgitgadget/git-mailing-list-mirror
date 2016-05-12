From: Jeff King <peff@peff.net>
Subject: Re: t0008 test fails with ksh
Date: Thu, 12 May 2016 14:20:55 -0400
Message-ID: <20160512182055.GB13886@sigill.intra.peff.net>
References: <CALR6jEjWjJA0X2qXsxqObqc_yxrgX87LYf8cmJ0MmJFF6PkmTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 12 20:21:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0vEM-00041L-Hd
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 20:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbcELSU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 14:20:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:38692 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751693AbcELSU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 14:20:58 -0400
Received: (qmail 1662 invoked by uid 102); 12 May 2016 18:20:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 14:20:57 -0400
Received: (qmail 12110 invoked by uid 107); 12 May 2016 18:20:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 14:20:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 May 2016 14:20:55 -0400
Content-Disposition: inline
In-Reply-To: <CALR6jEjWjJA0X2qXsxqObqc_yxrgX87LYf8cmJ0MmJFF6PkmTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294424>

On Thu, May 12, 2016 at 07:53:28PM +0200, Armin Kunaschik wrote:

> The reason seems that the snippet
> cat <<-EOF >expected-all
>         .gitignore:1:one        ../one
>         ::      ../not-ignored
>         .gitignore:1:one        one
>         ::      not-ignored
>         a/b/.gitignore:8:!on*   b/on
>         a/b/.gitignore:8:!on*   b/one
>         a/b/.gitignore:8:!on*   b/one one
>         a/b/.gitignore:8:!on*   b/one two
>         a/b/.gitignore:8:!on*   "b/one\"three"
>         a/b/.gitignore:9:!two   b/two
>         ::      b/not-ignored
>         a/.gitignore:1:two*     b/twooo
>         $global_excludes:2:!globaltwo   ../globaltwo
>         $global_excludes:2:!globaltwo   globaltwo
>         $global_excludes:2:!globaltwo   b/globaltwo
>         $global_excludes:2:!globaltwo   ../b/globaltwo
>         ::      c/not-ignored
> EOF
> 
> behaves differently in bash and in ksh.
>         a/b/.gitignore:8:!on*   "b/one\"three" comes out unmodified
> with bash but with ksh it becomes
>         a/b/.gitignore:8:!on*   "b/one"three"
> I'm not sure what shell is "wrong" here, but when I modify the line to
>         a/b/.gitignore:8:!on*   "b/one\\"three"
> both shells generate the "right" output:
>         a/b/.gitignore:8:!on*   "b/one\"three"
> 
> From what I've learned I'd expect the double backslash to be the
> "right" way to escape one
> backslash. Do you agree or am I wrong?
> 
> This snippet appears twice in this test, generates expected-all and
> expected-verbose.

I think either is reasonable (there is no need to backslash-escape a
double-quote inside a here-doc, but one assumes that backslash would
generally have its usual behavior). I'm not quite sure how to interpret
POSIX here (see below), but it seems clear that spelling it with two
backslashes as you suggest is the best bet.

For the curious, here's what POSIX says (in the section on
here-documents; "word" here refers to the EOF word):

  If no characters in word are quoted, all lines of the here-document
  shall be expanded for parameter expansion, command substitution, and
  arithmetic expansion. In this case, the backslash in the input behaves
  as the backslash inside double-quotes (see Double-Quotes). However,
  the double-quote character ( '"' ) shall not be treated specially
  within a here-document, except when the double-quote appears within
  "$()", "``", or "${}".

So OK, that sounds like ksh is doing the right thing. But what's that
"specially" in the last sentence? Do they just mean it doesn't start a
quoted section as it would elsewhere? Or do they mean in the section on
Double-Quotes, when they say:

  \
      The backslash shall retain its special meaning as an escape
      character (see Escape Character (Backslash)) only when followed by
      one of the following characters when considered special:

              $   `   "   \   <newline>

Since the double-quote isn't special here, does that mean that backslash
shouldn't retain its special meaning in this case?  That would make bash
right.

Anyway, it doesn't really matter what the standard says. We can spell
this in a less ambiguous way, and it does not hurt too much to do so.

-Peff
