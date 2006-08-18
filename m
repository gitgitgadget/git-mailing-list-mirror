From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unresolved issues #3
Date: Fri, 18 Aug 2006 02:26:27 -0700
Message-ID: <7vbqqics3g.fsf@assigned-by-dhcp.cox.net>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
	<tnx1wre4e6s.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 11:26:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE0cb-0005CX-K8
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 11:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWHRJ0a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 05:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWHRJ0a
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 05:26:30 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:21650 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751319AbWHRJ03 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 05:26:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060818092628.OSDL12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Aug 2006 05:26:28 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnx1wre4e6s.fsf@arm.com> (Catalin Marinas's message of "Fri, 18
	Aug 2006 09:54:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25638>

Catalin Marinas <catalin.marinas@arm.com> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> * Martin Langhoff proposed git-xxdiff as a helper after a failed
>>   merge.
>>
>>   Message-ID: <11546492331601-git-send-email-martin@catalyst.net.nz>
>>
>>   I like the general idea of this a lot, but am having a bit of
>>   trouble envisioning how we can integrate this while making
>>   sure mergers other than xxdiff can be added easily without
>>   disrupting the end user experience.
>
> In StGIT I can configure the merge command and I currently use the
> attached script (I need to add it to the StGIT repository). It tries
> diff3 first and, if that fails, invokes emacs' merge (can use xxdiff
> as well). It also checks whether the file was modified in case I want
> to exit and solve the conflict later (maybe after getting conflict
> information for the other files).

Thanks.  That is interesting.  However, the workflow Martin
wants to use this is a bit different from this.  He wants
regular diff3/merge to leave conflicted result and have "xxdiff
-U" to sort out the resulting mess (I do that manually myself
but without any wrapper).

Having said that...

> # default merger
> if os.system('diff3 -L current -L ancestor -L patched -m -E '
>              '"%s" "%s" "%s" > "%s"'
>              % (branch1, ancestor, branch2, output)):
>     # interactive merge
>     if os.path.exists(output):
>         mtime = os.path.getmtime(output)
>     else:
>         mtime = 0

This reminds me that I should make the git barebone
porcelain-ish to use diff3 directly without using merge
wrapper.

I wonder why you do not error out when "if os.path.exists(output)"
does not hold true; you are redirecting into it, so the possibilities
are:

 - the filesystem is full;
 - your quota ran out;
 - you do not have write permission to the directory "output"
   wants to be in;
 - the user gave 'fooled you"; rm -fr . "bye' as the value of
   sys.argv[4];

etc.  No matter what the reason, the fall-back interactive merge
would not be able to write into output either anyway, no?

Also I wonder what would happen upon a user error where an
existing file that is unwritable by the user is specified as
output.
