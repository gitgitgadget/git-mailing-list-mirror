Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4E5CD6137
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 20:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378016AbjJIUno (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 16:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378003AbjJIUnn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 16:43:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9849E
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 13:43:42 -0700 (PDT)
Received: (qmail 24220 invoked by uid 109); 9 Oct 2023 20:43:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 20:43:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18413 invoked by uid 111); 9 Oct 2023 20:43:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 16:43:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 16:43:41 -0400
From:   Jeff King <peff@peff.net>
To:     matthew sporleder <msporleder@gmail.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: gpg.ssh.defaultKeyCommand docs bug?
Message-ID: <20231009204341.GB3281325@coredump.intra.peff.net>
References: <CAHKF-AvUxH1Ar3Xijjb4_8N+_kssPHZVHqQSAE9kDGRfTYHyxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHKF-AvUxH1Ar3Xijjb4_8N+_kssPHZVHqQSAE9kDGRfTYHyxw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc Fabian, who wrote this code]

On Fri, Oct 06, 2023 at 01:14:49PM -0400, matthew sporleder wrote:

> https://git-scm.com/docs/git-config#Documentation/git-config.txt-gpgsshdefaultKeyCommand
> 
> This command that will be run when user.signingkey is not set and a
> ssh signature is requested. On successful exit a valid ssh public key
> prefixed with key:: is expected in the first line of its output. This
> allows for a script doing a dynamic lookup of the correct public key
> when it is impractical to statically configure user.signingKey. For
> example when keys or SSH Certificates are rotated frequently or
> selection of the right key depends on external factors unknown to git.
> 
> ---
> 
> The command does not actually work (for me, git version 2.42.0) with
> key:: prefixed.
> 
> It only works if I cat the public key as-is.
> 
> I only figured this out because the docs previously said it took the
> format of ssh-add -L, which also doesn't not contain key::.
> 
> I am using this script for my "dynamic" key discovery:
> #!/bin/sh
> f=$(ssh -G $(git remote get-url $(git remote|head -1)|awk -F':' '{
> print $1 }') |grep -E '^identityfile'|sed 's#^identityfile ##g')
> cat $(eval realpath ${f}.pub)

I'm not very familiar with this part of Git, but looking at the code
which parses the output of gpg.ssh.defaultKeyCommand, it splits it by
line and then calls is_literal_ssh_key() on it, which is:

  static int is_literal_ssh_key(const char *string, const char **key)
  {
          if (skip_prefix(string, "key::", key))
                  return 1;
          if (starts_with(string, "ssh-")) {
                  *key = string;
                  return 1;
          }
          return 0;
  }

So your script works because the pub file starts with "ssh-rsa" or
similar (and so would "ssh-add -L" output).

The user.signingKey docs say:

  For backward compatibility, a raw key which begins with "ssh-", such
  as "ssh-rsa XXXXXX identifier", is treated as "key::ssh-rsa XXXXXX
  identifier", but this form is deprecated; use the key:: form instead.

From reading the commit messages here, I guess this is about supporting
non-ssh key types (e.g., my TPM-based key is ecdsa-sha2-nistp256 in the
"ssh-add -L" output). But I'm not sure who is supposed to be put "key::"
there.

You said it "does not actually work" with "key::" prefixed. What
happens? In the signing code we make a similar call to
is_literal_ssh_key() that wills trip off the "key::" prefix, so I'd
expect it work. But I could also believe there is a bug. :)

-Peff
