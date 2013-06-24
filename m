From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v14 16/16] test: run testcases with POSIX absolute paths
 on Windows
Date: Mon, 24 Jun 2013 20:56:21 +0200
Message-ID: <51C89655.4070208@kdbg.org>
References: <cover.1372087065.git.worldhello.net@gmail.com> <7b6237d76d53c240daf4641a00a09af5135fbba7.1372087065.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 20:56:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrBwF-0001Eu-0K
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 20:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553Ab3FXS41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 14:56:27 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:60450 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751344Ab3FXS40 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 14:56:26 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 71F87A7EB3;
	Mon, 24 Jun 2013 20:56:22 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id DBB9F19F5EE;
	Mon, 24 Jun 2013 20:56:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7b6237d76d53c240daf4641a00a09af5135fbba7.1372087065.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228898>

Am 24.06.2013 17:21, schrieb Jiang Xin:
> Add new subcommand "mingw_path" in test-path-utils, so that we can get
> the expected absolute paths on Windows. For example:
> 
>     COMMAND LINE                        Linux  Windows
>     ==================================  =====  ===============
>     test-path-utils mingw_path /        /      C:/msysgit
>     test-path-utils mingw_path /a/b/    /a/b/  C:/msysgit/a/b/
> 
> With this utility, most skipped test cases in t0060 can be runcorrectly
> on Windows.

Thanks for working on this. Did you have an opportunity to test on Windows?

> +mingw_path() {
> +	case $2 in
> +	NO_MINGW)
> +		echo "$1"
> +		;;
> +	*)
> +		test-path-utils mingw_path "$1"
> +		;;
> +	esac
> +}
> +
> +get_prereq_flag() {
> +	case $1 in
> +	POSIX)
> +		echo $1
> +		;;
> +	*)
> +		;;
> +	esac
> +}

It took me a while to notice that the token POSIX serves a different
purpose than NO_MINGW: POSIX is only needed to skip a test, NO_MINGW is
only used to avoid a test-path-utils call. The reason for the complexity
is that you put both tokens in the same parameter position in the
invocations of the test cases.

You use NO_MINGW only twice. I would just skip these two tests, then the
parameter position is reserved for the prerequisite, and things stay simple.

> +
>  norm_path() {
> -	test_expect_success $3 "normalize path: $1 => $2" \
> -	"test \"\$(test-path-utils normalize_path_copy '$1')\" = '$2'"
> +	expected=$(mingw_path "$2" "$3")
> +	prereq=$(get_prereq_flag $3)
> +	test_expect_success $prereq "normalize path: $1 => $2" \
> +	"test \"\$(test-path-utils normalize_path_copy '$1')\" = '$expected'"
>  }
>  
>  relative_path() {
> -	test_expect_success $4 "relative path: $1 $2 => $3" \
> -	"test \"\$(test-path-utils relative_path '$1' '$2')\" = '$3'"
> +	expected=$(mingw_path "$3" "$4")
> +	prereq=$(get_prereq_flag $4)
> +	test_expect_success $prereq "relative path: $1 $2 => $3" \
> +	"test \"\$(test-path-utils relative_path '$1' '$2')\" = '$expected'"
>  }
>  
>  # On Windows, we are using MSYS's bash, which mangles the paths.
> @@ -39,8 +64,8 @@ ancestor() {
>  	 test \"\$actual\" = '$expected'"
>  }
>  
> -# Absolute path tests must be skipped on Windows because due to path mangling
> -# the test program never sees a POSIX-style absolute path
> +# Some absolute path tests should be skipped on Windows due to path mangling
> +# on POSIX-style absolute paths
>  case $(uname -s) in
>  *MINGW*)
>  	;;
> @@ -73,10 +98,10 @@ norm_path d1/s1//../s2/../../d2 d2
>  norm_path d1/.../d2 d1/.../d2
>  norm_path d1/..././../d2 d1/d2
>  
> -norm_path / / POSIX
> -norm_path // / POSIX
> -norm_path /// / POSIX
> -norm_path /. / POSIX
> +norm_path / /
> +norm_path // / NO_MINGW
> +norm_path /// / NO_MINGW
> +norm_path /. /
>  norm_path /./ / POSIX
>  norm_path /./.. ++failed++ POSIX
>  norm_path /../. ++failed++ POSIX
> @@ -84,19 +109,19 @@ norm_path /./../.// ++failed++ POSIX
>  norm_path /dir/.. / POSIX
>  norm_path /dir/sub/../.. / POSIX
>  norm_path /dir/sub/../../.. ++failed++ POSIX
> -norm_path /dir /dir POSIX
> -norm_path /dir// /dir/ POSIX
> -norm_path /./dir /dir POSIX
> -norm_path /dir/. /dir/ POSIX
> -norm_path /dir///./ /dir/ POSIX
> -norm_path /dir//sub/.. /dir/ POSIX
> -norm_path /dir/sub/../ /dir/ POSIX
> +norm_path /dir /dir
> +norm_path /dir// /dir/
> +norm_path /./dir /dir
> +norm_path /dir/. /dir/
> +norm_path /dir///./ /dir/
> +norm_path /dir//sub/.. /dir/
> +norm_path /dir/sub/../ /dir/
>  norm_path //dir/sub/../. /dir/ POSIX
> -norm_path /dir/s1/../s2/ /dir/s2/ POSIX
> -norm_path /d1/s1///s2/..//../s3/ /d1/s3/ POSIX
> -norm_path /d1/s1//../s2/../../d2 /d2 POSIX
> -norm_path /d1/.../d2 /d1/.../d2 POSIX
> -norm_path /d1/..././../d2 /d1/d2 POSIX
> +norm_path /dir/s1/../s2/ /dir/s2/
> +norm_path /d1/s1///s2/..//../s3/ /d1/s3/
> +norm_path /d1/s1//../s2/../../d2 /d2
> +norm_path /d1/.../d2 /d1/.../d2
> +norm_path /d1/..././../d2 /d1/d2
>  
>  ancestor / / -1
>  ancestor /foo / 0
> @@ -197,8 +222,8 @@ relative_path /a	/a/b		../
>  relative_path /		/a/b/		../../
>  relative_path /a/c	/a/b/		../c
>  relative_path /a/c	/a/b		../c
> -relative_path /a/b	"<empty>"	/a/b	POSIX
> -relative_path /a/b 	"<null>"	/a/b	POSIX
> +relative_path /a/b	"<empty>"	/a/b
> +relative_path /a/b 	"<null>"	/a/b
>  relative_path "<empty>"	/a/b		./
>  relative_path "<empty>"	"<empty>"	./
>  relative_path "<empty>"	"<null>"	./
> diff --git a/test-path-utils.c b/test-path-utils.c
> index 95ef4..699ef 100644
> --- a/test-path-utils.c
> +++ b/test-path-utils.c
> @@ -116,6 +116,11 @@ int main(int argc, char **argv)
>  		return 0;
>  	}
>  
> +	if (argc == 3 && !strcmp(argv[1], "mingw_path")) {
> +		puts(argv[2]);
> +		return 0;
> +	}
> +
>  	if (argc == 4 && !strcmp(argv[1], "relative_path")) {
>  		struct strbuf sb = STRBUF_INIT;
>  		const char *abs, *base, *rel;
> 
