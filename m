Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4BA20705
	for <e@80x24.org>; Mon,  5 Sep 2016 22:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755504AbcIEW1S (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 18:27:18 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47272 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755289AbcIEW1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 18:27:16 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 3D94820705;
        Mon,  5 Sep 2016 22:27:15 +0000 (UTC)
Date:   Mon, 5 Sep 2016 22:27:15 +0000
From:   Eric Wong <e@80x24.org>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, tboegi@web.de,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v1 1/2] sha1_file: open window into packfiles with CLOEXEC
Message-ID: <20160905222715.GA30031@starla>
References: <20160905211111.72956-1-larsxschneider@gmail.com>
 <20160905211111.72956-2-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160905211111.72956-2-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com wrote:
> All processes that the Git main process spawns inherit the open file
> descriptors of the main process. These leaked file descriptors can
> cause problems.


> -int git_open_noatime(const char *name)
> +int git_open_noatime_cloexec(const char *name)
>  {
> -	static int sha1_file_open_flag = O_NOATIME;
> +	static int sha1_file_open_flag = O_NOATIME | O_CLOEXEC;
>  
>  	for (;;) {
>  		int fd;

If there's real problems being caused by lack of cloexec
today, I think the F_SETFD fallback I proposed in
https://public-inbox.org/git/20160818173555.GA29253@starla/
will be necessary.

I question the need for the "_cloexec" suffixing in the
function name since the old function is going away entirely.

I prefer all FD-creating functions set cloexec by default
for FD > 2 to avoid inadvertantly leaking FDs.  So we
ought to use pipe2, accept4, socket(..., SOCK_CLOEXEC), etc...
and fallback to the racy+slower F_SETFD when not available.


Fwiw, Perl has been setting cloexec on FDs above $^F
(2, $SYSTEM_FD_MAX) for decades, and Ruby started
doing it a few years ago, too.
