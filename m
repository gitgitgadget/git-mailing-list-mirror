From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Sun, 13 Nov 2005 23:46:37 -0800
Message-ID: <7vwtjb3c4i.fsf@assigned-by-dhcp.cox.net>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>
	<43730E39.6030601@pobox.com> <7v64qzni9c.fsf@assigned-by-dhcp.cox.net>
	<4375DD4A.5050103@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 08:47:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbZ35-0007A8-Pk
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 08:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbVKNHqk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 02:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbVKNHqk
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 02:46:40 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:50149 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750966AbVKNHqj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 02:46:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051114074528.LXIC20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 02:45:28 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4375DD4A.5050103@op5.se> (Andreas Ericsson's message of "Sat, 12
	Nov 2005 13:17:14 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11771>

Andreas Ericsson <ae@op5.se> writes:

>> Also places we execute git-upload-pack and git-receive-pack over
>> an SSH connection need to be updated to execute 'git' with the
>> first parameter 'upload-pack' and 'receive-pack' to make sure it
>> would keep working with older or newer git on the other end.
>
> I've cooked up a patch that takes care of this if;
> 	git daemon
> is executed (rather than git-daemon)...

Actually I was more worried about these git native protocols
going over ssh, which is not helped by git-daemon.  I think
teaching the libdir to git-shell would make sense for "git
restricted shell" users, but most users coming from ssh to run
git native protocols would need to have some way of running the
executable on the other end.

My current thinking about this problem is that the handful
programs that need to run "on the other end" should stay in
/usr/bin, even after we move most things out of /usr/bin, if
only to avoid configuration hassles.  They are:

	receive-pack, upload-pack
        ssh-fetch, ssh-pull, ssh-push, ssh-upload

BTW, does anybody actually use these commit walkers over SSH?
Cogito switched out of it before 0.16r1 if I understand
correctly, and git barebone never used it.  It might not be a
bad idea to deprecate these altogether, now packed transfer
seems to be much nicer.

BTW^2, git-octopus should be deprecated as well; I am a bit
reluctant to see git-resolve go but it probably should too.

> All I really need to finalize it is that name, so It's up to you how 
> fast you want it. Perhaps we could take a poll?

Somehow libdir reminds me of where libraries are installed by
the Makefile, which usually does not mean executables, and that
was the reason I mentioned --exec-path.  Although I do not have
strong preference myself either way, I do not think the list
cares too much either, so in order not to waste time by
indecision, let's just say we use this one:

> The form will be
> 	exec_path=$(prefix)/lib/git-@@VERSION@@
> 	GIT_EXEC_PATH
> 	--exec-path
>
> for Makefile, environment and 'git', respectively. Substitute the 
> obvious part with whatever you prefer.

> ..., although I'm implementing Linus' idea of prepending the
> GIT_EXEC_PATH to $PATH so the porcelainish scripts in git-core
> shouldn't have to do it.

This sounds good to me; let's go with it.  Thanks.
