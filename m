From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase [-i --exec | -ix] <CMD>...
Date: Mon, 04 Jun 2012 19:48:50 +0200
Message-ID: <vpqk3znrmrh.fsf@bauges.imag.fr>
References: <1338817674-22877-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 04 19:49:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbbOp-0007Nw-DD
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 19:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754Ab2FDRs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 13:48:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60549 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478Ab2FDRs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 13:48:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q54He9r6019856
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2012 19:40:10 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SbbOd-0007Ao-48; Mon, 04 Jun 2012 19:48:51 +0200
In-Reply-To: <1338817674-22877-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Kong Lucien's message of "Mon, 4 Jun 2012 15:47:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Jun 2012 19:40:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q54He9r6019856
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339436413.74812@/ZBjjcT9xgDWC8y2f4OftQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199161>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -8,9 +8,9 @@ git-rebase - Forward-port local commits to the updated upstream head
>  SYNOPSIS
>  --------
>  [verse]
> -'git rebase' [-i | --interactive] [options] [--onto <newbase>]
> +'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
>  	[<upstream>] [<branch>]
> -'git rebase' [-i | --interactive] [options] --onto <newbase>
> +'git rebase' [-i | --interactive] [options] [--exec <cmd>] --onto <newbase>
>  	--root [<branch>]
>  'git rebase' --continue | --skip | --abort
>  
> @@ -210,6 +210,17 @@ rebase.autosquash::
>  
>  OPTIONS
>  -------
> +<cmd>::
> +	Shell command executed between each commit applications. The
> +	--exec option has to be specified.
[...]
> +-x::
> +--exec::

That seems weird to have --exec <cmd> specification split into one for
--exec, and another for <cmd> ...

> +You may execute several commands between each commit applications.
> +Therefore, you can use one instance of exec:
> +	git rebase -i --exec "cmd1; cmd2; ...".

s/Therefore/For this/ ?

(Therefore = donc in French)

> +if test -n "$cmd"
> +then
> +	OIFS=$IFS
> +	IFS=','
> +	for i in $cmd
> +	do
> +		sed "/^pick .*/aexec $i" "$todo" >tmp
> +		cat tmp >"$todo"
> +	done
> +	rm tmp

Isn't this executed from the top of the workdir? What if the user
already has a file named tmp there?

> +			if test -n "$cmd"
> +			then
> +				cmd="$2,$cmd"
> +			else
> +				cmd="$2"
> +			fi

What happens when <cmd> contains a comma (e.g. --exec "rm
file,with,commas,in,name.txt") ?

If you don't allow this case, then you should error out instead of
executing a weird behavior silently. Or you can escape the comma and
unescape it later, but that may be overkill.

> +if test -n "$exec_flag" &&
> +   test -z "$interactive_rebase"
> +then
> +	echo "--exec option must be used with --interactive option\n"
> +	usage
> +fi

I'd even skip the "usage" here, as the error message is clear enough
(and is much less visible before a page of "usage" output). Just die-ing
would be better I think.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
