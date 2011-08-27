From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Makefile: Improve compiler header dependency check
Date: Sat, 27 Aug 2011 14:19:59 -0700
Message-ID: <20110827211958.GA45286@gmail.com>
References: <1314434470-7988-1-git-send-email-davvid@gmail.com>
 <20110827162645.GA10476@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 27 23:20:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxQIi-0007PU-QA
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 23:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603Ab1H0VUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 17:20:08 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:56715 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab1H0VUG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 17:20:06 -0400
Received: by pzk37 with SMTP id 37so6213193pzk.1
        for <git@vger.kernel.org>; Sat, 27 Aug 2011 14:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gSjTHPbahFpgpHrLxklVlQewNVP6JtK+OryvJMH6vVw=;
        b=RE4OAvFiS3tH7DN23Jqb/zvjKyGjODpHZhip4MtSiH4td5CIRpgvymfoig6HD2lWxj
         scU2Fu3wXoadYl6ZMkkg6ZR4HhTYke0AqskKodhBmqsdkc3CODpyi+gn3Dky6HMswrVe
         iZAGJITzHvDig6fiDfbYCqQY0/S4lv22qxB/s=
Received: by 10.142.201.17 with SMTP id y17mr1498192wff.104.1314480005801;
        Sat, 27 Aug 2011 14:20:05 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net. [208.106.56.2])
        by mx.google.com with ESMTPS id x6sm9021928pba.5.2011.08.27.14.20.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Aug 2011 14:20:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110827162645.GA10476@elie.gateway.2wire.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180248>

On Sat, Aug 27, 2011 at 11:26:54AM -0500, Jonathan Nieder wrote:
> David Aguilar wrote:
> 
> > I fired up git's next branch on a mac laptop where I
> > have a config.mak that builds universal git binaries:
> >
> > CFLAGS = -arch i386 -arch x86_64
> >
> > This configuration broke when 111ee18c31f9bac9436426399355facc79238566
> > was merged into next.
> 
> Good catch; thanks.  This information would be useful for the commit
> message.
> 
> > gcc cannot generate header dependencies when
> > multiple -arch statements are used
> 
> Sounds like a bug.  Any idea why it behaves that way?  What error message
> does it write?
> 
> If it is a bug, it might be worth reporting this to the gcc devs while
> at it.

This has been the behavior for as long as I can remember.
I don't think it's a bug.  I included the error message
in the commit message for [PATCH v2]:

	gcc-4.2: -E, -S, -save-temps and -M options are
	not allowed with multiple -arch flags

I don't think it's a gcc bug.  This is just another one of
those annoying mac-isms.  When building against multiple archs
gcc will include a different set of headers for each arch
which is likely why the gcc devs do not support it.

I sent a v2 version of the patch that uses $(SHELL_PATH)
and omits $(EXTRA_CPPFLAGS).

I think the ideal situation would be for the dependency
check to emit headers required across all architectures
but that's not how it works.  Perhaps there are some
internal architectural limitations in gcc that prevent
it from being done that way.

My experience has been that most projects DTRT when CFLAGS
is configured this way.  It's always one or two that require
intrusive Makefile or libtool hacks to make them build
universal and those are no fun ;-)

BTW after applying this patch I immediately ran into the
compat/obstack.[ch] portability problem that I responded
to in another thread.  I was finally able to make git
build with the patch that I included inline there but
I think it still needs work.  I'll keep an eye on that
thread so that we can get a final patch for it.

I also noticed that a few of our compat/ files have
gcc/autoconf-isms such as:

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

Should I clean these up?  They seem unnecessary.
-- 
					David
