From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 1/8] Makefile: apply dependencies consistently to
 sparse/asm targets
Date: Wed, 20 Jun 2012 05:27:50 -0500
Message-ID: <20120620102750.GB4579@burratino>
References: <20120619232231.GA6328@sigill.intra.peff.net>
 <20120619232310.GA6496@sigill.intra.peff.net>
 <20120620035015.GA4213@burratino>
 <20120620042607.GA10414@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 12:28:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShI8u-0003qb-LH
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 12:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251Ab2FTK15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 06:27:57 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:41025 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225Ab2FTK14 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 06:27:56 -0400
Received: by ghrr11 with SMTP id r11so5464304ghr.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 03:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yZICmmBOfPP3uaD1pBxJfjIo4xb0W/51Dv0TkTSDap4=;
        b=C5yLk1tYoahS7mpwZ4XbEEFhV5HJ5jSeB4aEga24X3NdajtXVi7z3RFGK4zo4Iw6Q7
         C5WZIqmV3wY27NC8kZMrRaMvyZ0GauhceaLa8TbCnyl+FrkbZ7OaksioHLOKgc9JDYe+
         CFQAwr3utDMN3S2VzAvR11NMwub/mj9+GlSc3VDCNQhMQEpXkeCdMoCw1K8QJaHEYu3f
         wA0PSFr8dc6yV47KIYJauxd0eYVfh5hiUQ2kUjFPIW0+V12uWbinhdtWW5TdDgifqVJ7
         tgvsvLKvZvu5sTCaBM7QuQTx566f8SUODSHiY186C+XOC0gv6dCFJvAYOR7feWhLvBWH
         PFQQ==
Received: by 10.50.196.195 with SMTP id io3mr2158723igc.39.1340188075238;
        Wed, 20 Jun 2012 03:27:55 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id g5sm14803480ign.4.2012.06.20.03.27.54
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 03:27:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120620042607.GA10414@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200291>

Jeff King wrote:

>   1. The .sp and .s targets _do_ need the same -D macros that the .o
>      targets get.

Ah, you mean EXTRA_CPPFLAGS.  Yeah, that's also important, though the
patch doesn't have anything to do with it.

Some circuit in my mind missed that you meant EXTRA_CPPFLAGS and not a
file like GIT-CFLAGS.

[...]
>> It turns out that this patch is only about common-cmds.h, which was
>> the straightforward case.  Why not say so and save the reader from
>> having to think so hard? ;)
>
> Because I didn't realize it was the case at all. :) My intent was
> actually to clean up these lines so that they would be correct when I
> added GIT-VERSION-FILES and the like to them later.
>
> So I think my preference would be to tack on a note to the commit
> message saying "yeah, this doesn't do anything for meta-dependencies,
> but it doesn't hurt either". OK?

What is a meta-dependency?  I would find that even more confusing.

This change could be motivated more simply by saying that it prevents
"make git.sp", "make git.s", "make help.s", and "make builtin/help.s"
from failing when common-cmds.h doesn't exist yet, no?

The commit message could also say that it is improving consistency,
which is certainly valuable.

And a mention of EXTRA_CPPFLAGS and generated header files vs.
pre-existing header files could help explain that consistency.

But suggesting that we are supposed to ignore the FORCE just leaves
the reader wondering why the same patch does not also urgently need
to make additional changes such as the following, no?

	builtin/branch.o builtin/checkout.o builtin/clone.o \
	builtin/reset.o branch.o transport.o: branch.h

to

	builtin/branch.sp builtin/branch.o builtin/branch.s \
	builtin/checkout.sp builtin/checkout.o builtin/checkout.s \
	builtin/clone.sp builtin/clone.o builtin/clone.s \
	builtin/reset.sp builtin/reset.o builtin/reset.s \
	branch.sp branch.o branch.s \
	transport.sp transport.o transport.s: branch.h

Hoping that clarifies,
Jonathan
