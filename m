From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Warnings before rebasing -i published history
Date: Fri, 08 Jun 2012 00:04:30 +0200
Message-ID: <vpqy5ny22z5.fsf@bauges.imag.fr>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 00:04:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sckou-0002pg-7q
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 00:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757810Ab2FGWEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 18:04:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60337 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757728Ab2FGWEi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 18:04:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q57Lto4R009139
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 7 Jun 2012 23:55:50 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sckoh-00006y-8e; Fri, 08 Jun 2012 00:04:32 +0200
In-Reply-To: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Lucien Kong's message of "Thu, 7 Jun 2012 23:20:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 07 Jun 2012 23:55:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q57Lto4R009139
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339710950.81257@4i7R1I5Rt4pHCYxUV16hsg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199456>

Lucien Kong <Lucien.Kong@ensimag.imag.fr> writes:

> For now, the code only warns the user; he can't revert back to his
> original state. We agree with everyone that he should be given a
> way to abort the rebase.

He already has: empty the todo-list in the editor and you're done.

> +warn_published () {
> +	cat "$1" | while read -r command sha1 message
> +	do
> +		test -n "$sha1" || break
> +		if test -n "$(git branch -r --contains "$sha1")"
> +		then
> +			printf "%s\n" "$(sed -e "/"$sha1"/ s|$| [Published]|" "$1")" >"$1"
> +		fi
> +	done

Aren't you reading and writing from the same file here? Sounds
dangerous.

This appends [Published] to commits that are reachable from a
remote-tracking branch, but I'm wondering if actually showing the remote
branch name wouldn't be better, e.g.

pick <id> commit one
# Commits above this line appear in origin/master
pick <id> commit two
pick <id> commit three
# Commits above this line appear in origin/next
pick <id> most recent commit

>  test -s "$todo" || echo noop >> "$todo"
>  test -n "$autosquash" && rearrange_squash "$todo"
> +warn_published "$todo"

That should be configurable.

> @@ -869,6 +884,8 @@ cat >> "$todo" << EOF
>  #  f, fixup = like "squash", but discard this commit's log message
>  #  x, exec = run command (the rest of the line) using shell
>  #
> +# Warning: [Published] means that the commit has already been published

It's a pity to show the message unconditionally. If you go this way,
skip the message if you didn't display [Published].

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
