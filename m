From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to pre-empt git pull merge error?
Date: Wed, 27 Nov 2013 16:54:07 +0100
Message-ID: <vpq8uw9q1r4.fsf@anie.imag.fr>
References: <86d2llc1rs.fsf@gmail.com>
	<20131127194240.2abaff5575961b3d73e1970f@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pete Forman <petef4+usenet@gmail.com>, git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Nov 27 16:54:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlhRg-0000IL-4S
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 16:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870Ab3K0Py2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 10:54:28 -0500
Received: from mx2.imag.fr ([129.88.30.17]:42392 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756781Ab3K0Py0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 10:54:26 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id rARFs9G8013269
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Nov 2013 16:54:09 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rARFs7YV004103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 27 Nov 2013 16:54:11 +0100
In-Reply-To: <20131127194240.2abaff5575961b3d73e1970f@domain007.com>
	(Konstantin Khomoutov's message of "Wed, 27 Nov 2013 19:42:40 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 27 Nov 2013 16:54:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rARFs9G8013269
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1386172454.07729@uCpUGN7+W9Sjj6yrhZu8bA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238445>

Konstantin Khomoutov <flatworm@users.sourceforge.net> writes:

> On Wed, 27 Nov 2013 15:17:27 +0000
> Pete Forman <petef4+usenet@gmail.com> wrote:
>
>> I am looking for a way of detecting up front whether a git pull or git
>> merge would fail. The sort of script I want to perform is to update a
>> server.
>> 
>>     git fetch
>>     git okay
>>     stop server
>>     backup data
>>     git merge
>>     start server
>> 
>> Here git okay is a place holder for the command I am asking for.
>> 
>> If a file has been changed outside of a commit then git pull fails
>> with the following error.
>> 
>> error: Your local changes to '...' would be overwritten by merge.
>> Aborting. Please, commit your changes or stash them before you can
>> merge.
>
> What's wrong with "git okay" being
>
> if git merge whatever 2>/dev/null; then
>   ... OK path
> else
>   ... "merge failed" path
> fi

The idea seems to be to stop the server before actually doing the merge
(and avoid doing so if the merge is bound to fail).

I don't know a simple way to do the pre-merge check without actually
doing the merge (other than patching git merge to add a --dry-run
option), but you can do a pessimistic check by using the
require_work_tree_exists shell function defined in git-sh-setup (copied
below, but you can call it from a shell script after doing
. "$(git --exec-path)/git-sh-setup"):

require_clean_work_tree () {
	git rev-parse --verify HEAD >/dev/null || exit 1
	git update-index -q --ignore-submodules --refresh
	err=0

	if ! git diff-files --quiet --ignore-submodules
	then
		echo >&2 "Cannot $1: You have unstaged changes."
		err=1
	fi

	if ! git diff-index --cached --quiet --ignore-submodules HEAD --
	then
		if [ $err = 0 ]
		then
		    echo >&2 "Cannot $1: Your index contains uncommitted changes."
		else
		    echo >&2 "Additionally, your index contains uncommitted changes."
		fi
		err=1
	fi

	if [ $err = 1 ]
	then
		test -n "$2" && echo >&2 "$2"
		exit 1
	fi
}

Additionally, you may want to check that the merge is a fast-forward
(hence can't result in merge conflict), e.g. by checking that the
current commit is the merge base between itself and the commit to merge
(git merge-base HEAD $commit).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
