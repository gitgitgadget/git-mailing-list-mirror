From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Re* [PATCH] git-remote-testgit: avoid process substitution
Date: Sat, 27 Apr 2013 21:13:13 +0200
Message-ID: <517C2349.3050609@kdbg.org>
References: <7vvc7enxco.fsf@alter.siamese.dyndns.org> <7vwqrtgi1r.fsf@alter.siamese.dyndns.org> <51779052.8020507@viscovery.net> <CAMP44s1oX_m0d+2Z3+VkafOhT1bZK_9Z5m1ex456DMdAidEKeg@mail.gmail.com> <5177980A.4090305@viscovery.net> <5178C583.6000703@viscovery.net> <CAMP44s2nWs3XyaLQUnYd=A9u1=8tB7Qp+FN7gf+SrACxmtP8pw@mail.gmail.com> <7vobd1udz2.fsf@alter.siamese.dyndns.org> <CAMP44s3j5Bk3eqPeN2qkGTWFLO2NKz0taTGYVNvEut_VM=0NXA@mail.gmail.com> <7v8v44vpon.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:13:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWAYk-00080I-Om
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265Ab3D0TNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:13:19 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:16926 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751480Ab3D0TNS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:13:18 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C447B10012;
	Sat, 27 Apr 2013 21:13:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D879719F5AF;
	Sat, 27 Apr 2013 21:13:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7v8v44vpon.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222660>

Am 27.04.2013 01:26, schrieb Junio C Hamano:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
>> No, it wouldn't, but I don't think there's any way to do \<\> or \b in globs.
> 
> This should do in the meantime, but it further needs:
> 
>  - J6t's sign off for the follow-up part to remove remaining
>    bash-isms to complete this patch (the last part of the patch is
>    from <5178C583.6000703@viscovery.net> and we can take half the
>    log message from there);

The patch below doesn't remove the bash dependency, yet, but it addresses
the problematic mismatch you noticed without the need for $LF. Can you
please queue it to move the topic forward?

Removing the remaining bashisms and the following two can come later:

>  - Rename it to git-remote-testgit.sh and tell Makefile to replace
>    the shebang line with SHELL_PATH like other scripts;
> 
>  - Remove the "we need to have bash because we will run remote-testgit"
>    logic from t5801

Here's my

Signed-off-by: Johannes Sixt <j6t@kdbg.org>

for this part in case someone wants to pick it up:

> diff --git a/git-remote-testgit b/git-remote-testgit
> index b395c8d..ffac950 100755
> --- a/git-remote-testgit
> +++ b/git-remote-testgit
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env bash
> +#!/bin/sh
>  # Copyright (c) 2012 Felipe Contreras
>  
>  alias=$1
> @@ -23,7 +23,6 @@ then
>  	testgitmarks="$dir/testgit.marks"
>  	test -e "$gitmarks" || >"$gitmarks"
>  	test -e "$testgitmarks" || >"$testgitmarks"
> -	testgitmarks_args=( "--"{import,export}"-marks=$testgitmarks" )
>  fi
>  
>  while read line
> @@ -62,22 +61,31 @@ do
>  			echo "feature export-marks=$gitmarks"
>  		fi
>  		echo "feature done"
> -		git fast-export "${testgitmarks_args[@]}" $refs |
> +		git fast-export \
> +			${testgitmarks:+"--import-marks=$testgitmarks"} \
> +			${testgitmarks:+"--export-marks=$testgitmarks"} \
> +			$refs |
>  		sed -e "s#refs/heads/#${prefix}/heads/#g"
>  		echo "done"
>  		;;
>  	export)
>  		before=$(git for-each-ref --format='%(refname) %(objectname)')
>  
> -		git fast-import "${testgitmarks_args[@]}" --quiet
> +		git fast-import \
> +			${testgitmarks:+"--import-marks=$testgitmarks"} \
> +			${testgitmarks:+"--export-marks=$testgitmarks"} \
> +			--quiet
>  

--- 8< ---
Subject: [PATCH] git-remote-testgit: avoid process substitution

The implementation of bash on Windows does not offer process substitution.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 git-remote-testgit | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index 23c9d40..979b13e 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -87,17 +87,18 @@ do
 			exit 1
 		fi
 
-		before=$(git for-each-ref --format='%(refname) %(objectname)')
+		before=$(git for-each-ref --format=' %(refname) %(objectname) ')
 
 		git fast-import "${testgitmarks_args[@]}" --quiet
 
-		after=$(git for-each-ref --format='%(refname) %(objectname)')
-
 		# figure out which refs were updated
-		join -e 0 -o '0 1.2 2.2' -a 2 <(echo "$before") <(echo "$after") |
-		while read ref a b
+		git for-each-ref --format='%(refname) %(objectname)' |
+		while read ref a
 		do
-			test $a == $b && continue
+			case "$before" in
+			*" $ref $a "*)
+				continue ;;	# unchanged
+			esac
 			echo "ok $ref"
 		done
 
-- 
1.8.2.388.g36592d7
