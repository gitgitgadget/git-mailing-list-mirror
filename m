From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question about possible git races
Date: Wed, 22 Mar 2006 16:24:58 -0800
Message-ID: <7vacbi6m91.fsf@assigned-by-dhcp.cox.net>
References: <200603201724.12442.astralstorm@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 01:25:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMDdY-0001Ce-1o
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 01:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbWCWAZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 19:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWCWAZE
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 19:25:04 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:22685 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932643AbWCWAZC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 19:25:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060323002459.XTSJ20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Mar 2006 19:24:59 -0500
To: Radoslaw Szkodzinski <astralstorm@o2.pl>
In-Reply-To: <200603201724.12442.astralstorm@o2.pl> (Radoslaw Szkodzinski's
	message of "Mon, 20 Mar 2006 17:24:05 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17836>

Radoslaw Szkodzinski <astralstorm@o2.pl> writes:

> - push vs pull
>
> - push vs push
>
> - fetch vs fetch

About push vs push, with "really bare git", I take it that you
mean two send-pack from remote sites running two receive-pack
simultaneously.

There is an explicit race avoidance between the receive-pack
processes.  When a ref (either branch head or a tag) is updated,
it does:

 - read the current value from the ref.
 - do its work.
 - lock to prevent others to create the temporary file for
   updating the ref.
 - create the temporary file for the ref and write the new value.
 - check if the ref's value has not changed from what it
   initially read;
 - rename the temporary file to the ref to unlock.

Read receive-pack.c::update() for exact details if you are
interested.

> I'm meaning really bare git there, w/o bash+perl scripts.

The question does not make any sense for other cases, because
branch update by fetch and pull are all scripts based.
