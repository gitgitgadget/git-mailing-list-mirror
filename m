From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC PATCHv4] repack: rewrite the shell script in C.
Date: Wed, 21 Aug 2013 11:20:03 +0200
Message-ID: <52148643.2050706@kdbg.org>
References: <1376864786-21367-1-git-send-email-stefanbeller@googlemail.com> <1376954619-24314-1-git-send-email-stefanbeller@googlemail.com> <52136F9C.6030308@kdbg.org> <52138686.1070304@googlemail.com> <5213BC0C.6090901@web.de> <5213EF74.7020408@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
	git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com, mackyle@gmail.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 11:20:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VC4aV-0005Hk-Es
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 11:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512Ab3HUJUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 05:20:16 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:26739 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751422Ab3HUJUP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 05:20:15 -0400
Received: from [10.67.203.136] (178.115.251.136.wireless.dyn.drei.com [178.115.251.136])
	by bsmtp.bon.at (Postfix) with ESMTP id 803B2CDF92;
	Wed, 21 Aug 2013 11:20:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <5213EF74.7020408@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232696>

Am 21.08.2013 00:36, schrieb Stefan Beller:
> I think I got all the suggestions except the
> use of git_path/mkpathdup.
> I replaced mkpathdup by mkpath where possible,
> but it's still not perfect.
> I'll wait for the dokumentation patch of Jonathan,
> before changing all these occurences forth and back
> again.

I trust Jonathan's judgement of how to use git_path, mkpath, and mkpathdup 
more than my own. So, please take my earlier comments in this regard with 
an appropriately large grain of salt.

> Below there is just the diff against RFC PATCHv4,
> however I'll send the whole patch as well.

Thanks, that is VERY helpful!

I'll comment here and have a look at the full patch later.

>...
>   int cmd_repack(int argc, const char **argv, const char *prefix) {
>

You should move the opening brace to the next line, which would then not 
be empty anymore.

>...
> @@ -217,34 +217,34 @@ int cmd_repack(int argc, const char **argv, const char *prefix) {
>   	argv_array_push(&cmd_args, packtmp);
>
>   	memset(&cmd, 0, sizeof(cmd));
> -	cmd.argv = argv_array_detach(&cmd_args, NULL);
> +	cmd.argv = cmd_args.argv;
>   	cmd.git_cmd = 1;
>   	cmd.out = -1;
>   	cmd.no_stdin = 1;
>
> -	if (run_command(&cmd))
> +	if (start_command(&cmd))
>   		return 1;

You should have an int ret here and use it like

	ret = start_command(&cmd);
	if (ret)
		return ret;

to retain any exit codes from the sub-process. I know, the script didn't 
preserve it:

	names=$(git pack-objects ...) || exit 1

but that was not idiomatic as it should have been written as

	names=$(git pack-objects ...) || exit

to forward the failure exit code.

>
> -	struct string_list names = STRING_LIST_INIT_DUP;
> -	struct string_list rollback = STRING_LIST_INIT_DUP;
> -
> -	char line[1024];
> -	int counter = 0;
> -	FILE *out = xfdopen(cmd.out, "r");

Nice! I missed these decl-after-stmt in my earlier review.

> +	count_packs = 0;
> +	out = xfdopen(cmd.out, "r");
>   	while (fgets(line, sizeof(line), out)) {
>   		/* a line consists of 40 hex chars + '\n' */
> -		assert(strlen(line) == 41);
> +		if (strlen(line) != 41)
> +			die("repack: Expecting 40 character sha1 lines only from pack-objects.");

I agree with Jonathan that you should use strbuf_getline() here.

>   		line[40] = '\0';
>   		string_list_append(&names, line);
> -		counter++;
> +		count_packs++;
>   	}
> -	if (!counter)
> -		printf("Nothing new to pack.\n");
> +	if (finish_command(&cmd))
> +		return 1;

Same as above here:

	ret = finish_command(&cmd);
	if (ret)
		return ret;

I would prefer to see

	argv_array_clear(&cmd_args);

here, i.e., at the end of the current use rather than later at the 
beginning of the next use. (Ditto for the other uses of cmd_args.)

>   	fclose(out);

This should happen before finish_command(). It doesn't matter if there are 
no errors, but if things go awry, closing the channel before 
finish_command() avoids deadlocks.

>
> +	if (!count_packs && !quiet)
> +		printf("Nothing new to pack.\n");
> +
>...
> @@ -301,33 +299,33 @@ int cmd_repack(int argc, const char **argv, const char *prefix) {
>   	for_each_string_list_item(item, &names) {
>   		for (ext = 0; ext < 2; ext++) {
>   			char *fname, *fname_old;
> +			struct stat statbuffer;
>   			fname = mkpathdup("%s/pack-%s%s", packdir, item->string, exts[ext]);
> -			fname_old = mkpathdup("%s-%s%s", packtmp, item->string, exts[ext]);
> -			stat(fname_old, &statbuffer);
> -			statbuffer.st_mode &= ~S_IWUSR | ~S_IWGRP | ~S_IWOTH;
> -			chmod(fname_old, statbuffer.st_mode);
> +			fname_old = mkpath("%s-%s%s", packtmp, item->string, exts[ext]);
> +			if (!stat(fname_old, &statbuffer)) {
> +				statbuffer.st_mode &= ~S_IWUSR | ~S_IWGRP | ~S_IWOTH;

This is still wrong: it should be one of

			... &= ~S_IWUSR & ~S_IWGRP & ~S_IWOTH;
			... &= ~(S_IWUSR | S_IWGRP | S_IWOTH);

> +				chmod(fname_old, statbuffer.st_mode);
> +			}
>   			if (rename(fname_old, fname))
> -				die("Could not rename packfile: %s -> %s", fname_old, fname);
> +				die_errno(_("renaming '%s' failed"), fname_old);
>   			free(fname);
> -			free(fname_old);
>   		}
>   	}
>...

Everything else looks OK. But as I said, mkpath() may have to be reverted 
to mkpathdup() as per Jonathans comments.

-- Hannes
