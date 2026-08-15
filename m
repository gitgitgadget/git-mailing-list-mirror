Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293542AEF5
	for <git@vger.kernel.org>; Sat, 15 Aug 2026 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786801497; cv=none; b=L8BGtKNN3y219vz54v+RmwegOzEZRAgPHo/tzxE27SrkwwXHKh7YZTeKeNqpGLtaoHLurwSaa7pKMAmAE2L821IKy4RuM+UrE4eI+E34iV+8ZkSNHEXR3dkoxHI7H0473nH8nJsBQnvZyTuFXamfrAq812CF97DNVLUI/VnbJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786801497; c=relaxed/simple;
	bh=psRavPH1cPPvtqMKYbX+C+gucPNf24XSNh++7AL/duk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUkKvosUMQwxlKhM8WH/u90ksmap50nyuUFf/bu3dKqAS1zM9cVYzv92oofXjEb+P8UEwMT5UB0TxmTz9ND/we+ymV9QpDXfS+SFCLGs6m/dz3hVTGxvYK8ZukaGV/I1Lw2T0NQKJ1zbAbO0Qx2RkCW3bf4PQ+vz1gNXoNbx0wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.103] (unknown [89.144.223.124])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4hMgM14XtdzRnPn;
	Sat, 15 Aug 2026 15:44:45 +0200 (CEST)
Message-ID: <4f4129df-681f-4e99-8b1f-8bb96e206a2d@kdbg.org>
Date: Sat, 15 Aug 2026 15:44:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] mingw: rely on MSYS2's metadata instead of
 hard-coding it
Content-Language: en-US
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
 <pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
 <9de4ea7fc1d250e8e9dfae386424451242cb3daa.1786521173.git.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <9de4ea7fc1d250e8e9dfae386424451242cb3daa.1786521173.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 12.08.26 um 09:52 schrieb Johannes Schindelin via GitGitGadget:
> diff --git a/config.mak.uname b/config.mak.uname
> index 21f53e3f7e..3a90995587 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -465,14 +465,8 @@ ifeq ($(uname_S),Windows)
>  	GIT_VERSION := $(GIT_VERSION).MSVC
>  	pathsep = ;
>  	# Assume that this is built in Git for Windows' SDK
> -        ifeq (MINGW32,$(MSYSTEM))
> -		prefix = /mingw32
> -        else
> -                ifeq (CLANGARM64,$(MSYSTEM))
> -			prefix = /clangarm64
> -                else
> -			prefix = /mingw64
> -                endif
> +        ifneq (,$(MSYSTEM))
> +		prefix = $(MINGW_PREFIX)
>          endif
>  	# Prepend MSVC 64-bit tool-chain to PATH.
>  	#
> @@ -755,6 +749,10 @@ ifeq ($(uname_S),MINGW)
>  		BASIC_LDFLAGS += -Wl,--dynamicbase
>          endif
>          ifneq (,$(MSYSTEM))
> +                ifeq ($(MINGW_PREFIX),$(filter-out /%,$(MINGW_PREFIX)))
> +			# Override if empty or does not start with a slash
> +			MINGW_PREFIX := /$(shell echo '$(MSYSTEM)' | tr A-Z a-z)
> +                endif
>  		prefix = $(MINGW_PREFIX)
>  		HOST_CPU = $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
>  		BASIC_LDFLAGS += -Wl,--pic-executable

At this point, MINGW_PREFIX is only used to set prefix.

Only in 12/12 is the variable (and ENSURE_MSYSTEM_IS_SET) used to drive
C code. Therefore, it seems that the following hunks concerning the
CMake and meson build systems do not belong in this patch, yet, but only
in 12/12.

> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index a57c4b464f..7285bd9ac2 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -256,7 +256,14 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
>  				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
>  				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
>  				OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
> -				HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
> +				HAVE_WPGMPTR HAVE_RTLGENRANDOM)
> +	if(CMAKE_GENERATOR_PLATFORM STREQUAL "x64")
> +		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="MINGW64" MINGW_PREFIX="mingw64")
> +	elseif(CMAKE_GENERATOR_PLATFORM STREQUAL "arm64")
> +		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="CLANGARM64" MINGW_PREFIX="clangarm64")
> +	elseif(CMAKE_GENERATOR_PLATFORM STREQUAL "x86")
> +		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="MINGW32" MINGW_PREFIX="mingw32")
> +	endif()
>  	list(APPEND compat_SOURCES
>  		compat/mingw.c
>  		compat/winansi.c
> diff --git a/meson.build b/meson.build
> index 7073d5844d..a8aba81e29 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1318,7 +1318,6 @@ elif host_machine.system() == 'windows'
>  
>    libgit_c_args += [
>      '-DDETECT_MSYS_TTY',
> -    '-DENSURE_MSYSTEM_IS_SET',
>      '-DNATIVE_CRLF',
>      '-DNOGDI',
>      '-DNO_POSIX_GOODIES',
> @@ -1328,6 +1327,20 @@ elif host_machine.system() == 'windows'
>      '-D__USE_MINGW_ANSI_STDIO=0',
>    ]
>  
> +  msystem = get_option('msystem')
> +  if msystem != ''
> +    mingw_prefix = get_option('mingw_prefix')
> +    if mingw_prefix == ''
> +      mingw_prefix = msystem.to_lower()
> +    elif mingw_prefix.startswith('/')
> +      mingw_prefix = mingw_prefix.substring(1)
> +    endif
> +    libgit_c_args += [
> +      '-DENSURE_MSYSTEM_IS_SET="' + msystem + '"',
> +      '-DMINGW_PREFIX="' + mingw_prefix + '"'
> +    ]
> +  endif
> +
>    libgit_dependencies += compiler.find_library('ntdll')
>    libgit_include_directories += 'compat/win32'
>    if compiler.get_id() == 'msvc'
> diff --git a/meson_options.txt b/meson_options.txt
> index dc88f130d7..becf4689bf 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -21,6 +21,10 @@ option('runtime_prefix', type: 'boolean', value: false,
>    description: 'Resolve ancillary tooling and support files relative to the location of the runtime binary instead of hard-coding them into the binary.')
>  option('sane_tool_path', type: 'array', value: [],
>    description: 'An array of paths to pick up tools from in case the normal tools are broken or lacking.')
> +option('msystem', type: 'string', value: '',
> +  description: 'Fall-back on Windows when MSYSTEM is not set.')
> +option('mingw_prefix', type: 'string', value: '',
> +  description: 'Fall-back on Windows when MINGW_PREFIX is not set.')
>  
>  # Build information compiled into Git and other parts like documentation.
>  option('build_date', type: 'string', value: '',

-- Hannes

