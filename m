From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] Documentation/git-filter-branch.txt: Fix description of --commit-filter
Date: Sat, 31 May 2008 16:50:00 -0700
Message-ID: <CEA5A26A-9109-4D22-9D3F-8FFF8305DBEE@sb.org>
References: <1212183820-40712-1-git-send-email-kevin@sb.org> <7vlk1rh0av.fsf@gitster.siamese.dyndns.org> <98EEBDF4-9964-4CA6-ABBD-DB72C4F6CAD3@sb.org> <7v63svgy0q.fsf@gitster.siamese.dyndns.org> <AF9CB160-FFC9-4372-BE86-5FAC6B59A050@sb.org> <7v1w3jgs51.fsf@gitster.siamese.dyndns.org> <7vskvydrys.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 01:50:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2aqe-0008Rt-RW
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 01:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618AbYEaXuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 19:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753722AbYEaXuE
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 19:50:04 -0400
Received: from mailbigip.dreamhost.com ([208.97.132.5]:51518 "EHLO
	randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751593AbYEaXuC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 May 2008 19:50:02 -0400
Received: from [192.168.1.112] (c-76-103-51-229.hsd1.ca.comcast.net [76.103.51.229])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id 5CF30EEFB1;
	Sat, 31 May 2008 16:50:01 -0700 (PDT)
In-Reply-To: <7vskvydrys.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83417>

On May 31, 2008, at 3:33 PM, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Kevin Ballard <kevin@sb.org> writes:
>>
>>> You're still talking about the parent-filter here. I think you're
>>> quite confused.
>>
>> Blush.  I should go to bed.
>
> Now after following the codepath, your original
>
>    diff --git a/Documentation/git-filter-branch.txt b/Documentation/ 
> git-filter-branch.txt
>    index 506c37a..541bf23 100644
>    --- a/Documentation/git-filter-branch.txt
>    +++ b/Documentation/git-filter-branch.txt
>    @@ -113,8 +113,8 @@ OPTIONS
>            stdin.  The commit id is expected on stdout.
>     +
>     As a special extension, the commit filter may emit multiple
>    -commit ids; in that case, ancestors of the original commit will
>    -have all of them as parents.
>    +commit ids; in that case, the rewritten children of the original  
> commit will
>    +have all of them as parents. You probably don't want to do this.
>     +
>     You can use the 'map' convenience function in this filter, and  
> other
>     convenience functions, too.  For example, calling 'skip_commit  
> "$@"'
>
> does make sense to me.  Except for "You probably don't want to do  
> this."
> part.  It is just "the utility of this feature is unknown to us" ;-)
>
> I dug the code with "git blame" and the basic logic has been the same
> since its introduction to git with 6f6826c (Add git-filter-branch,
> 2007-06-03).  The commit-filter itself appeared first in Cogito as  
> d690516
> (cg-admin-rewritehist --commit-filter for omitting commits,  
> 2006-03-26),
> and the commit log message claims that it was primarily meant to  
> _omit_
> unwanted commits from the history, but at the same time it  
> advertises the
> multiple commits case as a "feature" without telling why somebody  
> wants to
> do so.
>
> Except for this gem, which may have been lost in our copy:
>
>    # ... Note that this handles merges properly! In case Darl
>    # committed a merge between P1 and P2, it will be propagated  
> properly
>    # and all children of the merge will become merge commits with  
> P1,P2
>    # as their parents instead of the merge commit.
>
> IOW, to rewrite this history:
>
>        ---A---C---D---E
>              /
>             B
>
> to pretend C never happened, you would give A' and B' back when you
> rewrite C, to end up with this history:
>
>        ---A'--D'--E'
>              /
>             B'
>
> I'd agree with "You probably don't want to do this", but perhaps it  
> needs
> a bit of clarification as to _why_ you would not:
>
> - If the history is being rewritten for the whole tree, this will
>   make D' an evil merge that contains difference between C to D.
>
> - If the filtering of the history is done to ignore parts of the tree
>   that is touched between C and D (iow, history simplification would
>   leave trees C and D the same), you would want to simplify away D'  
> not
>   C'.  IOW, you would want the resulting history to look like:
>
>        ---A'--C'--E'
>              /
>             B'
>
>   and for that you do not need to use this "feature".

Yeah, this utility of omitting commits occurred to me last night after  
I went to bed. It does seem pretty limited in use, but I guess someone  
might want to do it. For example, if C resolved merge conflicts  
incorrectly and D fixed it, and then later somebody said "why do I  
have two commits when I should just have one?" and wanted to omit C  
and leave D behind as the merge.

I'll submit a new patch later that has better wording and perhaps a  
diagram or two.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
