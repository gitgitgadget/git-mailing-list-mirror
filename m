From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-apply: apply submodule changes
Date: Sun, 12 Aug 2007 12:24:29 -0700
Message-ID: <7vr6m8imj6.fsf@assigned-by-dhcp.cox.net>
References: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
	<20070812142340.GA10399MdfPADPa@greensroom.kotnet.org>
	<7vwsw0ipp2.fsf@assigned-by-dhcp.cox.net>
	<20070812185006.GG999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Johannes.Schindelin@gmx.de
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Aug 12 21:24:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKJ3E-0002cn-Sd
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 21:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935954AbXHLTYd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 15:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935941AbXHLTYc
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 15:24:32 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:50875 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935275AbXHLTYc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 15:24:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070812192431.YUUE5405.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 12 Aug 2007 15:24:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id b7QW1X0061kojtg0000000; Sun, 12 Aug 2007 15:24:31 -0400
In-Reply-To: <20070812185006.GG999MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Sun, 12 Aug 2007 20:50:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55704>

Sven Verdoolaege <skimo@kotnet.org> writes:

>>  - what does ce have to do in this codepath?  read_old_data()
>>    does not care about what is in the index (in fact, in the
>>    index the entry can be a symlink when the path on the
>>    filesystem is a regular file, and it reads from the regular
>>    file as asked--it does not even look at ce by design).  
>>    if you have a regular file there in the current version, ce
>>    would say it is a regular file blob and you would not want
>>    read_gitlink_or_skip() to say "Subproject commit xyz...".
>
> Hmmm... the documentation says that if --index is in effect
> then the file to be patched in the work tree is supposed to be 
> up-to-date.

But that is the job of check_patch(), not this function, isn't it?

>> The type-mismatch case to attempt to apply gitlink patch to a
>> regular blob is covered much earlier in check_patch().  It
>> complains if st_mode does not match patch->old_mode; I think you
>> need to adjust it a bit to:
>> 
>>  - allow gitlink patch to a path that currently has nothing (no
>>    submodule checked out) or a directory that has ".git/"
>>    (i.e. submodule checked out).
>> 
>>  - reject gitlink patch otherwise.
>
> Are you talking about the case where --index is specified?

Talking about both cases, and the division of responsibility
between check_patch() and apply_data().
