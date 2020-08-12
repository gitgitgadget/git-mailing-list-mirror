Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A31AC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 14:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D372A20885
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 14:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgHLOUA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:20:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:56370 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgHLOUA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 10:20:00 -0400
Received: (qmail 9133 invoked by uid 109); 12 Aug 2020 14:19:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Aug 2020 14:19:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31614 invoked by uid 111); 12 Aug 2020 14:19:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Aug 2020 10:19:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Aug 2020 10:19:58 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #01; Mon, 3)
Message-ID: <20200812141958.GA32453@coredump.intra.peff.net>
References: <xmqq8sevt1lf.fsf@gitster.c.googlers.com>
 <20200804185057.GA1400256@coredump.intra.peff.net>
 <xmqqr1sms0f0.fsf@gitster.c.googlers.com>
 <20200804192053.GA1400936@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2008121516560.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2008121516560.50@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 03:35:06PM +0200, Johannes Schindelin wrote:

> > That was my philosophy, too, but it's annoying in the meantime as I get
> > a notification for "your build is broken" every time I run CI. So it
> > becomes a game of chicken over who gets annoyed first. ;)
> 
> I am a bit sad to read all this, as I thought that we had reached
> consensus that the `Makefile` _is_ the source of truth.
> 
> But then, most of the source files that need to be compiled _are_ parsed
> from the Makefile.
> 
> So I wonder what problems you ran into; Maybe we can come up with a
> strategy how to preempt future instances of the same nature?

There are definitely a lot of lists that are copied from the Makefile
into CMakeLists. For some concrete data, here are the patches I needed
for two of my topics.

This first one is for a topic that remotes git-remote-testsvn and
associated code.

---
 contrib/buildsystems/CMakeLists.txt | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 4be61247e5..bdd3121a7c 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -502,7 +502,7 @@ unset(CMAKE_REQUIRED_INCLUDES)
 #programs
 set(PROGRAMS_BUILT
 	git git-bugreport git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
-	git-shell git-remote-testsvn)
+	git-shell)
 
 if(NOT CURL_FOUND)
 	list(APPEND excluded_progs git-http-fetch git-http-push)
