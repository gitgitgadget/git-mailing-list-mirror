From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC PATCH] git-help: find library man pages again
Date: Thu, 02 Sep 2010 10:41:56 +0200
Message-ID: <4C7F6354.70108@drmicha.warpmail.net>
References: <0b8d803551f495e2494b43c6d95163daca82f62b.1283356852.git.git@drmicha.warpmail.net> <20100902081646.GK29713@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 10:42:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or5N6-0003nt-3l
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 10:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab0IBIlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 04:41:55 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33107 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751091Ab0IBIlx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 04:41:53 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F0A8E4AE;
	Thu,  2 Sep 2010 04:41:52 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 02 Sep 2010 04:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=GcbKfOg96RinmdTTkP0YulqbVgw=; b=EZ2lzw7fPbEuoqHu+zKN9SLiK3s+i5h81tS2sRBUbtjlMs0BI5cp6DG6rkvN/hLLtCS6EjiCDRx6mamqsIFjs1ODq81UrUCR3oWn71rQbjl1ARGrQU1cTWrXCanC/Y7NFjmbngS5RH9igkZsFp8vAJi8dPAEqb3wpgw3AYKS5i4=
X-Sasl-enc: Jqs9NzK5phYvPYK1RbydK+A2wZ/dGRT1i0ZOThW5qq5c 1283416912
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3BA005E618E;
	Thu,  2 Sep 2010 04:41:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <20100902081646.GK29713@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155111>

Jonathan Nieder venit, vidit, dixit 02.09.2010 10:16:
> Michael J Gruber wrote:
> 
>> 46bac90 (Do not install shell libraries executable, 2010-01-31) changed
>> the executable bits of shell variables in order to avoid false reports
>> from valgrind. As a side effect, this inhibits "git help" from finding
>> the corresponding man pages because list_command_in_dir() (called by
>> load_command_list()) checks that bit.
> 
> Hmm.  Thanks for noticing.
> 
> Isn't the main purpose of that check to populate the list of commands
> produced by "git help -a"?
> 
>> make
>> list_command_in_dir() ignore the executable bit when looking in the exec
>> dir, so that the following man pages are found again by "git-help":
>>
>> git-mergetool--lib
>> git-parse-remote
>> git-sh-setup
> [...]
>>     This does not help with the man page for git-remote-helpers which is installed
>>     but not found by git-help either. That is a different issue, though.
> 
> Therefore this seems wrong to me (except as a backward-compatibility
> measure).

[I don't seem to be very lucky with my patches lately; but that seems to
come from the common strive for the best solution, which is good, of
course :| ]

>  i.e. I think that is the same issue after all and that
> builtin/help.c ought to learn another heuristic than is_git_command().

