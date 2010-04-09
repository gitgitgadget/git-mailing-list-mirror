From: Eric Raymond <esr@thyrsus.com>
Subject: Re: Status of all files (was: Re: How can I tell if a file is
 ignored by git?
Date: Fri, 9 Apr 2010 09:20:37 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100409132037.GA27899@thyrsus.com>
References: <20100409040434.8602620CBBC@snark.thyrsus.com>
 <j2z8c9a061004082110se894f925i80c1389cd4e247f@mail.gmail.com>
 <20100409113248.GB27353@thyrsus.com>
 <864ojkx1un.fsf@red.stonehenge.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Helwig <jacob.helwig@gmail.com>,
	Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 15:20:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0E8a-00038d-3F
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 15:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab0DINUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 09:20:39 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:52162
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab0DINUi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 09:20:38 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 5EF44475FEF; Fri,  9 Apr 2010 09:20:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <864ojkx1un.fsf@red.stonehenge.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144432>

Randal L. Schwartz <merlyn@stonehenge.com>:
> A lot of these don't make sense for git and other DVCS.  How have
> hg and bzr interpreted these "canonical" states?

That asks the question the wrong way around.  These state codes
are used to change how VC *itself* performs when you fire various
commands; the VCSes called by the VC back ends never have to
'interpret' them.

It is not expected that every VCS will report all of them; in
particular, as you say, some only make sense in locking systems.  
When VC knows it's dealing with a merging system, it will never go
down a logic path where a locking-related state is checked for.

I deleted two of the locking-system-only states from what you saw, but
may have missed others; I don't completely understand all the states,
because at least eleven other people hacked on VC during the 15 years
I was doing other things and added several that were not in my
original design.

(There is some excuse for this. Emacs VC is probably unique in that
its ontology has to be rich enough to accomodate *every VCS there
is*. Nothing else even attempts that, AFAIK.)

But to answer your question at least in part, here is a piece of code
mapping status codes from Mercurial's hg status -A command to Emacs
state codes.

    (when (eq 0 status)
        (when (null (string-match ".*: No such file or directory$" out))
          (let ((state (aref out 0)))
            (cond
             ((eq state ?=) 'up-to-date)
             ((eq state ?A) 'added)
             ((eq state ?M) 'edited)
             ((eq state ?I) 'ignored)
             ((eq state ?R) 'removed)
             ((eq state ?!) 'missing)
             ((eq state ??) 'unregistered)
             ((eq state ?C) 'up-to-date) ;; Older mercurials use this
             (t 'up-to-date)))))))

This is failing to report at least one interesting state, 
which is 'conflict.  But otherwise it looks pretty complete.

What I'm really looking for is a git functional equivalent of hg status -A.
The git backend presently uses diff-index and interprets the output in
a way that I fear is rather brittle.

I'm inclined to think you are right that 'need-update and 'need-merge
don't make any sense in a tree-oriented VCS.  On the other hand, SVN 
and Monotone both report them.  On the gripping hand, I'm not certain these
qualify as "tree-oriented" in quite as strong a sense as hg and git do.
I need to understand this better.

If nothing else, perhaps this discussion will lead to me being able to
document Emacs statuses more completely.  There is a fair amount of
murk around them now, because the mode did a lot of growing by
accretion that I have not completely cleaned up yet.

> Eric>   'removed         Scheduled to be deleted from the repository
> Eric>                    on next commit.
> 
> Not useful in git.

I disagree.  At least, git status reports "removed" files before a commit.
This seems like the logical state for a file after it has been subjected 
to "git rm' but before commit.
 
> Eric>   'missing      The file is not present in the file system, but the VC
> Eric>                 system still tracks it.
> 
> Not available in git.  (If it's not a real file, it can't be tracked. :)

What about a file that has been deleted from the working copy with ordinary
rm (as opposed to git rm) so it's still in the index?  Wouldn't that qualify?

> Eric>   'ignored      The file showed up in a dir-status listing with a flag
> Eric>                 indicating the version-control system is ignoring it,
> 
> Eric>   'unregistered The file is not under version control.
> 
> These two would be identical in git.

Certainly not.  If I have "*.o" in my .gitignore, and two untracked files
foo.c and foo.o in my directory, both are unregistered, but only
foo.o is ignored.  Emacs wants to see foo.c -> 'unregistered but 
foo.o -> 'ignored.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
