From: Junio C Hamano <junkio@cox.net>
Subject: Re: Weirdness with port-update hook and local push
Date: Mon, 05 Dec 2005 14:11:34 -0800
Message-ID: <7vk6ej9otl.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0512051530560.25300@iabervon.org>
	<Pine.LNX.4.63.0512052138560.6554@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0512051651050.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Dec 05 23:14:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjOYd-0008IM-HD
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 23:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVLEWLg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 17:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbVLEWLg
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 17:11:36 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:43494 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964784AbVLEWLf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 17:11:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051205220954.OGPJ20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Dec 2005 17:09:54 -0500
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0512051651050.25300@iabervon.org> (Daniel
	Barkalow's message of "Mon, 5 Dec 2005 17:01:04 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13241>

Daniel Barkalow <barkalow@iabervon.org> writes:

> The thing that confuses me is that it works when run from ssh or directly, 
> but not when run from a local push. I'd expect the two that work to be 
> most different.

One suspicion and one suggestion (without knowing exactly where
that suggestion might lead us to).

 - your stdout/stderr might be connected to somewhere that your
   output gets stuck ("broken pipe"), when your script is run
   from the hook.

 - your environment might be different from what you are
   assuming.

How about doing something like this?

	  #!/bin/sh

	+ exec >/var/tmp/hook-out.$$ 2>/var/tmp/hook-err.$$
	+ echo "** env **"
	+ env
	+ echo "** vars **"
	+ i=0
	+ for v
	+ do
	+	 echo "$i: $v"
	+	 i=$(($i+1))
	+ done
	+ echo "** pwd etc **"
	+ pwd
	+ id -a

	  unset GIT_DIR
	  cd /home/barkalow/auto-working/web
	  if ! git pull /home/barkalow/git/web.git/

and then next replace the whole thing with:

	exec >/dev/null 2>&1

        
