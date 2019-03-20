Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2E9B20248
	for <e@80x24.org>; Wed, 20 Mar 2019 10:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfCTK13 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 06:27:29 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:50966 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfCTK13 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 06:27:29 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1h6YJx-0005Zd-7b
        for git@vger.kernel.org; Wed, 20 Mar 2019 19:19:41 +0900
Date:   Wed, 20 Mar 2019 19:19:41 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: How to properly find git config in a libgit.a-using executable?
Message-ID: <20190320101941.2xjsjx3zfnnp33a2@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

In git-cinnabar (the remote-helper that can talk to mercurial servers),
I'm using a fast-import-derived helper to do a lot of the heavy lifting,
because $REASONS. Anyways, while built (mostly) with the git build system,
using libgit.a, etc. the helper doesn't live in the GIT_EXEC_PATH. That
leads me to a very subtle problem: it doesn't necessarily find the
system config that git uses.

Because the system confit that git uses depends on how git was built,
the result might not be the right thing. For one, a Linux distro git
will likely have been built with prefix=/usr, which makes the system
config be /etc/gitconfig, but someone building their own git will have
a system config in etc/gitconfig relative to their git.

The latter is more of nitpicking, because practically speaking, it
doesn't matter much. Which is why I've been building with prefix=/usr
(at least for the helper binaries that I ship pre-built ; locally built
helpers actually don't get this treatment ; but that's also not much of
a practical problem because it seems Linux distros don't ship a
/etc/gitconfig anyways (at least Debian doesn't)).

Anyways, the real problem comes on Windows, because git-for-windows does
come with a system config that does make important tweaks, like setting
http.sslcainfo to a path that actually exists. And without reading that
system config, the helper doesn't find the cainfo file and fails to
connect to HTTPS mercurial servers.

Now, my question here is, what would you suggest I do to make my helper
find the right config?

I thought of a few options (it's worth noting the helper is invoked in a
way that makes $GIT_EXEC_PATH set, which can help a little):
- spawn `$GIT_EXEC_PATH/git-config -l -z`, parse its output, and set the
  internal config from that. That's the barbarian option.
- build the helper with RUNTIME_PREFIX, and modify the RUNTIME_PREFIX
  code to use $GIT_EXEC_PATH if it's set, rather than the path the
  executable is in. That actually sounds reasonable enough that I'd send
  a patch for git itself. But that doesn't quite address the nitpick case
  where ETC_GITCONFIG could be either `/etc/gitconfig` or
  `etc/gitconfig` depending how git was compiled, and there's no way to
  know which is the right one.

WDYT?

Mike