One heuristic, which I would have left for a later patch because of its
radicality (and I think we're in some phase of some rc something), is to
simply not do any checks when calling the viewers. This requires that
everything is prepended with "git-", which I see you have done in
builtin/help.c. Still, none-command help pages will not show up with
"git help -a". So it's not a complete solution.

Alternatively, load_command_list() etc. could simply fill up a third
list "other_pages" (with non-executables) so that "git help -a" could
list "other help pages" in addition to the commands. I don't think this
would require any renaming nor Documentation updates.

> How about something like this?
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  Documentation/Makefile                   |   10 +++++-----
>  Documentation/diff-options.txt           |    6 +++---
>  Documentation/git-add.txt                |    2 +-
>  Documentation/git-cat-file.txt           |    2 +-
>  Documentation/git-check-ref-format.txt   |    2 +-
>  Documentation/git-cherry-pick.txt        |    2 +-
>  Documentation/git-cli.txt                |    6 +++---

??? I guess this patch makes sense only after a patch which renames all
gitfoo.txt to git-foo.txt.

>  Documentation/git-commit.txt             |    4 ++--
>  Documentation/git-core-tutorial.txt      |   20 ++++++++++----------
>  Documentation/git-cvs-migration.txt      |   22 +++++++++++-----------
>  Documentation/git-cvsimport.txt          |    2 +-
>  Documentation/git-cvsserver.txt          |    2 +-
>  Documentation/git-diff.txt               |    4 ++--
>  Documentation/git-diffcore.txt           |    8 ++++----
>  Documentation/git-fast-import.txt        |    2 +-
>  Documentation/git-format-patch.txt       |    2 +-
>  Documentation/git-gc.txt                 |    2 +-
>  Documentation/git-glossary.txt           |   12 ++++++------
>  Documentation/git-hooks.txt              |    6 +++---
>  Documentation/git-log.txt                |    2 +-
>  Documentation/git-push.txt               |    2 +-
>  Documentation/git-rebase.txt             |    2 +-
>  Documentation/git-reflog.txt             |    2 +-
>  Documentation/git-repository-layout.txt  |   10 +++++-----
>  Documentation/git-rev-parse.txt          |    2 +-
>  Documentation/git-revert.txt             |    2 +-
>  Documentation/git-revisions.txt          |    6 +++---
>  Documentation/git-show-branch.txt        |    2 +-
>  Documentation/git-show-ref.txt           |    2 +-
>  Documentation/git-show.txt               |    2 +-
>  Documentation/git-tutorial-2.txt         |   24 ++++++++++++------------
>  Documentation/git-tutorial.txt           |   24 ++++++++++++------------
>  Documentation/git-update-server-info.txt |    2 +-
>  Documentation/git-workflows.txt          |    8 ++++----
>  Documentation/git.txt                    |   28 ++++++++++++++--------------
>  Documentation/gitk.txt                   |    2 +-
>  Documentation/pt_BR/gittutorial.txt      |   14 +++++++-------
>  Documentation/user-manual.txt            |   14 +++++++-------
>  Makefile                                 |   22 +++++++++++-----------
>  builtin/help.c                           |    4 +---
>  40 files changed, 145 insertions(+), 147 deletions(-)
> 

[trivial gitfoo -> git-foo diffs skipped]

> diff --git a/Makefile b/Makefile
> index b4745a5..f3c369f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2256,20 +2256,20 @@ check-docs::
>  		documented,gitattributes | \
>  		documented,gitignore | \
>  		documented,gitmodules | \
> -		documented,gitcli | \
> +		documented,git-cli | \
>  		documented,git-tools | \
> -		documented,gitcore-tutorial | \
> -		documented,gitcvs-migration | \
> -		documented,gitdiffcore | \
> -		documented,gitglossary | \
> -		documented,githooks | \
> -		documented,gitrepository-layout | \
> -		documented,gitrevisions | \
> -		documented,gittutorial | \
> -		documented,gittutorial-2 | \
> +		documented,git-core-tutorial | \
> +		documented,git-cvs-migration | \
> +		documented,git-diffcore | \
> +		documented,git-glossary | \
> +		documented,git-hooks | \
> +		documented,git-repository-layout | \
> +		documented,git-revisions | \
> +		documented,git-tutorial | \
> +		documented,git-tutorial-2 | \
>  		documented,git-bisect-lk2009 | \
>  		documented,git-remote-helpers | \
> -		documented,gitworkflows | \
> +		documented,git-workflows | \
>  		sentinel,not,matching,is,ok ) continue ;; \
>  		esac; \
>  		case " $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git gitk " in \
> diff --git a/builtin/help.c b/builtin/help.c
> index 61ff798..d1f6736 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -310,10 +310,8 @@ static const char *cmd_to_page(const char *git_cmd)
>  		return "git";
>  	else if (!prefixcmp(git_cmd, "git"))
>  		return git_cmd;
> -	else if (is_git_command(git_cmd))
> -		return prepend("git-", git_cmd);
>  	else
> -		return prepend("git", git_cmd);
> +		return prepend("git-", git_cmd);
>  }
>  
>  static void setup_man_path(void)
