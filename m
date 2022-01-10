Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA276C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 22:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbiAJWJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 17:09:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56011 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240848AbiAJWJj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 17:09:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8DCAA187448;
        Mon, 10 Jan 2022 17:09:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=baZaKH70kdGE
        I93CGgM2X687Fij0KxNa/JDmClRghRI=; b=G54ZpPt3Eb2083Bhm1LCrL5na7Ir
        IPbIBgIVFIxvbPZA2+S6LqwKFy4ua+zlPSgyoySznzKVI9GVStY4c7jvx0gPpOLm
        xWfpA6zocp51f3bI3eu66Bk/X1XZC/EeX44UcVJXIYEeWZhnkYLtA+96pQsdV8by
        k4hLHbpMSltSZD0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8756E187447;
        Mon, 10 Jan 2022 17:09:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D21E4187445;
        Mon, 10 Jan 2022 17:09:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, reiter.christoph@gmail.com,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?utf-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Subject: Re: [PATCH] lazyload: use correct calling conventions
References: <pull.1181.git.git.1641657750776.gitgitgadget@gmail.com>
Date:   Mon, 10 Jan 2022 14:09:35 -0800
In-Reply-To: <pull.1181.git.git.1641657750776.gitgitgadget@gmail.com>
        ("Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget"'s message of "Sat, 08
 Jan 2022
        16:02:30 +0000")
Message-ID: <xmqqh7abxmxs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FFB01762-7261-11EC-84B3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dscho, how does this look?  My choices are

 - Waiting for review.
 - Will merge to 'next'.
 - Will merge to 'next' and then to 'master'.

The last one will make it as part of Git 2.35.0 final, unless there
is some unexpected breakage found later.

Thanks.

(no comment of my own appears after this line, but the original is
left as reference).

"Matthias A=C3=9Fhauer via GitGitGadget"  <gitgitgadget@gmail.com>
writes:

> From: =3D?UTF-8?q?Matthias=3D20A=3DC3=3D9Fhauer?=3D <mha1993@live.de>
>
> Christoph Reiter reported on the Git for Windows issue tracker[1], that
> mingw_strftime() imports strftime() from ucrtbase.dll with the wrong
> calling convention. It should be __cdecl instead of WINAPI, which we
> always use in DECLARE_PROC_ADDR().
>
> The MSYS2 project encountered cmake sefaults on x86 Windows caused by
> the same issue in the cmake source. [2] There are no known git crashes
> that where caused by this, yet, but we should try to prevent them.
>
> We import two other non-WINAPI functions via DECLARE_PROC_ADDR(), too.
>
> * NtSetSystemInformation() (NTAPI)
> * GetUserNameExW()         (SEC_ENTRY)
>
> NTAPI, SEC_ENTRY and WINAPI are all ususally defined as __stdcall,
> but there are circumstances where they're defined differently.
>
> Teach DECLARE_PROC_ADDR() about calling conventions and be explicit
> about when we want to use which calling convention.
>
> Import winnt.h for the definition of NTAPI and sspi.h for SEC_ENTRY
> near their respective only users.
>
> [1] https://github.com/git-for-windows/git/issues/3560
> [2] https://github.com/msys2/MINGW-packages/issues/10152
>
> Reported-By: Christoph Reiter <reiter.christoph@gmail.com>
> Signed-off-by: Matthias A=C3=9Fhauer <mha1993@live.de>
> ---
>     lazyload: use correct calling conventions
>    =20
>     I wanted to get this out a lot earlier, but got distracted by a lot=
 of
>     work at $DAYJOB. I'm sorry about sending this this late in the 2.35=
.0
>     cycle.
>    =20
>     This applies cleanly on master and maint, but CI produces some weir=
d
>     build failures that seem unrelated in both of those situations.
>    =20
>     On master the FreeBSD fails with
>    =20
>     > archive.c:337:35: error: '_Generic' is a C11 extension
>     > [-Werror,-Wc11-extensions] strbuf_addstr(&path_in_archive,
>     > basename(path)); ^ /usr/include/libgen.h:61:21: note: expanded fr=
om
>     > macro 'basename' #define basename(x) __generic(x, const char *,
>     > __old_basename, basename)(x) ^ /usr/include/sys/cdefs.h:329:2: no=
te:
>     > expanded from macro '__generic' _Generic(expr, t: yes, default: n=
o)
>    =20
>     While on maint the CI / linux32 (daald/ubuntu32:xenial) job just
>     straight up can't find make. I have no clue what's up with that, bu=
t I'm
>     fairly certain I'm not the direct cause of either of those failures=
.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1=
181%2Frimrul%2Fwin-lazyload-calling-convention-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1181=
/rimrul/win-lazyload-calling-convention-v1
> Pull-Request: https://github.com/git/git/pull/1181
>
>  compat/mingw.c                           | 6 ++++--
>  compat/win32/lazyload.h                  | 6 +++---
>  compat/win32/trace2_win32_process_info.c | 4 ++--
>  compat/winansi.c                         | 5 +++--
>  t/helper/test-drop-caches.c              | 4 +++-
>  5 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 9e0cd1e097f..f38c4381123 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -8,6 +8,8 @@
>  #include "win32/lazyload.h"
>  #include "../config.h"
>  #include "dir.h"
> +#define SECURITY_WIN32
> +#include <sspi.h>
> =20
>  #define HCAST(type, handle) ((type)(intptr_t)handle)
> =20
> @@ -1008,7 +1010,7 @@ size_t mingw_strftime(char *s, size_t max,
>  	/* a pointer to the original strftime in case we can't find the UCRT =
version */
>  	static size_t (*fallback)(char *, size_t, const char *, const struct =
tm *) =3D strftime;
>  	size_t ret;
> -	DECLARE_PROC_ADDR(ucrtbase.dll, size_t, strftime, char *, size_t,
> +	DECLARE_PROC_ADDR(ucrtbase.dll, size_t, __cdecl, strftime, char *, si=
ze_t,
>  		const char *, const struct tm *);
> =20
>  	if (INIT_PROC_ADDR(strftime))
> @@ -2183,7 +2185,7 @@ enum EXTENDED_NAME_FORMAT {
> =20
>  static char *get_extended_user_info(enum EXTENDED_NAME_FORMAT type)
>  {
> -	DECLARE_PROC_ADDR(secur32.dll, BOOL, GetUserNameExW,
> +	DECLARE_PROC_ADDR(secur32.dll, BOOL, SEC_ENTRY, GetUserNameExW,
>  		enum EXTENDED_NAME_FORMAT, LPCWSTR, PULONG);
>  	static wchar_t wbuffer[1024];
>  	DWORD len;
> diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
> index 2b3637135f6..f2bb96c89c7 100644
> --- a/compat/win32/lazyload.h
> +++ b/compat/win32/lazyload.h
> @@ -4,7 +4,7 @@
>  /*
>   * A pair of macros to simplify loading of DLL functions. Example:
>   *
> - *   DECLARE_PROC_ADDR(kernel32.dll, BOOL, CreateHardLinkW,
> + *   DECLARE_PROC_ADDR(kernel32.dll, BOOL, WINAPI, CreateHardLinkW,
>   *                     LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);
>   *
>   *   if (!INIT_PROC_ADDR(CreateHardLinkW))
> @@ -25,10 +25,10 @@ struct proc_addr {
>  };
> =20
>  /* Declares a function to be loaded dynamically from a DLL. */
> -#define DECLARE_PROC_ADDR(dll, rettype, function, ...) \
> +#define DECLARE_PROC_ADDR(dll, rettype, convention, function, ...) \
>  	static struct proc_addr proc_addr_##function =3D \
>  	{ #dll, #function, NULL, 0 }; \
> -	typedef rettype (WINAPI *proc_type_##function)(__VA_ARGS__); \
> +	typedef rettype (convention *proc_type_##function)(__VA_ARGS__); \
>  	static proc_type_##function function
> =20
>  /*
> diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/tr=
ace2_win32_process_info.c
> index 8ccbd1c2c6f..a53fd924340 100644
> --- a/compat/win32/trace2_win32_process_info.c
> +++ b/compat/win32/trace2_win32_process_info.c
> @@ -143,8 +143,8 @@ static void get_is_being_debugged(void)
>   */
>  static void get_peak_memory_info(void)
>  {
> -	DECLARE_PROC_ADDR(psapi.dll, BOOL, GetProcessMemoryInfo, HANDLE,
> -			  PPROCESS_MEMORY_COUNTERS, DWORD);
> +	DECLARE_PROC_ADDR(psapi.dll, BOOL, WINAPI, GetProcessMemoryInfo,
> +			  HANDLE, PPROCESS_MEMORY_COUNTERS, DWORD);
> =20
>  	if (INIT_PROC_ADDR(GetProcessMemoryInfo)) {
>  		PROCESS_MEMORY_COUNTERS pmc;
> diff --git a/compat/winansi.c b/compat/winansi.c
> index c27b20a79d9..4fceecf14ce 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -45,8 +45,9 @@ typedef struct _CONSOLE_FONT_INFOEX {
>  static void warn_if_raster_font(void)
>  {
>  	DWORD fontFamily =3D 0;
> -	DECLARE_PROC_ADDR(kernel32.dll, BOOL, GetCurrentConsoleFontEx,
> -			HANDLE, BOOL, PCONSOLE_FONT_INFOEX);
> +	DECLARE_PROC_ADDR(kernel32.dll, BOOL, WINAPI,
> +			GetCurrentConsoleFontEx, HANDLE, BOOL,
> +			PCONSOLE_FONT_INFOEX);
> =20
>  	/* don't bother if output was ascii only */
>  	if (!non_ascii_used)
> diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
> index 7b4278462bb..e37396dd9c2 100644
> --- a/t/helper/test-drop-caches.c
> +++ b/t/helper/test-drop-caches.c
> @@ -3,6 +3,7 @@
> =20
>  #if defined(GIT_WINDOWS_NATIVE)
>  #include "lazyload.h"
> +#include <winnt.h>
> =20
>  static int cmd_sync(void)
>  {
> @@ -86,7 +87,8 @@ static int cmd_dropcaches(void)
>  {
>  	HANDLE hProcess =3D GetCurrentProcess();
>  	HANDLE hToken;
> -	DECLARE_PROC_ADDR(ntdll.dll, DWORD, NtSetSystemInformation, INT, PVOI=
D, ULONG);
> +	DECLARE_PROC_ADDR(ntdll.dll, DWORD, NTAPI, NtSetSystemInformation, IN=
T, PVOID,
> +		ULONG);
>  	SYSTEM_MEMORY_LIST_COMMAND command;
>  	int status;
> =20
>
> base-commit: e9d7761bb94f20acc98824275e317fa82436c25d
