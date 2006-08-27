From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 19/19] gitweb: Remove creating directory for temporary files
Date: Sat, 26 Aug 2006 19:51:34 -0700
Message-ID: <7v3bbizya1.fsf@assigned-by-dhcp.cox.net>
References: <200608240015.15071.jnareb@gmail.com>
	<200608252135.27894.jnareb@gmail.com>
	<7vpsen1eq3.fsf@assigned-by-dhcp.cox.net> <ecqaa3$j0u$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 04:51:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHAjz-0006w7-PJ
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 04:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWH0CvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 22:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWH0CvN
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 22:51:13 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:64140 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751143AbWH0CvM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 22:51:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060827025112.YSYT12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Sat, 26 Aug 2006 22:51:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id Eqr81V00H4Noztg0000000
	Sat, 26 Aug 2006 22:51:10 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ecqaa3$j0u$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	26 Aug 2006 22:18:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26081>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>>  * 13/19 gitweb: Add invisible hyperlink to from-file/to-file diff header
>> 
>>    You seem to have forgotten esc_html() on the patch-line
>>    before sending it to the browser.  Careful.
>
> Cannot esc_html() line with HTML code, namely the hyperlink.

OK,  I did not notice the lines are already HTMLified with links
at that point.

>>  * 14/19 gitweb: Always display link to blobdiff_plain in git_blobdiff
>> 
>>    Need justification why this change is needed (or why previous
>>    logic to avoid showing it in certain cases is wrong).
>
> Why we didn't display it before? I though it was a bug (oversimplification
> in case we don't have $hash_base or it is not a commit). If we can display
> "blob" view, we can display "blob_plain" view...

I take it that you mean that it avoids the case without
$hash_base even though it can do all the necessary computation
without it.  If so please say that in the commit log message.

>>    You seem to spell out '-M', '-C' everywhere.  I suspect
>>    fixing them all to just '-C' (or perhaps '-B', '-C') would be
>>    tedious but probably is a good idea.
>
> Does '-C' imply '-M'?

They are, in this order "-M" < "-C" < "--find-copies-harder -C",
strict superset/subset of each other.

Having said that, I think just -M (or perhaps -B -M) might be a
better default (or "only choice" if the UI does not give a
choice), for a few reasons:

 * -C tends to be far more expensive than -M.  The cost of -M is
    proportional to (number of removed files) * (number of new
    files).  The cost of -C is proportional to (number of
    changed files + number of removed files) * (number of new
    files).  For -C with --find-copies-harder, the cost is still
    more expensive: (number of files in the original tree) *
    (number of new files).

 * -C does not detect all copies.  It considers only the
    pre-image of files changed in the same commit as candidates
    of copy source.  To make it consider _any_ file that was in
    the original tree, you would need to give --find-copies-harder
    as well.  In a way, -C is a cheaper (but still more
    expensive) compromise, middle ground between -M and -C
    --find-copies-harder.

>>  * 17/19 gitweb: git_blobdiff_plain is git_blobdiff('plain')
>> 
>>    Needs justification why commitdiff and blobdiff plain needs
>>    to behave differently.
>
> First, if we have blobdiff generated with renames/copying detection (and
> "commit" view uses it, and provides link to blobdiffs using it), there not
> always is single diff (blobdiff) without renames/copying detection. So to
> have blobdiff and blobdiff_plain equivalent, and blobdiff_plain without
> renames detection, then blobdiff_plain view would have sometimes _two_
> patches.

Sorry, does not parse, but two paragraphs below I think you made
it clear why.

> The idea behind changing comittdiff (HTML version) to including rename
> detection was that it gives shorter and better to understand patches. The
> idea (perhaps wrong) behind leaving comitdiff_plain output without renames
> detection was that this output can be applied directly by non-git-aware
> tools. It can be easily changed to include renames/copying detection (put
> '-C' in one place).
>
> The idea behind having both blobdiff and blobdiff_plain have renames
> detection was that commit view used rename detection, the two views should
> be equivalent and one exist always for the other, and that it was easier on
> implementation ;-)

I am not sure about this.  People, especially the ones who do
_not_ use git and are interested in one single fix, are the ones
you are trying to help, because they can just be told about the
change (e.g. "'Fix bar blah' patch in Linus tree last week might
fix your problems"), go to gitweb and use it.  But:

 (0) If rename/copy is not involved there is no difference so I
     will not discuss that case further;

 (1) If rename/copy is involved, as you say, the patch is far
     easier to understand in git form; the person who downloaded
     the patch would have a hard time understanding it before
     applying the patch if you do not do -M/-C.

 (2) The post-image file would not exist in the tree the person
     who downloaded the patch has for renamed/copied paths, so
     failure from "patch -p1" is immediately noticeable.  The
     metainformation says what was renamed/copied where, and I
     do not think it is too much to expect for them to first
     rename/copy by hand then re-run "patch -p1".

 (3) If we do not do -M, in situations where the patch has fuzz
     or conflict when applied to the tree the person who
     downloaded has, the post-image patch will be applied
     cleanly and the removal patch will have conflict or fuzz.
     The local change can easily be lost that way.

> P.S. I have most problems with having legacy blobdiff URL (without 'hpb' 
> i.e. hash_parent_base parameter) working correctly without making use of
> external diff.

Are people bookmarking such URLs?  How important is the legacy
compatibility?
