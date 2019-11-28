Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC60DC432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 21:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E11D20880
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 21:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfK1VtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 16:49:04 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:49824 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbfK1VtD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 16:49:03 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47PB9Q2cnRz5tlB;
        Thu, 28 Nov 2019 22:48:58 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id CDBA71BFA;
        Thu, 28 Nov 2019 22:48:57 +0100 (CET)
Subject: Re: [PATCH 3/4] mingw: spawned processes need to inherit only
 standard handles
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.670.git.git.1574433665.gitgitgadget@gmail.com>
 <feb197792814701bf36cb15b73e1e73aae2baa4d.1574433665.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <00ef72f5-b1fa-f449-0e00-23713bed0187@kdbg.org>
Date:   Thu, 28 Nov 2019 22:48:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <feb197792814701bf36cb15b73e1e73aae2baa4d.1574433665.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

I'm sorry for being a bit slow lately. I found time to test this patch
only today.

Am 22.11.19 um 15:41 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> By default, CreateProcess() does not inherit any open file handles,
> unless the bInheritHandles parameter is set to TRUE. Which we do need to
> set because we need to pass in stdin/stdout/stderr to talk to the child
> processes. Sadly, this means that all file handles (unless marked via
> O_NOINHERIT) are inherited.
> 
> This lead to problems in VFS for Git, where a long-running read-object
> hook is used to hydrate missing objects, and depending on the
> circumstances, might only be called *after* Git opened a file handle.
> 
> Ideally, we would not open files without O_NOINHERIT unless *really*
> necessary (i.e. when we want to pass the opened file handle as standard
> handle into a child process), but apparently it is all-too-easy to
> introduce incorrect open() calls: this happened, and prevented updating
> a file after the read-object hook was started because the hook still
> held a handle on said file.
> 
> Happily, there is a solution: as described in the "Old New Thing"
> https://blogs.msdn.microsoft.com/oldnewthing/20111216-00/?p=8873 there
> is a way, starting with Windows Vista, that lets us define precisely
> which handles should be inherited by the child process.
> 
> And since we bumped the minimum Windows version for use with Git for
> Windows to Vista with v2.10.1 (i.e. a *long* time ago), we can use this
> method. So let's do exactly that.
> 
> We need to make sure that the list of handles to inherit does not
> contain duplicates; Otherwise CreateProcessW() would fail with
> ERROR_INVALID_ARGUMENT.
> 
> While at it, stop setting errno to ENOENT unless it really is the
> correct value.

I think the new code does not do that correctly. I observe a failure in
test #2 in t0061, which is this one:

test_expect_success 'start_command reports ENOENT (slash)' '
	test-tool run-command start-command-ENOENT ./does-not-exist 2>err &&
	test_i18ngrep "\./does-not-exist" err
'

It does not even get to test_i18ngrep (test-tool fails), and err
contains this:

error: cannot spawn ./does-not-exist: Result too large
FAIL start-command-ENOENT

That "Result too large" is ERANGE.

Don't you observe that, too? (I'm testing on Windows 10, BTW.)

I've done a bit of tracing, see below.

