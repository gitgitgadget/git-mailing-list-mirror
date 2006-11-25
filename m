X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Teach git-branch howto rename a branch
Date: Fri, 24 Nov 2006 21:40:30 -0800
Message-ID: <7v1wns6q41.fsf@assigned-by-dhcp.cox.net>
References: <1164409429445-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 05:40:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <1164409429445-git-send-email-hjemli@gmail.com> (Lars Hjemli's
	message of "Sat, 25 Nov 2006 00:03:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32254>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnqHN-0007nX-St for gcvg-git@gmane.org; Sat, 25 Nov
 2006 06:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757830AbWKYFkd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 00:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757832AbWKYFkd
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 00:40:33 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:11655 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1757830AbWKYFkc
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 00:40:32 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061125054031.UMUT296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Sat, 25
 Nov 2006 00:40:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qtgf1V00E1kojtg0000000; Sat, 25 Nov 2006
 00:40:39 -0500
To: Lars Hjemli <hjemli@gmail.com>
Sender: git-owner@vger.kernel.org

Lars Hjemli <hjemli@gmail.com> writes:

> +static void delete_branch(const char *branch, int force, struct commit *head_rev)
>  {
>...
> +}

Refactoring the single ref deletion into this function feels
sane.  I think you do not need a separate force parameter to
this function anymore; if the caller wants to force the deletion
it can send in a NULL for head_rev to signal that there is no
need for the "subset" check.

> +static void delete_branches(int argc, const char **argv, int force)
> +{
> +	struct commit *head_rev;
> +	int i;
> +	
> +	head_rev = lookup_commit_reference(head_sha1);
> +	if (!head_rev)
> +		die("Couldn't look up commit object for current HEAD.");
> +	for (i = 0; i < argc; i++) 
> +		delete_branch(argv[i], force, head_rev);
>  }

I do not think this die() is a good idea.  I think it is
reasonable to allow the following sequence:

	$ mkdir newdir && cd newdir
	$ git init-db
        $ git fetch $other_repo refs/heads/master:refs/heads/othre
        $ git branch -D othre ;# oops, typo
        $ git fetch $other_repo refs/heads/master:refs/heads/other

When forcing a deletion, we do not care about ancestry relation
between the HEAD and the branch being deleted, so we should not
even bother checking if HEAD is already valid.  The original
code before your patch shares the same problem.

> -static void create_branch(const char *name, const char *start,
> +static char *create_branch(const char *name, const char *start,
>  			  int force, int reflog)

This makes the returned names leak but probably we do not care
about it too much.  However, the only caller that cares about
the new refname is rename_branch, and we are talking only about
branches, so I think handcrafting the refname just like you
handcraft the refname for oldname in rename_branch() would be
a better solution without introducing new leaks.

> +static void rename_branch(const char *newname, const char *oldname, int force, int reflog)
> +{
> +	char ref[PATH_MAX];
> +
> +	snprintf(ref, sizeof ref, "refs/heads/%s", oldname);
> +	if (check_ref_format(ref))
> +		die("'%s' is not a valid branch name.", oldname);
> +
> +	newname = create_branch(newname, oldname, force, reflog);

This does not feel right.  The 'start' parameter to
create_branch is arbitrary SHA-1 expression so it can take
'master', 'heads/master' and 'refs/heads/master' to mean the
same thing, as long as they are unambiguous, but here you would
want to accept only 'master' because the paramter is supposed to
be the name of the branch you are renaming.  create_branch()
does not want to do that check for its start parameter, so you
should do the checking yourself here, and check_ref_format() is
not good enough for that.  Probably calling resolve_ref() on ref
(= "refs/heads/oldname") for reading (because you also want to
make sure oldname talks about an existing branch) is needed.

> +	if (!strcmp(oldname, head)) {
> +		create_symref("HEAD", newname);
> +		head = newname + 11;
> +	}
> +	delete_branch(oldname, force, NULL);
>  }

What is the right thing that should happen when newname talks
about an existing branch (I am not asking "what does your code
do?")?

Without -f, it should barf.  With -f, we would want the rename
to happen.  In the latter case, I think it should work the same
way as deleting it and creating it anew, and that would make
sure that reflog for the old one will be lost and a new log is
started afresh; otherwise, the log would say old history for
that branch and it won't be a "rename" anymore.

Also what happens when oldname is "frotz" and newname is
"frotz/nitfol"?  You would need to read the value of "frotz",
make sure you can delete it (perhaps the usual fast-forward
check as needed), and delete it to make room and then create
"frotz/nitfol".  I suspect your patch does not handle that
case.

