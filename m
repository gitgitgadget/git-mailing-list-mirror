From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Sun, 14 Aug 2011 11:04:40 -0500
Message-ID: <20110814160440.GK18466@elie.gateway.2wire.net>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 18:04:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsdBD-0000XT-C1
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 18:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521Ab1HNQEq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 12:04:46 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48696 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465Ab1HNQEp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2011 12:04:45 -0400
Received: by yxj19 with SMTP id 19so2812955yxj.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZQPGCJa6opP9GwAaSei0YyOKsjzW5rTKPUSwhvcSR1c=;
        b=sBqdssKm1Wtn/Xa0tjiUo+pTxhnM3HJsqZWyMZgJqlYeyQkNR439aUzWN5yZpXOf8A
         oZEOS3t5sQCJHhN1ORpVPNGrcEYENFRYWrtEUtqG887yGOSWOTJ4ZBNmvpBChOhjE8Me
         EJYIu8NuBM5XqFtG7ynvHW6BhvdxI3tYznSig=
Received: by 10.150.215.18 with SMTP id n18mr3904965ybg.424.1313337884695;
        Sun, 14 Aug 2011 09:04:44 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-108-227.dsl.chcgil.sbcglobal.net [68.255.108.227])
        by mx.google.com with ESMTPS id v17sm3137551ybj.17.2011.08.14.09.04.42
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 09:04:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313310789-10216-8-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179331>

Ramkumar Ramachandra wrote:

> Since d3f4628e (revert: Remove sequencer state when no commits are
> pending, 2011-07-06), the sequencer removes the sequencer state befor=
e
> the final commit is actually completed.  This design is inherently
> flawed, as it will not allow the user to abort the sequencer operatio=
n
> at that stage.  Instead, make 'git commit' notify the sequencer after
> every successful commit; the sequencer then removes the state if no
> more instructions are pending.

Sorry, I'm getting lost in all the words.  I suspect you are saying
=E2=80=9Cd3f4628e was trying to solve such-and-such problem, but its fi=
x was
problematic because it removes the data that a hypothetical "git
cherry-pick --abort" command would need to work.  Back out that
change and adopt the following instead.=E2=80=9D

In particular, the above does not make it clear to me:

 - as a user, what effect will I notice after this change?
 - what problem does it solve?
 - does it have any downsides?

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -26,6 +26,7 @@
>  #include "unpack-trees.h"
>  #include "quote.h"
>  #include "submodule.h"
> +#include "sequencer.h"
> =20
>  static const char * const builtin_commit_usage[] =3D {
>  	"git commit [options] [--] <filepattern>...",
> @@ -1521,6 +1522,13 @@ int cmd_commit(int argc, const char **argv, co=
nst char *prefix)
>  	unlink(git_path("MERGE_MODE"));
>  	unlink(git_path("SQUASH_MSG"));
> =20
> +	/*
> +	 * Notify the sequencer that we're committing.  The routine
> +	 * removes the sequencer state if our commit just completed
> +	 * the last instruction.
> +	 */
> +	sequencer_notify_commit();
> +
>  	if (commit_index_files())
>  		die (_("Repository has been updated, but unable to write\n"
>  		     "new_index file. Check that disk is not full or quota is\n"

The function name (..._notify_commit()) does not seem very intuitive.
Based on the name, I expect it to use the sequencer to print a message
to the user about the commit in progress.

What happens if writing to .git/index fails?  I can think of reasons
to remove the sequencer file before or afterward:

 - before, because once .git/index has been removed, the index is not
   locked any more and further commands could take place in parallel.

 - afterward, because when writing the index fails, I (the user)
   might want to react by running "git cherry-pick --abort".

The latter seems slightly more compelling to me --- after all, any
further command wanting to touch the sequencer directory is going
to check whether it exists --- but more importantly, the former
reminds me that we haven't thought carefully about what concurrent
operations using the sequencer are and aren't allowed.  Though I
doubt that it would come up much in practice. :)

> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -580,6 +580,17 @@ static void read_populate_todo(struct replay_ins=
n_list **todo_list)
>  		die(_("Unusable instruction sheet: %s"), todo_file);
>  }
> =20
> +void sequencer_notify_commit(void)
> +{
> +	struct replay_insn_list *todo_list =3D NULL;
> +
> +	if (!file_exists(git_path(SEQ_TODO_FILE)))
> +		return;
> +	read_populate_todo(&todo_list);
> +	if (!todo_list->next)
> +		remove_sequencer_state(1);
> +}

Not about this patch: I keep on forgetting what the argument to
remove_sequencer_state means.  Would it be possible to make it
a flag, which would both make the meaning more obvious and mean
it is easy to support additional flags in the future?

> --- a/t/t3032-merge-recursive-options.sh
> +++ b/t/t3032-merge-recursive-options.sh
> @@ -114,8 +114,10 @@ test_expect_success 'naive cherry-pick fails' '
>  	git read-tree --reset -u HEAD &&
>  	test_must_fail git cherry-pick --no-commit remote &&
>  	git read-tree --reset -u HEAD &&
> +	git cherry-pick --reset &&
>  	test_must_fail git cherry-pick remote &&
>  	test_must_fail git update-index --refresh &&
> +	git cherry-pick --reset &&
>  	grep "<<<<<<" text.txt
>  '

What is this about?  Maybe it would be clearer to change the "git
read-tree ..." to "git reset --hard", so the test assertion would not
rely on new cherry-pick features (and to mention the change in the
commit message!).

Doesn't this point to a risk in the patch?  Do you think there might
be scripts out there relying on being able to use "git read-tree
--reset -u HEAD" to clear away a failed cherry-pick before trying
again, and if so, can we do something about it?

> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -82,13 +82,13 @@ test_expect_success '--reset cleans up sequencer =
state' '
>  	test_path_is_missing .git/sequencer
>  '
> =20
> -test_expect_success 'cherry-pick cleans up sequencer state when one =
commit is left' '
> +test_expect_success 'final commit cleans up sequencer state' '
>  	pristine_detach initial &&
>  	test_must_fail git cherry-pick base..picked &&
> -	test_path_is_missing .git/sequencer &&
>  	echo "resolved" >foo &&
>  	git add foo &&
>  	git commit &&
> +	test_path_is_missing .git/sequencer &&
>  	{

It would also be nice to check "test_path_is_dir" before the final
commit, so people working on this code in the future know both aspects
of the patch are intentional.

Thanks, I'm glad to see this patch.
