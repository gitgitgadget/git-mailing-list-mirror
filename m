From: Petr Baudis <pasky@suse.cz>
Subject: Re: Expected Behavior?
Date: Tue, 8 Nov 2005 10:56:00 +0100
Message-ID: <20051108095600.GA1431@pasky.or.cz>
References: <E1EZKOB-0002j5-VY@jdl.com> <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 10:57:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZQD2-0001ND-2U
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 10:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVKHJ4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 04:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVKHJ4F
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 04:56:05 -0500
Received: from w241.dkm.cz ([62.24.88.241]:56725 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964894AbVKHJ4E (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 04:56:04 -0500
Received: (qmail 23973 invoked by uid 2001); 8 Nov 2005 10:56:00 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11322>

Dear diary, on Tue, Nov 08, 2005 at 07:00:11AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Nobody complained so far about this, probably because two side
> adding different versions is rare enough.  And the reasoning
> behind the current behaviour is probably because the tool cannot
> automerge them sensibly anyway.  Leaving the SHA1 in index file
> might probably be easier to clean up by hand (e.g. see ls-files
> --unmerged, and cut&paste the desired SHA1 to 'git-cat-file
> blob' command line, or something silly like that).  But if we
> were to go that route, adding --stage=[123] flag so that the
> user can say 'git-checkout-index --stage=3 file3'might have
> helped a bit more.

#
# Added in both (different in each).
#
".$id1$id2")
        #echo "Adding $file"
        filev="$file"
        while [ -e "$filev~1" ] || [ -e "$filev~2" ]; do
                filev="$filev~"
        done
        error "File $file added in both branches, but different in each!"
        error "Conflicting versions saved as '$filev~1' and '$filev~2'."
        git-update-index --add --cacheinfo "$mode1" "$id1" "$file" &&
                git-checkout-index -u -f -- "$file" &&
                mv "$file" "$filev~1" ||
                error "Cannot create '$filev~1'"
        git-update-index --add --cacheinfo "$mode2" "$id2" "$file" &&
                git-checkout-index -u -f -- "$file" &&
                mv "$file" "$filev~2" ||
                error "Cannot create '$filev~2'"
        exit 1
        ;;

is what Cogito's automerger does. It ain't very pretty, but it works.
:-) (At least it seems to.) I yet need to add some conflicts tracking to
Cogito to prevent accidental checking in of conflicts.

> We could instead use the attached patch to get the behaviour you
> are expecting.  I have a feeling that the result from this might
> be a little more intuitive and easier to resolve by hand than
> the current one.  Although we may end up unresolvable mess in
> file3 if either side is binary, in that case the user can still
> sift through 'diff-tree A B file3' output to find out the
> relevant SHA1 to recover the blobs from both sides by hand
> anyway.  Does anybody have strong opinion on this?

I think having

	<<<<<
	file1
	=====
	file2
	>>>>>

is an awful PITA to resolve, especially when the files actually are
similar. Running some vimdiff (or just diff and possibly applying either
way) on two separate files is much more convenient.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
