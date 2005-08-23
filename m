From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [RFC] Removing deleted files after checkout
Date: Tue, 23 Aug 2005 16:21:51 -0600
Organization: Hewlett Packard
Message-ID: <20050823222151.GA15321@hpsvcnb.fc.hp.com>
References: <20050823162156.GA32240@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508231533570.23242@iabervon.org> <20050823205052.GA13311@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508231713450.23242@iabervon.org> <7vvf1wnwtl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 24 00:23:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7hAC-0002BO-4C
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 00:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVHWWWd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 18:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVHWWWd
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 18:22:33 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:11188 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932412AbVHWWWc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 18:22:32 -0400
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.15.136.253])
	by atlrel7.hp.com (Postfix) with ESMTP id CED5D79F;
	Tue, 23 Aug 2005 18:21:56 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP
	id 5A1B541E2C3; Tue, 23 Aug 2005 22:21:51 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 49F332CD92; Tue, 23 Aug 2005 16:21:51 -0600 (MDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvf1wnwtl.fsf@assigned-by-dhcp.cox.net>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7681>

Ok, the following is what I came up with based on your response.  This
is .git/hooks/update.  It mostly works in my situation.  See below for
my discussion on what didn't work.

#!/bin/sh

export PATH=/usr/local/bin:/usr/bin:/bin

# cd to the root of the project directory (assume one dir up from GIT_DIR)
cd $GIT_DIR/..
unset GIT_DIR

if expr "$2" : '0*$' >/dev/null; then
    git-read-tree --reset $3 &&
        git-checkout-cache -q -f -u -a
else
    git-read-tree -m -u $2 $3
fi

exit 0

# --- snip ---

The thing that this doesn't do is remove empty directories when the last
file is deleted.  I once expressed the opinion in a previous thread that
directories should be added and removed explicitly in git.  (Thus
allowing an empty directory to be added).  If this were to happen then
this case would get handled correctly.  However, if git stays with the
status quo then I think that git-read-tree -u should be changed to
remove the empty directory.  This would make it consistent.

What do you think?  Ideas?

Carl

On Tue, Aug 23, 2005 at 02:54:30PM -0700, Junio C Hamano wrote:
> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> >> > If you don't use -f, git-checkout-script removes deleted files. Using -f
> >> > tells it to ignore the old index, which means that it can't tell the
> >> > difference between removed files and files that weren't tracked at all.
> 
> Yes and no.  "git checkout" assumes that the index file and the
> working tree somewhat resembles what is in .git/HEAD commit.
> Since push operation updates .git/HEAD commit without touching
> the index file, that assumption does not hold.
> 
> The update hook gets old commit name and new commit name, so you
> should be able to do (untested):
> 
>     git-read-tree -m -u $old_commit $new_commit
> 
> there, of course after making sure that you had old_commit (the
> first time push happens to a new ref you would not have that one).
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
