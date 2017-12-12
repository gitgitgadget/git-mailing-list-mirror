Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C882C1F419
	for <e@80x24.org>; Tue, 12 Dec 2017 00:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbdLLAsl (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 19:48:41 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:59103 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbdLLAsj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 19:48:39 -0500
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1eOYkP-0000t2-1B; Mon, 11 Dec 2017 19:48:38 -0500
Date:   Mon, 11 Dec 2017 19:48:31 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>, kyle@kyleam.com,
        Jeff King <peff@peff.net>
Message-ID: <20171212004831.2sfscbrlhyokzchz@hopa.kiewit.dartmouth.edu>
References: <20171211211102.rrxqd6yscnd33efd@hopa.kiewit.dartmouth.edu>
 <20171211225615.GC214273@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171211225615.GC214273@aiede.mtv.corp.google.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170609 (1.8.3)
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: jrnieder@gmail.com, git@vger.kernel.org, kyle@kyleam.com, peff@peff.net
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: Q: rational for $XDG_CONFIG_HOME/git/config to be "non global"
 or just a bug?
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, 11 Dec 2017, Jonathan Nieder wrote:
> > Example to show that TFM outlines precedence and --global correctly:

> > $> grep xdg .gitconfig .config/git/config
> > .gitconfig:    xdg-and-user = user
> > .config/git/config: xdg = xdg
> > .config/git/config: xdg-and-user = xdg
> > $> git config user.xdg ; git config user.xdg-and-user
> > xdg
> > user

> I agree, this is confusing.

> Reverse engineering from source, I find that git reads the following
> files in sequence:

> 	system:
> 		/etc/gitconfig
> 	global:
> 		$XDG_CONFIG_HOME/git/config
> 		$HOME/.gitconfig
> 	repo:
> 		$GIT_DIR/config
> 	commandline:
> 		options passed with -c or GIT_CONFIG_PARAMETERS

> These terms (system, global, repo, etc) are accessible in code as
> current_config_scope().  I don't think there's any user-visible effect
> to $XDG_CONFIG_HOME/git/config and $HOME/.gitconfig both being global
> --- it would probably be a good cleanup to rename the scope for one of
> them.

Well, we have got at least one user/contributor now who uses
$XDG_CONFIG_HOME/git/config in favor of ~/.gitconfig since it makes it
easier for modular user configuration.

> I think the documentation

> 	~/.gitconfig
> 		User-specific configuration file. Also called "global"
> 		configuration file.

> should be clarified --- e.g. it could say

> 	$XDG_CONFIG_HOME/git/config
> 	~/.gitconfig
> 		User-specific configuration files. Because options in
> 		these files are not specific to any repository, thes
> 		are sometimes called global configuration files.

> As for "git config --global", I think the best thing would be to split
> it into two options: something like "git config --user" and "git
> config --xdg-user".  That way, it is unambiguous which configuration
> file the user intends to inspect or modify.  When a user calls "git
> config --global" and both files exist, it could warn that the command
> is ambiguous.

why ambiguous?  as long as both are consistently called global, and the
overloading rules are clear for reading -- nothing ambigous.  The only
ambigous logic would be for writing.

> Thoughts?

Well -- my main functionality concern that ATM
$XDG_CONFIG_HOME/git/config is (as of 2.15.0) only --global for writing
but not for regular reading (as I demonstrated in the original email)

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
