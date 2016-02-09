From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1] travis-ci: override CFLAGS properly, add
 -Wdeclaration-after-statement
Date: Tue, 9 Feb 2016 12:36:22 -0500
Message-ID: <20160209173622.GA28699@sigill.intra.peff.net>
References: <1454921958-53129-1-git-send-email-larsxschneider@gmail.com>
 <20160208122551.GD24217@sigill.intra.peff.net>
 <9FBB5AFB-D44C-43A1-A0C5-A5A45675A122@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>, linux.mdb@gmail.com,
	Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 18:36:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTCDH-0005ki-PD
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 18:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969AbcBIRg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 12:36:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:39313 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932949AbcBIRgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 12:36:25 -0500
Received: (qmail 6437 invoked by uid 102); 9 Feb 2016 17:36:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Feb 2016 12:36:24 -0500
Received: (qmail 18553 invoked by uid 107); 9 Feb 2016 17:36:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Feb 2016 12:36:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Feb 2016 12:36:22 -0500
Content-Disposition: inline
In-Reply-To: <9FBB5AFB-D44C-43A1-A0C5-A5A45675A122@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285842>

On Tue, Feb 09, 2016 at 11:06:17AM +0100, Lars Schneider wrote:

> I collected the warnings from Junio's Make [1] script and merged them with 
> yours. This is the resulting warning list for clang and gcc:
> 
> -Wdeclaration-after-statement -Wno-format-zero-length -Wold-style-definition 
> -Woverflow -Wpointer-arith -Wstrict-prototypes -Wunused -Wvla

Sounds right.

> > I have, however, wondered if it would make sense to codify this
> > knowledge in the Makefile with an optional knob. E.g., let DEVELOPER=1
> > roughly mean "you are a git dev, you have a reasonably modern compiler,
> > and want to be as careful as possible before sending your patches".
> 
> That make sense. However, in "development mode" I don't like Werror.
> How about two knobs? One called DEVELOPER which enables all the warnings
> above and one called CONTINUOUS_INTEGRATION that enables Werror
> in addition?

I'm curious why you don't want -Werror. Junio is going to compile the
result of applying your patch with it, so it makes sense to me to catch
problems as early as possible.

And while there are certainly false positives from gcc's warnings, we
work to squelch them whether -Werror is in effect or not. So IMHO,
-Werror is mostly about making sure you _see_ the warnings and don't
lose them in a flood of compilation messages.

> Regarding CI checks:
> 
> Jeff Merkey made me aware of http://kernelnewbies.org/FirstKernelPatch [2]
> where I found checkpatch.pl [3]. Would it make sense to check all commits
> that are not in next/master/maint with this script on Travis-CI?
> 
> Stefan Beller recently mentioned "Adhere to the common coding style of 
> Git" [4] where he removed explicit NULL checks. This kind of stuff could be
> checked automatically with checkpatch.pl as far as I can see.

Perhaps. I'm not sure that people actually use checkpatch.pl for git.
Out of curiosity, I tried:

  mkdir out
  git format-patch -o out v2.6.0..v2.7.0
  checkpatch.pl out/*

It's rather noisy, and after skimming, I'd say (subjectively) that only
a small fraction are actual style issues we try to enforce. So it would
certainly need a fair bit of tweaking for regular use, I think.

-Peff
