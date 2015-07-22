From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 8/9] tag.c: implement '--format' option
Date: Wed, 22 Jul 2015 21:38:34 +0200
Message-ID: <vpq7fpsnft1.fsf@anie.imag.fr>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
	<1437256837-13378-1-git-send-email-Karthik.188@gmail.com>
	<1437256837-13378-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 21:38:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHzqn-0001to-P0
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 21:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbbGVTil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 15:38:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50833 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154AbbGVTil (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 15:38:41 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6MJcWwP020565
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 22 Jul 2015 21:38:32 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6MJcY7j029974;
	Wed, 22 Jul 2015 21:38:34 +0200
In-Reply-To: <1437256837-13378-2-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 19 Jul 2015 03:30:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 22 Jul 2015 21:38:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6MJcWwP020565
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438198713.38818@aYmTnYO7tTU0FxRxtqx2EQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274461>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -13,7 +13,8 @@ SYNOPSIS
>  	<tagname> [<commit> | <object>]
>  'git tag' -d <tagname>...
>  'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
> -	[--column[=<options>] | --no-column] [--sort=<key>] [<pattern>...]
> +	[--column[=<options>] | --no-column] [--sort=<key>] [--format=<format>]
> +	[<pattern>...]
>  'git tag' -v <tagname>...
>  
>  DESCRIPTION
> @@ -155,6 +156,19 @@ This option is only applicable when listing tags without annotation lines.
>  	The object that the new tag will refer to, usually a commit.
>  	Defaults to HEAD.
>  
> +<format>::
> +	A string that interpolates `%(fieldname)` from the
> +	object pointed at by a ref being shown.  If `fieldname`
> +	is prefixed with an asterisk (`*`) and the ref points
> +	at a tag object, the value for the field in the object
> +	tag refers is used.  When unspecified, defaults to
> +	`%(objectname) SPC %(objecttype) TAB %(refname)`.

I think this last sentence is taken from for-each-ref where it is true,
but for 'git tag', the default is just %(refname:short), as written
here:

> -	else
> +	else if (!format)
>  		format = "%(refname:short)";

right?

> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1507,4 +1507,20 @@ EOF"
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '--format cannot be used with -n' '
> +	test_must_fail git tag -l -n4 --format="%(refname)"
> +'
> +
> +test_expect_success '--format should list tags as per format given' '
> +	cat >expect <<-\EOF &&
> +	foo1.10
> +	foo1.3
> +	foo1.6
> +	foo1.6-rc1
> +	foo1.6-rc2
> +	EOF
> +	git tag -l --format="%(refname)" "foo*" >actual &&
> +	test_cmp expect actual
> +'

This tests the pattern argument, but the the test still passes if I
remove the --format option, so it does not test what it claims.

Also, why does "git tag"'s %(refname) behave like "git for-each-ref"'s
%(refname:short)? I find it very confusing as I think --format's
argument should be interpreted the same way for all ref-listing
commands. Actually I didn't find a way to have "git tag" display the
full refname other than with --format "refs/tags/%(refname)".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
