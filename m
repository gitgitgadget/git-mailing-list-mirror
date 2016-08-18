Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BC7C1F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 01:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754941AbcHSBVy (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:21:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52578 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754978AbcHSBVi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:21:38 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 8FD7E1F6C1;
        Thu, 18 Aug 2016 17:35:55 +0000 (UTC)
Date:   Thu, 18 Aug 2016 17:35:55 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Ben Wijen <ben@wijen.net>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 2/2] mingw: ensure temporary file handles are not
 inherited by child processes
Message-ID: <20160818173555.GA29253@starla>
References: <cover.1471437637.git.johannes.schindelin@gmx.de>
 <77e7c4e4de6c45a1b24bb4d08ca20a1385f43444.1471437637.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77e7c4e4de6c45a1b24bb4d08ca20a1385f43444.1471437637.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> +++ b/compat/mingw.h
> @@ -67,6 +67,10 @@ typedef int pid_t;
>  #define F_SETFD 2
>  #define FD_CLOEXEC 0x1
>  
> +#if !defined O_CLOEXEC && defined O_NOINHERIT
> +#define O_CLOEXEC	O_NOINHERIT
> +#endif


> +++ b/tempfile.c
> @@ -120,7 +120,7 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
>  	prepare_tempfile_object(tempfile);
>  
>  	strbuf_add_absolute_path(&tempfile->filename, path);
> -	tempfile->fd = open(tempfile->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
> +	tempfile->fd = open(tempfile->filename.buf, O_RDWR | O_CREAT | O_EXCL | O_CLOEXEC, 0666);
>  	if (tempfile->fd < 0) {
>  		strbuf_reset(&tempfile->filename);
>  		return -1;

O_CLOEXEC only exists since Linux 2.6.23 and there are likely
still LTS (CentOS 5.x?) and non-Linux systems which do not have
it, as well as machines with could have it defined in userspace
headers but not have it in the kernel.

So I suggest something like the following: (untested)

#define GIT_O_TMP (O_RDWR | O_CREAT | O_EXCL)

#ifndef O_CLOEXEC
#  define O_CLOEXEC 0
#endif
	/* state: -1=unknown; 0=broken; 1=working */
	static int cloexec_state = O_CLOEXEC == 0 ? 0 : -1;
	static int GIT_O_ETMP = (GIT_O_TMP | O_CLOEXEC)

	int fd = open(filename, GIT_O_ETMP, 0666);

	if (fd < 0 && errno == EINVAL && cloexec_state == -1 &&
			GIT_O_ETMP != GIT_O_TMP) {
		GIT_O_ETMP = GIT_O_TMP;

		fd = open(filename, GIT_O_ETMP, 0666);
		if (fd >= 0)
			/* don't try O_CLOEXEC again */
			cloexec_state = 0;
	}

	/*
	 * This is racy in the presence of threads,
	 * but the best we can do for old *nix:
	 */
#if defined(F_GETFD) && defined(F_SETFD) && defined(FD_CLOEXEC)
	if (fd >= 0 && cloexec_state != 1) {
		int flags = fcntl(fd, F_GETFD);

		if (flags == -1)
			die_errno("F_GETFD failed");
		if (flags & O_CLOEXEC)
			cloexec_state = 1;
		else {
			flags = fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
			if (flags == -1)
				die_errno("F_SETFD failed");
			cloexec_state = 0;

		}
	}
#endif
	...