@@ -568,12 +568,6 @@ parse_makefile_for_sources(libxdiff_SOURCES "XDIFF_OBJS")
 list(TRANSFORM libxdiff_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(xdiff STATIC ${libxdiff_SOURCES})
 
-#libvcs-svn
-parse_makefile_for_sources(libvcs-svn_SOURCES "VCSSVN_OBJS")
-
-list(TRANSFORM libvcs-svn_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
-add_library(vcs-svn STATIC ${libvcs-svn_SOURCES})
-
 if(WIN32)
 	if(NOT MSVC)#use windres when compiling with gcc and clang
 		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
@@ -660,9 +654,6 @@ if(CURL_FOUND)
 	endif()
 endif()
 
-add_executable(git-remote-testsvn ${CMAKE_SOURCE_DIR}/remote-testsvn.c)
-target_link_libraries(git-remote-testsvn common-main vcs-svn)
-
 set(git_builtin_extra
 	cherry cherry-pick format-patch fsck-objects
 	init merge-subtree restore show
@@ -838,26 +829,20 @@ if(BUILD_TESTING)
 add_executable(test-fake-ssh ${CMAKE_SOURCE_DIR}/t/helper/test-fake-ssh.c)
 target_link_libraries(test-fake-ssh common-main)
 
-add_executable(test-line-buffer ${CMAKE_SOURCE_DIR}/t/helper/test-line-buffer.c)
-target_link_libraries(test-line-buffer common-main vcs-svn)
-
-add_executable(test-svn-fe ${CMAKE_SOURCE_DIR}/t/helper/test-svn-fe.c)
-target_link_libraries(test-svn-fe common-main vcs-svn)
-
 #test-tool
 parse_makefile_for_sources(test-tool_SOURCES "TEST_BUILTINS_OBJS")
 
 list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/t/helper/")
 add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-tool_SOURCES})
 target_link_libraries(test-tool common-main)
 
-set_target_properties(test-fake-ssh test-line-buffer test-svn-fe test-tool
+set_target_properties(test-fake-ssh test-tool
 			PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/t/helper)
 
 if(MSVC)
-	set_target_properties(test-fake-ssh test-line-buffer test-svn-fe test-tool
+	set_target_properties(test-fake-ssh test-tool
 				PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/t/helper)
-	set_target_properties(test-fake-ssh test-line-buffer test-svn-fe test-tool
+	set_target_properties(test-fake-ssh test-tool
 				PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/helper)
 endif()
 
@@ -866,7 +851,7 @@ set(wrapper_scripts
 	git git-upload-pack git-receive-pack git-upload-archive git-shell git-remote-ext)
 
 set(wrapper_test_scripts
-	test-fake-ssh test-line-buffer test-svn-fe test-tool)
+	test-fake-ssh test-tool)
 
 
 foreach(script ${wrapper_scripts})
@@ -967,7 +952,6 @@ if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
 	file(COPY ${CMAKE_SOURCE_DIR}/mergetools/tkdiff DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
 	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-prompt.sh DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
 	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-completion.bash DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
-	file(COPY ${CMAKE_SOURCE_DIR}/contrib/svn-fe/svnrdump_sim.py DESTINATION ${CMAKE_BINARY_DIR}/contrib/svn-fe/)
 endif()
 
 file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")


It's mostly removal, which is nice, but I think it gives a pretty clear
example of how often lists from Makefile are replicated (and often
repeated in several spots within CMakeLists). I suspect most of these
lists could be pulled from the Makefile with a pre-processing step.

This second one is for a topic which moved some credential programs into
builtins (since they link libgit.a and nothing else, there's no reason
for them to take up extra space on disk). Even if we read more lists
from the Makefile, I think these hunks still would have needed to be
modified in CMakeLists because I changed the way they interact with
NO_UNIX_SOCKETS (instead of not building credential-cache in that case,
we get a builtin that says "sorry, this was built with
NO_UNIX_SOCKETS").

---
 contrib/buildsystems/CMakeLists.txt | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 47215df25b..4be61247e5 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -501,15 +501,9 @@ unset(CMAKE_REQUIRED_INCLUDES)
 
 #programs
 set(PROGRAMS_BUILT
-	git git-bugreport git-credential-store git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
+	git git-bugreport git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
 	git-shell git-remote-testsvn)
 
-if(NO_UNIX_SOCKETS)
-	list(APPEND excluded_progs git-credential-cache git-credential-cache--daemon)
-else()
-	list(APPEND PROGRAMS_BUILT git-credential-cache git-credential-cache--daemon)
-endif()
-
 if(NOT CURL_FOUND)
 	list(APPEND excluded_progs git-http-fetch git-http-push)
 	add_compile_definitions(NO_CURL)
@@ -633,9 +627,6 @@ target_link_libraries(git common-main)
 add_executable(git-bugreport ${CMAKE_SOURCE_DIR}/bugreport.c)
 target_link_libraries(git-bugreport common-main)
 
-add_executable(git-credential-store ${CMAKE_SOURCE_DIR}/credential-store.c)
-target_link_libraries(git-credential-store common-main)
-
 add_executable(git-daemon ${CMAKE_SOURCE_DIR}/daemon.c)
 target_link_libraries(git-daemon common-main)
 
@@ -672,15 +663,6 @@ endif()
 add_executable(git-remote-testsvn ${CMAKE_SOURCE_DIR}/remote-testsvn.c)
 target_link_libraries(git-remote-testsvn common-main vcs-svn)
 
-if(NOT NO_UNIX_SOCKETS)
-	add_executable(git-credential-cache ${CMAKE_SOURCE_DIR}/credential-cache.c)
-	target_link_libraries(git-credential-cache common-main)
-
-	add_executable(git-credential-cache--daemon ${CMAKE_SOURCE_DIR}/credential-cache--daemon.c)
-	target_link_libraries(git-credential-cache--daemon common-main)
-endif()
-
-
 set(git_builtin_extra
 	cherry cherry-pick format-patch fsck-objects
 	init merge-subtree restore show
