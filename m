Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21538C433F5
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 22:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJCW2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 18:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJCW1b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 18:27:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456A35E66E
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 15:24:14 -0700 (PDT)
Received: (qmail 742 invoked by uid 109); 3 Oct 2022 22:24:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Oct 2022 22:24:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29882 invoked by uid 111); 3 Oct 2022 22:24:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Oct 2022 18:24:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Oct 2022 18:24:12 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Tim Jaacks <timjaacks@posteo.de>, git@vger.kernel.org
Subject: Re: Bash completion for git aliases containing nested subcommands
Message-ID: <YzthDLdqeQx6bEcj@coredump.intra.peff.net>
References: <em8d7ca854-51a3-4cb5-aaf9-30ed37b4194b@acer-switch-tim>
 <20221003142437.GB7659@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221003142437.GB7659@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2022 at 04:24:37PM +0200, SZEDER Gábor wrote:

> > Is there a way to get the completion on the alias behave like on the
> > original command?
> 
> In general: no.  Our Bash completion script is organized as one
> _git_cmd() function for each git supported command.  If a command has
> subcommands, then its completion function looks for any of its
> subcommands amond the words on the command line, and takes the
> appropriate action, which is usually executing a particular arm of a
> case statement.  The two main issues are that in case of such an alias
> there is no subcommand ("show") on the command line, and there is no
> dedicated function to handle only the completion for 'git stash show'.

It feels like this ought to be able to work, for the same reason that
"git stash show <TAB>" works. In the non-aliased case, we call into
_git_stash(), and it sees that "show" is already there on the command
line. But in the aliased case, we know "show" is part of the alias but
throw away that information completely, and never feed it to
_git_stash() at all.

I think we could do something like the patch below, though I suspect
there are some dragons with more complicated aliases. I wonder if
__git_aliased_command() needs to be more careful with distinguishing
pure-git-command aliases from the complexity of "!" aliases. Or maybe
the alias stuff is all best-effort enough that this doesn't make
anything worse.

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ba5c395d2d..f68bfcbf05 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1148,10 +1148,13 @@ __git_aliased_command ()
 		cur=
 
 		for word in $cmdline; do
+			if test -n "$cur"; then
+				expansion_words+=("$word")
+				continue
+			fi
 			case "$word" in
 			\!gitk|gitk)
 				cur="gitk"
-				break
 				;;
 			\!*)	: shell command alias ;;
 			-*)	: option ;;
@@ -1163,14 +1166,13 @@ __git_aliased_command ()
 			\'*)	: skip opening quote after sh -c ;;
 			*)
 				cur="$word"
-				break
 			esac
 		done
 	done
 
 	cur=$last
 	if [[ "$cur" != "$1" ]]; then
-		echo "$cur"
+		expansion=$cur
 	fi
 }
 
@@ -3507,9 +3509,13 @@ __git_main ()
 
 	__git_complete_command "$command" && return
 
-	local expansion=$(__git_aliased_command "$command")
+	# __git_aliased_command now writes to these
+	local expansion
+	local expansion_words
+	__git_aliased_command "$command"
 	if [ -n "$expansion" ]; then
-		words[1]=$expansion
+		words=("${words[0]}" "$expansion" "${expansion_words[@]}" "${words[@]:2}")
+		cword=$((cword + ${#expansion_words[@]}))
 		__git_complete_command "$expansion"
 	fi
 }

By the way, you'll notice that the splice into "words" happens right
at words[1]. That matches the earlier code that just touches words[1].
But I suspect that isn't right. If we're completing "git -p foo", for
example, then the command is at word[2]. I don't know if this causes any
bugs, since we get to the right completion function based on $expansion,
not any value in $words. But presumably it should be __git_cmd_idx?

-Peff
