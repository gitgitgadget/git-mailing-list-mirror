From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t6300: test sort with multiple keys
Date: Sun, 19 Aug 2012 17:38:29 -0700
Message-ID: <7vk3wuo0sa.fsf@alter.siamese.dyndns.org>
References: <e5b3ab37553f384235f3cb14e42f7e2b56507bde.1345410836.git.draenog@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 02:39:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3G1V-0005dn-VL
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 02:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab2HTAie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 20:38:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63777 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665Ab2HTAic (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 20:38:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D18639308;
	Sun, 19 Aug 2012 20:38:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1oZgtgzGBA30qXBvwjDn99fnS3E=; b=V49apH
	4laFLj2hhUmr9w4e8Bh/SYtRGZCiGK0Yra3fPiOEHt/qK3F5gq83JKKWwH4bG9qj
	XtVWPbBopSsTkdv9bhc41eaO0to196wAC6xU6CdUTnz4uEhoM+gz2aXbojkxfO1L
	XtsEy6PHxO3RCknN4ScFHBE6UaOAFjsMJpyA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ih5IkFrZLXeTdnQRhGriy7/6G2PYoG1c
	dYlGC9E8fUjxzFH//OaInGbACsNirggg0vzWUq7H8uh3Op5KFC0UqZK9Il2Tt8C+
	SEpKsf/BYu+wKpa1uASiFChNTCPC9sozKt4RYpHIRwuXynYgDIQN4coXyrE9eAkj
	dh3dIiPf4/4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFC229307;
	Sun, 19 Aug 2012 20:38:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07A809303; Sun, 19 Aug 2012
 20:38:30 -0400 (EDT)
In-Reply-To: <e5b3ab37553f384235f3cb14e42f7e2b56507bde.1345410836.git.draenog@pld-linux.org> (Kacper Kornet's message of "Sun, 19 Aug 2012 23:15:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D90CC4A-EA5F-11E1-9AAB-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203745>

Kacper Kornet <draenog@pld-linux.org> writes:

> Documentation of git-for-each-ref says that --sort=<key> option can be
> used multiple times, in which case the last key becomes the primary key.
> However this functionality was never checked in test suite and is
> currently broken. This commit adds appropriate test in preparation for fix.
>
> Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
> ---

Thanks.

> +test_expect_success 'Create branches to test sort with multiple keys' '
> +	git checkout -b Branch1 &&
> +	echo foo >> one &&
> +	git commit -a -m "Branch1 commit" &&
> +	git checkout -b Branch2 &&
> +	echo foo >> one &&
> +	git commit -a -m "Branch2 commit"
> +'
> +
> +test_atom refs/heads/Branch1 objectname 32fca05e9f638021a123a84226acf17756acc18b
> +test_atom refs/heads/Branch2 objectname 194a5b89ac661a114566ba4374bc06c2797539f3

Do these need to be "Branch[12]", not "branch[12]" for the code to
exhibit the bug?  If not, please don't be creative in names like
these.  On case corrupting filesystems you may write Branch1 and
they may come back as branch1, but that is not what we are testing
here.

Also, style: redirection sticks to the target file, e.g.

	echo foo >>one &&

> +
>  cat >expected <<\EOF
> +67a36f10722846e891fbada1ba48ed035de75581 commit	refs/heads/master
> +194a5b89ac661a114566ba4374bc06c2797539f3 commit	refs/heads/Branch2
> +32fca05e9f638021a123a84226acf17756acc18b commit	refs/heads/Branch1
> +EOF
> +
> +test_expect_failure 'Verify sort with multiple keys' '
> +	git for-each-ref --sort=objectname --sort=committerdate refs/heads > actual &&
> +	test_cmp expected actual
> +'
> +
> +cat >expected <<\EOF
> +'refs/heads/Branch1'
> +'refs/heads/Branch2'
>  'refs/heads/master'
>  'refs/remotes/origin/master'
>  'refs/tags/testtag'
> @@ -264,6 +289,8 @@ test_expect_success 'Quoting style: python' '
>  '
>  
>  cat >expected <<\EOF
> +"refs/heads/Branch1"
> +"refs/heads/Branch2"
>  "refs/heads/master"
>  "refs/remotes/origin/master"
>  "refs/tags/testtag"
> @@ -285,6 +312,8 @@ for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
>  done
>  
>  cat >expected <<\EOF
> +Branch1
> +Branch2
>  master
>  testtag
>  EOF
> @@ -296,6 +325,8 @@ test_expect_success 'Check short refname format' '
>  '
>  
>  cat >expected <<EOF
> +
> +
>  origin/master

What are these blank line outputs?

>  EOF
>  
> @@ -309,7 +340,7 @@ cat >expected <<EOF
>  EOF
>  
>  test_expect_success 'Check short objectname format' '
> -	git for-each-ref --format="%(objectname:short)" refs/heads >actual &&
> +	git for-each-ref --format="%(objectname:short)" refs/heads/master >actual &&
>  	test_cmp expected actual
>  '

All in all, I have to wonder if you can limit the updates to other
unrelated tests if you added a new test near the end.  Also doesn't
the existing test already create enough refs to let you sort with
multiple keys and demonstrate the breakage already, without adding
new refs and objects?
