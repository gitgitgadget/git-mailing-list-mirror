From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] pretty: format aliases
Date: Sun, 25 Apr 2010 15:48:00 -0400
Message-ID: <20100425194800.GB14736@coredump.intra.peff.net>
References: <1272210175-20484-1-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 21:48:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O67oY-0004Af-Lz
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 21:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab0DYTsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 15:48:05 -0400
Received: from peff.net ([208.65.91.99]:39955 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837Ab0DYTsE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 15:48:04 -0400
Received: (qmail 30969 invoked by uid 107); 25 Apr 2010 19:48:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 25 Apr 2010 15:48:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Apr 2010 15:48:00 -0400
Content-Disposition: inline
In-Reply-To: <1272210175-20484-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145763>

On Sun, Apr 25, 2010 at 04:42:52PM +0100, Will Palmer wrote:

> The following patch series adds the ability to configure aliases for
> user-defined formats. The first two patches define new placeholders and
> modify the output of existing placeholders to allow aliases to be more
> consistent with the way builtin formats are handled. The final patch
> adds support for the aliases themselves.

Interesting idea. I think right now most people just want to use their
format with "log", so they would do something like:

  git config alias.mylog "log --format='...'"

Your method allows the same format to be used with multiple commands,
which is more flexible. But I wonder how many people would find it
useful in practice. I can think of only "log" and "show" that I would
really want to share between.

I skimmed your patches and have included a few comments below, as I
don't have time at the moment to do a thorough review.

> There were a couple of places where I wasn't entirely sure about which
> color setting I should be following, but I've tried to be consistent
> throughout. It may be that I could have simply followed diffopt's color
> option in all cases, in which case various modifications to show_log()
> were entirely unnecessary. I'll await judgement at the hands of one who
> groks those sections more than I do, but I think what I've done feels
> correct.

I think that makes some sense. The "diff" color option was the first,
and so the commit-coloring in "git log" follows that already. So short
of making a new "color.log" variable, that makes the most sense.

> My original goal was to make it possible to define all of the builtin
> formats as builtin aliases to format strings, but complications

I like that goal. As you found out, it may be harder than you would
like. But the pretty-print code is IMHO a bit messy with conditionals,
and most of it can now be expressed as much simpler user-formats.

>   pretty: add conditional %C?colorname placeholders

This one seems reasonable overall.

>   pretty: make %H/%h dependent on --abbrev[-commit]

This is really a variation on the first one. And there are more
variations, like %T/%t, %P/%p, etc. I'm a little hesitant to just change
the meaning of "%H", which has always explicitly meant the full sha1.
Should we perhaps introduce some universal syntax for "abbreviate if
--abbrev was given, otherwise full sha1". Like "%?H" as you did above,
except that "?" doesn't really make sense.

>   pretty: add aliases for pretty formats

The config variables format.* are traditionally about format-patch. I
see we have format.pretty these days, too. I'm not sure if that is a
deliberate attempt to make format.* more inclusive, or simply an error.
If the latter, we should probably not make it worse with
format.pretty.name.

-Peff

PS Welcome to the git list. It is nice to see a submission from a
newcomer who has clearly read SubmittingPatches, and that even has
appropriate documentation and test updates. :)
