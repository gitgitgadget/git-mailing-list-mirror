From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] receive-pack: optionally deny case clone refs
Date: Wed, 04 Jun 2014 08:06:00 +0200
Message-ID: <538EB748.3050300@viscovery.net>
References: <1401851607-8255-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 08:06:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ws4L0-0002yE-Rl
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 08:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbaFDGGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 02:06:09 -0400
Received: from so.liwest.at ([212.33.55.25]:37195 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755171AbaFDGGI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 02:06:08 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ws4Kn-0000oq-53; Wed, 04 Jun 2014 08:06:01 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B4D9516613;
	Wed,  4 Jun 2014 08:06:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <1401851607-8255-1-git-send-email-dturner@twitter.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250716>

Am 6/4/2014 5:13, schrieb David Turner:
> It is possible to have two branches which are the same but for case.
> This works great on the case-sensitive filesystems, but not so well on
> case-insensitive filesystems.  It is fairly typical to have
> case-insensitive clients (Macs, say) with a case-sensitive server
> (GNU/Linux).
> 
> Should a user attempt to pull on a Mac when there are case clone
> branches with differing contents, they'll get an error message
> containing something like "Ref refs/remotes/origin/lower is at
> [sha-of-lowercase-branch] but expected [sha-of-uppercase-branch]....
> (unable to update local ref)"
> 
> With a case-insensitive git server, if a branch called capital-M
> Master (that differs from lowercase-m-master) is pushed, nobody else
> can push to (lowercase-m) master until the branch is removed.
> 
> Create the option receive.denycaseclonebranches, which checks pushed
> branches to ensure that they are not case clones of an existing
> branch.  This setting is turned on by default if core.ignorecase is
> set, but not otherwise.
> 
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  Documentation/config.txt           |  6 ++++++
>  Documentation/git-push.txt         |  5 +++--
>  Documentation/glossary-content.txt |  5 +++++
>  builtin/receive-pack.c             | 27 +++++++++++++++++++++++-
>  t/t5400-send-pack.sh               | 43 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 83 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1932e9b..4deddf8 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2053,6 +2053,12 @@ receive.unpackLimit::
>  	especially on slow filesystems.  If not set, the value of
>  	`transfer.unpackLimit` is used instead.
>  
> +receive.denyCaseCloneBranches::
> +	If set to true, git-receive-pack will deny a ref update that creates
> +	a ref which is the same but for case as an existing ref.  This is
> +	useful when clients are on a case-insensitive filesystem, which
> +	will cause errors when given refs which differ only in case.

Shouldn't this better be named 'receive.denyCaseCloneRefs'?

How about 'denyCaseInsensitiveRefs', 'denyIgnoreCaseRefs'?

Is this entry really so important that it must be the first in the list of
receive.deny* list, which is not alphabetically sorted?

> +
>  receive.denyDeletes::
>  	If set to true, git-receive-pack will deny a ref update that deletes
>  	the ref. Use this to prevent such a ref deletion via a push.

> --- a/t/t5400-send-pack.sh
> +++ b/t/t5400-send-pack.sh
> @@ -129,6 +129,49 @@ test_expect_success 'denyNonFastforwards trumps --force' '
>  	test "$victim_orig" = "$victim_head"
>  '
>  
> +test_expect_success 'denyCaseCloneBranches works' '
> +	(
> +	    cd victim &&
> +	    git config receive.denyCaseCloneBranches true

Broken && chain.

> +	    git config receive.denyDeletes false
> +	) &&
> +	git send-pack ./victim HEAD:refs/heads/caseclone &&
> +	orig_ver=$(git rev-parse HEAD) &&
> +	test_must_fail git send-pack ./victim HEAD^:refs/heads/CaseClone &&
> +	#confirm that this had no effect upstream
> +	(
> +	    cd victim &&
> +	    test_must_fail git rev-parse CaseClone &&
> +	    remote_ver=$(git rev-parse caseclone) &&
> +	    test $orig_ver = $remote_ver

Please use double-quotes around the variable expansions: There could be a
failure mode where remote_ver (and even orig_ver) are empty, which would
lead to a syntax error or a wrong result.

BTW, on a case-insensitive file system, is there not a chance that 'git
rev-parse CaseClone' succeeds even though the ref is stored in
victim/.git/refs/heads/caseclone? Perhaps you should inspect the output of
'git for-each-ref' for the expected result? (Mental note: At least a
case-preserving file system is required to run the test.)

> +	) &&
> +	git send-pack ./victim HEAD^:refs/heads/notacaseclone &&
> +	test_must_fail git send-pack ./victim :CaseClone &&
> +	#confirm that this had no effect upstream

Please insert a blank after the hash mark.

> +	(
> +	    cd victim &&
> +	    test_must_fail git rev-parse CaseClone &&
> +	    remote_ver=$(git rev-parse caseclone) &&
> +	    test $orig_ver = $remote_ver
> +	) &&
> +	git send-pack ./victim :caseclone &&
> +	#confirm that this took effect upstream
> +	(
> +	    cd victim &&
> +	    test_must_fail git rev-parse caseclone
> +	)

Broken && chain.

> +	#check that we can recreate a branch after deleting a
> +	#case-clone of it
> +	case_clone_ver=$(git rev-parse HEAD^)

Broken && chain.

> +	git send-pack ./victim HEAD^:CaseClone &&
> +	(
> +	    cd victim &&
> +	    test_must_fail git rev-parse caseclone &&
> +	    remote_ver=$(git rev-parse CaseClone) &&
> +	    test $case_clone_ver = $remote_ver
> +	)
> +'
> +
>  test_expect_success 'push --all excludes remote-tracking hierarchy' '
>  	mkdir parent &&
>  	(
> 

-- Hannes
