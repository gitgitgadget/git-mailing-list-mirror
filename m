From: Ian Hilt <Ian.Hilt@gmx.com>
Subject: Re: [PATCH] pre-commit hook should ignore carriage returns at EOL
Date: Tue, 24 Jun 2008 14:26:17 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-332828461-1214331985=:32759"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Christian Holtje <docwhat@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 20:27:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBDEd-0005vS-11
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 20:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847AbYFXS0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 14:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754824AbYFXS0U
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 14:26:20 -0400
Received: from mail.gmx.com ([74.208.5.67]:39413 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753231AbYFXS0T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 14:26:19 -0400
Received: (qmail invoked by alias); 24 Jun 2008 18:26:17 -0000
Received: from cpe-75-185-208-72.woh.res.rr.com (EHLO [192.168.1.1]) [75.185.208.72]
  by mail.gmx.com (mp-us004) with SMTP; 24 Jun 2008 14:26:17 -0400
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX1+uz7gzfGOuK9VrdbCmCT2bk7uytgcIOGM0CwYCBo
	Zk/2leS0xbjHcl
In-Reply-To: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86101>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-332828461-1214331985=:32759
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 24 Jun 2008 at 12:23pm -0400, Christian Holtje wrote:

> When commit files that use DOS style CRLF end-of-lines, the pre-commit
> hook would raise an error.  When combined with the fact that the hooks
> get activated by default on windows, it makes life difficult for
> people working with DOS files.
> 
> This patch causes the pre-commit hook to deal with crlf files
> correctly.
> 
> Signed-off-by: Christian H√∂ltje <docwhat@gmail.com>
> ---
> t/t7503-template-hook--pre-commit.sh |   75 ++++++++++++++++++++++++++++++++++
> templates/hooks--pre-commit          |   10 ++++-
> 2 files changed, 83 insertions(+), 2 deletions(-)
> create mode 100755 t/t7503-template-hook--pre-commit.sh
> 
> diff --git a/t/t7503-template-hook--pre-commit.sh
> b/t/t7503-template-hook--pre-commit.sh
> new file mode 100755
> index 0000000..8f0c3c9
> --- /dev/null
> +++ b/t/t7503-template-hook--pre-commit.sh
> @@ -0,0 +1,75 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2008 Christian H√∂ltje
> +#
> +
> +test_description='t7503 templates-hooks--pre-commit
> +
> +This test verifies that the pre-commit hook shipped with
> +git by default works correctly.
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'verify that autocrlf is unset' '
> +   if git config core.autocrlf
> +   then
> +     false
> +   else
> +     test $? -eq 1
> +   fi
> +'
> +
> +test_expect_success 'lf without hook' '
> +
> +	echo "foo" > lf.txt &&
> +	git add lf.txt &&
> +	git commit -m "lf without hook" lf.txt
> +
> +'
> +
> +test_expect_success 'crlf without hook' '
> +
> +	echo "foo\r" > crlf.txt &&

Perhaps you want to use printf "foo\r" instead?  echo "foo\r" does not
produce a CR on my system.

> +	git add crlf.txt &&
> +	git commit -m "crlf without hook" crlf.txt
> +
> +'
> +
> +# Set up the pre-commit hook.
> +HOOKDIR="$(git rev-parse --git-dir)/hooks"
> +mkdir -p "${HOOKDIR}"
> +cp -r "${HOOKDIR}-disabled/pre-commit" "${HOOKDIR}/pre-commit"
> +chmod +x "${HOOKDIR}/pre-commit"
> +
> +test_expect_success 'lf with hook' '
> +
> +	echo "bar" >> lf.txt &&
> +	git add lf.txt &&
> +	git commit -m "lf with hook" lf.txt
> +
> +'
> +test_expect_success 'crlf with hook' '
> +
> +	echo "bar\r" >> crlf.txt &&
> +	git add crlf.txt &&
> +	git commit -m "crlf with hook" crlf.txt
> +
> +'
> +
> +test_expect_success 'lf with hook white-space failure' '
> +
> +	echo "bar " >> lf.txt &&
> +	git add lf.txt &&
> +	! git commit -m "lf with hook" lf.txt
> +
> +'
> +test_expect_success 'crlf with hook white-space failure' '
> +
> +	echo "bar \r" >> crlf.txt &&
> +	git add crlf.txt &&
> +	! git commit -m "crlf with hook" crlf.txt
> +
> +'
> +
> +test_done
> diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
> index b25dce6..335ca09 100644
> --- a/templates/hooks--pre-commit
> +++ b/templates/hooks--pre-commit
> @@ -55,8 +55,14 @@ perl -e '
> 	if (s/^\+//) {
> 	    $lineno++;
> 	    chomp;
> -	    if (/\s$/) {
> -		bad_line("trailing whitespace", $_);
> +	    if (/\r$/) {

Wouldn't it be less redundant to do a test for \s\r$ here instead of
testing for \r$ and then \s\r$?

> +		if (/\s\r$/) {
> +		    bad_line("trailing whitespace", $_);
> +		}
> +	    } else {
> +		if (/\s$/) {
> +		    bad_line("trailing whitespace", $_);
> +		}
> 	    }
> 	    if (/^\s* \t/) {
> 		bad_line("indent SP followed by a TAB", $_);
> 

-- 
Ian Hilt
Ian.Hilt (at) gmx.com
GnuPG key: 0x4AFC1EE3
--8323328-332828461-1214331985=:32759--
