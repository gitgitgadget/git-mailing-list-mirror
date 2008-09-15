From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [ANNOUNCE] GIT 1.6.0-rc2
Date: Mon, 15 Sep 2008 19:12:40 +0200
Message-ID: <20080915171240.GB4787@efreet.light.src>
References: <1218099517.8625.3.camel@twins> <7v3alhjgau.fsf@gitster.siamese.dyndns.org> <20080807.052648.239243998.davem@davemloft.net> <20080913.013330.29519747.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, peterz@infradead.org, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Mon Sep 15 19:15:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfHeA-0003Nu-Ba
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 19:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707AbYIORMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 13:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753810AbYIORMs
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 13:12:48 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:33000 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753575AbYIORMr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 13:12:47 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 6C6C757416;
	Mon, 15 Sep 2008 19:12:45 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id BFmNts5AGNpY; Mon, 15 Sep 2008 19:12:42 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 043EA5740F;
	Mon, 15 Sep 2008 19:12:40 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KfHcu-0003Sx-Dr; Mon, 15 Sep 2008 19:12:40 +0200
Content-Disposition: inline
In-Reply-To: <20080913.013330.29519747.davem@davemloft.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95925>

On Sat, Sep 13, 2008 at 01:33:30 -0700, David Miller wrote:
> As a followup this turned out to be the classic "PATH when doing GIT over
> SSH" problem.
> 
> I have to say this is very unfun to debug, and even less fun to "fix"
> even once you know this is the problem.  And what's more I know this is
> the second time I've had to spend a night debugging this very problem.
> 
> I ended up having to make a ~/.ssh/environment file and then restart my
> SSH server with "PermitUserEnvironment yes" added to sshd_config.
> 
> But I can't believe this is what I have to do just to pull from a machine
> where I have GIT only installed in my home directory.  What if I were just
> a normal user and couldn't change the SSHD config?  What hoops would I
> need to jump through to get my PATH setup correctly? :)
> 
> It doesn't even work to put ~/bin into the PATH listed in the system wide
> /etc/environment, because that does not do tilde expansion, SSHD just takes
> it as-is.
> 
> Wouldn't it make sense to put the bindir into PATH when we try to do
> execv_git_cmd()?  The code has already put the gitexecdir into the
> PATH at this point.

I don't think it gets to execv_git_cmd(). Git on local side will run
    ssh <host> git upload-pack
and it's ssh that can't find git in ~/bin (or maybe it's still using the
dashed form for backward compatibility; the argument stands either way).

There are two possible solutions (besides the .ssh/environment one):
 1. Without hacking git: Use a separate key pair for git access and configure
    that key on the server with 'command="/home/you/bin/git-shell"' option in
    .ssh/authorized_keys. Git shell should run the command from exec-dir
    properly.
 2. Hack git to support some variable to set the remote command for ssh
    protocol.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
