From: Dmitry Pavlenko <dmit10@gmail.com>
Subject: git-svn commit parents detection algorithm
Date: Fri, 7 May 2010 17:35:10 +0400
Message-ID: <201005071735.10322.dmit10@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Semen Vadishev <semen.vadishev@gmail.com>,
	Marc Strapetz <marc.strapetz@syntevo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 15:40:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OANms-0001OA-E8
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 15:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160Ab0EGNkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 09:40:11 -0400
Received: from mail.intellij.net ([213.182.181.98]:45885 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab0EGNkK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 09:40:10 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 May 2010 09:40:08 EDT
Received: (qmail 4520 invoked by uid 89); 7 May 2010 13:33:27 -0000
Received: by simscan 1.1.0 ppid: 4455, pid: 4512, t: 0.0843s
         scanners: regex: 1.1.0
Received: from unknown (HELO dmit10.localnet) (172.26.240.255)
  by mail.intellij.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 7 May 2010 13:33:26 -0000
User-Agent: KMail/1.13.3 (Linux/2.6.32-3-amd64; KDE/4.4.3; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146535>

Hello.

I have several questions regarding git-svn parents detection algorithm for the 
newly created branch. It seems that I have found some bugs.

The most general question is: could you describe a parents detection algorithm 
in the git-svn?

1. When I try to fetch revision created like this:
svn cp trunk branches/branch1
svn merge http://host/path/branches/branch2 branches/branch1
svn commit

svn:mergeinfo property is set but git-svn tries to do "svn switch"'s low level 
analog if it's possible. svn:mergeinfo property is not received in this case 
(revealed by setting a breakpoint at change_dir_prop in git-svn script) though 
it's present ("svn propget" shows this property). But if "svn switch" 
operation is not available in the perl svn client library simple "svn update" 
operation is used. I didn't check but suspect that then svn:mergeinfo would be 
processed and git-svn's find_extra_svn_parents would find addidtional parents. 
But I thought that parents set shouldn't depend on the svn version (or at 
least newer versions of svn library that support "svn switch" shouldn't make 
behaviour worse).

My opinion is that svn:mergeinfo should be checked in this case and merge 
parents be detected and added to the whole parents set.

2. Is it true that "find_extra_svn_parents" requires a reference to a list of 
exactly one parent as 4th argument?

If @$parents is empty in the function "git rev-list" and "git merge-base" 
calls in it would fail because of bad syntax. If @$parents has 2 or more 
elements than merge-base call would have unpredictable behaviour.

$merge_base = command_oneline(
				"merge-base",
				@$parents, $merge_tip,
			);
			
Git merge-base command finds a merge-base between the first commit and any of 
other commits listed as arguments. So if @$parents is (a, b) "git merge-base" 
will find common ancestor between "a" and "b" or "a" and $merge_tip that is 
nonsense. 

More over if the "find_extra_svn_parents" call requires exactly one parent and 
"make_log_entry" function in git-svn is always called with one-element parents 
list then finding additional parents in "find_extra_svk_parents" method that  is 
called before "find_extra_svn_parents" would cause fail of finding extra parents 
in  "find_extra_svn_parents".

Maybe these lines should be rewritten as 

$merge_base = command_oneline(
				"merge-base",
				$merge_tip, @$parents
			);
This makes sense in the case of several parents.

3. What's the purpose of "parents_exclude" git-svn's function?

It is called on reference to already found parents list and @commits that are 
found as "merge tips" of svn:mergeinfo property. But note that svn:mergeinfo 
value lines are listed *alphabetically*. For example:
/branches/branch1:4
/branches/branch2:3-4,8
/trunk:2,7
disregarding their reverse chronological order(!). So the @commits list would 
contain hashes that corresponding to (branch1, r4), (branch2, r8), (trunk, r7) 
in this "alphabetical" order (note: alphabetical order depends on branch 
naming).

Let us consider another example: we have commits in @commits: a, b, c, d, e, 
f, g (in this order) and $@parents consists of commit "h" . And suppose for 
simplicity that no commit of a, b, c, d, e, f, g is reachable from "h" (than 
"--not h" will have no sense). Suppose the commits have the following reverse 
chronological order e, c, f, g, a, b, d.

Then do {} while () in the "parents_exclude" will have 3 iterations:

"git rev-list -1 a b c d e f g --not h" for this case will return simply the 
latest 
commit (e). Then inner cycle will set @new to the slice @new = {a, b, c, d} // 
f, g are rejected because they are after "e". We add "e" to @excluded and 
repeat

`git rev-list -1 a b c d --not h` will return c as latest from these. 
New value of @new will become {a, b} and @excluded {e, c}

`git rev-list -1 a b --not h` will return a.
@new will become empty and @excluded will contain {e, c, a}.

Personally I don't know why these commits are better than others.

Moreover the order of {e, c, a} is not used later in the 
"find_extra_svn_parents" function.

I have two ideas about parents_exclude's purpose:
1) it lists a set of all commits not reachable from parents;
2) it lists a set of all commits not reachable from parents in *chronological* 
order.

To achieve 1) the "last;" operator should be removed from "parents_exclude" 
function.
To achieve 2) the "last;" operator should be removed from "parents_exclude" 
function and the function result should be assigned to @merge_tips list in 
"find_extra_svn_parents" function (without  "map { $_ => 1 }" construction) to 
save @excluded commits reverse chronological *order*.

As for me 2) is the most reasonable because then fetched svn repository 
wouldn't depend on branching naming.

If parents in @excluded shouldn't be reachable from another parents (that is 
true) then

my @cmd = ('rev-list', "-1", @commits, "--not", @$parents);

should be replaced into

my @cmd = ('rev-list', "-1", @commits, "--not", @$parents, @excluded );

Maybe this will make useless the check done in the doulbe cycle at the end of 
"find_extra_svn_parents":

	for ( my $i = 0; $i <= $#new_parents; $i++ ) {
			for ( my $j = 0; $j <= $#new_parents; $j++ ) {

4. The "parents_exclude" function pushes "undef" value to @merge_tips (in the 
case of bad $tip_commit) list and then excludes them by "grep" and "next 
unless $merge_tip and $excluded{$merge_tip};" line. So pushing "undef" is 
useless operation, it shouldn't perplex.

5. In the function "do_fetch" the last commit (my $lc = $self->last_commit) is 
*not* put to the parents list for the "find_extra_svn_parents" function in the 
case when "copyfrom_path parent" from "find_parent_branch" is found (it is 
added later then) but is put otherwise. Is it done intentionally or by a 
mistake?

6. Could you please tell in a few word "linearize_history" function's goals? 
In all cases I tested the commits list returned by it was the same as its 
input hash list. I tried to imagine the situation when these lists differ.

Let 
commit c1 has parent c2
commit c2 has parents c3 and c4
commit c3 has parent c4
commit c4 has parent c5

In this case "linearize_history" for (c1, c2, c3, c4, c5) list would return 
(c1, c2, c3) but I can't reproduce this situation by "git" command (I will try 
using git low-level library later).
Additional question: is it true that "git svn dcommit" will loose commits c4 
and c5 in this strange case?
