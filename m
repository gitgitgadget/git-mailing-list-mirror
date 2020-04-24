Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3691C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98037206B9
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgDXRjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:39:32 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:41576 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgDXRjc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 13:39:32 -0400
Received: from [92.30.123.115] (helo=[192.168.1.39])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jS2II-00098E-A3; Fri, 24 Apr 2020 18:39:19 +0100
Subject: Re: [PATCH 6/8] cmake: support for building git on windows with mingw
To:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <d6c630028bf43ea74ef1ac3b60d49aea252b3f4b.1587700897.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <3fd87ba7-654c-ff5e-2951-7bbbe3c5d119@iee.email>
Date:   Fri, 24 Apr 2020 18:39:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d6c630028bf43ea74ef1ac3b60d49aea252b3f4b.1587700897.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sibi,

On 24/04/2020 05:01, Sibi Siddharthan via GitGitGadget wrote:
> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
>
> This patch facilitates building git on Windows with CMake using MinGW
>
> NOTE: The funtions unsetenv and hstrerror are not checked in Windows
> builds.
> Reasons
> NO_UNSETENV is not compatible with Windows builds.
> lines 262-264 compat/mingw.h
>
> compat/mingw.h(line 25) provides a definition of hstrerror which
> conflicts with the definition provided in
> git-compat-util.h(lines 733-736).
>
> To use CMake on Windows with MinGW do this:
> cmake `relative-path-to-srcdir` -G "MinGW Makefiles"
>
> Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> ---
>  CMakeLists.txt | 120 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 97 insertions(+), 23 deletions(-)
>
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 29a23eb11f7..d9eb1060390 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -13,9 +13,12 @@ project(git
>  	VERSION ${git_version}
>  	LANGUAGES C)
>  
> +
>  #TODO gitk git-gui gitweb
> +#TODO Enable NLS on windows natively
>  #TODO Add pcre support
>  
> +
>  include(CheckTypeSize)
>  include(CheckCSourceRuns)
>  include(CheckCSourceCompiles)
> @@ -31,6 +34,7 @@ find_package(EXPAT)
>  find_package(Iconv)
>  find_package(Intl)
>  
> +
>  if(NOT Intl_FOUND)
>  	add_compile_definitions(NO_GETTEXT)
>  	if(NOT Iconv_FOUND)
> @@ -53,6 +57,16 @@ if(Intl_FOUND)
>  endif()
>  
>  find_program(SH_EXE sh)
> +if(NOT SH_EXE)
> +	message(FATAL_ERROR "sh interpreter was not found in your path, please install one. On Windows you can get it from here https://gitforwindows.org/")
Either the error message or the web page it points to need to coordinate
on the 'sh interpreter' reference to help the script kiddies follow the
thread. At the moment there is no 'interp..' on the gitforwindows web
page. Would someone attempting to use cmake need to use the Download or
the Contribute buttons, or some other route to acquire the missing SH_EXE?

