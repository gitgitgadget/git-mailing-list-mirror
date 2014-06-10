From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule.sh: avoid "test <cond> -a/-o <cond>"
Date: Tue, 10 Jun 2014 10:02:06 -0700
Message-ID: <xmqqegywaeb5.fsf@gitster.dls.corp.google.com>
References: <1402418594-1377-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 19:03:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuPRe-00019p-7o
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 19:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbaFJRCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 13:02:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55867 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888AbaFJRCS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 13:02:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 673361CCCC;
	Tue, 10 Jun 2014 13:02:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3ekRO32gp2p9+Tf7SZMUEw5wWPA=; b=BIlPHx
	uK3iZ63ef1x6YQDl68b9ZeKt1A1BiBSaoUhfYdjm7K75fZuifooNZ5vwE7SxCmU2
	oOu4DlsIDPATO2u3zqwiQ6zRvBWjsSz5zc52r5IaHnRt4oOS9Gv53C7eMUHceRRD
	0OxmBqio/NzdSkk+C9nHTYeHBJZsiz75NPCbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Twcm3AnOOl23zoRvWashfYZcM1hWBEop
	FkSHkLIrwbGIpdElLDee8PcUXyrSrKJoIzkppulJPrEdBcDNlk42Twaa4zyGOjYB
	gcNni4YfJyzg4GiP+PU6V0xu7ditpdPtOXzE5j4hsJkW/LX7Rl0czj4EcE+9orlr
	+q+cv7yMDPE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E3191CCCA;
	Tue, 10 Jun 2014 13:02:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 336DE1CCB5;
	Tue, 10 Jun 2014 13:02:08 -0400 (EDT)
In-Reply-To: <1402418594-1377-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Tue, 10 Jun 2014 09:43:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F4C5BCC4-F0C0-11E3-B135-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251205>

Elia Pinto <gitter.spiros@gmail.com> writes:

> @@ -832,7 +832,7 @@ Maybe you want to use 'update --init'?")"
>  			continue
>  		fi
>  
> -		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
> +		if ! test -d "$sm_path"/.git && test -f "$sm_path"/.git

Hmmmm.  Is the above correct?

    $ if ! false && true; then echo true; else echo false; fi
    true

In other words, "! cmd1 && cmd2" parses not as "! (cmd1 && cmd2)"
but as "(! cmd1) && cmd2".

It almost makes me wonder if the code may become simpler if we did
it the way in the attached.  That is, "if $sm_path/.git is there
(whether as an embedded repository, or a file pointing to a
repository elsewhere), then grab its HEAD, otherwise $sm_path is a
submodule that hasn't been run 'submodule init' on, so run the whole
nine yards starting from module_clone".

 git-submodule.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index e146b83..018f1bb 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -832,15 +832,15 @@ Maybe you want to use 'update --init'?")"
 			continue
 		fi
 
-		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
+		if test -e "$sm_path/.git"
 		then
-			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
-			cloned_modules="$cloned_modules;$name"
-			subsha1=
-		else
 			subsha1=$(clear_local_git_env; cd "$sm_path" &&
 				git rev-parse --verify HEAD) ||
 			die "$(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
+		else
+			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
+			cloned_modules="$cloned_modules;$name"
+			subsha1=
 		fi
 
 		if test -n "$remote"
