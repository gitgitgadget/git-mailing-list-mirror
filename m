From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH v5 1/4] implement submodule config API for lookup of
 .gitmodules values
Date: Wed, 8 Jul 2015 16:52:14 -0400
Message-ID: <CABURp0pyYcKvmbEeDSYqm15DtXvH7g_UXASR3utGco+=D95bOA@mail.gmail.com>
References: <cover.1434400625.git.hvoigt@hvoigt.net> <ef740bdea9af35564c75efd2a6daae65f3108df5.1434400625.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jul 08 22:52:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCwKd-0006R0-TD
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 22:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758633AbbGHUwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 16:52:36 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36222 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758261AbbGHUwe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 16:52:34 -0400
Received: by ykey15 with SMTP id y15so22642451yke.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=slqzr88Hl23RaMcam6vrUbSfa7ZPf6+FPGbhI0WO87c=;
        b=KiCjnBjLrTKo+T+GVYN+XdLcSpzwTd6aYiL7Lgzho1DDtFQiJuPVDhRbno3KGDjGqc
         hKXGcedGq8N7W3EuGXPDMbV1oihfEoFPzV8qBTSmUruttRpmM1WzRGyaf73ymKI/7l9F
         luChNVC4vNfZ76Pq267xLAX+jO+2z7SH84gIv/ET2g1VYrUQRW62RGYLWTek/VF4NTcd
         i2KJPrQ5nvlLhqj8C4phOxj5KuDKmjrnTrwRUklgqeeHCvosU35WVLAIP6nfTnYtnqvX
         LiIqfVEblJ3qLCx6e/ssoyEbWs6a1CsVKisQmRN/21M/dBCWiKhdGTD4dUxQqJu+x64l
         STug==
X-Received: by 10.129.102.213 with SMTP id a204mr13394033ywc.19.1436388753817;
 Wed, 08 Jul 2015 13:52:33 -0700 (PDT)
Received: by 10.37.106.198 with HTTP; Wed, 8 Jul 2015 13:52:14 -0700 (PDT)
In-Reply-To: <ef740bdea9af35564c75efd2a6daae65f3108df5.1434400625.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273710>

On Mon, Jun 15, 2015 at 5:06 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> In a superproject some commands need to interact with submodules. They
> need to query values from the .gitmodules file either from the worktree
> of from certain revisions. At the moment this is quite hard since a
> caller would need to read the .gitmodules file from the history and then
> parse the values. We want to provide an API for this so we have one
> place to get values from .gitmodules from any revision (including the
> worktree).
>
> The API is realized as a cache which allows us to lazily read
> .gitmodules configurations by commit into a runtime cache which can then
> be used to easily lookup values from it. Currently only the values for
> path or name are stored but it can be extended for any value needed.
>
> It is expected that .gitmodules files do not change often between
> commits. Thats why we lookup the .gitmodules sha1 from a commit and then
> either lookup an already parsed configuration or parse and cache an
> unknown one for each sha1. The cache is lazily build on demand for each
> requested commit.
>
> This cache can be used for all purposes which need knowledge about
> submodule configurations. Example use cases are:
>
>  * Recursive submodule checkout needs to lookup a submodule name from
>    its path when a submodule first appears. This needs be done before
>    this configuration exists in the worktree.
>
>  * The implementation of submodule support for 'git archive' needs to
>    lookup the submodule name to generate the archive when given a
>    revision that is not checked out.
>
>  * 'git fetch' when given the --recurse-submodules=on-demand option (or
>    configuration) needs to lookup submodule names by path from the
>    database rather than reading from the worktree. For new submodule it
>    needs to lookup the name from its path to allow cloning new
>    submodules into the .git folder so they can be checked out without
>    any network interaction when the user does a checkout of that
>    revision.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>  .gitignore                                       |   1 +
>  Documentation/technical/api-submodule-config.txt |  46 +++
>  Makefile                                         |   2 +
>  submodule-config.c                               | 445 +++++++++++++++++++++++
>  submodule-config.h                               |  27 ++
>  submodule.c                                      |   1 +
>  submodule.h                                      |   1 +
>  t/t7411-submodule-config.sh                      |  85 +++++
>  test-submodule-config.c                          |  66 ++++
>  9 files changed, 674 insertions(+)
>  create mode 100644 Documentation/technical/api-submodule-config.txt
>  create mode 100644 submodule-config.c
>  create mode 100644 submodule-config.h
>  create mode 100755 t/t7411-submodule-config.sh
>  create mode 100644 test-submodule-config.c


Instead of test-submodule-config.c to test this new module, it could
be useful to implement these as extensions to rev-parse:

    git rev-parse --submodule-name [<ref>:]<path>
    git rev-parse --submodule-path [<ref>:]<name>
    git rev-parse --submodule-url [<ref>:]<name>
    git rev-parse --submodule-ignore [<ref>:]<name>
    git rev-parse --submodule-recurse [<ref>:]<name>

Has this already been considered and rejected for some reason?