(this is also a context line in the next patch)
> +endif()
> +
> +if(WIN32)
> +	find_program(WINDRES_EXE windres)
> +	if(NOT WINDRES_EXE)
> +		message(FATAL_ERROR "Install windres on Windows for resource files")
> +	endif()
> +endif()
>  
>  find_program(MSGFMT_EXE msgfmt)
>  if(NOT MSGFMT_EXE)
> @@ -85,11 +99,39 @@ add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
>  			BINDIR="bin"
>  			GIT_BUILT_FROM_COMMIT="")
>  
> -set(FALLBACK_RUNTIME_PREFIX /home/$ENV{USER})
> -add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
> +if(WIN32)
> +	set(FALLBACK_RUNTIME_PREFIX /mingw64)
> +	add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
> +else()
> +	set(FALLBACK_RUNTIME_PREFIX /home/$ENV{USER})
> +	add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
> +endif()
>  
> -add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
> -list(APPEND compat_SOURCES unix-socket.c)
> +
> +#Platform Specific
> +if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
> +	include_directories(compat/win32)
> +	add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_UNIX_SOCKETS WIN32
> +				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
> +				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0 NO_ST_BLOCKS_IN_STRUCT_STAT
> +				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
> +				UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET)
> +	list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c compat/win32/path-utils.c
> +		compat/win32/pthread.c compat/win32mmap.c compat/win32/syslog.c
> +		compat/win32/trace2_win32_process_info.c compat/win32/dirent.c
> +		compat/nedmalloc/nedmalloc.c compat/strdup.c)
> +	set(NO_UNIX_SOCKETS 1)
> +
> +elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
> +	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
> +	list(APPEND compat_SOURCES unix-socket.c)
> +endif()
> +
> +if(WIN32)
> +	set(EXE_EXTENSION .exe)
> +else()
> +	set(EXE_EXTENSION)
> +endif()
>  
>  #header checks
>  check_include_file(libgen.h HAVE_LIBGEN_H)
> @@ -150,7 +192,12 @@ endif()
>  #function checks
>  set(function_checks
>  	strcasestr memmem strlcpy strtoimax strtoumax strtoull
> -	setenv  mkdtemp poll pread  memmem unsetenv hstrerror)
> +	setenv  mkdtemp poll pread  memmem)
> +
> +#unsetenv,hstrerror are incompatible with windows build
> +if(NOT WIN32)
> +	list(APPEND function_checks unsetenv hstrerror)
> +endif()
>  
>  foreach(f ${function_checks})
>  	string(TOUPPER ${f} uf)
> @@ -309,7 +356,13 @@ endif()
>  #programs
>  set(PROGRAMS_BUILT
>  	git git-bugreport git-credential-store git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
> -	git-shell git-remote-testsvn git-credential-cache git-credential-cache--daemon)
> +	git-shell git-remote-testsvn)
> +
> +if(NO_UNIX_SOCKETS)
> +	list(APPEND excluded_progs git-credential-cache git-credential-cache--daemon)
> +else()
> +	list(APPEND PROGRAMS_BUILT git-credential-cache git-credential-cache--daemon)
> +endif()
>  
>  if(NOT CURL_FOUND)
>  	list(APPEND excluded_progs git-http-fetch git-http-push)
> @@ -410,15 +463,34 @@ set(libvcs-svn_SOURCES
>  	vcs-svn/svndiff.c vcs-svn/svndump.c)
>  add_library(vcs-svn STATIC ${libvcs-svn_SOURCES})
>  
> +#add git.rc for gcc
> +if(WIN32)
> +	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
> +			COMMAND ${WINDRES_EXE} -O coff -DMAJOR=${PROJECT_VERSION_MAJOR} -DMINOR=${PROJECT_VERSION_MINOR}
> +				-DMICRO=${PROJECT_VERSION_PATCH} -DPATCHLEVEL=0 -DGIT_VERSION="\\\"${PROJECT_VERSION}.GIT\\\""
> +				-i ${CMAKE_SOURCE_DIR}/git.rc -o ${CMAKE_BINARY_DIR}/git.res
> +			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
> +			VERBATIM)
> +	add_custom_target(git-rc DEPENDS ${CMAKE_BINARY_DIR}/git.res)
> +endif()
> +
>  #link all required libraries to common-main
>  add_library(common-main OBJECT common-main.c)
> -target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES} pthread rt)
> +
> +target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES})
>  if(Intl_FOUND)
>  	target_link_libraries(common-main ${Intl_LIBRARIES})
>  endif()
>  if(Iconv_FOUND)
>  	target_link_libraries(common-main ${Iconv_LIBRARIES})
>  endif()
> +if(WIN32)
> +	target_link_libraries(common-main ws2_32 ntdll ${CMAKE_BINARY_DIR}/git.res)
> +	add_dependencies(common-main git-rc)
> +	target_link_options(common-main PUBLIC -municode -Wl,--nxcompat -Wl,--dynamicbase -Wl,--pic-executable,-e,mainCRTStartup)
> +elseif(UNIX)
> +	target_link_libraries(common-main pthread rt)
> +endif()
>  
>  
>  set(git_SOURCES
> @@ -501,11 +573,13 @@ endif()
>  add_executable(git-remote-testsvn remote-testsvn.c)
>  target_link_libraries(git-remote-testsvn common-main vcs-svn)
>  
> -add_executable(git-credential-cache credential-cache.c)
> -target_link_libraries(git-credential-cache common-main)
> +if(NOT NO_UNIX_SOCKETS)
> +	add_executable(git-credential-cache credential-cache.c)
> +	target_link_libraries(git-credential-cache common-main)
>  
> -add_executable(git-credential-cache--daemon credential-cache--daemon.c)
> -target_link_libraries(git-credential-cache--daemon common-main)
> +	add_executable(git-credential-cache--daemon credential-cache--daemon.c)
> +	target_link_libraries(git-credential-cache--daemon common-main)
> +endif()
>  
>  
>  set(git_builtin_extra
> @@ -517,16 +591,16 @@ set(git_builtin_extra
>  foreach(s ${git_SOURCES} ${git_builtin_extra})
>  	string(REPLACE "builtin/" "" s ${s})
>  	string(REPLACE ".c" "" s ${s})
> -	file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git git-${s})\n")
> -	list(APPEND git_links ${CMAKE_BINARY_DIR}/git-${s})
> +	file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git${EXE_EXTENSION} git-${s}${EXE_EXTENSION})\n")
> +	list(APPEND git_links ${CMAKE_BINARY_DIR}/git-${s}${EXE_EXTENSION})
>  endforeach()
>  
>  if(CURL_FOUND)
>  	set(remote_exes
>  		git-remote-https git-remote-ftp git-remote-ftps)
>  	foreach(s ${remote_exes})
> -		file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git-remote-http ${s})\n")
> -		list(APPEND git_http_links ${CMAKE_BINARY_DIR}/${s})
> +		file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git-remote-http${EXE_EXTENSION} ${s}${EXE_EXTENSION})\n")
> +		list(APPEND git_http_links ${CMAKE_BINARY_DIR}/${s}${EXE_EXTENSION})
>  	endforeach()
>  endif()
>  
> @@ -654,20 +728,20 @@ set(bin_links
>  	git-receive-pack git-upload-archive git-upload-pack)
>  
>  foreach(b ${bin_links})
> -install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/bin/${b})")
> +install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/bin/${b}${EXE_EXTENSION})")
>  endforeach()
>  
> -install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git)")
> -install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git-shell ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-shell)")
> +install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git${EXE_EXTENSION})")
> +install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git-shell${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-shell${EXE_EXTENSION})")
>  
>  foreach(b ${git_links})
>  	string(REPLACE "${CMAKE_BINARY_DIR}" "" b ${b})
> -	install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b})")
> +	install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b}${EXE_EXTENSION})")
>  endforeach()
>  
>  foreach(b ${git_http_links})
>  	string(REPLACE "${CMAKE_BINARY_DIR}" "" b ${b})
> -	install(CODE "file(CREATE_LINK  ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-remote-http ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b})")
> +	install(CODE "file(CREATE_LINK  ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-remote-http${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b}${EXE_EXTENSION})")
>  endforeach()
>  
>  install(PROGRAMS ${git_shell_scripts} ${git_perl_scripts} ${CMAKE_BINARY_DIR}/git-p4
> @@ -734,14 +808,14 @@ set(wrapper_test_scripts
>  foreach(script ${wrapper_scripts})
>  	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
>  	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
> -	string(REPLACE "@@PROG@@" "${script}" content "${content}")
> +	string(REPLACE "@@PROG@@" "${script}${EXE_EXTENSION}" content "${content}")
>  	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
>  endforeach()
>  
>  foreach(script ${wrapper_test_scripts})
>  	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
>  	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
> -	string(REPLACE "@@PROG@@" "t/helper/${script}" content "${content}")
> +	string(REPLACE "@@PROG@@" "t/helper/${script}${EXE_EXTENSION}" content "${content}")
>  	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
>  endforeach()
>  
> @@ -807,7 +881,7 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PTHREADS='${NO_PTHREADS}'\
>  file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_UNIX_SOCKETS='${NO_UNIX_SOCKETS}'\n")
>  file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PAGER_ENV='${PAGER_ENV}'\n")
>  file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "DC_SHA1='${DC_SHA1}'\n")
> -file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X=''\n")
> +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X='${EXE_EXTENSION}'\n")
>  file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n")
>  file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
>  file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")

