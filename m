From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem cloning the Linux history tree
Date: Fri, 04 Nov 2005 01:59:53 -0800
Message-ID: <7vacgkzqau.fsf@assigned-by-dhcp.cox.net>
References: <7vmzkl3yl0.fsf@assigned-by-dhcp.cox.net>
	<20051104092146.E5E35353C33@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 11:00:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXyMa-0002SE-QU
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 11:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbVKDJ74 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 04:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161128AbVKDJ74
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 04:59:56 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:47558 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1161127AbVKDJ7z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 04:59:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051104095936.JEHX16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Nov 2005 04:59:36 -0500
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20051104092146.E5E35353C33@atlas.denx.de> (Wolfgang Denk's
	message of "Fri, 04 Nov 2005 10:21:46 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11127>

Wolfgang Denk <wd@denx.de> writes:

> Missing object of tag v2.6.14-rc3... unable to retrieve

I do not have a clue on this one; I am assuming that it is
coming from cg-fetch.

> [Fri Nov 04 09:55:13 2005] [error] [client 84.150.96.170] File does not exist: /srv/git/linux-2.6-denx.git/objects/bc
>
> These directories really don't exist:
>
> $ cd /srv/git/linux-2.6-denx.git/objects
> . ls -l
> total 8
> drwxrwxr-x  2 wd wd 4096 Nov  4 09:52 info
> drwxrwxr-x  2 wd wd 4096 Nov  3 15:15 pack

Quick question.  Is the source repository fully packed (i.e. git
repack followed by git prune)?  If that is the case there is
nothing to worry about.  The latest git prunes empty
$GIT_OBJECT_DIRECTORY/??/ directories and recreates them on
demand.

> The question is : why are they requested?

Fetching over http is what we call a "commit walker" -- it
learns the top commit object names, gets that object and reads
it to learn what other objects it needs to slurp, and keeps
asking the next object, one by one.  When dealing with a packed
repository, it first asks individual objects (expecting they
would be found in $GIT_OBJECT_DIRECTORY/??/ directory), and when
not found it fetchs packs and looks inside.  Recent commit
walker knows how to issue multiple requests while earlier
request is still in transit, so you can expect some requests to
individual objects.  That is benign.

>> Cloning over git native transport should work, though:
>> 
>>     $ git clone git://git.kernel.org/pub/scm/lin.../history.git history
>
> This does not work for me,  either.

The above uses git:// URL  but your failure below uses http://

> -> git clone http://www.denx.de/git/linux-2.6-denx.git bar
> ...
> walk c264852726dde251a0c09ec22f61a9be8b0db68b
> walk 69903d6500c73af8329a5fba7153b0d50748981c
> walk b59a9504cb93db7fae31e60760725d48652a1fc3
> error: Could not interpret tags/DENX-2005-10-02-18:30 as something to pull

This one I can answer.  It is the colon in your tag name.
Please rename it to make git-check-ref-format(1) happy, run
git-update-server-info(1) and try again.
