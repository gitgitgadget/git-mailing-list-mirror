From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] hash-object: add -v/--verbose option
Date: Mon, 02 Mar 2015 16:12:10 +0100
Message-ID: <54F47DCA.7020402@drmicha.warpmail.net>
References: <1425304500-14117-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Alexander Kuleshov <kuleshovmail@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 16:12:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSS13-00041K-15
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 16:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295AbbCBPMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 10:12:13 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54696 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754620AbbCBPMM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 10:12:12 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id D46A5209E1
	for <git@vger.kernel.org>; Mon,  2 Mar 2015 10:12:10 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 02 Mar 2015 10:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=eRiwFWOWdjG+6C0mjvhWrm
	+fhcw=; b=FGizUEFL80sUXjGL6ebC4Fo4yWw2Oa6cf0Xavzl+Z+NkOENrF5QQ2H
	xCXf7NeT0ynPs/sWv06zDgcuCy3DK7sq7RQI+vwgSpeGehCdIqkiIyAMQqGv4ino
	+BE2KWpDDNJHVJgsHtmTmNVJImCiPEbrH8yzrJlKr6KbgXOfXtYQE=
X-Sasl-enc: MBaJr5Mfywp//JD1Yt0EG2z13zhaxdq7ZerY+pqjcGnv 1425309131
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 598FEC002A2;
	Mon,  2 Mar 2015 10:12:11 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1425304500-14117-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264602>

Alexander Kuleshov venit, vidit, dixit 02.03.2015 14:55:
> This patch provides ability to pass -v/--verbose option to the
> git hash-object command. hash-object will print not only hash,
> but also file path of a file from what hash was calculated.
> 
> It can be useful in scripting, especially with --stdin-paths
> option.

Hmmm. You mean it's useful because -v would "dupe" the input stream as
one column in the output stream in this case? Hmmm.

> For example:
> 
> $ git hash-object -v test
> e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	test
> 
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  builtin/hash-object.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/hash-object.c b/builtin/hash-object.c
> index 207b90c..97961ee 100644
> --- a/builtin/hash-object.c
> +++ b/builtin/hash-object.c
> @@ -10,6 +10,8 @@
>  #include "parse-options.h"
>  #include "exec_cmd.h"
>  
> +static int verbose;
> +

Other flags are passed down as argument to hash_fd(). Is there a reason
this one has to be a (file) global?

>  /*
>   * This is to create corrupt objects for debugging and as such it
>   * needs to bypass the data conversion performed by, and the type
> @@ -43,7 +45,10 @@ static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
>  		die((flags & HASH_WRITE_OBJECT)
>  		    ? "Unable to add %s to database"
>  		    : "Unable to hash %s", path);
> -	printf("%s\n", sha1_to_hex(sha1));
> +	if (verbose)
> +		printf("%s\t%s\n", sha1_to_hex(sha1), path);
> +	else
> +		printf("%s\n", sha1_to_hex(sha1));
>  	maybe_flush_or_die(stdout, "hash to stdout");
>  }
>  
> @@ -79,7 +84,7 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
>  int cmd_hash_object(int argc, const char **argv, const char *prefix)
>  {
>  	static const char * const hash_object_usage[] = {
> -		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters] [--stdin] [--] <file>..."),
> +		N_("git hash-object [-t <type>] [-w] [-v] [--path=<file> | --no-filters] [--stdin] [--] <file>..."),
>  		N_("git hash-object  --stdin-paths < <list-of-paths>"),
>  		NULL
>  	};
> @@ -99,6 +104,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
>  		OPT_BOOL( 0, "literally", &literally, N_("just hash any random garbage to create corrupt objects for debugging Git")),
>  		OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),
> +		OPT__VERBOSE(&verbose, N_("show hash and file path")),
>  		OPT_END()
>  	};
>  	int i;
> @@ -108,6 +114,11 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, NULL, hash_object_options,
>  			     hash_object_usage, 0);
>  
> +	if (verbose & literally)
> +		errstr = "Can't use --verbose with --literally";
> +	else if (verbose & hashstdin)
> +		errstr = "Can't use --verbose with --stdin";
> +

I fail to see why those should be incompatible. All these modes just use
hash_fd() which you patch to show the 2nd column with -v.

[And we would write && here to be safe and make the intention clearer.]

>  	if (flags & HASH_WRITE_OBJECT) {
>  		prefix = setup_git_directory();
>  		prefix_length = prefix ? strlen(prefix) : 0;
> 
