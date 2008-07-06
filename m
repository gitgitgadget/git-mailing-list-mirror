From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] better git-submodule status output
Date: Sat, 05 Jul 2008 23:19:16 -0700
Message-ID: <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org>
References: <20080701150119.GE5852@joyeux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sylvain Joyeux <sylvain.joyeux@dfki.de>
To: Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 08:20:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFNby-00050e-4w
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 08:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbYGFGTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 02:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbYGFGTj
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 02:19:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41504 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbYGFGTi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 02:19:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 350E11B375;
	Sun,  6 Jul 2008 02:19:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 296331B36B; Sun,  6 Jul 2008 02:19:27 -0400 (EDT)
In-Reply-To: <20080701150119.GE5852@joyeux> (Sylvain Joyeux's message of
 "Tue, 1 Jul 2008 17:01:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 81A5DBA0-4B23-11DD-81C4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87501>

Sylvain Joyeux <sylvain.joyeux@dfki.de> writes:

> This patch makes the output of git-submodule more useful to handle the
> management of a repository using multiple submodules. Namely, it
> displays informations about how the current checked out version relates
> to the registered one (i.e. direct parent, direct child, "just
> different", registered revision does not exist), and displays if the
> submodules contain uncommitted changes.
>
> This (among other things) allows to do git-submodule update while
> knowing exactly what will happen.
> --
> Sylvain
>
>>From 16553a9b210a956b0af961d55a9cf06f1b9b8114 Mon Sep 17 00:00:00 2001
> From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
> Date: Tue, 1 Jul 2008 16:01:01 +0200
> Subject: [PATCH] more information in git-submodule status output
>
> This commit adds more information in the 'status' output of
> git-submodule. More specifically, it displays different flags if the
> submodule and the registered revision are direct parents (> and <,
> depending on which is the ancestor), if they are not direct parents (+)
> or if the registered revision cannot be found (i.e. if submodule update
> would fail, '!')
>
> Finally, it shows if the submodule contains uncommitted changes (M flag)

Which one is the commit message ;-)?

People who rely on working submodule support, do you have any feedback on
this patch?  I do not use submodule myself, so it is hard for me to judge
how much value (if any) this patch is adding to the real world use of the
status subcommand.

> @@ -97,7 +110,7 @@ for details.
>  
>  AUTHOR
>  ------
> -Written by Lars Hjemli <hjemli@gmail.com>
> +Written by Lars Hjemli <hjemli@gmail.com> and Sylvain Joyeux <sylvain.joyeux@m4x.org>

That is somehow inconsistent with what

	git-shortlog -s -n -e --no-merges git-submodule.sh 

tells me.

Honestly, I'd prefer (1) drop these "AUTHOR" lines, or (2) only list the
primary author or two.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 3eb78cc..e2b91f6 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -562,20 +566,40 @@ cmd_status()
> ...
>  		if git diff-files --quiet -- "$path"
>  		then
> -			say " $sha1 $path$revname"
> +			say " $unclean $sha1 $path$revname"
>  		else
> +                        head=$(unset GIT_DIR; cd "$path" && git rev-parse --verify HEAD)
> +                        common=$(unset GIT_DIR; cd "$path" && git merge-base HEAD $sha1)
> +                        if test -z "$common"; then
> +                            common=$(unset GIT_DIR; cd "$path" && git-fetch -q &&
> +                                    git merge-base HEAD $sha1)
> +                        fi

This "fetch" feels very wrong.  The user did not ask you to change the
state of the repository, but this will silently change the remote tracking
branches.  The repository after all might be unreachable.
