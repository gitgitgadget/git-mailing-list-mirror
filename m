From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] Don't clean any untracked submodule's .git dir by
 default in git-clean
Date: Tue, 30 Jun 2009 08:40:45 +0200
Message-ID: <4A49B36D.2080103@viscovery.net>
References: <1246327845-22718-1-git-send-email-jason.k.holden@gmail.com> <1246327845-22718-2-git-send-email-jason.k.holden@gmail.com> <1246327845-22718-3-git-send-email-jason.k.holden@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jason Holden <jason.k.holden@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 08:41:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLX1c-0007Nk-0b
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 08:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbZF3Gky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 02:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752483AbZF3Gkx
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 02:40:53 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:58550 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbZF3Gkw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 02:40:52 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MLX1K-0006Vj-0c; Tue, 30 Jun 2009 08:40:50 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B2731795; Tue, 30 Jun 2009 08:40:45 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1246327845-22718-3-git-send-email-jason.k.holden@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122492>

Jason Holden schrieb:
> Git-clean is not safe when the submodules are not tracked in mainline.

Generally, I think you are addressing a real issue. On the other hand, it
also changes the behavior substantially. Nevertheless IMO it is better to
be safe than sorry, even if existing 'git clean' users may now observe
that directories are left over that previously weren't.

>  If
> we run git-clean on the mainline branch, when we have a submodule that only
> exists on a local branch, the entire .git directory of the untracked
> submodule will get deleted, possibly losing any un-pushed local changes to
> the submodule.

This is not about "mainline" and "local branch"; it is about switching
from one branch that tracks the submodule to another one that doesn't
track it.

> This change doesn't delete any untracked submodule's .git directories during
> the recursive-delete (unless forced with the -m option to git-clean), so that
> the submodule history can be restored w/ the proper git commands.
> 
> # Example illustrating problem:
> # Clone mainline project
> git clone git://github.com/thoughtbot/paperclip.git
> cd paperclip/
> 
> # Add a submodule not tracked by mainline
> git checkout -b test_submodule_clean

# Add a submodule to a different branch
# git checkout -b has-submodule

> git submodule add git://github.com/technoweenie/attachment_fu.git attachement_fu
> git commit -m "add submodule"
> 
> # Make a modification to the submodule.  Note that we haven't pushed the change
> cd attachement_fu/
> git checkout -b mod_readme_in_submodule
> vi README
> git add README
> git commit -m "Small change in submodule"
> 
> # Go back to mainline's master branch and do a clean
> cd ..
> git checkout master
> git clean -f -d
> 
> # Our change to the submodule, that was never pushed, is now gone forever
> # because all the history stored in the submodule's .git direct is deleted.
> # There is no recovering from this.
> # This breaks the "git must be safe" rule, as we've lost potentially a lot of
> # changes to any submodule projects that didn't get pushed yet. Solve
> # this issue by not deleting any .git directories we come across during a
> # git-clean, unless the "-m" option is passed to git-clean.

If you indent the example script by some spaces, you won't have to mark
the surrounding text like shell script comments (surrounding text is the
line '# Example...' and the paragraph '# Our change...'. But the
interspersed comments are very helpful.

> +-m::
> +	Clean any .git directories that may be left-over, untracked
> +	submodules.

	Remove .git directories from subdirectories (i.e.
	untracked submodules).

Please address (here and in the code later) that -m makes sense only in
combination with -d.

There is one in-tree user of git-clean (git-filter-branch). Did you check
whether it needs this new flag?

> @@ -44,6 +45,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  		OPT_BOOLEAN('f', NULL, &force, "force"),
>  		OPT_BOOLEAN('d', NULL, &remove_directories,
>  				"remove whole directories"),
> +		OPT_BOOLEAN('m', NULL, &rm_untracked_submodules,
> +				"remove untracked submodules"),
>  		OPT_BOOLEAN('x', NULL, &ignored, "remove ignored files, too"),
>  		OPT_BOOLEAN('X', NULL, &ignored_only,
>  				"remove only ignored files"),
> @@ -59,6 +62,14 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
>  			     0);
>  
> +
> +	int keep_dot_git = 0;
> +	if (rm_untracked_submodules == 0)
> +		keep_dot_git = 1;
> +	else
> +		printf("Any untracked .git directories will be deleted (abandoned submodules)\n");
> +
> +

I can share your feelings about lost work, and that you want to be extra
verbose about .git directories.

But step back a bit. This warning is absolutely useless: It just repeats
the user's instruction: After passing -m, we *expect* 'git clean' to
remove .git directories.

BTW, for what reason are you using a new variable keep_dot_git if there is
already rm_untracked_submodules?

Please add a test to the test suite.

-- Hannes
