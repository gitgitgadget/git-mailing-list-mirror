From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: How to handle merge-recursive corner cases?
Date: Wed, 29 Sep 2010 14:51:26 -0500
Message-ID: <20100929195125.GA28181@capella.cs.uchicago.edu>
References: <AANLkTimwUQafGDrjxWrfU9uY1uKoFLJhxYs=vssOPqdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 21:51:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P12gg-0006M9-Od
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 21:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037Ab0I2Tv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 15:51:28 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:47479 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422Ab0I2Tv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 15:51:27 -0400
Received: from capella.cs.uchicago.edu (capella.cs.uchicago.edu [128.135.24.228])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id C6F04B9AC;
	Wed, 29 Sep 2010 14:51:26 -0500 (CDT)
Received: by capella.cs.uchicago.edu (Postfix, from userid 10442)
	id 99B02DFB5C; Wed, 29 Sep 2010 14:51:26 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimwUQafGDrjxWrfU9uY1uKoFLJhxYs=vssOPqdf@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157595>

Hi Elijah,

Elijah Newren wrote:

> #      B   D
> #      o---o
> #     / \ / \
> #  A o   X   ? F
> #     \ / \ /
> #      o---o
> #      C   E
> In other words, there
> 
> Let's start with a simple though very contrived case that will
> illustrate issues later, namely a repository with exactly one file
> named 'file', with the following contents at different points in
> history:
> 
> Commit A: file has contents 'A\n'
> Commit B: file has contents 'B\n'
> Commit C: file has contents 'C\n'
> Commit D: file has contents 'D\n'
> Commit E: file has the following 5 lines in it:
> <<<<<<< Temporary merge branch 1
> C
> =======
> B
> >>>>>>> Temporary merge branch 2
> 
> Now, if we try to merge D & E, clearly there should be a conflict.
> But git merges cleanly, giving file the contents 'D\n'.

Funny.  A different problem is that with a less unusual history (i.e.
no conflict hunks committed) with "[merge] conflictstyle=diff3", if
there are conflicts in an early stage of recursive merge, we get
nested conflict hunks, leaving rerere and humans confused.

I have wondered: why doesn't merge-recursive implicitly use the union
merge driver for its in-core merge of ancestors?  The resulting
diff3-style conflict hunks from the final 3-way merge would be more
readable, but now you've provided an answer: coincidences of matching
content like you describe would become more likely.

[...]
> It's wrong, but the only way to fix it is to somehow have an entry in
> the virtual ancestor tree where the conflict region(s) of file are
> guaranteed to not match the corresponding content locations of file
> for either D or E.  (Perhaps by adding random content on the line
> after the ='s?)

Random content does not provides a guarantee.

Maybe merge_recursive()/merge_trees() could steal a flag bit from
struct object for "conflicted"?  No, that would give only one bit
for the entire tree, and we need one bit per path.

How about using index entries for this?

>From the signature of git_merge_trees(1, ...) it is not obvious
to me where it reports conflicts.  From the start to
write_tree_from_memory() I would guess it does not at all.

[...]
> Possibility 1: Virtual ancestor somehow contains both 'a' and 'a/file'
> (currently impossible in git, since this virtual ancestor is written
> as a tree
[...]
> The only way out of this that I see (and I'm hoping I'm just missing
> something), is a modification of possibility 1: make the virtual
> ancestor contain both 'a' and 'a/file'

Hmm, D/F is a little harder than the content conflict case, I guess.
;-)  But I think in general, the thing to do is to keep something
other than a tree.

Thanks for the food for thought.
Jonathan
