From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 05:52:17 +0200
Organization: At home
Message-ID: <e05354$cc9$1@sea.gmane.org>
References: <20060326014946.GB18185@pasky.or.cz> <7virq1sywj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Mar 26 06:10:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNMaU-0003Ae-HW
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 06:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWCZEKn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 23:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWCZEKn
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 23:10:43 -0500
Received: from main.gmane.org ([80.91.229.2]:50111 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751572AbWCZEKm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 23:10:42 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FNMaP-00039l-Ex
	for git@vger.kernel.org; Sun, 26 Mar 2006 06:10:41 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Mar 2006 06:10:41 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Mar 2006 06:10:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18025>

Junio C Hamano wrote:

> Petr Baudis <pasky@ucw.cz> writes:
> 
>>   An obvious solution would be to have git-diff-tree --follow which
>> updates its interesting path set based on seen renames, and now that
>> I've written about non-linear history, it's obvious that it's incorrect.
>> The other obvious way to go is then to add rename detection support to
>> git-rev-list, and it's less obvious that this is a dead end too - I
>> didn't inspect the code myself yet, but for now I trust Linus in [2]
>> (I didn't quite understand the argument, I guess I need to sleep on it).
> 
> I'd have to sleep on how the core side can help Porcelains, but
> I think it is a good thing that you, one of the most vocal
> advocate on the list for doing rename recording, are thinking
> about this issue and probably would look into rev-list.c soon.
> 
> Looking at the evolution of rev-list.c file itself was a good
> exercise to realize that rename tracking (more specifically,
> having whatchanged to follow renames) is not such a useful
> thing (at least for me).
[...]
> What this suggests is that switching the set of paths to follow
> while traversing ancestry chain needs to depend on which part of
> the original file you are interested in.  Marking "this commit
> renames (or copies) file A to file B" is not that useful -- for
> that matter, detecting at runtime like we currently do is not
> better either.  If a file A and file B were cleaned up and
> merged into a single file C, which is in the tip of the tree,
> which one you would want whatchanged to switch following depends
> on which part of the C you were interested in.
> 
> Unless you are interested in the _entire_ contents of the file,
> that is.  Then tracking or even recording renames becomes
> useful, but that is a special case.
> 
> That is the reason I am not so enthused about recording renames.
> I think the time is better spent on enhancing what pickaxe tries
> to do (currently it does very little), which I hinted in a
> separate message late last night.

I think one of the better ideas/suggestions about *recording* filenames was
in the "impure renames / history tracking" thread
 http://marc.theaimsgroup.com/?l=git&m=114122175216489&w=2
 <Pine.LNX.4.64.0603011343170.13612@sheen.jakma.org>
about adding *auxiliary* (helper) information about renames in commits. I'm
not sure about recording parts of the file that were moved or copied. That
might have been left for runtime detection in the likes of pickaxe.

As it would be helper-only information it would ensure backwards
compatibility (older versions would ignore additional information) and
forward compatibility (newer version would fallback to current runtime
renames tracking/detection).

To be generic, I think that the command to record rename/copy or
copy'n'paste/cut'n'paste would take set of source files (one or more,
unless we want to have an option to mark the file as new supressing any
superficial similarities, in which case it would be zero or more), and set
of destination files (one or more, with files which were in source repeated
it was copy, not repeated if it was rename or cut'n'paste; unless we want
to record deletions also, in which case it would be zero or more files).
Such information can be I guess easily entered by user... if one remembers
to record rename/cut'n'paste/etc. that is. Perhaps if it were a way to easy
add such information later, for example confirming detected
renames/relationships during merge... It would be much more difficult for
user to enter the ranges unassisted.

What worries me is that such information, recorded in "own fields to the GIT
revision messages" (in commits) can be used only if you track the ancestry;
it doesn't help if you have only have two or more revisions and not build
relationship graph between them. But maybe I worry unnecessary...

BTW. following renames is important not only in examining file [contents]
history, in the likes of diff, whatchanged, annotate/blame, pickaxe but
also for merges.

References:
===========
* http://marc.theaimsgroup.com/?l=linux-kernel&m=111314792424707
* http://article.gmane.org/gmane.comp.version-control.git/217
* http://marc.theaimsgroup.com/?l=git&m=114123702826251
* http://marc.theaimsgroup.com/?l=git&m=114315795227271

-- 
Jakub Narebski
Warsaw, Poland
