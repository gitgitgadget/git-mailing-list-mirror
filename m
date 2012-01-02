From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Mon, 2 Jan 2012 03:25:08 -0600
Message-ID: <20120102092508.GA10977@elie.hsd1.il.comcast.net>
References: <20111014211921.GB16429@sigill.intra.peff.net>
 <1318803076-4229-1-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Jan 02 10:25:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rhe9C-0007cf-In
	for gcvg-git-2@lo.gmane.org; Mon, 02 Jan 2012 10:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354Ab2ABJZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jan 2012 04:25:16 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38468 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab2ABJZO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jan 2012 04:25:14 -0500
Received: by iaeh11 with SMTP id h11so29014013iae.19
        for <git@vger.kernel.org>; Mon, 02 Jan 2012 01:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=b8rLwjQiTm2zAQo56bVi7BswqdIde2ROFmWYsZZrQFw=;
        b=SUemcnMOLwNkr2hzlCide+zbxsUSAFqfGdpbt0MCqyMDmbOeKtpzXoj7T2OZoNRAu5
         ExCV6UxDbivmXqe6wjH43sGKmrYT4YqBhTbsVhcLja6Z+d0XDoks/+FCo0VcxlGOVgrY
         L2xH31oIMHihxqi9uhMxYNKXG8OBX2q6ZKwcc=
Received: by 10.42.153.6 with SMTP id k6mr50402279icw.30.1325496313773;
        Mon, 02 Jan 2012 01:25:13 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id d19sm162734176ibh.8.2012.01.02.01.25.12
        (version=SSLv3 cipher=OTHER);
        Mon, 02 Jan 2012 01:25:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1318803076-4229-1-git-send-email-drizzd@aon.at>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187837>

(+cc: Erik, Ilari, Duy)
Hi,

Clemens Buchacher wrote:

> [Subject: daemon: add tests]

Can't believe I missed this.  That seems like a worthy cause ---
can someone remind me why this is dropped, or if there are any
tweaks I can help with to get it picked up again?

Patch left unsnipped for convenience of people cc-ed.

Jonathan

