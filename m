Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43E3E20FD0
	for <e@80x24.org>; Wed, 29 Jun 2016 20:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbcF2UBo (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 16:01:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41816 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195AbcF2UBn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 16:01:43 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6904A20FCF;
	Wed, 29 Jun 2016 20:01:42 +0000 (UTC)
Date:	Wed, 29 Jun 2016 20:01:42 +0000
From:	Eric Wong <e@80x24.org>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH v2 00/10] Add initial experimental external ODB
 support
Message-ID: <20160629200142.GA17878@dcvr.yhbt.net>
References: <20160628181933.24620-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160628181933.24620-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> wrote:
> Design discussion about performance
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Yeah, it is not efficient to fork/exec a command to just read or write
> one object to or from the external ODB. Batch calls and/or using a
> daemon and/or RPC should be used instead to be able to store regular
> objects in an external ODB. But for now the external ODB would be all
> about really big files, where the cost of a fork+exec should not
> matter much. If we later want to extend usage of external ODBs, yeah
> we will probably need to design other mechanisms.

I would also investigate switching run_command to use vfork+exec
or posix_spawn for performance (keeping in mind vfork
caveats documented at https://ewontfix.com/7/ )

posix_spawn in future glibc (probably 2.24) will use CLONE_VFORK
in all cases under Linux, and posix_spawn may help with
portability, too.  I think the only thing we can't support
with posix_spawn which run_command supports is chdir;
all the redirections/closing FDs should be fine.

With only 10MB malloc-ed, the following shows vfork performance
being noticeably faster than plain fork:

/* gcc -o vfork-test -Wall -O2 vfork-test.c */
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[], char *envp[])
{
	int i;
	int do_vfork = argc > 1 && !strcmp(argv[1], "vfork");
	char * const cmd[] = { "/bin/true", 0 };
	size_t n = 1024 * 1024 * 10;
	char *mem = malloc(n);

	memset(mem, 'a', n); /* make sure it's really allocated */

	for (i = 0; i < 10000; i++) {
		pid_t pid = do_vfork ? vfork() : fork();

		if (pid == 0) {
			execve(cmd[0], cmd, envp);
			write(2, "exec error\n", 11);
			_exit(1);
		}
		waitpid(pid, 0, 0);
	}
	return 0;
}
