From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] commit: make the error message on unmerged entries user-friendly.
Date: Wed, 06 Jan 2010 18:49:53 +0100
Message-ID: <vpqtyuz86ny.fsf@bauges.imag.fr>
References: <1262783414-23101-1-git-send-email-Matthieu.Moy@imag.fr>
	<7veim3yx5o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 18:52:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSa3p-0005wY-Ly
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 18:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005Ab0AFRwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 12:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755992Ab0AFRwl
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 12:52:41 -0500
Received: from imag.imag.fr ([129.88.30.1]:64198 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755430Ab0AFRwj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 12:52:39 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o06Hnrbr018726
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Jan 2010 18:49:55 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NSa13-00085X-ED; Wed, 06 Jan 2010 18:49:53 +0100
In-Reply-To: <7veim3yx5o.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 06 Jan 2010 09\:13\:07 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 06 Jan 2010 18:49:58 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136278>

Junio C Hamano <gitster@pobox.com> writes:

>> Two questions:
>>
>> * Did anyone actually use the 3 "file: unmerged (sha1)" lines?
>
> I don't think anybody does these days, and even if the question were about
> the historical practice, I doubt anybody used "git merge-file" using these
> blob object names to come up with a resolution.  Besides, if they really
> want to, they can ask "ls-files -u" for that information themselves. 

OK, that's what I thought, but 'wanted to be sure.

>I imagine you would say
> something like this?
>
>   With this patch, the error looks like this:
>
>   $ git commit
>   U foo.txt
>   fatal: Commit is not possible because you have unmerged files.
>   Please, resolve the conflicts listed above, and then mark them
>   as resolved with 'git add <filename>', or use 'git commit -a'

Yes, sorry for not making it more explicit.

> Do I like it?  Hmmm.
>
>  - "Please, ", especially with the comma, looks superfluous;

I wouldn't call it mandatory, but it doesn't harm, and

$ grep -i -n -e '"Please' *.c
builtin-commit.c:246:		    "Please, resolve the conflicts listed above, and then mark them\n"
builtin-commit.c:698:			"Please supply the message using either -m or -F option.\n");
builtin-help.c:209:			"Please consider using 'man.<tool>.cmd' instead.",
builtin-help.c:221:			"Please consider using 'man.<tool>.path' instead.",
builtin-remote.c:1124:					"Please choose one explicitly with:");
builtin-tag.c:321:			"Please supply the message using either -m or -F option.\n");
merge-recursive.c:1191:			"Please, commit your changes or stash them before you can merge.";
setup.c:241:		warning("Please upgrade Git");

>  - Some people consider "please resolve the conflicts" to mean the whole
>    process of "fix them up in the work tree, and mark them resolved in the
>    index", and others consider it to mean only the first step to "fix them
>    up in the work tree".  I happen to be in the former camp, and to me
>    ",and then mark them as..., add <filename>'," look superfluous because
>    of that.
>
>    I however think it is more helpful to new people who benefit from this
>    advice message if we spell out these two steps.

Yes. Someone having "resolved" (i.e. removed markers), and trying to
commit should get a hint on the commands he can use to achieve this
goal.

>    Unfortunately, for that purpose, the description of the latter
>    "mark them resolved in the index" step you have looks inadequate;
>    e.g. sometimes it needs to be done with "git rm <filename>".

Maybe "sometimes", but to me, that's sufficiently rare to be omited
here (I don't think I ever used 'git rm' to resolve a conflict). The
user manual says this:

,----
| Each time you resolve the conflicts in a file and update the index:
| 
| $ git add file.txt
| 
| the different stages of that file will be "collapsed", after which git
| diff will (by default) no longer show diffs for that file.
`----

and I don't think it makes sense to try to be more exhaustive here
than in the user-manual.

> The need to give this advice on how to resolve conflicts is shared among
> commands like 'git merge', 'git cherry-pick', and 'git status', to name a
> few.

Not sure 'status' needs anything more. It already says

# Unmerged paths:
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#       both modified:      foo.txt

and the big difference between 'git status' and the others is that
it's legitimate to run it while resolving conflicts, while calling
'git merge' or 'git commit' can be done only by mistake.

It's not serious to eat 3 or 4 lines of the screen to display a
message to tell the user he shouldn't have done this, but it'd be
disturbing to eat more than 1 line for a common case.

> I think we should consolidate them all.

Right, although "commit" is definitely the most important (dumb users
don't need "git merge").

>  - Decide if we go one-step (i.e. just say "resolve conflicts" and nothing
>    else) or two-step (i.e. say "Fix them up in the work tree" and "mark
>    them resolved in the index") approach; I am leaning toward the latter.

Meetoo.

>  - Decide the exact language used.  I think "Fix them up in the work tree"
>    is passably okay, but "Mark them resolved in the index" needs to be
>    made more concrete, and "git add <filename>" is not quite it, I am
>    afraid.

See above. To me, pointing to "git commit -a" and "git add" is
sufficient.

Pointing to "git commit -a" is also important to me, because Git
newbies may have been told to always use "git commit" with "-a"
(common use-case: "I have to use Git, I know SVN and I don't want to
learn anything new").

>  - Omit issuing the advisory message when advice.resolveConflict is set to
>    false.

Sensible, yes.

>  - Perhaps have a common helper function to do this from the commands that
>    need to give the advice.

Probably not, because the advice will be different:

git merge => please resolve and commit before you can merge
git commit => please resolve before you can commit
...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
