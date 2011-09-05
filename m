From: Naohiro Aota <naota@elisp.net>
Subject: Re: [PATCH] shell portability: Use sed instead of non-portable variable expansion
Date: Mon, 05 Sep 2011 16:55:41 +0900
Message-ID: <87fwkbzama.fsf@elisp.net>
References: <8762l73758.fsf@elisp.net> <4E647442.9000005@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, tarmigan+git@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 09:55:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0U28-0006zU-24
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 09:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278Ab1IEHzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 03:55:52 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33289 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab1IEHzu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 03:55:50 -0400
Received: by iabu26 with SMTP id u26so6070916iab.19
        for <git@vger.kernel.org>; Mon, 05 Sep 2011 00:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mzip+31On2smyAbpg8WrR6W6uCNRv4zZqlknJDwr1WI=;
        b=bMDbNL3wM4RaU5uQ5Cu7ybjp2tIJr/xaabGrohzCaCvD0LtzTuVEQ5jgfQ+7AVVTWH
         jA+eXcmZv25iniVHttXEuhz6mtaJHRSSdzD/UJW19bQCAAm3HgyPjxU/7tN76bHceFbQ
         e3dDkkY9lAdyKG7uKW2XcgqGGKWYtx810Fjp8=
Received: by 10.231.63.11 with SMTP id z11mr7135120ibh.23.1315209350302;
        Mon, 05 Sep 2011 00:55:50 -0700 (PDT)
Received: from kaede (e0109-49-132-8-98.uqwimax.jp [49.132.8.98])
        by mx.google.com with ESMTPS id r2sm12804643ibq.7.2011.09.05.00.55.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Sep 2011 00:55:49 -0700 (PDT)
In-Reply-To: <4E647442.9000005@viscovery.net> (Johannes Sixt's message of
	"Mon, 05 Sep 2011 09:03:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180725>

Ah, seems I was misundertanding much of things :(

Johannes Sixt <j.sixt@viscovery.net> writes:

> What happens if you write these as
>
> 	QUERY_STRING=${1#*\?} \
> 	PATH_TRANSLATED=$HTTPD_DOCUMENT_ROOT_PATH/${1%%\?*} \
>
> i.e., drop the double-quotes?

not worked, even increased the number of failure...

Junio C Hamano <gitster@pobox.com> writes:

> Naohiro Aota <naota@elisp.net> writes:
>
>> Variable expansions like "${foo#bar}" or "${foo%bar}" doesn't work on
>> shells like FreeBSD sh and they made the test to fail.
>
> Sorry, I do appreciate the effort, but a patch like this takes us in the
> wrong direction.
>
> While we do not allow blatant bashisms like ${parameter:offset:length}
> (substring expansion), ${parameter/pattern/string} (pattern substitution),
> "local" variables, "function" noiseword, and shell arrays in our shell
> scripts, the two kinds of substitution you quoted above are purely POSIX,
> and our coding guideline does allow them to be used in the scripts.
>
> Even though you may be able to rewrite trivial cases easily in some
> scripts (either tests or Porcelain), some Porcelain scripts we ship
> (e.g. "git bisect", "git stash", "git pull", etc.) do use these POSIX
> constructs, and we do not want to butcher them with extra forks and
> reduced readability.
>
> Please use $SHELL_PATH and point to a POSIX compliant shell on your
> platform instead. "make test" should pick it up and pass it down to
> t/Makefile to be used when it runs these test scripts.

Thanks, I'll try this.

> Besides, even inside t/ directory, there are many other instances of these
> prefix/postfix substitution, not just 5560. Do the following tests pass on
> your box without a similar patch?
>
> $ git grep -n -e '\${[^}]*[#%]' -- t/\*.sh
> t/t1410-reflog.sh:33:	aa=${1%??????????????????????????????????????} zz=${1#??}
> t/t1410-reflog.sh:38:	aa=${1%??????????????????????????????????????} zz=${1#??}
> t/t2030-unresolve-info.sh:125:	rerere_id=${rerere_id%/postimage} &&
> t/t2030-unresolve-info.sh:151:	rerere_id=${rerere_id%/postimage} &&
> t/t5560-http-backend-noserver.sh:12:	QUERY_STRING="${1#*\?}" \
> t/t5560-http-backend-noserver.sh:13:	PATH_TRANSLATED="$HTTPD_DOCUMENT_ROOT_PATH/${1%%\?*}" \
> t/t6050-replace.sh:124:     aa=${HASH2%??????????????????????????????????????} &&
> t/t9010-svn-fe.sh:17:		printf "%s\n" "K ${#property}" &&
> t/t9010-svn-fe.sh:19:		printf "%s\n" "V ${#value}" &&
> t/t9010-svn-fe.sh:30:	printf "%s\n" "Text-content-length: ${#text}" &&
> t/t9010-svn-fe.sh:31:	printf "%s\n" "Content-length: $((${#text} + 10))" &&
> t/test-lib.sh:838:		test_results_path="$test_results_dir/${0%.sh}-$$.counts"
> t/test-lib.sh:1047:this_test=${0##*/}
> t/test-lib.sh:1048:this_test=${this_test%%-*}
> t/valgrind/analyze.sh:98:				test $output = ${output%.message} &&

I've tried t[0-9]{4}-*.sh and all of them passed. (t9010 had some known
breakages) yeah, my patch was taking wrong way.

> Looking at the above output, I suspect that it _might_ be that your shell
> is almost POSIX but does not handle the backslash-quoted question mark
> correctly or something silly like that, in which case a stupid patch like
> the attached might be an acceptable compromise, until the shell is fixed.
>
> diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
> index 0ad7ce0..c8bbacc 100755
> --- a/t/t5560-http-backend-noserver.sh
> +++ b/t/t5560-http-backend-noserver.sh
> @@ -9,8 +9,8 @@ test_have_prereq MINGW && export GREP_OPTIONS=-U
>  
>  run_backend() {
>  	echo "$2" |
> -	QUERY_STRING="${1#*\?}" \
> -	PATH_TRANSLATED="$HTTPD_DOCUMENT_ROOT_PATH/${1%%\?*}" \
> +	QUERY_STRING="${1#*[?]}" \
> +	PATH_TRANSLATED="$HTTPD_DOCUMENT_ROOT_PATH/${1%%[?]*}" \
>  	git http-backend >act.out 2>act.err
>  }

This worked on my box. hm, then the problem should be in /bin/sh