> 
> Also, fall back to not limiting handle inheritance under certain error
> conditions (e.g. on Windows 7, which is a lot stricter in what handles
> you can specify to limit to).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/mingw.c         | 120 +++++++++++++++++++++++++++++++++++++----
>  t/t0061-run-command.sh |   2 +-
>  2 files changed, 110 insertions(+), 12 deletions(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index fe609239dd..cac18cc3da 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1398,8 +1398,13 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
>  			      const char *dir,
>  			      int prepend_cmd, int fhin, int fhout, int fherr)
>  {
> -	STARTUPINFOW si;
> +	static int restrict_handle_inheritance = 1;
> +	STARTUPINFOEXW si;
>  	PROCESS_INFORMATION pi;
> +	LPPROC_THREAD_ATTRIBUTE_LIST attr_list = NULL;
> +	HANDLE stdhandles[3];
> +	DWORD stdhandles_count = 0;
> +	SIZE_T size;
>  	struct strbuf args;
>  	wchar_t wcmd[MAX_PATH], wdir[MAX_PATH], *wargs, *wenvblk = NULL;
>  	unsigned flags = CREATE_UNICODE_ENVIRONMENT;
> @@ -1435,11 +1440,23 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
>  		CloseHandle(cons);
>  	}
>  	memset(&si, 0, sizeof(si));
> -	si.cb = sizeof(si);
> -	si.dwFlags = STARTF_USESTDHANDLES;
> -	si.hStdInput = winansi_get_osfhandle(fhin);
> -	si.hStdOutput = winansi_get_osfhandle(fhout);
> -	si.hStdError = winansi_get_osfhandle(fherr);
> +	si.StartupInfo.cb = sizeof(si);
> +	si.StartupInfo.hStdInput = winansi_get_osfhandle(fhin);
> +	si.StartupInfo.hStdOutput = winansi_get_osfhandle(fhout);
> +	si.StartupInfo.hStdError = winansi_get_osfhandle(fherr);
> +
> +	/* The list of handles cannot contain duplicates */
> +	if (si.StartupInfo.hStdInput != INVALID_HANDLE_VALUE)
> +		stdhandles[stdhandles_count++] = si.StartupInfo.hStdInput;
> +	if (si.StartupInfo.hStdOutput != INVALID_HANDLE_VALUE &&
> +	    si.StartupInfo.hStdOutput != si.StartupInfo.hStdInput)
> +		stdhandles[stdhandles_count++] = si.StartupInfo.hStdOutput;
> +	if (si.StartupInfo.hStdError != INVALID_HANDLE_VALUE &&
> +	    si.StartupInfo.hStdError != si.StartupInfo.hStdInput &&
> +	    si.StartupInfo.hStdError != si.StartupInfo.hStdOutput)
> +		stdhandles[stdhandles_count++] = si.StartupInfo.hStdError;
> +	if (stdhandles_count)
> +		si.StartupInfo.dwFlags |= STARTF_USESTDHANDLES;
>  
>  	if (*argv && !strcmp(cmd, *argv))
>  		wcmd[0] = L'\0';
> @@ -1472,16 +1489,97 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
>  	wenvblk = make_environment_block(deltaenv);
>  
>  	memset(&pi, 0, sizeof(pi));
> -	ret = CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL, TRUE,
> -		flags, wenvblk, dir ? wdir : NULL, &si, &pi);
> +	if (restrict_handle_inheritance && stdhandles_count &&
> +	    (InitializeProcThreadAttributeList(NULL, 1, 0, &size) ||
> +	     GetLastError() == ERROR_INSUFFICIENT_BUFFER) &&
> +	    (attr_list = (LPPROC_THREAD_ATTRIBUTE_LIST)
> +			(HeapAlloc(GetProcessHeap(), 0, size))) &&
> +	    InitializeProcThreadAttributeList(attr_list, 1, 0, &size) &&
> +	    UpdateProcThreadAttribute(attr_list, 0,
> +				      PROC_THREAD_ATTRIBUTE_HANDLE_LIST,
> +				      stdhandles,
> +				      stdhandles_count * sizeof(HANDLE),
> +				      NULL, NULL)) {
> +		si.lpAttributeList = attr_list;
> +		flags |= EXTENDED_STARTUPINFO_PRESENT;
> +	}
> +
> +	ret = CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL,
> +			     stdhandles_count ? TRUE : FALSE,
> +			     flags, wenvblk, dir ? wdir : NULL,
> +			     &si.StartupInfo, &pi);
> +
> +	/*
> +	 * On Windows 2008 R2, it seems that specifying certain types of handles
> +	 * (such as FILE_TYPE_CHAR or FILE_TYPE_PIPE) will always produce an
> +	 * error. Rather than playing finicky and fragile games, let's just try
> +	 * to detect this situation and simply try again without restricting any
> +	 * handle inheritance. This is still better than failing to create
> +	 * processes.
> +	 */
> +	if (!ret && restrict_handle_inheritance && stdhandles_count) {
> +		DWORD err = GetLastError();

CreateProcessW failed, so we arrive here. At this point, err is 2
(ERROR_FILE_NOT_FOUND) as expected.

> +		struct strbuf buf = STRBUF_INIT;
> +
> +		if (err != ERROR_NO_SYSTEM_RESOURCES &&

Then this is true, ...

> +		    /*
> +		     * On Windows 7 and earlier, handles on pipes and character
> +		     * devices are inherited automatically, and cannot be
> +		     * specified in the thread handle list. Rather than trying
> +		     * to catch each and every corner case (and running the
> +		     * chance of *still* forgetting a few), let's just fall
> +		     * back to creating the process without trying to limit the
> +		     * handle inheritance.
> +		     */
> +		    !(err == ERROR_INVALID_PARAMETER &&
> +		      GetVersion() >> 16 < 9200) &&

... the bracketed expression is false, but it's negated, so it's true
again, ...

> +		    !getenv("SUPPRESS_HANDLE_INHERITANCE_WARNING")) {

... and the variable isn't set, so we continue here. (But I don't think
it is important.)

> +			DWORD fl = 0;
> +			int i;
> +
> +			setenv("SUPPRESS_HANDLE_INHERITANCE_WARNING", "1", 1);
> +
> +			for (i = 0; i < stdhandles_count; i++) {
> +				HANDLE h = stdhandles[i];
> +				strbuf_addf(&buf, "handle #%d: %p (type %lx, "
> +					    "handle info (%d) %lx\n", i, h,
> +					    GetFileType(h),
> +					    GetHandleInformation(h, &fl),
> +					    fl);
> +			}
> +			strbuf_addstr(&buf, "\nThis is a bug; please report it "
> +				      "at\nhttps://github.com/git-for-windows/"
> +				      "git/issues/new\n\n"
> +				      "To suppress this warning, please set "
> +				      "the environment variable\n\n"
> +				      "\tSUPPRESS_HANDLE_INHERITANCE_WARNING=1"
> +				      "\n");
> +		}
> +		restrict_handle_inheritance = 0;
> +		flags &= ~EXTENDED_STARTUPINFO_PRESENT;
> +		ret = CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL,
> +				     TRUE, flags, wenvblk, dir ? wdir : NULL,
> +				     &si.StartupInfo, &pi);

