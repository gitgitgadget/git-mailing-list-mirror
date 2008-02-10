From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] daemon: Set up PATH properly on startup.
Date: Sun, 10 Feb 2008 21:00:26 +0100
Message-ID: <20080210200027.169BD5B0E7@dx.sixt.local>
References: <1202555873-8099-1-git-send-email-mdw@distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: Mark Wooding <mdw@distorted.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 21:01:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOIMM-0007u2-Ra
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbYBJUAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 15:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbYBJUAa
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:00:30 -0500
Received: from smtp5.srv.eunet.at ([193.154.160.227]:35551 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbYBJUAa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 15:00:30 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 5EE1413AB88;
	Sun, 10 Feb 2008 21:00:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 169BD5B0E7;
	Sun, 10 Feb 2008 21:00:27 +0100 (CET)
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73395>

Mark Wooding wrote:
> Since exec_cmd.c changed (511707d42b3b3e57d9623493092590546ffeae80) to
> just use the PATH variable for finding Git binaries, the daemon has been
> broken for people with picky inetds (such as the OpenBSD one) which
> launder the environment on startup.  The result is that the daemon
> mysteriously fails to do anything useful.
[...] 
> diff --git a/daemon.c b/daemon.c
> index 41a60af..cfd6124 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1149,6 +1149,7 @@ int main(int argc, char **argv)
>  usage(daemon_usage);
>  }
>  
> +     setup_path(NULL);
>  if (inetd_mode && (group_name || user_name))
>  die("--user and --group are incompatible with --inetd");
>  

There are 2 reason, *not* to do this:

1. It's not needed. You can use

    /usr/local/bin/git --exec-path=/usr/local/bin daemon --inetd ...

to inject the exec-path.

2. Security. Those inetds launder the environment for a reason. Assume inetd
sets PATH=/usr/bin:/bin and git-daemon is installed
as /usr/sbin/git-daemon. With your patch now all hooks run with the path
set to /usr/sbin:/usr/bin:/bin.

-- Hannes
