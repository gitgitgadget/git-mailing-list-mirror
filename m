From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2 (v2)] submodule: no [--merge|--rebase] when newly
 cloned
Date: Thu, 17 Feb 2011 12:02:13 -0800
Message-ID: <7vbp2abfay.fsf@alter.siamese.dyndns.org>
References: <1297959526-8089-1-git-send-email-olsonse@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Spencer E. Olson" <olsonse@umich.edu>
X-From: git-owner@vger.kernel.org Thu Feb 17 21:02:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqA3d-00067s-8p
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 21:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757928Ab1BQUCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 15:02:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44545 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002Ab1BQUCV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 15:02:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AEA40327A;
	Thu, 17 Feb 2011 15:03:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=3tnJc+s3o3GK/JMT44WgtRzfNGA=; b=x2qR32+5YryvO7f/H/SBZYM
	LPeIT6c0EYZ6EAtuuXnhDE3xZneYQmbqxqFXdUZsdzeiVzvBNR+5o4Rge3Q0QX5n
	jLtdIgPizfPnId4zE/rHNavY4hAT6ygobxM7qlcnWKb8RLzHBmD43My2xHeFFrR0
	iRzbBjvJI6nvAdV4MZPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=cg1Qx4sYEwWW5mw0GrUQxzLtwjxnrvph55yBMbM3Seui4Wrf5
	6jbmsYwrR7OzTGn5KMRRgct7hI7+DpZOM3oMkcDP3ibIdotyz/Z9EvUZ7xEXs2Yn
	JaWuOOAG5PBX+xNzqaN77hM7RojrB7ohhYbQV6JPwaNZUdFrJOBtl+gbpY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D8543279;
	Thu, 17 Feb 2011 15:03:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EE6753278; Thu, 17 Feb 2011
 15:03:21 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FABB104C-3AD0-11E0-B5C6-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167110>

"Spencer E. Olson" <olsonse@umich.edu> writes:

> @@ -469,6 +484,12 @@ cmd_update()
>  				die "Unable to fetch in submodule path '$path'"
>  			fi
>  
> +			list_contains "$name" "$cloned_modules"
> +			if test "$?" = 0
> +			then
> +				update_module=
> +			fi
> +

It would be a lot easier to read if you said this:

	if list_contains "$name" "$cloned_modules"
        then
		update_module=
	fi

or just open code the idiom:

	case ";list-of-stuff-with-delimiter;" in
        *";i-want-to-see-this;"*) : happy ;;
	esac

without introducing "list_contains" that is called only once.

But otherwise the patch looks good.

Thanks.

-- >8 --
From: Spencer E. Olson <olsonse@umich.edu>
Date: Thu, 17 Feb 2011 09:18:45 -0700
Subject: [PATCH] submodule: no [--merge|--rebase] when newly cloned

Previously, when a new submodule is cloned by running "git submodule update
[--merge|--rebase]", the newly cloned submodule does not get checked out and a
rebase or merge is incorrectly attempted against an empty working directory.
This patch ignores --rebase or --merge for new submodules and instead simply
checks out the appropriate revision.

Signed-off-by: Spencer E. Olson <olsonse@umich.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-submodule.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8b90589..5e989b7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -423,6 +423,7 @@ cmd_update()
 		cmd_init "--" "$@" || return
 	fi
 
+	cloned_modules=
 	module_list "$@" |
 	while read mode sha1 stage path
 	do
@@ -442,6 +443,7 @@ cmd_update()
 		if ! test -d "$path"/.git -o -f "$path"/.git
 		then
 			module_clone "$path" "$url" "$reference"|| exit
+			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
 			subsha1=$(clear_local_git_env; cd "$path" &&
@@ -469,6 +471,13 @@ cmd_update()
 				die "Unable to fetch in submodule path '$path'"
 			fi
 
+			# Is this something we just cloned?
+			case ";$cloned_modules;" in
+			*";$name;"*)
+				# then there is no local change to integrate
+				update_module= ;;
+			esac
+
 			case "$update_module" in
 			rebase)
 				command="git rebase"
-- 
1.7.4.1.107.ga7184
