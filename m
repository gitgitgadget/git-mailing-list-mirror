From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix race and deadlock when sending pack
Date: Mon, 19 Dec 2005 14:44:56 -0800
Message-ID: <7vr788emfr.fsf@assigned-by-dhcp.cox.net>
References: <43A628F6.1060807@serice.net>
	<7vzmmxlkbq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512191236290.25300@iabervon.org>
	<7vy82gg5t7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512191645230.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 23:47:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoTkd-0006eR-Gu
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 23:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbVLSWo6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 17:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbVLSWo6
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 17:44:58 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:57555 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965016AbVLSWo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 17:44:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051219224330.XPTH17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Dec 2005 17:43:30 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0512191645230.25300@iabervon.org> (Daniel
	Barkalow's message of "Mon, 19 Dec 2005 17:00:45 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13840>

Daniel Barkalow <barkalow@iabervon.org> writes:

> If we have the reporting mechanism, that will effectively be part of the 
> protocol. It's obviously done transferring the pack at that point, but it 
> still wants fixed-format communication, so switching over to being the 
> stardard output of the hooks would cause problems with this.

In order to add reporting mechanism later, I think we need to be
able to identify the protocol version in a backward compatible
way, something like the "server capabilities hidden behind the
NUL" trick we did for fetch-pack/upload-pack protocol.  Once
that is in place, it does not cause harm even if the current
protocol program connects hooks' stdout to send-pack, at least
in theory.  If we take Paul's patch now, however, it would add
more work for us later when we do that protocol change, because
we will need to wrap the output from the hook in the pkt-line
interface in the new protocol, in order to give that back to the
stdout of send-pack.  Considering that, I think we may want to
drop Paul's patch and declare that hooks stdout does not come
back to send-pack.

Honestly speaking, I do not really care where stdout of hooks go
as long as that does not cause breakage/deadlocks, and I think
your earlier patch on December 7th is serving us well enough; we
needed to have told users to do an "exec 1>somewhere" in their
hooks before that fix, which was not nice at all (and we even
forgot to tell them that).  If people want to send the output to
a log file, they can do so; if they want e-mails, they can do
so; if they want to show the output to the pusher, they can do
1>&2; all inside their hooks.  I do "echo nitfol | at now" and
love the way that I do not have to worry about how "at" command
gives me back execution report via e-mail at all ;-).

> It's probably worth making sure that all the hooks run with something 
> sane, and punt making it configurable andnice until post-1.0.

I think we agree that /dev/null is one of the sane choices as
you did in your earlier fix.  Duping stderr would have been
another sane choice, but I honestly do not think we care much
either way.
