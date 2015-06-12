From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] fetch-pack: optionally save packs to disk
Date: Fri, 12 Jun 2015 08:22:50 +0200
Message-ID: <557A7ABA.2000404@kdbg.org>
References: <CAGZ79kaS4utvDbXOo7emmSUH6M-8LY-oA65Ss3PLDkFModkbSg@mail.gmail.com> <1434049168-10613-1-git-send-email-augie@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Augie Fackler <augie@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 08:23:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3IMm-0003c6-TT
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 08:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbbFLGW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 02:22:56 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:20942 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750808AbbFLGWz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 02:22:55 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3m7Bn80JZRz5tlM;
	Fri, 12 Jun 2015 08:22:51 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 2198C5252;
	Fri, 12 Jun 2015 08:22:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <1434049168-10613-1-git-send-email-augie@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271472>

Am 11.06.2015 um 20:59 schrieb Augie Fackler:
> When developing server software, it's often helpful to save a
> potentially-bogus pack for later analysis. This makes that trivial,
> instead of painful.

When you develop server software, shouldn't you test drive the server 
via the bare metal protocol anyway? That *is* painful, but unavoidable 
because you must harden the server against any garbage that a 
potentially malicous client could throw at it. Restricting yourself to a 
well-behaved client such as fetch-pack is only half the deal.

That said, I do think that fetch-pack could learn a mode that makes it 
easier to debug the normal behavior of a server (if such a mode is 
missing currently).

What is the problem with the current fetch-pack implementation? Does it 
remove a bogus packfile after download? Does it abort during download 
when it detects a broken packfile? Does --keep not do what you need?

Instead of your approach (which forks off tee to dump a copy of the 
packfile), would it not be simpler to add an option --debug-pack 
(probably not the best name) that skips the cleanup step when a broken 
packfile is detected and prints the name of the downloaded packfile?

> diff --git a/fetch-pack.c b/fetch-pack.c
> index a912935..fe6ba58 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -684,7 +684,7 @@ static int get_pack(struct fetch_pack_args *args,
>   	const char *argv[22];
>   	char keep_arg[256];
>   	char hdr_arg[256];
> -	const char **av, *cmd_name;
> +	const char **av, *cmd_name, *savepath;
>   	int do_keep = args->keep_pack;
>   	struct child_process cmd = CHILD_PROCESS_INIT;
>   	int ret;
> @@ -708,9 +708,8 @@ static int get_pack(struct fetch_pack_args *args,
>   	cmd.argv = argv;
>   	av = argv;
>   	*hdr_arg = 0;
> +	struct pack_header header;
>   	if (!args->keep_pack && unpack_limit) {
> -		struct pack_header header;
> -
>   		if (read_pack_header(demux.out, &header))
>   			die("protocol error: bad pack header");
>   		snprintf(hdr_arg, sizeof(hdr_arg),
> @@ -762,7 +761,44 @@ static int get_pack(struct fetch_pack_args *args,
>   		*av++ = "--strict";
>   	*av++ = NULL;
>
> -	cmd.in = demux.out;
> +	savepath = getenv("GIT_SAVE_FETCHED_PACK_TO");
> +	if (savepath) {
> +		struct child_process cmd2 = CHILD_PROCESS_INIT;
> +		const char *argv2[22];
> +		int pipefds[2];
> +		int e;
> +		const char **av2;
> +		cmd2.argv = argv2;
> +		av2 = argv2;
> +		*av2++ = "tee";
> +		if (*hdr_arg) {
> +			/* hdr_arg being nonempty means we already read the
> +			 * pack header from demux, so we need to drop a pack
> +			 * header in place for tee to append to, otherwise
> +			 * we'll end up with a broken pack on disk.
> +			 */

			/*
			 * Write multi-line comments
			 * like this (/* on its own line)
			 */

> +			int fp;
> +			struct sha1file *s;
> +			fp = open(savepath, O_CREAT | O_TRUNC | O_WRONLY, 0666);
> +			s = sha1fd_throughput(fp, savepath, NULL);
> +			sha1write(s, &header, sizeof(header));
> +			sha1flush(s);

Are you abusing sha1write() and sha1flush() to write a byte sequence to 
a file? Is write_in_full() not sufficient?

> +			close(fp);
> +			/* -a is supported by both GNU and BSD tee */
> +			*av2++ = "-a";
> +		}
> +		*av2++ = savepath;
> +		*av2++ = NULL;
> +		cmd2.in = demux.out;
> +		e = pipe(pipefds);
> +		if (e != 0)
> +			die("couldn't make pipe to save pack");

start_command() can create the pipe for you. Just say cmd2.out = -1.

> +		cmd2.out = pipefds[1];
> +		cmd.in = pipefds[0];
> +		if (start_command(&cmd2))
> +			die("couldn't start tee to save a pack");

When you call start_command(), you must also call finish_command(). 
start_command() prints an error message for you; you don't have to do 
that (the start_command() in the context below is a bad example).

> +	} else
> +		cmd.in = demux.out;
>   	cmd.git_cmd = 1;
>   	if (start_command(&cmd))
>   		die("fetch-pack: unable to fork off %s", cmd_name);
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 58207d8..bf4640d 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -82,11 +82,23 @@ test_expect_success 'fetch changes via http' '
>   	test_cmp file clone/file
>   '
>
> +test_expect_success 'fetch changes via http and save pack' '
> +	echo content >>file &&
> +	git commit -a -m two &&
> +	git push public &&
> +	GIT_SAVE_FETCHED_PACK_TO=saved.pack &&
> +	export GIT_SAVE_FETCHED_PACK_TO &&
> +	(cd clone && git pull) &&

This can be written as

	(
		cd clone &&
		GIT_SAVE_FETCHED_PACK_TO=../saved.pack git pull
	) &&

without 'export'.

> +	git index-pack clone/saved.pack
> +'
> +
>   cat >exp <<EOF
>   GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
>   POST /smart/repo.git/git-upload-pack HTTP/1.1 200
>   GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
>   POST /smart/repo.git/git-upload-pack HTTP/1.1 200
> +GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
> +POST /smart/repo.git/git-upload-pack HTTP/1.1 200
>   EOF
>   test_expect_success 'used upload-pack service' '
>   	sed -e "
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index bfdaf75..73f9e1c 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -40,6 +40,15 @@ test_expect_success C_LOCALE_OUTPUT 'output from clone' '
>   	test $(grep Clon output | wc -l) = 1
>   '
>
> +test_expect_success 'clone allows saving a pack' '
> +	rm -fr dst saved.pack &&
> +	GIT_SAVE_FETCHED_PACK_TO=saved.pack &&
> +	export GIT_SAVE_FETCHED_PACK_TO &&
> +	git clone -n "file://$(pwd)/src" dst >output 2>&1 &&

Same here.

> +	test -e saved.pack &&
> +	git index-pack saved.pack
> +'
> +
>   test_expect_success 'clone does not keep pack' '
>
>   	rm -fr dst &&
>

-- Hannes
