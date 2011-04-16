From: Jeff King <peff@peff.net>
Subject: Re: textconv not invoked when viewing merge commit
Date: Sat, 16 Apr 2011 02:33:53 -0400
Message-ID: <20110416063353.GB28853@sigill.intra.peff.net>
References: <4DA415AB.9020008@drmicha.warpmail.net>
 <20110414190901.GA1184@sigill.intra.peff.net>
 <7vipughbxh.fsf@alter.siamese.dyndns.org>
 <7vd3kohb5n.fsf@alter.siamese.dyndns.org>
 <7v8vvcha2s.fsf@alter.siamese.dyndns.org>
 <20110414202356.GB6525@sigill.intra.peff.net>
 <vpq62qg3sxy.fsf@bauges.imag.fr>
 <7v7havckgg.fsf@alter.siamese.dyndns.org>
 <20110416014758.GB23306@sigill.intra.peff.net>
 <7v39lid8uz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Oberndorfer <kumbayo84@arcor.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 08:34:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAz54-0008JO-0I
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 08:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab1DPGd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 02:33:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49536
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214Ab1DPGd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 02:33:57 -0400
Received: (qmail 18346 invoked by uid 107); 16 Apr 2011 06:34:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 16 Apr 2011 02:34:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Apr 2011 02:33:53 -0400
Content-Disposition: inline
In-Reply-To: <7v39lid8uz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171664>

On Fri, Apr 15, 2011 at 11:10:44PM -0700, Junio C Hamano wrote:

> >> And the ones that have been parsing cdiff wouldn't have done anything good
> >> before this change on such a binary blob anyway, no?
> >
> > No, but we can view the proposed change as fixing a bug for such a tool
> > Whereas turning it into:
> >
> >   --Binary blob XXX
> >   + Binary blob YYY
> >    +Binary blob ZZZ
> >
> > is codifying ambiguous output, and making the tool forever broken.
> 
> Of course, if we did this for a plumbing command and when the user did not
> ask for --textconv, I would agree with your argument.  Such an output
> makes it impossible to tell between the text files that had these lines
> and binary files.

OK, but what do you intend to do for a plumbing command _without_
--textconv? I think what it is doing now (pretending that lines in the
binary file are relevant, and either truncating output on NUL or spewing
NULs to the output stream) is just wrong.

The only reasonable thing I see there is inventing some combined-diff
form of the "Binary files differ" message.

> What I am suggesting is to make any binary file use a fallback textconv
> "Binary blob $SHA-1", when the --textconv option is given from the command
> line and no textconv filter is configured for the path, in any textconv
> aware commands consistently, not limited to -c/--cc under discussion.

Ick, why? That pseudo-diff contains no additional interesting
information that is not already there (since the "index" line already
contains the blob sha1s). I suppose one could argue that it's more
readable, but I don't find it so; I actually think it is less readable,
because it makes you (even as a human, not a parsing script) think you
are looking at a meaningful text diff.

And then on top of that is the fact that what we do now is consistent
with other diff implementations, so people expect it.

> With the current codebase, such a change *would* break a bog-standard,
> two-way "git diff" for a binary file; we do want to see the traditional
> "Binary files differ" by not using the fallback textconv, but we cannot
> tell if the --textconv option was explicitly given from the command line
> with the test used in Michael's patch (i.e. ALLOW_TEXTCONV), because we
> set the bit by default for Porcelain commands.  And showing "-Binary X"
> followed by "-Binary Y" is simply wrong and ambiguous, of course, in such
> a case.  We need to be able to tell if an explicit --textconv was given or
> we have ALLOW_TEXTCONV merely because we are running a Porcelain.
> 
> But I suspect that isn't something we cannot fix---we can just use another
> bit to record that in the command line parser.

Sure, it would take some code tweaking, but it wouldn't be hard to get
the behavior you are mentioning.

> Once that is fixed, I don't think giving "Binary files differ" when the
> line-counter script reads from a plumbing command that was invoked
> explicitly with the --textconv command is any better than giving the above
> three lines.  For a two-way merge, it does not matter much, but when
> viewing a merge with three or more parents, -c/--cc output that shows
> which sets of parents had the same blobs would be useful for humans (and
> tools) than a single "Binary files differ" output that does not tell any
> details.

Oh, sure. I am not proposing that "-c" should just say exactly "Binary
files X and Y differ", only that we need a message _like_ that.  I think
it would be fine to represent which parents had which sha1, either in
some structured format or even as text. I just think that making it look
exactly like a text diff (even though, yes, that is a convenient
structured format that we already have) is unnecessarily confusing to
both humans and scripts.

-Peff
