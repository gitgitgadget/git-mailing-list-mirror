From: Jeff King <peff@peff.net>
Subject: Re: Proposed git mv behavioral change
Date: Sat, 20 Oct 2007 02:24:00 -0400
Message-ID: <20071020062400.GA30388@coredump.intra.peff.net>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <20071019015419.GV14735@spearce.org> <A2C1BF08-4CC8-4F98-9CA8-B81B2FBFE9E4@mit.edu> <20071019031959.GE14735@spearce.org> <20071019032407.GA10622@coredump.intra.peff.net> <7E3647F4-E61C-4FBE-9AA7-81CDBE324308@MIT.EDU> <20071019033500.GB10697@coredump.intra.peff.net> <93BF5798-F1C3-48EE-8233-A0F111BF8138@MIT.EDU> <20071019034704.GB11095@coredump.intra.peff.net> <1192859748.13347.146.camel@g4mdd.entnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@MIT.EDU>, git@vger.kernel.org
To: Ari Entlich <lmage11@twcny.rr.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 08:24:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij7kx-0004Br-NO
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 08:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765AbXJTGYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 02:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbXJTGYF
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 02:24:05 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2221 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663AbXJTGYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 02:24:04 -0400
Received: (qmail 18928 invoked by uid 111); 20 Oct 2007 06:24:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 20 Oct 2007 02:24:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Oct 2007 02:24:00 -0400
Content-Disposition: inline
In-Reply-To: <1192859748.13347.146.camel@g4mdd.entnet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61790>

On Sat, Oct 20, 2007 at 01:55:48AM -0400, Ari Entlich wrote:

> Well, I also want to move the working directory file so that the index
> and the working directory still match up and so that their differences
> are preserved. Therefore, --cached isn't quite right (see Shawn's
> messages and my response to them).

Ah, OK. I understand now. So what you would want could be accomplished
with something like:

  mv A B
  (git-ls-files -s | sed s/A$/B/;
   echo 0 0000000000000000000000000000000000000000	A) \
  | git-update-index --index-info

IOW:
  1. move working tree A to B
  2. create staged entry B, same as staged entry A
  3. remove staged entry A

> Hmm, that's an interesting point. Are you talking about situations in
> which your changes after (1) leave the program in an uncompilable state?

No, I meant more that the state you have staged will never have actually
existed in your working tree, so you could not possibly have tested it.
However, it may be that the changes you are trying to avoid staging are
trivial, and you're willing to accept that. And git shouldn't stand in
your way.

And it sounds like you don't necessarily want to make a _commit_ out of
this, you just want to keep working and not have git-mv munge your
staged state.

> I don't really see why you're analyzing the situations in which this
> would be used. I think it should be obvious from my descriptions of my

Because I was having trouble understanding what Michael was trying to
accomplish with his "here are two methods, and one is better" since they
seemed to do different things. But that is perhaps my fault for joining
the thread in the middle. I may have simply caused more confusion by
getting involved. :)

Now I think I understand exactly what you're trying to accomplish,
and I agree that it makes sense.  Shawn is right that "git-mv --cached"
doesn't do what you want, since to be consistent with other tools it
wouldn't touch the working tree (though I wonder if you would be
satisfied with "git-mv --cached A B; mv A B"). I think at this point the
best way forward is to produce a patch and try to solicit comments (in
particular, which behaviors should be supported (current, --cached, or
what you are proposing) and which should be the default).

> But... that's not even the point I was going to make. I think the
> questions you should be asking are things like "Does this fit with the
> overall architecture?", "Does this or doesn't this provide power and
> flexibility to the user?", etc. Is git being made for "the 80%" that use

There seems to be a strong sentiment among the various gits that you
shouldn't build in flexibility for the sake of flexibility if there's no
good use for it. I tend to be less of that sentiment than some others
here, but I think when proposing a feature it is still worth saying "and
here's why it's useful."

> Sorry if anything I've said here sounded confrontational; that was not
> not my intent at all. I'm just raising some points I think are
> important. I don't want any flame wars...

I think you stated your position fine. And we've had enough flame wars
around here lately to last us a while.

-Peff
