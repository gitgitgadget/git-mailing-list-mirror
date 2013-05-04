From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Pitfalls in auto-fast-forwarding heads that are not checked out?
Date: Sat, 04 May 2013 09:34:17 +0200
Message-ID: <5184B9F9.2010708@kdbg.org>
References: <CACPiFCLnjCeCpt8wR71bFweFyA3rFCsnbEiR1yRD1n=X5K84Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 04 09:34:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYWzO-0003yE-6H
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 09:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756518Ab3EDHeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 03:34:22 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:36716 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754065Ab3EDHeW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 03:34:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 855D4130047;
	Sat,  4 May 2013 09:34:18 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id F26F519F5C6;
	Sat,  4 May 2013 09:34:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CACPiFCLnjCeCpt8wR71bFweFyA3rFCsnbEiR1yRD1n=X5K84Mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223356>

Am 04.05.2013 00:46, schrieb Martin Langhoff:
> I am building a small git wrapper around puppet, and one of the
> actions it performs is auto-fastforwarding of branches without
> checking them out.
> 
> In simplified code... we ensure that we are on a head called master,
> and in some cases "ppg commit", will commit to master and...
> 
>   ## early on
>   # sanity-check we are on master
>   headname=$(git rev-parse --symbolic-full-name --revs-only HEAD)
>   if [ "$headname" -ne "refs/heads/headname" ]; then

You mean "refs/heads/master" and "!=" here because -ne is numeric
comparison in a shell script.

>       echo >&2 "ERROR: can only issue --immediate commit from the
> master branch!"
>       exit 1
>   fi
> 
>   ## then
>   git commit -bla blarg baz
> 
>   ## and then...
> 
>   # ensure we can ff
>   head_sha1=$(git rev-parse --revs-only master)
>   mb=$(git merge-base $production_sha1 refs/heads/master)
>   if [[ "$mb" -ne "$production_sha1" ]]; then

Your approach looks OK (but note again the incorrect "-ne").

Since git 1.8.0 you can express this check as

    if git merge-base --is-ancestor $production_sha1 refs/heads/master

>       echo >&2 "ERROR: cannot fast-forward master to production"

	echo >&2 "ERROR: cannot fast-forward production to master"

>       exit 1
>   fi
>   $GIT_EXEC_PATH/git-update-ref -m "ppg immediate commit"
> refs/heads/production $head_sha1 $production_sha1 || exit 1
> 
> Are there major pitfalls in this approach?

I don't think there are.

> I cannot think of any, but
> git has stayed away from updating my local tracking branches; so maybe
> there's a reason for that...

I don't understand what you are saying here. What is "that"?

-- Hannes
