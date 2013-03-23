From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: feature request - have git honor nested .gitconfig files
Date: Sat, 23 Mar 2013 07:15:42 +0100
Message-ID: <878v5ezlo1.fsf@pctrast.inf.ethz.ch>
References: <CAM2RUGOOWnxRd2=04-NmKTC+tvnCD=ebgmmiexHas5bwyYrm4w@mail.gmail.com>
	<20130322182211.GD12223@google.com>
	<20130322183306.GA32448@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Josh Sharpe <josh.m.sharpe@gmail.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 23 07:18:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJHn5-0005Hr-R4
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 07:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755749Ab3CWGSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 02:18:22 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:18977 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560Ab3CWGSV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 02:18:21 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 23 Mar
 2013 07:15:43 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.211.113) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Sat, 23 Mar 2013 07:15:45 +0100
In-Reply-To: <20130322183306.GA32448@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 22 Mar 2013 14:33:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.211.113]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218889>

Jeff King <peff@peff.net> writes:

> I'd rather not invent a new language. It will either not be featureful
> enough, or will end up bloated. Or both. How about something like:
>
>   [include]
>        exec = "
>          case \"$GIT_DIR\" in)
>            */dev/*) cat ~/.config/git/dev-config ;;
>                  *) cat ~/.config/git/nondev-config ;;
>           esac
>        "
>
> It involves a shell invocation, but it's not like we parse config in a
> tight loop. Bonus points if git provides the name of the current config
> file, so exec can use relative paths like:

We do, however, parse config more than once:

  $ strace git log -1 2>&1 | grep 'open.*config'
  open("/home/thomas/.gitconfig", O_RDONLY) = 3
  open(".git/config", O_RDONLY)           = 3
  open("/home/thomas/.gitconfig", O_RDONLY) = 3
  open(".git/config", O_RDONLY)           = 3
  open("/home/thomas/.gitconfig", O_RDONLY) = 3
  open(".git/config", O_RDONLY)           = 3
  open("/home/thomas/.gitconfig", O_RDONLY) = 3
  open(".git/config", O_RDONLY)           = 3

git-log might be somewhat of an extreme example, but I suspect it's at
least twice for all commands (once for repo detection and once for
actual parsing).  So I further suspect that the slowdown in git's own
shellscripts (rebase) would be quite large if you actually spawned two
extra shells every time someone says 'git rev-parse ...'.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
