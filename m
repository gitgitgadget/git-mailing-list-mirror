From: Junio C Hamano <junkio@cox.net>
Subject: Re: quick bare clones taking longer?
Date: Wed, 09 May 2007 15:59:23 -0700
Message-ID: <7v3b25siwk.fsf@assigned-by-dhcp.cox.net>
References: <7vvef2t36n.fsf@assigned-by-dhcp.cox.net>
	<20070509.130614.15589957.davem@davemloft.net>
	<7virb1sm6h.fsf@assigned-by-dhcp.cox.net>
	<20070509.150256.59469756.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Thu May 10 00:59:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlv8V-0000IV-O1
	for gcvg-git@gmane.org; Thu, 10 May 2007 00:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759871AbXEIW7h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 18:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760074AbXEIW7g
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 18:59:36 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:50925 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759526AbXEIW70 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 18:59:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509225925.QOYN24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 18:59:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xAzQ1W0041kojtg0000000; Wed, 09 May 2007 18:59:24 -0400
In-Reply-To: <20070509.150256.59469756.davem@davemloft.net> (David Miller's
	message of "Wed, 09 May 2007 15:02:56 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46807>

David Miller <davem@davemloft.net> writes:

> From: Junio C Hamano <junkio@cox.net>
> Date: Wed, 09 May 2007 14:48:38 -0700
>
>> > + no_checkout=yes
>> > + use_separate_remote=
>> > + test -z ''
>> > + origin=origin
>> > ++ get_repo_base ../torvalds/linux-2.6.git
>> > + base=
>> 
>> This part puzzles me.  The only way I could reproduce this was:
>> 
>> $ ls -F victim victim.git
>> ls: victim: No such file or directory
>> victim.git:
>> ./   HEAD	config	 description	       hooks/  lost-found/  refs/
>> ../  branches/	config~  gitcvs.master.sqlite  info/   objects/     remotes/
>> $ mkdir j
>> $ cd j
>> $ git clone --bare -l -s -n ../victim new.git
>> 
>> That is, I did not have ../victim but I did have ../victim.git/
>> repository, and I gave the former to "git clone".
>> 
>> But that suggests that you do not have ../torvalds/linux-2.6.git
>> directory but instead have ../torvalds/linux-2.6.git.git/ which
>> sound a bit insane.
>> 
>> Puzzled...
>
> This deeply puzzles me too.
>
> I'm just not going to go into my git directory using that
> symlink in my home directory any more. :-)

Ahhh, symlink!

get_repo_base does this:

        get_repo_base() {
                (cd "$1" && (cd .git ; pwd)) 2> /dev/null
        }

and is used like this:

        # Turn the source into an absolute path if
        # it is local
        if base=$(get_repo_base "$repo"); then
                repo="$base"
                local=yes
        fi

That is, get_repo_base does:

 * first try to cd to ../torvalds/linux-2.6.git; if it fails
   then give up.

 * then further cd down to .git if we can but do not worry about
   it if we can't.  Report where we are and succeed.

If the above "fails", the caller considers the cloned-from
repository a non-local one, and turns off -l -s optimization.

The above sequence is called before we create the new directory
and chdir to it.  Maybe pwd has funny behaviour (e.g. $PWD) and
we need to explicitly say /bin/pwd or somesuch...
