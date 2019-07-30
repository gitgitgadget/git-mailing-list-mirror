Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAD491F462
	for <e@80x24.org>; Tue, 30 Jul 2019 18:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfG3SKN (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 14:10:13 -0400
Received: from elephants.elehost.com ([216.66.27.132]:64217 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfG3SKN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 14:10:13 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x6UIA8Gg096824
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 14:10:08 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, <git-packagers@googlegroups.com>
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com> <xmqq7e7zton5.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7e7zton5.fsf@gitster-ct.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
Date:   Tue, 30 Jul 2019 14:10:02 -0400
Message-ID: <04a401d54702$05624290$1026c7b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIOLVcRtBsBNXlmTtIvSwfiR5E4KQFlKwmSpmZ/hMA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 30, 2019 1:32 PM, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> > t0066: dir-iterator
> >
> > Subtest 4 depends on a non-portable error code. ENOENT is not
> guaranteed ...
> > Subtest 5 also depends on a non-portable error code. ENOTDIR is not
gua...
> 
> Yikes, and sorry.  I've become somewhat complacent after relying on how
> good our other reviewers are, pretty much ignored the new code in fringes
> like t/helper/, and failed catch an obvious amateurish mistake like this
one.
> 
> I do not think of a portable way to map an int ENOENT to a string
"ENOENT",
> but there are only only two errors test-dir-iterator test code cares
about, so
> perhaps a patch like the following may be sufficient.
> 
> I wonder if a tool like sparse can help us catch a pattern that feeds
errno to
> "%d" format.
> 
>  t/helper/test-dir-iterator.c | 11 ++++++++++-
>  t/t0066-dir-iterator.sh      |  4 ++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
index
> a5b96cb0dc..c7c30664da 100644
> --- a/t/helper/test-dir-iterator.c
> +++ b/t/helper/test-dir-iterator.c
> @@ -4,6 +4,15 @@
>  #include "iterator.h"
>  #include "dir-iterator.h"
> 
> +static const char *error_name(int error_number) {
> +	switch (error_number) {
> +	case ENOENT: return "ENOENT";
> +	case ENOTDIR: return "ENOTDIR";
> +	default: return "ESOMETHINGELSE";
> +	}
> +}
> +
>  /*
>   * usage:
>   * tool-test dir-iterator [--follow-symlinks] [--pedantic] directory_path
@@ -
> 31,7 +40,7 @@ int cmd__dir_iterator(int argc, const char **argv)
>  	diter = dir_iterator_begin(path.buf, flags);
> 
>  	if (!diter) {
> -		printf("dir_iterator_begin failure: %d\n", errno);
> +		printf("dir_iterator_begin failure: %s\n",
error_name(errno));
>  		exit(EXIT_FAILURE);
>  	}
> 
> diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh index
> 9354d3f1ed..92910e4e6c 100755
> --- a/t/t0066-dir-iterator.sh
> +++ b/t/t0066-dir-iterator.sh
> @@ -55,13 +55,13 @@ test_expect_success 'dir-iterator should list files in
> the correct order' '
>  test_expect_success 'begin should fail upon inexistent paths' '
>  	test_must_fail test-tool dir-iterator ./inexistent-path \
>  		>actual-inexistent-path-output &&
> -	echo "dir_iterator_begin failure: 2" >expected-inexistent-path-
> output &&
> +	echo "dir_iterator_begin failure: ENOENT"
> +>expected-inexistent-path-output &&
>  	test_cmp expected-inexistent-path-output actual-inexistent-path-
> output  '
> 
>  test_expect_success 'begin should fail upon non directory paths' '
>  	test_must_fail test-tool dir-iterator ./dir/b >actual-non-dir-output
> &&
> -	echo "dir_iterator_begin failure: 20" >expected-non-dir-output &&
> +	echo "dir_iterator_begin failure: ENOTDIR" >expected-non-dir-
> output &&
>  	test_cmp expected-non-dir-output actual-non-dir-output  '
> 

Seems reasonable. Better than trying to use strerror(), which previously
(I'm not sure whether it was this project or another) had a similar mapping
issue because the error text does not match either.

