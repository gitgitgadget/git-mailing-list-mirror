Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32CB1F404
	for <e@80x24.org>; Mon, 11 Dec 2017 21:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbdLKVft (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 16:35:49 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:56457 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbdLKVfs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 16:35:48 -0500
X-Greylist: delayed 1479 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Dec 2017 16:35:48 EST
Received: from [129.170.31.54] (helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1eOVLv-0004Un-9t; Mon, 11 Dec 2017 16:11:08 -0500
Date:   Mon, 11 Dec 2017 16:11:02 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     kyle@kyleam.com
Message-ID: <20171211211102.rrxqd6yscnd33efd@hopa.kiewit.dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170609 (1.8.3)
X-SA-Exim-Connect-IP: 129.170.31.54
X-SA-Exim-Rcpt-To: git@vger.kernel.org, kyle@kyleam.com
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Q: rational for $XDG_CONFIG_HOME/git/config to be "non global" or
 just a bug?
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Gurus,

We [1] have got confused a bit about this recent addition of handling
$XDG_CONFIG_HOME/git/config -- is it --global or not? ;)

According to the man git-config (v 2.15.0 in debian)

       --global
           For writing options: write to global ~/.gitconfig file rather than
           the repository .git/config, write to $XDG_CONFIG_HOME/git/config
           file if this file exists and the ~/.gitconfig file doesn’t.

           For reading options: read only from global ~/.gitconfig and from
           $XDG_CONFIG_HOME/git/config rather than from all available files.

           See also the section called “FILES”.

suggesting that $XDG_CONFIG_HOME/git/config is a part of the "--global" config
space, which it is not, which is also later described in FILES:

       $(prefix)/etc/gitconfig
           System-wide configuration file.

       $XDG_CONFIG_HOME/git/config
           Second user-specific configuration file. If $XDG_CONFIG_HOME is not set or empty, $HOME/.config/git/config will be used. Any
           single-valued variable set in this file will be overwritten by whatever is in ~/.gitconfig. It is a good idea not to create this file if
           you sometimes use older versions of Git, as support for this file was added fairly recently.

       ~/.gitconfig
           User-specific configuration file. Also called "global" configuration file.

which

1. says that $XDG_CONFIG_HOME/git/config is the "Second user-specific ..."
   suggesting that it should be the one read AFTER the first user-specific...
   I guess that the first one is the ~/.gitconfig , but then why the first one
   overrides the settings of the second one ? ;)  (as described above in TFM and
   see below for an example)

2. why $XDG_CONFIG_HOME/git/config is not a part of the "global" configuration?

   I always assumed that "global" is ALL settings defined for a user,
   which are not specific to a repository.

   It is double-confusing since, as --global doc describes (and example
   below shows), git config --global --add modifies the
   $XDG_CONFIG_HOME/git/config if there is no ~/.gitconfig

   Actually the doc for --global for "reading" seems to be not correct,
   that the file is not consulted for --global (see below)

Example to show that TFM outlines precedence and --global correctly:

$> grep xdg .gitconfig .config/git/config                              
.gitconfig:    xdg-and-user = user
.config/git/config: xdg = xdg
.config/git/config: xdg-and-user = xdg
$> git config user.xdg ; git config user.xdg-and-user
xdg                          
user
$> git config --global user.xdg            # so outputs nothing
$> git config --global user.xdg-and-user
user

$> mv .gitconfig{,.aside}
$> git config --global --add user.new value 
$> cat .config/git/config 
[user]
 xdg = xdg
 xdg-and-user = xdg
 new = value


So, is that simply a bug and $XDG_CONFIG_HOME/git/config should be
consulted for --global reading and doc should be adjusted to
state that it is a part of "global" config in FILES description?
Or it shouldn't be --global (then writing should be fixed, and
documentation adjusted to exclude it from --global)
Or am I just confused? ;)

thanks in advance for the clarification!

[1]  https://github.com/datalad/datalad/pull/2019#issuecomment-350757960
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
