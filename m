Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDBC3207DF
	for <e@80x24.org>; Thu, 15 Sep 2016 11:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934495AbcIOL6H (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 07:58:07 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:40283 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934388AbcIOL6E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 07:58:04 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bkVIg-0005R4-Ew; Thu, 15 Sep 2016 13:57:54 +0200
Date:   Thu, 15 Sep 2016 13:57:52 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Jens Lehmann <jens.lehmann@web.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] extending pathspec support to submodules
Message-ID: <20160915115752.GA37903@book.hvoigt.net>
References: <1473897473-154528-1-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1473897473-154528-1-git-send-email-bmwill@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Sep 14, 2016 at 04:57:53PM -0700, Brandon Williams wrote:
> ---
> I've been trying to think through how we could potentially add pathspec support
> for --recurse-submodule options (for builtins like ls-files or grep down the
> line).  This is something that could be useful if the user supply's a pathspec
> that could match to a file in a submodule.  We could match the submodule to the
> pathspec and then fork the process to recursively run the command on the
> submodule which can be passed a modified pathspec.
> 
> For example with a pathspec 'sub/dir/a', where sub is a submodule in the root
> directory of the supermodule's repo, we could match 'sub' to that spec and then
> recursively call the git command with a pathspec of 'dir/a'.  The child process
> would then have the responsibility of matching 'dir/a' to files in its repo.
> 
> Does this seem like a reasonable feature to add? And if so are how is my
> initial approach at solving the problem?

The problem when you do that is that the child is not aware that it is
actually run as a submodule process. E.g.

   git grep --recurse-submodules foobar -- sub/dir/a

would report back matches in 'dir/a' instead of 'sub/dir/a'. From the
users perspective this will be confusing since she started the grep in
the superproject.

So what I would suggest is that we make the childs aware of the fact
that they are called from a superproject by passing a prefix when
calling it. E.g. like this

   git grep --submodule-prefix=sub foobar -- sub/dir/a

Whether we pass the full or stripped path is now a matter of taste or
ease of implementation, since we could either preprend or strip it in
the child. But the important difference is that we have information
about the original path.

Another approach could, of course, be to omit passing the prefix and
parse the output of the child and try to substitute, paths but that
seems quite error prone to me.

Cheers Heiko
