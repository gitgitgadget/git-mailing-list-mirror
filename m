From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-rebase: fix probable reflog typo
Date: Wed, 23 Apr 2014 13:36:35 +0200
Message-ID: <vpqy4ywxoos.fsf@anie.imag.fr>
References: <1398212084-16304-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 13:36:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcvTq-00065I-Is
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 13:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbaDWLgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 07:36:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38654 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbaDWLgk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 07:36:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3NBaYfh025245
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Apr 2014 13:36:34 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3NBaawn025645;
	Wed, 23 Apr 2014 13:36:36 +0200
In-Reply-To: <1398212084-16304-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 22 Apr 2014 19:14:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 23 Apr 2014 13:36:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3NBaYfh025245
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1398857796.84455@HJlvShz7NaiRppYVwHX0aA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246819>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Commit 26cd160 (rebase -i: use a better reflog message) tried to produce
> a better reflog message, however, it seems a statement was introduced by
> mistake.
>
> 'comment_for_reflog start' basically overides the GIT_REFLOG_ACTION we
> just set.

I think this is more complex than this. To give a bit more context, the
code you're changing is:

comment_for_reflog start

if test ! -z "$switch_to"
then
	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
	output git checkout "$switch_to" -- ||
	die "Could not checkout $switch_to"

	comment_for_reflog start
fi

The GIT_REFLOG_ACTION= changes the reflog message for the git checkout
command.

Since we use the construct

GIT_REFLOG_ACTION="..." shell_function

the shell may keep $GIT_REFLOG_ACTION set after calling the function (I
don't remember what POSIX says, but dash does it:
$ f () { echo $X; }
$ X=42 f
42
$ echo $X
42
$ X=y f               
y
$ echo $X
y
).

So, one needs to reset $GIT_REFLOG_ACTION to what it used to be if is it
to be used later. However, it seems to me that the "comment_for_reflog
start" is used only for this checkout command. If so, there's no need
for the "comment_for_reflog start" before the if statement either.

In any case, this should be clarified with at least a comment in the
code.

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 43631b4..5f1d8c9 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -893,8 +893,6 @@ then
>  	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
>  	output git checkout "$switch_to" -- ||
>  	die "Could not checkout $switch_to"
> -
> -	comment_for_reflog start
>  fi
>  
>  orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
