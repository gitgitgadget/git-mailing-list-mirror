From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH sb/diff-orderfile-config] diff test: reading a directory as a file need not error out
Date: Fri, 10 Jan 2014 15:30:11 -0800
Message-ID: <xmqq4n5b8lfg.fsf@gitster.dls.corp.google.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
	<1387411692-15562-3-git-send-email-naesten@gmail.com>
	<20140110201031.GI4776@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel Bronson <naesten@gmail.com>, git@vger.kernel.org,
	Anders Waldenborg <anders@0x63.nu>,
	Antoine Pelisse <apelisse@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 11 00:30:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1lXH-00008C-TM
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jan 2014 00:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758026AbaAJXaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 18:30:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35956 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757939AbaAJXa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 18:30:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D235462240;
	Fri, 10 Jan 2014 18:30:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oi6VprhYnryFCwBQOPq2uooGYtc=; b=VbQkr2
	5DtuSDnFXFYA1ush23wrtk+CvBfzcPDC3FLcMu2XnExMMp1dG46IqMM5emJD94iS
	Sad6phhb0UQdl9iXj7Ne05HniZEtKaHf07UwfMsRSbN3mxKYTNGsFlbclp455Eoi
	JdQH5Daf2T663oP3YTgG0bzYeLuxGgQeaBn3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lG8PrqI7lFrOsT2MZwkfrI1PT+n+v/k+
	EfT3gIG5k7nYQm+u9NNEfuWSHtvunsGF6/UNCjrWuG2xGYXdvmdIhs/S7sOGhRry
	M1LN+UDNh5SP7elEp6uUHvncbsKGUw0Z2ca2subgmukDXU7ru0xrP2od137C3Pkb
	heaosVqfobk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B4A06222F;
	Fri, 10 Jan 2014 18:30:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4A2B6221F;
	Fri, 10 Jan 2014 18:30:21 -0500 (EST)
In-Reply-To: <20140110201031.GI4776@google.com> (Jonathan Nieder's message of
	"Fri, 10 Jan 2014 12:10:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2C6333E8-7A4F-11E3-868F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240320>

Jonathan Nieder <jrnieder@gmail.com> writes:

> There is no guarantee that strbuf_read_file must error out for
> directories.  On some operating systems (e.g., Debian GNU/kFreeBSD
> wheezy), reading a directory gives its raw content:
>
> 	$ head -c5 < / | cat -A
> 	^AM-|^_^@^L$
>
> As a result, 'git diff -O/' succeeds instead of erroring out on
> these systems, causing t4056.5 "orderfile is a directory" to fail.
>
> On some weird OS it might even make sense to pass a directory to the
> -O option and this is not a common user mistake that needs catching.
> Remove the test.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Hi,
>
> t4056 is failing on systems using glibc with the kernel of FreeBSD[1]:
>
> | expecting success: 
> | 	test_must_fail git diff -O/ --name-only HEAD^..HEAD
> |
> | a.h
> | b.c
> | c/Makefile
> | d.txt
> | test_must_fail: command succeeded: git diff -O/ --name-only HEAD^..HEAD
> | not ok 5 - orderfile is a directory
>
> How about this patch?

Sounds sensible. Thanks.



> Thanks,
> Jonathan
>
> [1] https://buildd.debian.org/status/fetch.php?pkg=git&arch=kfreebsd-amd64&ver=1%3A2.0~next.20140107-1&stamp=1389379274
>
>  t/t4056-diff-order.sh | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
> index 1ddd226..9e2b29e 100755
> --- a/t/t4056-diff-order.sh
> +++ b/t/t4056-diff-order.sh
> @@ -68,10 +68,6 @@ test_expect_success POSIXPERM,SANITY 'unreadable orderfile' '
>  	test_must_fail git diff -Ounreadable_file --name-only HEAD^..HEAD
>  '
>  
> -test_expect_success 'orderfile is a directory' '
> -	test_must_fail git diff -O/ --name-only HEAD^..HEAD
> -'
> -
>  for i in 1 2
>  do
>  	test_expect_success "orderfile using option ($i)" '
