From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v2 3/4] use new config API for worktree
 configurations of submodules
Date: Mon, 14 Jul 2014 22:57:59 +0200
Message-ID: <20140714205759.GA3682@sandbox-ub>
References: <20140628095800.GA89729@book.hvoigt.net>
 <20140628100321.GD89729@book.hvoigt.net>
 <xmqqy4w38v6r.fsf@gitster.dls.corp.google.com>
 <20140709195547.GA3081@sandbox-ub>
 <xmqqegxu9ojh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 22:58:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nKK-0002Rl-9j
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559AbaGNU6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:58:20 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:38693 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756180AbaGNU6T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:58:19 -0400
Received: from [37.4.179.65] (helo=sandbox-ub)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1X6nK2-0002Wl-Qn; Mon, 14 Jul 2014 22:58:06 +0200
Content-Disposition: inline
In-Reply-To: <xmqqegxu9ojh.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253514>

On Wed, Jul 09, 2014 at 03:04:50PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > On Tue, Jul 08, 2014 at 01:14:20PM -0700, Junio C Hamano wrote:
> >> Heiko Voigt <hvoigt@hvoigt.net> writes:
> >> 
> >> > diff --git a/builtin/checkout.c b/builtin/checkout.c
> >> > index 07cf555..03ea20d 100644
> >> > --- a/builtin/checkout.c
> >> > +++ b/builtin/checkout.c
> >> > @@ -18,6 +18,7 @@
> >> >  #include "xdiff-interface.h"
> >> >  #include "ll-merge.h"
> >> >  #include "resolve-undo.h"
> >> > +#include "submodule-config.h"
> >> >  #include "submodule.h"
> >> >  #include "argv-array.h"
> >> >  
> >> 
> >> Hmph.  What is this change about?  
> >> 
> >> Nobody in checkout.c needs anything new, yet we add a new include?
> >
> > This is because I moved the parse_submodule_config_option() function
> > into the submodule-config.c module. This was necessary so all parsed
> > submodule values are stored in the cache with the null_sha1. We use
> > static functions from this module to do this and thats thats the reason
> > for the move. 
> >
> >> > diff --git a/diff.c b/diff.c
> >> > index f72769a..f692a3c 100644
> >> > --- a/diff.c
> >>  ...
> >> Likewise.
> >
> > Same as above.
> 
> Can there be any caller that include and use submodule-config.h that
> does not need anythjing from submodule.h?  Or vice versa?
> 
> It just did not look like these two headers describe independent
> subsystems but they almost always have to go hand-in-hand.  And if
> that is the case, perhaps it is not such a good idea to add it as a
> new header.  That was where my question came from.

The reason for a separate module was because we add quite some lines of
code for it.

$ wc -l submodule.c
1068 submodule.c
$ wc -l submodule-config.c 
435 submodule-config.c

Because of this I would like to keep the c-files separate.

The header simply came from that. It is possible to use them
individually but it is very likely that we will always use both. At the
moment all occurrences of submodule-config.h also have submodule.h. The
other way around it is not that way.

I like it to have a header per c-module since you directly know where to
look for definitions. Also the config topic can be considered a separate
subsystem for submodules. And for me it feels that way. If we want to
make it easier for the user it probably makes sense to move the
declarations into submodule.h

But then how should we document it? As api-submodule.txt?

I do not have a strong opinion either way. I like it in the current
shape but if you convince me it makes more sense with one header, I
would also be fine with it.

Cheers Heiko
