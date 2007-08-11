From: David Kastrup <dak@gnu.org>
Subject: Re: [fixed PATCH] git-filter-branch.sh: Fix broken setting of GIT_DIR
Date: Sat, 11 Aug 2007 14:29:01 +0200
Message-ID: <851weaw8z6.fsf@lola.goethe.zz>
References: <868x8j7aj2.fsf@lola.quinscape.zz>
	<864pj74ay9.fsf@lola.quinscape.zz>
	<7vk5s2mllf.fsf@assigned-by-dhcp.cox.net>
	<85r6mawedp.fsf@lola.goethe.zz> <858x8iw9q1.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 14:29:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJq5g-0007gl-Tq
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 14:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbXHKM3K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 08:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbXHKM3I
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 08:29:08 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:45524 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751035AbXHKM3H (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Aug 2007 08:29:07 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 0D1631840BE;
	Sat, 11 Aug 2007 14:29:05 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id F22F12D3788;
	Sat, 11 Aug 2007 14:29:04 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-049-066.pools.arcor-ip.net [84.61.49.66])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 49F3D22D166;
	Sat, 11 Aug 2007 14:29:02 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id A79651C3C79D; Sat, 11 Aug 2007 14:29:01 +0200 (CEST)
In-Reply-To: <858x8iw9q1.fsf@lola.goethe.zz> (David Kastrup's message of "Sat\, 11 Aug 2007 14\:12\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3923/Sat Aug 11 10:03:45 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55608>

David Kastrup <dak@gnu.org> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Anyway, if $GIT_DIR is a relative path, things would go wrong in some
>> lines earlier,
>
> and if GIT_DIR were used or exported which it isn't, so we are lucky...
>
>> where the path is already being changed.
>>
>> If git-sh-setup sets GIT_DIR, perhaps it would be sanest if it also
>> made it absolute?
>>
>> Otherwise any script that does "cd" will lose track of GIT_DIR, right?
>
> Actually, wouldn't by far the most straightforward thing be if
> git-rev-parse --git-dir always returned an absolute path (even when
> being passed a relative path in GIT_DIR)?
>
> No need for postprocessing, no need to keep track of changed
> directories.

To illustrate the potential for trouble:

git-commit.sh

has the lines

647:
    cd_to_toplevel

    git rerere

    if test "$ret" = 0
    then
            if test -x "$GIT_DIR"/hooks/post-commit
            then
                    "$GIT_DIR"/hooks/post-commit
            fi

Obviously, this won't work if GIT_DIR has a relative path and the
command has not been started from the top level already.

In a similar vein, git-checkout.sh has

263:
     GIT_DIR="$GIT_DIR" git symbolic-ref -m "checkout: moving from $old_branch_name to $branch" HEAD "refs/heads/$branch"

while we have previously cd_to_toplevel in line 154.


And so on.  Rather than fixing all those scripts, it would seem safer
to let git-rev-parse --git-dir (I don't understand the code in
builtin-rev-parse, by the way: why does it look at "prefix"?), or at
the very least git-sh-setup.sh return an absolute path.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
