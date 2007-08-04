From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Fri, 03 Aug 2007 21:38:08 -0700
Message-ID: <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
	<200708040341.36147.ismail@pardus.org.tr>
	<7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
	<46B3F762.1050306@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 06:38:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHBP6-0006c5-AI
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 06:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbXHDEiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 00:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbXHDEiM
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 00:38:12 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:42824 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbXHDEiL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 00:38:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070804043810.VGDN7349.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 4 Aug 2007 00:38:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Xge91X0081kojtg0000000; Sat, 04 Aug 2007 00:38:10 -0400
In-Reply-To: <46B3F762.1050306@midwinter.com> (Steven Grimm's message of "Sat,
	04 Aug 2007 11:49:54 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54788>

Steven Grimm <koreth@midwinter.com> writes:

> How attached are we to asciidoc? Every time I do a clean build and sit
> there twiddling my thumbs waiting for xmlto to do its thing, I think
> to myself, "If this were a dedicated Perl script to do the syntax
> transformations directly to man and html formats, it would blast
> through all the .txt files in a second or two total." It seems
> outlandish to me that it takes longer to build the (relatively small)
> documentation than it does to build the actual code. Plus we
> constantly run into this sort of problem.

I cannot say that I am really happy with the current situation.
In my unscientific tests, it appears that we are spending about
50% of the time in asciidoc and 50% in xmlto for man backend
(total about 5 seconds for producing git.7 on my private box).
For xhtml11 backend, git.html takes about 2.3 seconds (for
xhtml11 backend, the output is written directly by asciidoc).

> Do we want to keep using asciidoc (e.g., so people can easily export
> to other asciidoc-supported formats), or is a dedicated renderer
> something we'd consider switching to? I have a flight from China back
> to the US coming in a couple weeks; this could be a perfect little
> project to keep me occupied between in-flight movies. It doesn't look
> like the syntax transformations are very hard, and it'd be easy enough
> to verify correctness by just comparing against the existing asciidoc
> output.
>
> Am I correct in observing that "*roff -man" and HTML are the only two
> output formats we care about, or do people use other formats in their
> private branches?

I obviously do not speak for others, but the only format I care
about personally is the *.txt one.  We picked asciidoc primarily
because the source language was readable.

Unfortunately, AsciiDoc 8 requires authors to quote more
"special characters" we would rather be able to use as literals
(most importantly, plus sign '+') than AsciiDoc 7, and I am
afraid the trend to hijack more non alphabet letters as
"special" may continue.

If I read you correctly, what you are proposing to offer is a
clone of asciidoc, perhaps AsciiDoc 7, with only xhtml11 and man
backends.  It is a subset in the sense that you will do only two
backends, but otherwise is a clone in the sense that you are
going to implement the input language we use (one thing I
personally care about while probably other people do not is the
conditional compilation "ifdef::stalenotes[]" in git.txt).

There is an obvious maintenance cost and risk with such a fork.

 * You would need to duplicate the AsciiDoc 7 manual and
   maintain it as well; otherwise, when later versions of
   AsciiDoc comes, people who update our documentation will
   refer to asciidoc website to learn the syntax, and find out
   that your dialect does not match what is described there.
   This already is the case, as our documentation source is
   written for AsciiDoc 7 and we use asciidoc7compatible support
   when running with AsciiDoc 8.

 * How much can we really rely on your fork to be kept
   maintained?  When we need newer mark-up that is not offered
   by AsciiDoc 7 clone, is it our plan to model that after
   AsciiDoc X (X > 7), or we just come up with an extension of
   our own?

 * What would happen when xhtml11 goes out of fashion and we
   would want to switch to newer formats?

 * What to do with the user manual, which formats to docbook
   "book" output?

I have a mild suspicion that a clone/fork of AsciiDoc is not a
way to go.

It might be more worthwhile to research what other "Text-ish
lightweight mark-up" systems are availble, and if there is one
that is more efficient and can go to at least html and man,
one-time convert our documentation source to that format using
your Perl magic.  The minimum requirements are:

 * The source is readable without too much mark-up distraction;

 * Can go to roff -man;

 * Can go to html.
