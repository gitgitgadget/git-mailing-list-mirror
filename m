Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569B4C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 09:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjDKJmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 05:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDKJl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 05:41:59 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED4526AB
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 02:41:57 -0700 (PDT)
Received: (qmail 6854 invoked by uid 109); 11 Apr 2023 09:41:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Apr 2023 09:41:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5897 invoked by uid 111); 11 Apr 2023 09:41:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Apr 2023 05:41:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Apr 2023 05:41:56 -0400
From:   Jeff King <peff@peff.net>
To:     Mervin Guy <mail@mervin.works>
Cc:     git@vger.kernel.org
Subject: Re: 'git config --edit' unexpected behavior
Message-ID: <20230411094156.GC398350@coredump.intra.peff.net>
References: <D6798678-9CC3-416F-B238-F3D28EC910B2@mervin.works>
 <C65981B6-49FA-4A62-84D6-541D3CFF0541@mervin.works>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C65981B6-49FA-4A62-84D6-541D3CFF0541@mervin.works>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2023 at 07:05:12PM -0400, Mervin Guy wrote:

> I'm confident there is an error in the `git config --global -e`
> pipeline though (very likely git.c), because when using git-aliases
> the function performs as expected.
> 
> My current alias `ec` pointing to the command `!vi $HOME/.gitconfig` -
> where $HOME is `/root`. The full command looks like `git ec` and works
> as expected.
> 
> Meaning that the only difference between the failed-run and
> successful-run was calling the git built-in `git config --global -e`.

OK, so we can guess it has to do with the "--edit" option specifically,
and your editor is doing what we'd expect. The main thing that code is
doing is just opening the editor, but there's this curious bit of code
before it does so:

  $ sed -ne '851,+11p' builtin/config.c
  		if (use_global_config) {
  			int fd = open(config_file, O_CREAT | O_EXCL | O_WRONLY, 0666);
  			if (fd >= 0) {
  				char *content = default_user_config();
  				write_str_in_full(fd, content);
  				free(content);
  				close(fd);
  			}
  			else if (errno != EEXIST)
  				die_errno(_("cannot create configuration file %s"), config_file);
  		}
  		launch_editor(config_file, NULL, NULL);

That shouldn't be overwriting your existing file, since O_EXCL will
refuse to open the file in that case.

But I wonder if something funny is going on with the file selection. We
support both the traditional $HOME/.gitconfig location, but also the xdg
location (usually $HOME/.config/git/config, but $XDG_CONFIG_HOME can
tweak that).

When reading config for most commands, we will generally pull from both
sources. But for "git config --global", we have to pick one to operate
on, both for reading and writing. The logic is supposed to prefer
$HOME/.gitconfig, but use the xdg location if it exists and the $HOME
one doesn't.

From your output:

> > Using the command, the trace says it’s using 'vi /root/.gitconfig' -
> > which is indeed the set editor.

it's picking the $HOME one. You said you had previous contents that were
overwritten. How did you add them originally, and might they have been
in the xdg location? Can you see if there is anything in /root/.config/git?

I admit I still don't know how we'd trigger this case; if the file did
exist then we should never use /root/.config in the first place.

Another left-field possibility: is /root on an unusual filesystem (e.g.,
a networked one) where O_EXCL might not behave as it should?

-Peff
