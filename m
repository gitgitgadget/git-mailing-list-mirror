From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 10:17:04 +0200
Message-ID: <vpq38us2oov.fsf@grenoble-inp.fr>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
	<1365887729-9630-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 10:17:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URebU-0004j2-EQ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 10:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934479Ab3DOIR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 04:17:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34171 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933147Ab3DOIR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 04:17:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3F8H38d007466
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Apr 2013 10:17:03 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UReb2-0007PU-Jn; Mon, 15 Apr 2013 10:17:04 +0200
In-Reply-To: <1365887729-9630-4-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sun, 14 Apr 2013 02:45:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Apr 2013 10:17:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3F8H38d007466
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1366618625.73104@KUaK19ro6D/QggSXhgn/nA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221201>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +stash_required () {
> +	! (git diff-files --quiet --ignore-submodules &&
> +	git diff-index --quiet --cached HEAD --ignore-submodules)
> +}

Isn't this too pessimistic? If the local changes do not overlap (in
terms of files) with the pulled changes, then autosquash is not needed.

There should be a test for the case of non-overlapping changes.

> +if test "$autostash" = true && stash_required
> +then
> +	git stash || die "$(gettext "Cannot autostash")" &&
> +	require_clean_work_tree "pull" "Please commit or stash them." &&
> +	if eval "$eval"
> +	then
> +		git stash pop || die "$(gettext "Cannot pop stash")"
> +	else
> +		exit_code=$?
> +		echo "Please run 'git stash pop' after commiting the conflict resolution."
> +		exit $exit_code
> +	fi
> +else
> +	eval "exec $eval"
> +fi

Shouldn't this belong to "git merge" instead (i.e. implement "git merge
--autosquash" and call it from "git pull")? Users doing "git fetch &&
git merge" by hand should be able to use --autosquash, I think.

Something should be done for "git rebase" and "git pull --rebase" too.
In this case, the UI can be much smoother, since the user would have to
run "git rebase --continue" anyway, so you can do the auto-stash-pop for
him by adding something like "exec git stash pop" at the end of the todo-list.

Ideally, "git rebase --abort" should auto-stash-pop too, although this
is much less trivial to implement.

Maybe a good first step is to implement --autosquash only for non-rebase
pull, and later to implement "git rebase --autosquash" and call it from
"git pull".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
