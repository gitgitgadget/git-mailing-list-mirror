From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: Subprojects
Date: Sat, 14 Jan 2006 12:16:26 -0800
Message-ID: <7vek3ah8f9.fsf@assigned-by-dhcp.cox.net>
References: <43C52B1F.8020706@hogyros.de>
	<Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de>
	<43C537C9.4090206@hogyros.de>
	<Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>
	<7vacdzkww3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 14 21:16:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExrpK-0001yq-Qd
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 21:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWANUQa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 15:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWANUQa
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 15:16:30 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:30100 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751057AbWANUQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2006 15:16:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060114201536.TYDI3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 Jan 2006 15:15:36 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 14 Jan 2006 11:16:34 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14677>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 14 Jan 2006, Junio C Hamano wrote:
>
> The thing is, if you do the contained projects as "union projects" as you 
> suggest, I will bet that it will really really suck, because it ends up 
> losing the two positives above.

After a good night's sleep, I agree.  I have not thought things
through and still have a feeling that (feasibilities aside) it
would be interesting if we can do a "union projects" a la "union
mounts" (or translucent filesystem).  But that "interesting"
thing would probably not be very useful in practice.

> would actually act like they now act for directories that they don't 
> recurse into, ie you'd see something like
>
> 	:160000 160000 5eb57670... 3f1a42aa... M	sub-project
>
> and it would be up to higher-level porcelain to recurse.

This I agree with.

> The other reason? A lot of the git infrastructure really does only work on 
> the "one project" level. The programs work with _one_ index, not two. 
> Reading two trees is perfectly possible, but unless you keep them in 
> separate stages, you can't separate them afterwards. IOW, trying to be 
> recursive really does end up being a big change, for very little gain (and 
> for a lot of potential bugs and instability).

Yup.  BTW, I think with a couple of minor tweaking and giving it
the same restriction ("two pluses and one negative") as the
gitlink proposal, the "union" approach would work equally well,
perhaps with a simpler implementation. I'll think aloud about
this at the end.

>> Fetching/cloning at the core level is easy.  "git-fetch-pack"
>> would just need to do one level, but Porcelains need to address
>> how to actually arrange the subprojects cloning to happen, which
>> is harder.
>...
> So only if you actually check it out (which is often in practice the 
> second stage of the cloning, of course) do you want to fetch the 
> subproject too.

We are in complete agreement here.

> I think this one has serious disadvantages:
>
>  - it's much less obvious when there are common names and especially 
>    common subdirectories.
>  - in _practice_, almost all sub-projects are kept in sub-directories. Are 
>    you doing to change the sub-project git tree? How are you going to 
>    merge back to the original sub-project?
>  - iow, I think this only works for sub-projects that are totally 
>    controlled by the top-level project - in which case they might as well 
>    just be totally merged into the top level (the way we did with the 
>    "tools" project, and largely with "gitk").

Yes, I agree to the above 100%; the serious disadvantages come
from the fact that we do not have clear separation between
subprojects -- which new files belong to what subproject.  I
think re-rooting read-tree and write-tree would help solving
that.  After I wrote the message you are replying to, I came up
with a couple of tweaks.

 - Do the octopus-like thing, but always give subprojects a
   separate directories to work in.

 - Extend "commit" objects for the toplevel project to record
   what subprojects with what head commits are contained at
   which subdirectory.  I wrote in the previous message to make
   subprojects heads parents of aggregate commits, but I think
   that one without "where to" information has a serious
   disadvantage when computing a merge.

In the "embedded linux" example that has "linux-2.6" and
"gcc-4.0" projects as an externally controlled subprojects, and
has all the rest (including the toplevel Makefile) in "master"
branch:

     $ tar xf embed.tar embed && cd embed && git init-db
     $ git add . ;# toplevel Makefile and stuff
     $ git commit -a -m 'embedded repo - initial'

After doing "git-fetch-pack -k git://.../linux-2.6.git/ master"
and "echo $H >.git/refs/heads/kernel" (similar for gcc-4.0) to
set up the branch heads (but we do not have any working tree
files for these subprojects yet):

	$ git bind -m 'Bind kernel and gcc into us' \
        	kernel=linux-2.6 gcc=gcc-4.0

would prepare the subprojects binding (I am just looking for a
better word --- I called it "setup-overlay" in the previous
message).  This would:

 - append the tree object in "kernel" commit object to the
   current index, rerooted at linux-2.6/; similar for "gcc" at
   gcc-4.0/. We may need a new mode and option for read-tree for
   this, or we may not.  Internally this step would be scripted
   in "git bind" wrapper like this:

	git read-tree --bind --prefix=linux-2.6 kernel
	git read-tree --bind --prefix=gcc-4.0 gcc

   and would result in an index file that has these trees
   "mounted" at specified places.  If you look at only the index
   file, you cannot tell this is an overlay, unlike gitlink
   scheme.

 - make a commit that records the tree object (the whole thing
   including the subproject trees), with the initial commit we
   made earlier as the sole parent commit, and additionally
   records the two subproject heads with bind points.  This
   happens in the same "git bind" wrapper, and produces
   something like:

	$ git cat-file commit HEAD
        tree e9de76f2e141824439caa00a65e3b91d05d125c9
        parent bfca932434cc65e7aa90794e7c4d66f75d00b16a
        bind a8fe7257b8427d31cfcca0aa336335bb43689fc9 linux-2.6
        bind b3b2df23226634f42c9646bd7961fbea8b00f914 gcc-4.0
        author Junio C Hamano <junkio@cox.net> 1137205528 -0800
        committer Junio C Hamano <junkio@cox.net> 1137205528 -0800

	Bind kernel and gcc into us.

   "bind" line needs to be taught to fsck-objects.  The format
   is the object name of the commit followed by (c-style quoted)
   subdirectory name.

 - record the branch name vs subproject directory binding in
   $GIT_DIR/ somewhere, say $GIT_DIR/mtab ;-).

	$ cat .git/mtab
	kernel	linux-2.6
        gcc	gcc-4.0

After this, "git checkout-index -f -q -u -a" would populate the
whole thing.  Instead of linux-2.6/.git/HEAD as in gitlink
example, I am using .git/refs/heads/kernel; this would not make
a semantic difference.  One big difference however is I have
only one index file that controls the whole tree, without using
a separate linux-2.6/.git/index.

After mucking with a file in linux-2.6/ subdirectory and nowhere
else, committing the result from the whole tree would work like
this:

 - Look at the current commit and notice the bind for two
   subdirectories; then look them up in $GIT_DIR/mtab to see
   which branches keep track of them.

 - Notice that there are modified paths in the index vs tree
   from the last commit under linux-2.6/ directory.

 - Write out only that part, re-rooted, into a tree.

	git write-tree --prefix=linux-2.6

 - Make a commit to record that tree, with a parent set to the
   "kernel" branch head; update the "kernel" branch head at that
   commit.

 - Make another commit to record the tree made from the whole
   index (obviously linux-2.6 subdirectory would result in the
   same tree object we just committed in the subproject) with
   parent set to .git/HEAD and bind adjusted accordingly; update
   the "HEAD".

Now I have to think about clones and merges but this is getting
too long so I'll leave it to a separate message.
