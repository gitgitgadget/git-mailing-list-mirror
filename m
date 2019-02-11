Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 103451F453
	for <e@80x24.org>; Mon, 11 Feb 2019 21:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfBKVnM (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 16:43:12 -0500
Received: from ikke.info ([178.21.113.177]:49500 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbfBKVnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 16:43:09 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 7C6CA4400C1; Mon, 11 Feb 2019 22:43:06 +0100 (CET)
Date:   Mon, 11 Feb 2019 22:43:06 +0100
From:   Kevin Daudt <me@ikke.info>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v3] utf8: handle systems that don't write BOM for UTF-16
Message-ID: <20190211214306.GB14229@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Rich Felker <dalias@libc.org>
References: <20190209200802.277139-1-sandals@crustytoothpaste.net>
 <20190211012639.579489-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211012639.579489-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 01:26:39AM +0000, brian m. carlson wrote:
> When serializing UTF-16 (and UTF-32), there are three possible ways to
> write the stream. One can write the data with a BOM in either big-endian
> or little-endian format, or one can write the data without a BOM in
> big-endian format.
> 
> Most systems' iconv implementations choose to write it with a BOM in
> some endianness, since this is the most foolproof, and it is resistant
> to misinterpretation on Windows, where UTF-16 and the little-endian
> serialization are very common. For compatibility with Windows and to
> avoid accidental misuse there, Git always wants to write UTF-16 with a
> BOM, and will refuse to read UTF-16 without it.
> 
> However, musl's iconv implementation writes UTF-16 without a BOM,
> relying on the user to interpret it as big-endian. This causes t0028 and
> the related functionality to fail, since Git won't read the file without
> a BOM.
> 
> Add a Makefile and #define knob, ICONV_OMITS_BOM, that can be set if the
> iconv implementation has this behavior. When set, Git will write a BOM
> manually for UTF-16 and UTF-32 and then force the data to be written in
> UTF-16BE or UTF-32BE. We choose big-endian behavior here because the
> tests use the raw "UTF-16" encoding, which will be big-endian when the
> implementation requires this knob to be set.
> 
> Update the tests to detect this case and write test data with an added
> BOM if necessary. Always write the BOM in the tests in big-endian
> format, since all iconv implementations that omit a BOM must use
> big-endian serialization according to the Unicode standard.
> 
> Preserve the existing behavior for systems which do not have this knob
> enabled, since they may use optimized implementations, including
> defaulting to the native endianness, which may improve performance.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Makefile                         |  7 +++++++
>  t/t0028-working-tree-encoding.sh | 30 +++++++++++++++++++++++++++---
>  utf8.c                           | 10 ++++++++++
>  3 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 571160a2c4..c6172450af 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -259,6 +259,10 @@ all::
>  # Define OLD_ICONV if your library has an old iconv(), where the second
>  # (input buffer pointer) parameter is declared with type (const char **).
>  #
> +# Define ICONV_OMITS_BOM if your iconv implementation does not write a
> +# byte-order mark (BOM) when writing UTF-16 or UTF-32 and always writes in
> +# big-endian format.
> +#
>  # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
>  #
>  # Define NO_R_TO_GCC_LINKER if your gcc does not like "-R/path/lib"
> @@ -1415,6 +1419,9 @@ ifndef NO_ICONV
>  		EXTLIBS += $(ICONV_LINK) -liconv
>  	endif
>  endif
> +ifdef ICONV_OMITS_BOM
> +	BASIC_CFLAGS += -DICONV_OMITS_BOM
> +endif
>  ifdef NEEDS_LIBGEN
>  	EXTLIBS += -lgen
>  endif
> diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
> index e58ecbfc44..8936ba6757 100755
> --- a/t/t0028-working-tree-encoding.sh
> +++ b/t/t0028-working-tree-encoding.sh
> @@ -6,6 +6,30 @@ test_description='working-tree-encoding conversion via gitattributes'
>  
>  GIT_TRACE_WORKING_TREE_ENCODING=1 && export GIT_TRACE_WORKING_TREE_ENCODING
>  
> +test_lazy_prereq NO_UTF16_BOM '
> +	test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) = 6
> +'
> +
> +test_lazy_prereq NO_UTF32_BOM '
> +	test $(printf abc | iconv -f UTF-8 -t UTF-32 | wc -c) = 12
> +'
> +
> +write_utf16 () {
> +	if test_have_prereq NO_UTF16_BOM
> +	then
> +		printf '\xfe\xff'
> +	fi &&
> +	iconv -f UTF-8 -t UTF-16
> +}
> +
> +write_utf32 () {
> +	if test_have_prereq NO_UTF32_BOM
> +	then
> +		printf '\x00\x00\xfe\xff'
> +	fi &&
> +	iconv -f UTF-8 -t UTF-32
> +}
> +
>  test_expect_success 'setup test files' '
>  	git config core.eol lf &&
>  
> @@ -13,8 +37,8 @@ test_expect_success 'setup test files' '
>  	echo "*.utf16 text working-tree-encoding=utf-16" >.gitattributes &&
>  	echo "*.utf16lebom text working-tree-encoding=UTF-16LE-BOM" >>.gitattributes &&
>  	printf "$text" >test.utf8.raw &&
> -	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
> -	printf "$text" | iconv -f UTF-8 -t UTF-32 >test.utf32.raw &&
> +	printf "$text" | write_utf16 >test.utf16.raw &&
> +	printf "$text" | write_utf32 >test.utf32.raw &&
>  	printf "\377\376"                         >test.utf16lebom.raw &&
>  	printf "$text" | iconv -f UTF-8 -t UTF-32LE >>test.utf16lebom.raw &&
>  
> @@ -223,7 +247,7 @@ test_expect_success ICONV_SHIFT_JIS 'check roundtrip encoding' '
>  
>  	text="hallo there!\nroundtrip test here!" &&
>  	printf "$text" | iconv -f UTF-8 -t SHIFT-JIS >roundtrip.shift &&
> -	printf "$text" | iconv -f UTF-8 -t UTF-16 >roundtrip.utf16 &&
> +	printf "$text" | write_utf16 >roundtrip.utf16 &&
>  	echo "*.shift text working-tree-encoding=SHIFT-JIS" >>.gitattributes &&
>  
>  	# SHIFT-JIS encoded files are round-trip checked by default...
> diff --git a/utf8.c b/utf8.c
> index 83824dc2f4..5d9a917bc8 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -568,6 +568,16 @@ char *reencode_string_len(const char *in, size_t insz,
>  		bom_str = utf16_be_bom;
>  		bom_len = sizeof(utf16_be_bom);
>  		out_encoding = "UTF-16BE";
> +#ifdef ICONV_OMITS_BOM
> +	} else if (same_utf_encoding("UTF-16", out_encoding)) {
> +		bom_str = utf16_be_bom;
> +		bom_len = sizeof(utf16_be_bom);
> +		out_encoding = "UTF-16BE";
> +	} else if (same_utf_encoding("UTF-32", out_encoding)) {
> +		bom_str = utf32_be_bom;
> +		bom_len = sizeof(utf32_be_bom);
> +		out_encoding = "UTF-32BE";
> +#endif
>  	}
>  
>  	conv = iconv_open(out_encoding, in_encoding);

With some additional fixes, this indeed does solve the issue for Alpine
Linux, thanks.

I had to fix the following as well:

iff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 8936ba6757..8491f216aa 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -148,8 +148,8 @@ do
        test_when_finished "rm -f crlf.utf${i}.raw lf.utf${i}.raw" &&
        test_when_finished "git reset --hard HEAD^" &&

-       cat lf.utf8.raw | iconv -f UTF-8 -t UTF-${i} >lf.utf${i}.raw &&
-       cat crlf.utf8.raw | iconv -f UTF-8 -t UTF-${i} >crlf.utf${i}.raw &&
+       cat lf.utf8.raw | eval "write_utf${i}" >lf.utf${i}.raw &&
+       cat crlf.utf8.raw | eval "write_utf${i}" >crlf.utf${i}.raw &&
        cp crlf.utf${i}.raw eol.utf${i} &&

        cat >expectIndexLF <<-EOF &&
