Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB0FD20A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 15:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbeLHPpp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 8 Dec 2018 10:45:45 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:33294 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeLHPpp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 10:45:45 -0500
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1gVenY-0005lx-El
        for git@vger.kernel.org; Sat, 08 Dec 2018 10:45:44 -0500
Date:   Sat, 8 Dec 2018 10:45:39 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     git <git@vger.kernel.org>
Message-ID: <20181208154539.GH4633@hopa.kiewit.dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: [wishlist] submodule.update config
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Relates (but orthogonal) to my other thread

  [wishlist] git submodule update --reset-hard

ATM, it possible to specify per submodule update strategy via
configuration variable submodule.SUBMODULE.update where SUBMODULE is the name
of the corresponding submodule.  But I see no way to specify default update
strategy for all submodules.

From our conversation in that other thread  I have discovered to myself about
existence of  submodule.recurse  configuration, and there seems to be a few
more (.fetchJobs, .active) where e.g. .active seems to complement per-submodule
submodule.*.active:

	yoh@debian:~/proj/misc/git$ git grep '[^.]submodule\.[a-z]' -- Documentation/
	Documentation/RelNotes/2.14.0.txt: * Many commands learned to pay attention to submodule.recurse
	Documentation/RelNotes/2.15.0.txt: * "git -c submodule.recurse=yes pull" did not work as if the
	Documentation/config.txt:include::config/submodule.txt[]
	Documentation/config/submodule.txt:     update'. If neither submodule.<name>.active or submodule.active are
	Documentation/config/submodule.txt:     interact with submodules; settings like `submodule.active`
	Documentation/config/submodule.txt:     submodule.active config option. See linkgit:gitsubmodules[7] for
	Documentation/config/submodule.txt:     as computed via `submodule.alternateLocation`. Possible values are
	Documentation/git-clone.txt:    of multiple entries.  The resulting clone has `submodule.active` set to
	Documentation/git-clone.txt:    Defaults to the `submodule.fetchJobs` option.
	Documentation/git-submodule.txt:If no path is specified and submodule.active has been configured, submodules
	Documentation/git-submodule.txt:        Defaults to the `submodule.fetchJobs` option.
	Documentation/gitsubmodules.txt:`submodule.foo.path = path/to/bar`.
	Documentation/gitsubmodules.txt:The section `submodule.foo.*` in the `.gitmodules` file gives additional
	Documentation/gitsubmodules.txt:hints to Git's porcelain layer. For example, the `submodule.foo.url`
	Documentation/gitsubmodules.txt:  b. if the submodule's path matches the pathspec in `submodule.active`
	Documentation/gitsubmodules.txt:submodule's path is excluded in the pathspec in `submodule.active`, the
	Documentation/gitsubmodules.txt:  git config --global submodule.recurse true
	Documentation/gitsubmodules.txt:your working tree. Alternatively you can set 'submodule.recurse' to have
	Documentation/technical/api-config.txt:if (!git_configset_get_bool(gm_config, "submodule.frotz.ignore", &b)) {
	Documentation/technical/http-protocol.txt:  $GIT_URL:     http://example.com/git/repo.git/path/submodule.git
	Documentation/technical/http-protocol.txt:  URL request:  http://example.com/git/repo.git/path/submodule.git/info/refs

I wondered, if you think it would be sensible to also add of
submodule.update which would be considered before submodule.SUBMODULE.update
variable possibly defined per submodule.  That would be more inline with desire
to use any of the --merge, --rebase (and hopefully soon --reset-hard)
strategies specified as an option for submodule update, where no per-submodule
handling  is happening.

Thanks in advance for the consideration!
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
