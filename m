From: David Kastrup <dak@gnu.org>
Subject: Re: [fixed PATCH] git-filter-branch.sh: Fix broken setting of GIT_DIR
Date: Sat, 11 Aug 2007 12:32:18 +0200
Message-ID: <85r6mawedp.fsf@lola.goethe.zz>
References: <868x8j7aj2.fsf@lola.quinscape.zz>
	<864pj74ay9.fsf@lola.quinscape.zz>
	<7vk5s2mllf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 12:32:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJoGr-0004hG-T8
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 12:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbXHKKcg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 06:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754362AbXHKKcg
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 06:32:36 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:53512 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752951AbXHKKcX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Aug 2007 06:32:23 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 2F92F303076;
	Sat, 11 Aug 2007 12:32:22 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 1CEB923D303;
	Sat, 11 Aug 2007 12:32:22 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-049-066.pools.arcor-ip.net [84.61.49.66])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 1876F3BE23;
	Sat, 11 Aug 2007 12:32:19 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id A26561C3C79D; Sat, 11 Aug 2007 12:32:18 +0200 (CEST)
In-Reply-To: <7vk5s2mllf.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat\, 11 Aug 2007 03\:06\:36 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3923/Sat Aug 11 10:03:45 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55605>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> If filter-branch is entered with an unset GIT_DIR, things are rather
>> fragile.  The GIT_DIR variable setting then points to something like
>> $(pwd)/../.. which is neither guaranteed to be a git directory
>
> I think this comment refers to this part, ...
>
>> -case "$GIT_DIR" in
>> -/*)
>> -	;;
>> -*)
>> -	GIT_DIR="$(pwd)/../../$GIT_DIR"
>> -	;;
>> -esac
>
> ... however, at the beginning of the script, it dot-includes
> git-sh-setup, which sets (but not export) GIT_DIR for the rest
> of the script to use (see the last if..then..else).

Ah, ok.  In that case my patch is overengineered.  However, one could
replace the whole case with

GITDIR=$(cd ../..;cd $GIT_DIR;pwd)

This would work with Windows absolute paths, too.

> If you got an unset GIT_DIR when you reached that case statement
> you are removing here, I suspect that there is something else
> going on, but I do not see what it is...
>
> Puzzled...

The problem I saw was that "$(pwd)/../../$GIT_DIR" does no longer exist
by the time the end of the script it reached, because what was
"$(pwd)" has already been removed.  So it is less onerous than I
thought, but still a nuisance when the script ends.

Anyway, if $GIT_DIR is a relative path, things would go wrong in some
lines earlier, where the path is already being changed.

If git-sh-setup sets GIT_DIR, perhaps it would be sanest if it also
made it absolute?

Otherwise any script that does "cd" will lose track of GIT_DIR, right?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
