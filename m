From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Hook after pull ?
Date: Wed, 11 Jul 2007 14:26:18 -0700
Message-ID: <7vk5t63a4l.fsf@assigned-by-dhcp.cox.net>
References: <4694EC0F.10003@gmail.com>
	<81b0412b0707110751i7947ac5bv819e1c2de4e94621@mail.gmail.com>
	<4694F74F.8050908@gmail.com> <20070711183341.GA2798@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Claudio Scordino <cloud.of.andor@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:27:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8jiN-0007v9-Nb
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 23:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758156AbXGKV0s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 17:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758055AbXGKV0q
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 17:26:46 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61280 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289AbXGKV0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 17:26:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070711212619.HHCQ1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 11 Jul 2007 17:26:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NMSJ1X0051kojtg0000000; Wed, 11 Jul 2007 17:26:19 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52208>

Alex Riesen <raa.lkml@gmail.com> writes:

> Claudio Scordino, Wed, Jul 11, 2007 17:29:19 +0200:
>> >>If no, does exist any easy way of creating such hook ?
>> >
>> >What for? What do you want to do?
>> >
>> I just need my script to be called after a pull. My script just sends an 
>> email saying that the repository has been pulled (I already did it for the 
>> push).
>
> Ach, on _remote_ repo. Where it is _pulled_from_.
> There are none. You can catch log output of git-daemon, but...
> Isn't it a bit extreme? A fetch (part of a pull) is *very* common
> operation, sometime you'll get a *real* lot of mail.
>
> P.S. BTW, there is no hooks for pull in local (where it is pulled
> into): it is not needed, you already control everything what happens.

I am not sure I am reading this exchange correctly, but I think
Claudio wants to say

	$ git pull repo.or.cz:somebody/project.git/ the-branch 

and have it automatically send e-mail to the somebody (obviously
the hook script needs to have a mapping from the repository to
whom to notify).  As the daemon side cannot tell if the local is
only fetching (and possibly discarding the result) or pulling
(resulting in a merge), I do not think it is reasonable to do
the hooking on the remote side.  It has to be done on the local
if ever.

As you said, the local side has all the control, so in the
strictest sense there is no need for post-* hook, but we do
support a few hooks for local operations, such as post-commit.

(Sam Vilain CC'ed as he wanted to have hooks during and after a
merge).

I suspect that a post merge hook (that also is called in
fast-forward case) would be a good thing to have if people would
want to do this kind of thing often.  The hook most likely wants
to get the ORIG_HEAD and the updated HEAD as parameters, and can
act differently based on the nature of the merge (e.g. was it
fast-forward, was it a merge between the commits made by the
same committer as myself, etc.)
