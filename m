From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [patch 05/15] diff-test_cmp.patch
Date: Tue, 16 Mar 2010 00:21:01 -0700
Message-ID: <7veijkohpe.fsf@alter.siamese.dyndns.org>
References: <20100316054220.075676000@mlists.thewrittenword.com>
 <20100316054321.668397000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 08:21:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrR5Y-0002tM-VX
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 08:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937495Ab0CPHVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 03:21:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937471Ab0CPHVK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 03:21:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 72C38A2F63;
	Tue, 16 Mar 2010 03:21:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=2fqB38EjcIjcyKJh0DUBqRFIpfs=; b=pqMHdvWDHt3oPyix0VVDarJ
	+3Nz46rHDjDJPen2DXCkJn2exir6UzEjoLuUYR5VE/RhTIiKjg0oGaoqeI52WORm
	iL1eJ76Zxyw2Vab4H6YzXOuXooCaSE3I/7am32ZY4Kt86lv9e9BYHw1GL+84+H+T
	E5f15QMg+ZH39TQtmuEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=oFa/eDGhmuRSlAoflFFDacQ48TkxID0zyUuHYjtJEc4gHPM8b
	zS11hdGQxZUuo6AAZx/IBJiDpmFNbT/lEDeLKY5rJWmYSb3+ES1xA5FDDzv8BT9d
	t8VBO0U9HmV7347S/vK7wrXmX+jrnfhH+Vrj2zRGJIJ+edIp0xnCmRhqRI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C226A2F62;
	Tue, 16 Mar 2010 03:21:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C57CA2F61; Tue, 16 Mar
 2010 03:21:02 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7BCB8186-30CC-11DF-9D6F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142324>

"Gary V. Vaughan" <git@mlists.thewrittenword.com> writes:

> Index: b/t/t0000-basic.sh
> ===================================================================
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -280,7 +280,7 @@ $expectfilter >expected <<\EOF
>  EOF
>  test_expect_success \
>      'validate git diff-files output for a know cache/work tree state.' \
> -    'git diff-files >current && diff >/dev/null -b current expected'
> +    'git diff-files >current && test_cmp current expected >/dev/null'

The original says "compare ignoring whitespace changes" but the updated
one says "they must match literally".  Is this conversion safe?

For the purpose of debugging tests, I think it would be better to lose the
redirection into /dev/null.  If the test passes, we wouldn't see anything
anyway, and if the test fails, we would see what's different, and that
helps diagnosing the breakage.  For systems with implementations of diff
that is "-u" challenged, we could define test_cmp in terms of "diff -c"
instead of "cmp".

> Index: b/t/t9400-git-cvsserver-server.sh
> ===================================================================
> --- a/t/t9400-git-cvsserver-server.sh
> +++ b/t/t9400-git-cvsserver-server.sh
> @@ -226,7 +226,7 @@ test_expect_success 'gitcvs.ext.enabled 
>    'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
>     GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false &&
>     GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
> -   diff -q cvswork cvswork2'
> +   test_cmp cvswork cvswork2' >/dev/null

If the -q in the original really matters, then please add the redirection
to /dev/null only for test_cmp; never redirect the output from the entire
test_expect_success.  On the other hand, if -q does not matter the outcome
of the test, simply lose the "quiet".  We really should not care, and make
sure it is available easily to people who broke cvsserver and need to see
the difference between expected and actual results while debugging.

There are similar dubious conversions in your patch to this file.

> Index: b/t/Makefile
> ===================================================================
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -6,6 +6,7 @@
>  -include ../config.mak
>  
>  #GIT_TEST_OPTS=--verbose --debug
> +GIT_TEST_CMP ?= $(DIFF)

If this forces plain diff not more readable "diff -u" to everybody, that
sounds like a regression to me.

Other than that, the conversion in this patch looked sane.

Thanks.
