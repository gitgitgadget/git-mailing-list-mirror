From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Halt during fetch on MacOS
Date: Sat, 1 Mar 2014 01:15:32 -0500
Message-ID: <20140301061532.GC20397@sigill.intra.peff.net>
References: <CAFFUb6X455R4OD5FKnVFHFmvTyRqtV300bc=a8Xs03agM+=uLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Conley Owens <cco3@android.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 07:15:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJdD0-0001Dn-EW
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 07:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbaCAGPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 01:15:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:59201 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750909AbaCAGPe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 01:15:34 -0500
Received: (qmail 21581 invoked by uid 102); 1 Mar 2014 06:15:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 01 Mar 2014 00:15:34 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Mar 2014 01:15:32 -0500
Content-Disposition: inline
In-Reply-To: <CAFFUb6X455R4OD5FKnVFHFmvTyRqtV300bc=a8Xs03agM+=uLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243044>

On Fri, Feb 28, 2014 at 03:26:28PM -0800, Conley Owens wrote:

> test.sh
> """""""""""""""""""""""""""""""""""""
> #!/bin/bash
> rungit() {
>     mkdir $1
>     GIT_DIR=$1 git init --bare
>     echo '[remote "aosp"]' > $1/config
>     echo '    url =
> https://android.googlesource.com/platform/external/tinyxml2' >>
> $1/config
>     GIT_DIR=$1 git fetch aosp +refs/heads/master:refs/remotes/aosp/master

I don't think this is affecting your test, but you probably want ">>" to
append to the config for the first line, too. Otherwise you are
overwriting some of git's default settings.

> When everything cools, you can see that there are some fetches hanging
> (typically).
> $ ps | grep 'git fetch'
> ...
> 63310 ttys004    0:00.01 git fetch aosp
> +refs/heads/master:refs/remotes/aosp/master
> [...]

I can't reproduce here on Linux. Can you find out what the processes are
doing with something like strace?

> You can look at the parent process of each and see that one half
> spawned the other half, or you can look at the environment variables
> for each to see that there are two processes operating in the same
> directory for each directory where there's an issue.
> $ echo "$(for pid in $(ps | grep 'git fetch' | grep -o '^[0-9]*'); do
> ps -p $pid -wwwE | grep 'GIT_DIR=[^ ]*' -o; done)" | sort
> GIT_DIR=testdir14
> GIT_DIR=testdir14
> GIT_DIR=testdir32
> GIT_DIR=testdir32
> GIT_DIR=testdir47
> GIT_DIR=testdir47

A fetch will start many sub-processes. Try:

  GIT_TRACE=1 git fetch \
    https://android.googlesource.com/platform/external/tinyxml2

which shows git-fetch starting the git-remote-https helper, which in
turn starts git-fetch-pack to do the actual protocol, which uses
git-unpack-objects to manage the incoming pack.

-Peff
