From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v5 1/4] implement submodule config API for lookup of
 .gitmodules values
Date: Thu, 9 Jul 2015 14:09:01 +0200
Message-ID: <20150709120900.GA24040@book.hvoigt.net>
References: <cover.1434400625.git.hvoigt@hvoigt.net>
 <ef740bdea9af35564c75efd2a6daae65f3108df5.1434400625.git.hvoigt@hvoigt.net>
 <CABURp0pyYcKvmbEeDSYqm15DtXvH7g_UXASR3utGco+=D95bOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 14:09:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDAdl-0005yB-RW
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 14:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbbGIMJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 08:09:17 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:39648 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbbGIMJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 08:09:16 -0400
Received: from [80.135.122.168] (helo=book.hvoigt.net)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1ZDAcu-00035T-Je; Thu, 09 Jul 2015 14:08:28 +0200
Content-Disposition: inline
In-Reply-To: <CABURp0pyYcKvmbEeDSYqm15DtXvH7g_UXASR3utGco+=D95bOA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273743>

On Wed, Jul 08, 2015 at 04:52:14PM -0400, Phil Hord wrote:
> On Mon, Jun 15, 2015 at 5:06 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > In a superproject some commands need to interact with submodules. They
> > need to query values from the .gitmodules file either from the worktree
> > of from certain revisions. At the moment this is quite hard since a
> > caller would need to read the .gitmodules file from the history and then
> > parse the values. We want to provide an API for this so we have one
> > place to get values from .gitmodules from any revision (including the
> > worktree).
> >
> > The API is realized as a cache which allows us to lazily read
> > .gitmodules configurations by commit into a runtime cache which can then
> > be used to easily lookup values from it. Currently only the values for
> > path or name are stored but it can be extended for any value needed.
> >
> > It is expected that .gitmodules files do not change often between
> > commits. Thats why we lookup the .gitmodules sha1 from a commit and then
> > either lookup an already parsed configuration or parse and cache an
> > unknown one for each sha1. The cache is lazily build on demand for each
> > requested commit.
> >
> > This cache can be used for all purposes which need knowledge about
> > submodule configurations. Example use cases are:
> >
> >  * Recursive submodule checkout needs to lookup a submodule name from
> >    its path when a submodule first appears. This needs be done before
> >    this configuration exists in the worktree.
> >
> >  * The implementation of submodule support for 'git archive' needs to
> >    lookup the submodule name to generate the archive when given a
> >    revision that is not checked out.
> >
> >  * 'git fetch' when given the --recurse-submodules=on-demand option (or
> >    configuration) needs to lookup submodule names by path from the
> >    database rather than reading from the worktree. For new submodule it
> >    needs to lookup the name from its path to allow cloning new
> >    submodules into the .git folder so they can be checked out without
> >    any network interaction when the user does a checkout of that
> >    revision.
> >
> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> > ---
> >  .gitignore                                       |   1 +
> >  Documentation/technical/api-submodule-config.txt |  46 +++
> >  Makefile                                         |   2 +
> >  submodule-config.c                               | 445 +++++++++++++++++++++++
> >  submodule-config.h                               |  27 ++
> >  submodule.c                                      |   1 +
> >  submodule.h                                      |   1 +
> >  t/t7411-submodule-config.sh                      |  85 +++++
> >  test-submodule-config.c                          |  66 ++++
> >  9 files changed, 674 insertions(+)
> >  create mode 100644 Documentation/technical/api-submodule-config.txt
> >  create mode 100644 submodule-config.c
> >  create mode 100644 submodule-config.h
> >  create mode 100755 t/t7411-submodule-config.sh
> >  create mode 100644 test-submodule-config.c
> 
> 
> Instead of test-submodule-config.c to test this new module, it could
> be useful to implement these as extensions to rev-parse:
> 
>     git rev-parse --submodule-name [<ref>:]<path>
>     git rev-parse --submodule-path [<ref>:]<name>
>     git rev-parse --submodule-url [<ref>:]<name>
>     git rev-parse --submodule-ignore [<ref>:]<name>
>     git rev-parse --submodule-recurse [<ref>:]<name>
> 
> Has this already been considered and rejected for some reason?

No that has not been considered. But I am open to it if others agree
that this is a sensible thing to do. We should be able to adapt the
existing tests right?

Cheers Heiko
