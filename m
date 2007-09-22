From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Fri, 21 Sep 2007 19:33:21 -0700
Message-ID: <7vlkazh1ji.fsf@gitster.siamese.dyndns.org>
References: <20070921214346.GF97288@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Sat Sep 22 04:33:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYuoJ-0006mT-KK
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 04:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756557AbXIVCda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 22:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758393AbXIVCd3
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 22:33:29 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:45590 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756330AbXIVCd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 22:33:28 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C0DA137301;
	Fri, 21 Sep 2007 22:33:45 -0400 (EDT)
In-Reply-To: <20070921214346.GF97288@void.codelabs.ru> (Eygene Ryabinkin's
	message of "Sat, 22 Sep 2007 01:43:46 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58912>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

> Good day.
>
> I had found that FreeBSD's /bin/sh refuses to work with git 1.5.3.2.
> correctly: no flags are recognized.

> @@ -109,7 +109,7 @@ dotest=.dotest sign= utf8=t keep= skip= interactive= resolved= binary=
>  resolvemsg= resume=
>  git_apply_opt=
>  
> -while case "$#" in 0) break;; esac
> +while case "$#" in 0) break;; *) : ;; esac
>  do

I am assuming that this works around _a_ bug in that /bin/sh; I
would make sure I understand the nature of the bug.  Is it Ok to
understand that with that shell, after this construct runs:

	case <some word> in
        <case arm #1>)
        	something ;;
	<case arm #2>)
        	something else ;;
	esac

the status from the whole case statement is false, when <some word>
does not match any of the glob patterns listed in any of the case arm?

That is, what does the shell say if you do this?

	case Ultra in
        Super)
        	false ;;
	Hyper)
        	true ;;
	esac &&
        echo case returned ok

The reason I ask is because

	while case $# in 0) ... esac
        do
        	...
	done

is not the only place the status from "case" itself matters in
our scripts.  There are places that do

	something &&
	case ... in
        ...
        esac &&
        something else

and we would need to add no-op match-everything arm to all of
such case statements in our scripts.

Besides test scripts, there is one in git-ls-remote.sh which you
seem to have missed.
