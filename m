From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] walk PATH to generate list of commands for "help -a"
Date: Wed, 24 Oct 2007 22:33:32 -0700
Message-ID: <7vk5pb21xv.fsf@gitster.siamese.dyndns.org>
References: <1193283437-1706-1-git-send-email-srp@srparish.net>
	<1193283437-1706-2-git-send-email-srp@srparish.net>
	<1193283437-1706-3-git-send-email-srp@srparish.net>
	<1193283437-1706-4-git-send-email-srp@srparish.net>
	<1193283437-1706-5-git-send-email-srp@srparish.net>
	<1193283437-1706-6-git-send-email-srp@srparish.net>
	<7vve8v24al.fsf@gitster.siamese.dyndns.org>
	<20071025050736.GG759@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 07:34:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkvMY-0003Tv-Dw
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 07:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759284AbXJYFdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 01:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759189AbXJYFdk
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 01:33:40 -0400
Received: from rune.pobox.com ([208.210.124.79]:45787 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759170AbXJYFdi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 01:33:38 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id DBCF814F22A;
	Thu, 25 Oct 2007 01:33:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 2627514E559;
	Thu, 25 Oct 2007 01:33:55 -0400 (EDT)
In-Reply-To: <20071025050736.GG759@srparish.net> (Scott Parish's message of
	"Wed, 24 Oct 2007 22:07:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62275>

Scott Parish <sRp@srparish.net> writes:

> On Wed, Oct 24, 2007 at 09:42:42PM -0700, Junio C Hamano wrote:
>
>> Scott R Parish <srp@srparish.net> writes:
>> 
>> > Signed-off-by: Scott R Parish <srp@srparish.net>
>> 
>> Rationale?
>
> Well, the ultimate reason that i've been working on all of this is
> i'd like to push git as a viable development tool where i work. To
> give an effective idea, lets say that shared tools get placed on
> nfs servers, which can be mounted to different paths depending on
> which nfs server is up or down or which system is the nfs client.

It sounds to me that your nfs client systems might find what
people usually expect in /usr/local/bin not there but on
/mnt/random47/bin depending on the system, without a reasonable
system administration effort that places stable symlinks to give
end users a consistent view of the world regardless from which
client, which sounds insane.  I personally do not think we
should support lazy system administrators by making git unsafe.

But using PATH as a fallback is what we already do for scripts,
and that is good enough to deal with such an installation.

> Should i be putting all that in my commit messages?

Even in a well behaved installation, where everything is found
where they should be (iow, GIT_EXEC_PATH), this is needed
because 4/7 lets you run a custom "git that" command from PATH
and this 6/7 is to teach "help -a" about it.  I think at least
that much needs to be said in the commit message.

>> There are two cases execv_git_cmd() runs "git-that" from a non
>> standard place, if we take your [PATCH 4/7].
>> 
>>  - If there is a directory that contains a location that used to
>>    hold an old installation of git-* commands (some of which may
>>    have been removed in the latest git) and if the user has that
>>    directory on PATH, we would run obsolete git subcommand from
>>    there.
>
> I could see that as being problematic. I suppose there are ways
> around that (have "git" pass to "git-cmd" an argument of what version
> it is) but none that i really like.

As I said, this is making git a bit less safe from unintended
leftover executables, but the scripts already work that way and
your 4/7 merely makes the C level in line with that behaviour.
I do not think it is too much of a problem anyway.

>> It may be nicer if the user can somehow tell from the output if
>> each of the command is from the standard set (i.e. on
>> GIT_EXEC_PATH or built-in), or from a non standard place (either
>> custom command as intended, or an unintended obsolete leftover).
>
> What if git marked commands that weren't found in the location where
> it thinks that it is running from?

Currently "git help -a" says "available in $where" at the top.
Perhaps make a separate list that is listed as "available from
elsewhere" and show the ones that are on PATH but not masked by
the ones on GIT_EXEC_PATH?

    git commands available in '/home/junio/git-next/bin'
    ----------------------------------------------------
      add                 gui                 rebase--interactive
      add--interactive    hash-object         receive-pack
      ...

    git commands available from elsewhere on your $PATH
    ----------------------------------------------------
      frotz               nitfol
