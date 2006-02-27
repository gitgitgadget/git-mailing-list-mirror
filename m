From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] First cut at libifying revlist generation
Date: Sun, 26 Feb 2006 21:09:45 -0800
Message-ID: <7vy7zx1j6u.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602251608160.22647@g5.osdl.org>
	<7vpsl93395.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602261914270.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 27 06:10:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDadu-0000Jw-MW
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 06:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWB0FJt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 00:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWB0FJt
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 00:09:49 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:30597 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751363AbWB0FJt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 00:09:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060227050650.MLIC26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Feb 2006 00:06:50 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16825>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 26 Feb 2006, Junio C Hamano wrote:
>> 
>> I am clueless about the "limited = (list && list->next)" part,
>> but there is only one commit involved hence the test is false
>> with my testcase "git-rev-list --objects v1.0.0^0..v1.0.0"; I
>> think the old code said dotdot is a limited case.
>
> dotdot should insert _two_ commits onto the list - the positive and 
> the negative one.  Doesn't it? 

Not really, because the second invocation of add_one_commit()
says "I've seen that *commit*", which is correct.  And the story
is obviously the same if you used longhand "^v1.0.0^0 v1.0.0".

As a symbolic notation v1.0.0^0..v1.0.0 may not make much sense,
but the point is "the other end says he has that commit object,
but now he wants the tag we later attached to that commit
object; let's list the objects we need to send him".  This is
what upload-pack does.

A bad consequence of not limiting is that:

	git-rev-list ^v1.0.0^0 v1.0.0 | tail -n 1

gives this commit ;-):

	e83c5163316f89bfbde7d9ab23ca2e25604af290

Argh.