Then this one fails again (with GetLastError() == 2, too, as expected).

> +		if (ret && buf.len) {
> +			errno = err_win_to_posix(GetLastError());
> +			warning("failed to restrict file handles (%ld)\n\n%s",
> +				err, buf.buf);
> +		}
> +		strbuf_release(&buf);
> +	} else if (!ret)
> +		errno = err_win_to_posix(GetLastError());
> +
> +	if (si.lpAttributeList)
> +		DeleteProcThreadAttributeList(si.lpAttributeList);
> +	if (attr_list)
> +		HeapFree(GetProcessHeap(), 0, attr_list);
>  
>  	free(wenvblk);
>  	free(wargs);
>  
> -	if (!ret) {
> -		errno = ENOENT;
> +	if (!ret)
>  		return -1;

And then we take this error exist. At this point, GetLastError() == 0
(probably from the successful cleanup functions), but errno == 34
(ERANGE), probably a fallout from one of the xutftowcs that we do
earlier (I didn't check). The point is, we leave the function with a
failure indication, but without having set errno.

Any ideas?

And why don't you observe the failure? A coincidence?

> -	}
> +
>  	CloseHandle(pi.hThread);
>  
>  	/*
> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index 473a3405ef..7d599675e3 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -12,7 +12,7 @@ cat >hello-script <<-EOF
>  	cat hello-script
>  EOF
>  
> -test_expect_failure MINGW 'subprocess inherits only std handles' '
> +test_expect_success MINGW 'subprocess inherits only std handles' '
>  	test-tool run-command inherited-handle
>  '
>  
> 

-- Hannes
