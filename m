From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] git-svn: Support for git-svn propset
Date: Sun, 07 Dec 2014 06:45:12 +0100
Message-ID: <5483E968.6060708@web.de>
References: <20141206222942.GB91825@elvis.mu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Michael G. Schwern" <schwern@pobox.com>,
	David Fraser <davidf@sjsoft.com>
To: Alfred Perlstein <alfred@freebsd.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 07 06:45:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxUf7-0006Bi-8u
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 06:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbaLGFpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2014 00:45:36 -0500
Received: from mout.web.de ([212.227.17.12]:58330 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbaLGFpg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2014 00:45:36 -0500
Received: from macce.local ([78.72.72.190]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LtWwK-1XpYdy0OV2-010x6k; Sun, 07 Dec 2014 06:45:14
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141206222942.GB91825@elvis.mu.org>
X-Provags-ID: V03:K0:/MsH1omWUIZO6XbBPsk+ckl1n9LwvLDBzFHUJk/47ObCNROyoEi
 vQtFv1brOn0kuZrM5f6AgfHZDDzzUI4xOBDQSDRLjTHlh/9oRisdN3HccFmbgcW2y5Pkdod
 SIa5rjZDZmknTJih6SpvRB+I1CtVGgZlbnQVVzgLEUGKXWisoK8l5Idn7ca7dsR824vOR/T
 gTpiOvCXrI0wbtDWM3JEg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260971>


> diff --git a/t/t9148-git-svn-propset.sh b/t/t9148-git-svn-propset.sh
> new file mode 100755
> index 0000000..b36a8a2
> --- /dev/null
> +++ b/t/t9148-git-svn-propset.sh
> @@ -0,0 +1,71 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2014 Alfred Perlstein
> +#
> +
> +test_description='git svn propset tests'
> +
> +. ./lib-git-svn.sh
> +
> +foo_subdir2="subdir/subdir2/foo_subdir2"
> +
In case something goes wrong (for whatever reason):
do we need a && chain here ?
> +mkdir import
> +(cd import
> +	mkdir subdir
> +	mkdir subdir/subdir2
> +	touch foo		# for 'add props top level'
"touch foo" can be written shorter:
>foo

> +	touch subdir/foo_subdir # for 'add props relative'
> +	touch "$foo_subdir2"	# for 'add props subdir'
> +	svn_cmd import -m 'import for git svn' . "$svnrepo" >/dev/null
> +)
> +rm -rf import
> +

> +test_expect_success 'initialize git svn' 'git svn init "$svnrepo"'
> +test_expect_success 'fetch revisions from svn' 'git svn fetch'
This may look a little bit strange, 2 times test_expect_success in a row,
is the indentention OK ?
> +
> +# There is a bogus feature about svn propset which means that it will only
> +# be taken as a delta for svn dcommit iff the file is also modified.
> +# That is fine for now.
"there is a bogus feature ?"
Small typo: s/iff/if/
How about this:
#The current implementation has a restriction:
#svn propset will be taken as a delta for svn dcommit only
#if the file content is also modified

> +test_expect_success 'add props top level' '
> +	git svn propset svn:keywords "FreeBSD=%H" foo &&
> +	echo hello >> foo &&
> +	git commit -m "testing propset" foo &&
> +	git svn dcommit
> +	svn_cmd co "$svnrepo" svn_project &&
> +	(cd svn_project && test "`svn propget svn:keywords foo`" = "FreeBSD=%H") &&
> +	rm -rf svn_project
> +	'
Is there a reason why there is no "&&" after "git svn dcommit" ?
If yes, it could be better to make this really clear to the readers and write
(This idea is stolen from Peff)

{ git svn dcommit || true } &&

> +
> +test_expect_success 'add multiple props' '
> +	git svn propset svn:keywords "FreeBSD=%H" foo &&
> +	git svn propset fbsd:nokeywords yes foo &&
> +	echo hello >> foo &&
> +	git commit -m "testing propset" foo &&
> +	git svn dcommit
> +	svn_cmd co "$svnrepo" svn_project &&
> +	(cd svn_project && test "`svn propget svn:keywords foo`" = "FreeBSD=%H") &&
> +	(cd svn_project && test "`svn propget fbsd:nokeywords foo`" = "yes") &&
> +	(cd svn_project && test "`svn proplist -q foo | wc -l`" -eq 2) &&
> +	rm -rf svn_project
> +	'
> +
Ah, another small thing:
the "wc -l" will not work under Mac OS X.
Please see test_line_count() in t/test-lib-functions.sh

And thanks for improving Git
