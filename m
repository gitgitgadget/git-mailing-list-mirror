From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 02/11] Makefile: fold MISC_H into LIB_H
Date: Fri, 6 Jul 2012 17:47:18 -0500
Message-ID: <20120706224718.GB3728@burratino>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183055.GB30995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 07 00:47:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnHJJ-0007rh-97
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jul 2012 00:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758424Ab2GFWr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 18:47:26 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:36620 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756913Ab2GFWrW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 18:47:22 -0400
Received: by ghrr11 with SMTP id r11so9110584ghr.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 15:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HaFT73M2cKqbH67usZurjuRy7xnn8DG+Qp/2naRPkl8=;
        b=mt4rJw5DeCXywCcdPhFJDXXqaTd2gVPMieTn24Br59E5yOnsKQ3gFRjXX7wZSiVONz
         acZWLP75PKsK+Ym35XPcbxsAPokIXXrUhjerkRz5MJqu9iZgK9bdfnCo3heDuh8qCsji
         CUfM4qjvPUPbyLuLwhMaKarn3BP70z2iOtlja1FogNUbPtTmjR4u3XsSYIVCLbIpfEKh
         ERx2GSD+G8dQWaLYBiz0ErcUtWQ5kMZZseKcokb9PSk50q23Rye/EDgpetUamVVbR0wT
         B5iTnhQ50UhpnKEVQIZobJdUyFk1ccPxsCA/f8uHv12+nd/U94xcHzVnHlwOAERXuPzU
         OwJw==
Received: by 10.50.209.73 with SMTP id mk9mr3492818igc.66.1341614841983;
        Fri, 06 Jul 2012 15:47:21 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id dw5sm3428607igc.6.2012.07.06.15.47.20
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 15:47:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120620183055.GB30995@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201153>

Hi,

I finally found some moments to revisit this series, so I'm starting
here.  I think the justification for this patch is something like
this:

  Keeping track of what files include each header is an error-prone
  chore.  On top of that, for l10n, these days we have to keep a master
  list of all headers, too, which is double work when adding a new
  header that adds insult to injury.

  Active Makefile hackers tend to use compilers like gcc that support
  automatic dependency generation with -MMD.  The precise header deps
  aren't even used when building with these compilers, so the people
  maintaining the precise header deps do not benefit from them at all.
  Unfair!

  Non-developers who can't fend for themselves do not rebuild after a
  small header change very often, so they would not be hurt much by a
  "change one header, rebuild everything" rule when automatic
  dependency generation is disabled, either.

  That leaves at least one important category of people to be hurt by
  this change: the glorious MSVC hackers.  MSVC supports the
  appropriate magic to compute header dependencies, but no one's
  gotten around to teaching the Makefile to use it yet.  So let's stop
  delaying the inevitable and drop the detailed dependencies.  If
  anyone complains then we can work with them to finish support for
  computing header dependencies for the relevant compiler.

Fair enough.  

Two details puzzle me:

Jeff King wrote:

>                                 The original point
> of LIB_H was that it would force recompilation of C files
> when any of the library headers changed.

LIB_H was introduced by commit e590d694 (Add more header dependencies,
2005-04-18).  It only lists

	cache.h
	object.h

even though some translation units included tree.h, commit.h, or
blob.h already.  So at least back then, it seems to have been about
library headers and not about all headers (and "all headers" was
puzzlingly not worth worrying about at all).

So isn't this a fundamentally new thing, rather than a return to the
state of nature?

The other remaining question is why we don't use something like
$(wildcard *.h) and avoid listing individual headers altogether.
Is the fear that some stray non-git header will find its way into
the cwd and poison the translation files?  (If so, I'd like to
document that as well to help readers understand why we keep doing
the work we do.)

Ciao,
Jonathan