> The semantics of the git daemon tests are similar to the http
> transport tests.  In fact, they are only a slightly modified copy
> of t5550, plus the newly added remote error tests.
>
> All daemon tests will be skipped unless the environment variable
> GIT_TEST_DAEMON is set.
> 
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---
> 
> This patch is based on jk/daemon-msgs.
> 
>  t/lib-daemon.sh       |   52 +++++++++++++++++
>  t/t5570-git-daemon.sh |  148 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 200 insertions(+), 0 deletions(-)
>  create mode 100644 t/lib-daemon.sh
>  create mode 100755 t/t5570-git-daemon.sh
> 
> diff --git a/t/lib-daemon.sh b/t/lib-daemon.sh
> new file mode 100644
> index 0000000..30a89ea
> --- /dev/null
> +++ b/t/lib-daemon.sh
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +
> +if test -z "$GIT_TEST_DAEMON"
> +then
> +	skip_all="Daemon testing disabled (define GIT_TEST_DAEMON to enable)"
> +	test_done
> +fi
> +
> +LIB_DAEMON_PORT=${LIB_DAEMON_PORT-'8121'}
> +
> +DAEMON_PID=
> +DAEMON_DOCUMENT_ROOT_PATH="$PWD"/repo
> +DAEMON_URL=git://127.0.0.1:$LIB_DAEMON_PORT
> +
> +start_daemon() {
> +	if test -n "$DAEMON_PID"
> +	then
> +		error "start_daemon already called"
> +	fi
> +
> +	mkdir -p "$DAEMON_DOCUMENT_ROOT_PATH"
> +
> +	trap 'code=$?; stop_daemon; (exit $code); die' EXIT
> +
> +	say >&3 "Starting git daemon ..."
> +	git daemon --listen=127.0.0.1 --port="$LIB_DAEMON_PORT" \
> +		--reuseaddr --verbose \
> +		--base-path="$DAEMON_DOCUMENT_ROOT_PATH" \
> +		"$@" "$DAEMON_DOCUMENT_ROOT_PATH" \
> +		>&3 2>&4 &
> +	DAEMON_PID=$!
> +}
> +
> +stop_daemon() {
> +	if test -z "$DAEMON_PID"
> +	then
> +		return
> +	fi
> +
> +	trap 'die' EXIT
> +
> +	# kill git-daemon child of git
> +	say >&3 "Stopping git daemon ..."
> +	pkill -P "$DAEMON_PID"
> +	wait "$DAEMON_PID"
> +	ret=$?
> +	if test $ret -ne 143
> +	then
> +		error "git daemon exited with status: $ret"
> +	fi
> +	DAEMON_PID=
> +}
> diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> new file mode 100755
> index 0000000..aa5771a
> --- /dev/null
> +++ b/t/t5570-git-daemon.sh
> @@ -0,0 +1,148 @@
> +#!/bin/sh
> +
> +test_description='test fetching over git protocol'
> +. ./test-lib.sh
> +
> +. "$TEST_DIRECTORY"/lib-daemon.sh
> +start_daemon
> +
> +test_expect_success 'setup repository' '
> +	echo content >file &&
> +	git add file &&
> +	git commit -m one
> +'
> +
> +test_expect_success 'create git-accessible bare repository' '
> +	mkdir "$DAEMON_DOCUMENT_ROOT_PATH/repo.git" &&
> +	(cd "$DAEMON_DOCUMENT_ROOT_PATH/repo.git" &&
> +	 git --bare init &&
> +	 : >git-daemon-export-ok
> +	) &&
> +	git remote add public "$DAEMON_DOCUMENT_ROOT_PATH/repo.git" &&
> +	git push public master:master
> +'
> +
> +test_expect_success 'clone git repository' '
> +	git clone $DAEMON_URL/repo.git clone &&
> +	test_cmp file clone/file
> +'
> +
> +test_expect_success 'fetch changes via git protocol' '
> +	echo content >>file &&
> +	git commit -a -m two &&
> +	git push public &&
> +	(cd clone && git pull) &&
> +	test_cmp file clone/file
> +'
> +
> +test_expect_failure 'remote detects correct HEAD' '
> +	git push public master:other &&
> +	(cd clone &&
> +	 git remote set-head -d origin &&
> +	 git remote set-head -a origin &&
> +	 git symbolic-ref refs/remotes/origin/HEAD > output &&
> +	 echo refs/remotes/origin/master > expect &&
> +	 test_cmp expect output
> +	)
> +'
> +
> +test_expect_success 'prepare pack objects' '
> +	cp -R "$DAEMON_DOCUMENT_ROOT_PATH"/repo.git "$DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git &&
> +	(cd "$DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git &&
> +	 git --bare repack &&
> +	 git --bare prune-packed
> +	)
> +'
> +
> +test_expect_success 'fetch notices corrupt pack' '
> +	cp -R "$DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git "$DAEMON_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
> +	(cd "$DAEMON_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
> +	 p=`ls objects/pack/pack-*.pack` &&
> +	 chmod u+w $p &&
> +	 printf %0256d 0 | dd of=$p bs=256 count=1 seek=1 conv=notrunc
> +	) &&
> +	mkdir repo_bad1.git &&
> +	(cd repo_bad1.git &&
> +	 git --bare init &&
> +	 test_must_fail git --bare fetch $DAEMON_URL/repo_bad1.git &&
> +	 test 0 = `ls objects/pack/pack-*.pack | wc -l`
> +	)
> +'
> +
> +test_expect_success 'fetch notices corrupt idx' '
> +	cp -R "$DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git "$DAEMON_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
> +	(cd "$DAEMON_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
> +	 p=`ls objects/pack/pack-*.idx` &&
> +	 chmod u+w $p &&
> +	 printf %0256d 0 | dd of=$p bs=256 count=1 seek=1 conv=notrunc
> +	) &&
> +	mkdir repo_bad2.git &&
> +	(cd repo_bad2.git &&
> +	 git --bare init &&
> +	 test_must_fail git --bare fetch $DAEMON_URL/repo_bad2.git &&
> +	 test 0 = `ls objects/pack | wc -l`
> +	)
> +'
> +
> +test_remote_error()
> +{
> +	do_export=YesPlease
> +	while test $# -gt 0
> +	do
> +		case $1 in
> +		-x)
> +			shift
> +			chmod -X "$DAEMON_DOCUMENT_ROOT_PATH/repo.git"
> +			;;
> +		-n)
> +			shift
> +			do_export=
> +			;;
> +		*)
> +			break
> +		esac
> +	done
> +
> +	if test $# -ne 3
> +	then
> +		error "invalid number of arguments"
> +	fi
> +
> +	cmd=$1
> +	repo=$2
> +	msg=$3
> +
> +	if test -x "$DAEMON_DOCUMENT_ROOT_PATH/$repo"
> +	then
> +		if test -n "$do_export"
> +		then
> +			: >"$DAEMON_DOCUMENT_ROOT_PATH/$repo/git-daemon-export-ok"
> +		else
> +			rm -f "$DAEMON_DOCUMENT_ROOT_PATH/$repo/git-daemon-export-ok"
> +		fi
> +	fi
> +
> +	test_must_fail git "$cmd" "$DAEMON_URL/$repo" 2>output &&
> +	echo "fatal: remote error: $msg: /$repo" >expect &&
> +	test_cmp expect output
> +	ret=$?
> +	chmod +X "$DAEMON_DOCUMENT_ROOT_PATH/repo.git"
> +	(exit $ret)
> +}
> +
> +msg="access denied or repository not exported"
> +test_expect_success 'clone non-existent' "test_remote_error    clone nowhere.git '$msg'"
> +test_expect_success 'push disabled'      "test_remote_error    push  repo.git    '$msg'"
> +test_expect_success 'read access denied' "test_remote_error -x fetch repo.git    '$msg'"
> +test_expect_success 'not exported'       "test_remote_error -n fetch repo.git    '$msg'"
> +
> +stop_daemon
> +start_daemon --informative-errors
> +
> +test_expect_success 'clone non-existent' "test_remote_error    clone nowhere.git 'no such repository'"
> +test_expect_success 'push disabled'      "test_remote_error    push  repo.git    'service not enabled'"
> +test_expect_success 'read access denied' "test_remote_error -x fetch repo.git    'no such repository'"
> +test_expect_success 'not exported'       "test_remote_error -n fetch repo.git    'repository not exported'"
> +
> +stop_daemon
> +test_done
> -- 
> 1.7.7
> 
> 
