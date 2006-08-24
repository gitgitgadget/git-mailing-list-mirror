From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 1/x] gitweb: Use git-diff-tree patch output for commitdiff
Date: Thu, 24 Aug 2006 13:10:13 +0200
Organization: At home
Message-ID: <eck1em$p8b$1@sea.gmane.org>
References: <200608240015.15071.jnareb@gmail.com> <7v3bbmhoa2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 24 13:12:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGD7n-00081r-ER
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 13:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWHXLLs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 07:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWHXLLs
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 07:11:48 -0400
Received: from main.gmane.org ([80.91.229.2]:54686 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751113AbWHXLLr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 07:11:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GGD7H-0007w8-MI
	for git@vger.kernel.org; Thu, 24 Aug 2006 13:11:20 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 13:11:19 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 13:11:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25954>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Converting "blobdiff" and "blobdiff_plain" format would be much easier
>> if git-diff-tree and friends had -L <label>/--label=<label> option,
>> like GNU diff has.
> 
> I am not sure how that would be useful, given that you would
> disect the header line-by-line to colorize anyway.

gitweb could output patch directly (slurp-print) in blobdiff_plain,
if there were -L <label>/--label=<label> option to git-diff. As it is now
git_blobdiff_plain (or git_blobdiff('plain')) would have to process diff
header, replacing hashes by file names.

Anyway to get full information you need commits to diff, not only blobs to
diff, otherwise the mode change information is lost, I think. And then we
would be able to reus git_patchset_body for git_blobdiff...

>> Current patch preserves much of current output; the question is if for
>> example generate if 'plain' format should generate patch which could
>> be appplied by ordinary patch which do not understand git diff
>> extensions (including renaming and copying), as it is done in current
>> version, and if 'html' version should detect renames and copying.
> 
> I would say html is definitely for human consumption; does
> anybody cut&paste html patch and expect to apply that?  Plain
> format I am easy but probably enabling rename is fine.  You can
> edit the header or tell patch to apply to which file anyway, and
> I think the value of being able to view the real changes outweigh
> that inconvenience.

Or I we can add another format/option, 'broken' to git_commitdiff
and friends.

>>  * "commitdiff" now products patches with renaming and copying
>>    detection (git-diff-tree is invoked with -M and -C options).
> 
> You do not have to give -M and -C; a single -C is enough.
> I wonder if -B is also useful as a default (i.e. -B -C).

So -C implies -M?

> For a merge, I often would want to see --cc just like gitk does,
> but it is probably just me.

Planned. The problem is that raw format for --cc differs, and parser
has to be improved (and similarity is lost)

> I do not know we would want to slurp the entier diff in an
> array before processing.  Is this easy to streamify by passing
> an pipe fd to the formatting sub?

That was one question I meant to ask: slurp entire diff (process
then output rule) or streamify (streamify larger output for faster 
result)?  Will do (quite easy).

>>    Empty patches (mode changes and pure renames and copying)
>>    are not written currently.
> 
> That's quite bad.

This can be easily changed. Question: what format? Current "gitweb diff
header" (<filetype>:<sha1 link> -> <filetype>:<sha1 link>) has no place for
that. Can be easily changed.

Another question: do output difftree in commitdiff, like in commit view?
Do write out extended header, perhaps except index line (repeats information
in "gitweb diff header")?


>>  * "commitdiff_plain" now only generates X-Git-Tag: line only if there
>>    is tag pointing to the current commit.
> 
> Hmph...
> 
>>    ...; besides we are
>>    interested rather in tags _preceding_ the commit, and _heads_
>>    following the commit.
> 
> Interesting observation.  When somebody says "feature X was
> introduced in such and such commit", people would want to know (1) the
> point release they are using has the feature -- which means you
> would want to know the earliest tag that comes after the commit,
> or (2) if the branch they are working on already has that
> feature -- which again means if the head follows the commit.  So
> I am not sure when preceding tag is interesting...

Qgit and gitk both show "Follows:" listing followed = preceding tag(s).
This answers question if given commit has given feature.

I have planned separating generation of first/all preceding/following
tags/heads (from git_get_references) into subroutines anyway.

I will add 'X-Git-Tag-After:' then.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
