From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] reflog-walk: don't segfault on non-commit sha1's in the reflog
Date: Wed, 30 Dec 2015 14:42:52 -0800
Message-ID: <xmqqk2nvd0cz.fsf@gitster.mtv.corp.google.com>
References: <1451512152.9251.23.camel@kaarsemaker.net>
	<20151230221705.GA4025@spirit>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Dec 30 23:43:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEPSM-0000JB-PH
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 23:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbbL3Wm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 17:42:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51835 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751387AbbL3Wmy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 17:42:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D8CDB36DCA;
	Wed, 30 Dec 2015 17:42:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wMzjooCkB9RRU4FcvzqbqJ/n9/I=; b=MZHPff
	flY0PT0WoO2BN2oqXzzQgI4ZOZyIQFXmSsVDHKg2pUhJcnX/C0CNVHmygm9AS0M+
	2CHZBkERhzt0/6DbiUN+JUsyE3z1GHNbStZMray9ewTsf2uM216FB3aST4Q9QiH5
	hEi+rIZmbmjkTZz8S6Sz3/m8jkbfKZmCUX6Yc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dLhBfAgPWdHiI+p1lY3Y/d6DJKNeUykQ
	2adelZyKKVbmt26GgQ0e23FtqbTwCvEAAMstlNJhOjhYMZ4YrR5x79mn3kQQpxmd
	AnThhjOhJnr4+RvMrfX32TvtpBOUlcRnCF5Sfr/nodbGeYHbjgAh4A8a5/VRYYqT
	vD+yTV9w6xI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D01F436DC9;
	Wed, 30 Dec 2015 17:42:53 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4DF6136DC6;
	Wed, 30 Dec 2015 17:42:53 -0500 (EST)
In-Reply-To: <20151230221705.GA4025@spirit> (Dennis Kaarsemaker's message of
	"Wed, 30 Dec 2015 23:17:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A9A40F20-AF46-11E5-AED8-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283211>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> The really correct way of fixing this bug may actually be a level higher, and
> making git reflog not rely on information about parent commits, whether they
> are fake or not.

I tend to agree.

The only common thing between "git reflog" wants to do (i.e. showing
the objects referred to by reflog entries) and what the normal "git
log" was/is designed to do is "we have many things, and we show them
one by one".  As the "many things" we have in the context of the
normal "git log" are all commits, it is reasonable that the internal
interface (i.e. revision.c::get_revision()) to iterate over these
"many things" returns a "struct commit *" and it also is reasonable
that "show them one by one" is done by calling log_tree_commit() in
builtin/log.c::cmd_log_walk().  Neither is suitable to deal with
series of reflog entries in general.  A proper implementation of
"git reflog" would have liked to be able to iterate over "many
things" by returning "struct object *" one-by-one, and then do the
equivalent of the switch() statement in builtin/log.c::cmd_show()
to show these objects.

The way "git log" was abused and made to show entries from reflog is
one of the ugly and unfortunate hacks in our codebase.

However, I see that there are one of two things that you could do to
make this part of code do slightly better than stopping at the first
non-commit object:

 - pretend that the non-commit entry never existed in the first
   place and return the commit that appears in the reflog next.

 - fabricate a fake "commit" object that says "I am not a commit;
   I merely exist to represent that the reflog you are walking has
   this non-commit object at this point in the sequence" and return
   it, instead of giving NULL in the error path.

> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index b79049f..130d671 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -325,4 +325,17 @@ test_expect_success 'parsing reverse reflogs at BUFSIZ boundaries' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'no segfaults for reflog containing non-commit sha1s' '
> +	git update-ref --create-reflog -m "Creating ref" \
> +		refs/tests/tree-in-reflog HEAD &&
> +	git update-ref -m "Forcing tree" refs/tests/tree-in-reflog HEAD^{tree} &&
> +	git update-ref -m "Restoring to commit" refs/tests/tree-in-reflog HEAD &&
> +	git reflog refs/tests/tree-in-reflog
> +'
> +
> +test_expect_failure 'reflog containing non-commit sha1s displays fully' '
> +	git reflog refs/tests/tree-in-reflog > actual &&

Please write this without space after the redirection operator, i.e.

	git reflog refs/tests/tree-in-reflog >actual &&

> +	test_line_count = 3 actual
> +'
> +
>  test_done
