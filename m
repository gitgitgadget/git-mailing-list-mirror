Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DEB21F576
	for <e@80x24.org>; Thu, 25 Jan 2018 11:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeAYL4u (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 06:56:50 -0500
Received: from lucaswerkmeister.de ([94.130.58.99]:60614 "EHLO
        lucaswerkmeister.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeAYL4t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 06:56:49 -0500
Received: from [172.16.67.210] (p578a6e4c.dip0.t-ipconnect.de [87.138.110.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mail@lucaswerkmeister.de)
        by lucaswerkmeister.de (Postfix) with ESMTPSA id 9E404196B0A;
        Thu, 25 Jan 2018 12:56:47 +0100 (CET)
Authentication-Results: lucaswerkmeister.de; dmarc=fail (p=none dis=none) header.from=lucaswerkmeister.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucaswerkmeister.de;
        s=mail; t=1516881407;
        bh=ev4H2C8ALZbVfXkIJmRjNTrxGefhSxtOgBCkO2rNP8w=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:Content-Transfer-Encoding:From:Reply-To:
         Subject:Date:To:Cc:In-Reply-To:References:Message-Id:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version;
        b=gF5kwncgul58fgxMYBd3PZGPRhZN07YV4QHd5/HS/CVXqWYjv/hCL7NIqlQa6ZQcN
         qyaCzsIytnC10mIePMJonCTO79IkMcGmeJu41kjM+0Den7+fFoOkVqCB9taLhmGkWY
         oTZplML5RPDo53Er+tbKpuMQ9fzkrdrNZXfdNs2M=
Subject: Re: [PATCH 2/6] t/lib-git-daemon: record daemon log
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
References: <20180125005447.GA26661@sigill.intra.peff.net>
 <20180125005511.GB26850@sigill.intra.peff.net>
From:   Lucas Werkmeister <mail@lucaswerkmeister.de>
Message-ID: <38b41541-5758-d013-3d64-314eec7e31ed@lucaswerkmeister.de>
Date:   Thu, 25 Jan 2018 12:56:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180125005511.GB26850@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25.01.2018 01:55, Jeff King wrote:
> When we start git-daemon for our tests, we send its stderr
> log stream to a named pipe. We synchronously read the first
> line to make sure that the daemon started, and then dump the
> rest to descriptor 4. This is handy for debugging test
> output with "--verbose", but the tests themselves can't
> access the log data.
> 
> Let's dump the log into a file, as well, so that future
> tests can check the log. There are two subtleties worth
> calling out here:
> 
>   - we replace "cat" with a subshell loop around "read" to
>     ensure that there's no buffering (so that tests can be
>     sure that after a request has been served, the matching
>     log entries will have made it to the file)

POSIX specifies the -u option for that behavior, can’t you use that?
(GNU coreutils’ cat ignores it, since writing without delay is
apparently its default behavior already.)

> 
>   - we open the logfile for append, rather than just output.
>     That makes it OK for tests to truncate the logfile
>     without restarting the daemon (the OS will atomically
>     seek to the end of the file when outputting each line).
>     That allows tests to look at the log without worrying
>     about pollution from earlier tests.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/lib-git-daemon.sh | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
> index 987d40680b..19f3ffdbb1 100644
> --- a/t/lib-git-daemon.sh
> +++ b/t/lib-git-daemon.sh
> @@ -53,11 +53,19 @@ start_git_daemon() {
>  		"$@" "$GIT_DAEMON_DOCUMENT_ROOT_PATH" \
>  		>&3 2>git_daemon_output &
>  	GIT_DAEMON_PID=$!
> +	>daemon.log
>  	{
>  		read line <&7
> +		echo "$line"
>  		echo >&4 "$line"
> -		cat <&7 >&4 &
> -	} 7<git_daemon_output &&
> +		(
> +			while read line <&7
> +			do
> +				echo "$line"
> +				echo >&4 "$line"
> +			done
> +		) &
> +	} 7<git_daemon_output >>"$TRASH_DIRECTORY/daemon.log" &&
>  
>  	# Check expected output
>  	if test x"$(expr "$line" : "\[[0-9]*\] \(.*\)")" != x"Ready to rumble"
> 

read without -r clobbers backslashes, and echo may interpret escape
sequences. To faithfully reproduce the output, it would be better to use
read -r and printf '%s\n' "$line", I think. (However, it looks like the
existing code already uses read+echo, so I guess you could also keep
that pattern in this change and then fix it in a later one.)
