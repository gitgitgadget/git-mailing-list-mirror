From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v5 1/4] implement submodule config API for lookup of
 .gitmodules values
Date: Mon, 13 Jul 2015 13:17:25 +0200
Message-ID: <20150713111725.GB27160@book.hvoigt.net>
References: <cover.1434400625.git.hvoigt@hvoigt.net>
 <ef740bdea9af35564c75efd2a6daae65f3108df5.1434400625.git.hvoigt@hvoigt.net>
 <CABURp0pyYcKvmbEeDSYqm15DtXvH7g_UXASR3utGco+=D95bOA@mail.gmail.com>
 <20150709120900.GA24040@book.hvoigt.net>
 <20150709154903.GA14320@peff.net>
 <559ECE6A.2070802@web.de>
 <xmqqoajlumnp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 13:20:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEbmX-0003tm-4c
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 13:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbbGMLUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 07:20:14 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:44248 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbbGMLUN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 07:20:13 -0400
Received: from [188.108.15.213] (helo=book.hvoigt.net)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1ZEbj0-0001Ay-PJ; Mon, 13 Jul 2015 13:16:42 +0200
Content-Disposition: inline
In-Reply-To: <xmqqoajlumnp.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273914>

On Thu, Jul 09, 2015 at 01:00:10PM -0700, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
> >> How does git-submodule access this information? It looks like it just
> >> hits "git config -f .gitmodules" directly. Perhaps whatever interface is
> >> designed should be suitable for its use here (and if there really is no
> >> more interesting interface needed, then why is "git config" not good
> >> enough for other callers?).
> >
> > The git-submodule script doesn't need this and is fine using plain old
> > "git config", as by the time it is run the .gitmodules file is already
> > updated in the work tree. Heiko's series is about adding infrastructure
> > to allow builtins like checkout and friends to access the configuration
> > values from the .gitmodules file of the to-be-checked-out commit when
> > run with "--recurse-submodules". And yes, if we want to expose this
> > functionality to users or scripts some day "git config" looks like the
> > best place to do that to me too.
> 
> Did you mean "git submodule config"?

I think he actually meant "git config" and that is already implemented.
When I implemented the infrastructure to read configurations from blobs,
Peff extended it so it will be exposed via the config command line. E.g.
you can do:

	git config --blob HEAD^^^:.gitmodules <value>

to get .gitmodules configurations from the history, so that is already
implemented.  And for reading .gitmodules values we probably do not need
more, since calling git from scripting we always have new invocations of
processes anyway and that would throw away the cache I am implementing.
Reading such values via config from scripts is also more flexible since
it supports arbitrary values and my cache only specific values needed by
the builtins that use it.

My submodule config cache infrastructure is directed for C-code wanting
to query submodule values. So e.g. when "git checkout" wants to know
about values but the ".gitmodules" file that is in charge, but has not
been checked out yet. We also need this for fetch which will actually
need values from more than one revision, since we might need to merge
configurations when fetching multiple branches. Fetch also needs
information about URLs for new submodules that appear in branches, when
auto clone is switched on. That means to support the "I want to go on an
airplane get me everything I might need" use-case.

Cheers Heiko
