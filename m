Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4C9C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00EA620774
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VNn2S0f/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgHMSBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:01:32 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53561 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSBc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 14:01:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4A30DFE0F;
        Thu, 13 Aug 2020 14:01:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FyRGtS3g6+e5u7A1fQ7JUa3PYxc=; b=VNn2S0
        f/nEiYLMk9UMknQ9BITiWvjPNia7N6Z+Vl9i0ODMWmlg4aPn/4XZs8ajcftco/Ro
        opc/orDKJuKhOFz882ywKWmaECbyrNiY9vq49RaecrVKnKOzY8g9phgdAinkWwEL
        iTiOes/4PLkuEZn6QIHRJBz8hQDvtMWwtafo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PcsMuohw6CtktTX+2MZ1hLeHTfI1izgV
        PNDBEN5sDqf01zc1McWntRpY1Q5VC0gaeFIt/40fSP6Cjyc1/NmsodMds+djWsIO
        5ZHGaqtpMaobpTI37mpSCNIJzyqfLfkNJ5T54gk4cOUXdexc4z3o+YaoTcJvr/+R
        LRQ2lrCcOvk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CD47BDFE0E;
        Thu, 13 Aug 2020 14:01:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1264CDFE0D;
        Thu, 13 Aug 2020 14:01:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 3/5] make git-bugreport a builtin
References: <20200813145515.GA891139@coredump.intra.peff.net>
        <20200813145936.GC891370@coredump.intra.peff.net>
Date:   Thu, 13 Aug 2020 11:01:23 -0700
In-Reply-To: <20200813145936.GC891370@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 13 Aug 2020 10:59:36 -0400")
Message-ID: <xmqqr1sa2znw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00C0B54E-DD8F-11EA-9CB6-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There's no reason that bugreport has to be a separate binary. And since
> it links against libgit.a, it has a rather large disk footprint. Let's
> make it a builtin, which reduces the size of a stripped installation
> from 24MB to 22MB.
>
> This also simplifies our Makefile a bit. And we can take advantage of
> builtin niceties like RUN_SETUP_GENTLY.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Makefile                            |  6 +-----
>  builtin.h                           |  1 +
>  bugreport.c => builtin/bugreport.c  | 10 +++-------
>  contrib/buildsystems/CMakeLists.txt |  5 +----
>  git.c                               |  1 +
>  5 files changed, 7 insertions(+), 16 deletions(-)
>  rename bugreport.c => builtin/bugreport.c (96%)

I am on the fence, as bugreport does not seem to be fully completed
part of the system.  The original thinking was that it may soon want
to grow by linking with platform specific libraries for lower-level
system characteristic identification, at which time we'd not want to
have it in builtins and "we can take advantage of builtin niceties"
will cause us regrets.  The only reason that hasn't happened as far
as I can see is because its development speed is rather slow.

So, I dunno.


> diff --git a/Makefile b/Makefile
> index 5b43c0fafb..acaff6968b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -671,7 +671,6 @@ EXTRA_PROGRAMS =
>  # ... and all the rest that could be moved out of bindir to gitexecdir
>  PROGRAMS += $(EXTRA_PROGRAMS)
>  
> -PROGRAM_OBJS += bugreport.o
>  PROGRAM_OBJS += daemon.o
>  PROGRAM_OBJS += fast-import.o
>  PROGRAM_OBJS += http-backend.o
> @@ -1041,6 +1040,7 @@ BUILTIN_OBJS += builtin/archive.o
>  BUILTIN_OBJS += builtin/bisect--helper.o
>  BUILTIN_OBJS += builtin/blame.o
>  BUILTIN_OBJS += builtin/branch.o
> +BUILTIN_OBJS += builtin/bugreport.o
>  BUILTIN_OBJS += builtin/bundle.o
>  BUILTIN_OBJS += builtin/cat-file.o
>  BUILTIN_OBJS += builtin/check-attr.o
> @@ -2458,10 +2458,6 @@ endif
>  git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
>  
> -git-bugreport$X: bugreport.o GIT-LDFLAGS $(GITLIBS)
> -	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> -		$(LIBS)
> -
>  git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
>  		$(IMAP_SEND_LDFLAGS) $(LIBS)
> diff --git a/builtin.h b/builtin.h
> index 4a0aed5448..1e78d6c142 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -119,6 +119,7 @@ int cmd_archive(int argc, const char **argv, const char *prefix);
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
>  int cmd_blame(int argc, const char **argv, const char *prefix);
>  int cmd_branch(int argc, const char **argv, const char *prefix);
> +int cmd_bugreport(int argc, const char **argv, const char *prefix);
>  int cmd_bundle(int argc, const char **argv, const char *prefix);
>  int cmd_cat_file(int argc, const char **argv, const char *prefix);
>  int cmd_checkout(int argc, const char **argv, const char *prefix);
> diff --git a/bugreport.c b/builtin/bugreport.c
> similarity index 96%
> rename from bugreport.c
> rename to builtin/bugreport.c
> index 09579e268d..9c920cc065 100644
> --- a/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -1,4 +1,4 @@
> -#include "cache.h"
> +#include "builtin.h"
>  #include "parse-options.h"
>  #include "strbuf.h"
>  #include "help.h"
> @@ -119,16 +119,14 @@ static void get_header(struct strbuf *buf, const char *title)
>  	strbuf_addf(buf, "\n\n[%s]\n", title);
>  }
>  
> -int cmd_main(int argc, const char **argv)
> +int cmd_bugreport(int argc, const char **argv, const char *prefix)
>  {
>  	struct strbuf buffer = STRBUF_INIT;
>  	struct strbuf report_path = STRBUF_INIT;
>  	int report = -1;
>  	time_t now = time(NULL);
>  	char *option_output = NULL;
>  	char *option_suffix = "%Y-%m-%d-%H%M";
> -	int nongit_ok = 0;
> -	const char *prefix = NULL;
>  	const char *user_relative_path = NULL;
>  
>  	const struct option bugreport_options[] = {
> @@ -139,8 +137,6 @@ int cmd_main(int argc, const char **argv)
>  		OPT_END()
>  	};
>  
> -	prefix = setup_git_directory_gently(&nongit_ok);
> -
>  	argc = parse_options(argc, argv, prefix, bugreport_options,
>  			     bugreport_usage, 0);
>  
> @@ -170,7 +166,7 @@ int cmd_main(int argc, const char **argv)
>  	get_system_info(&buffer);
>  
>  	get_header(&buffer, _("Enabled Hooks"));
> -	get_populated_hooks(&buffer, nongit_ok);
> +	get_populated_hooks(&buffer, !startup_info->have_repository);
>  
>  	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
>  	report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 4be61247e5..3e211606fd 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -501,7 +501,7 @@ unset(CMAKE_REQUIRED_INCLUDES)
>  
>  #programs
>  set(PROGRAMS_BUILT
> -	git git-bugreport git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
> +	git git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
>  	git-shell git-remote-testsvn)
>  
>  if(NOT CURL_FOUND)
> @@ -624,9 +624,6 @@ list(TRANSFORM git_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
>  add_executable(git ${CMAKE_SOURCE_DIR}/git.c ${git_SOURCES})
>  target_link_libraries(git common-main)
>  
> -add_executable(git-bugreport ${CMAKE_SOURCE_DIR}/bugreport.c)
> -target_link_libraries(git-bugreport common-main)
> -
>  add_executable(git-daemon ${CMAKE_SOURCE_DIR}/daemon.c)
>  target_link_libraries(git-daemon common-main)
>  
> diff --git a/git.c b/git.c
> index 39a160fa52..bf790e7f4f 100644
> --- a/git.c
> +++ b/git.c
> @@ -479,6 +479,7 @@ static struct cmd_struct commands[] = {
>  	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
>  	{ "blame", cmd_blame, RUN_SETUP },
>  	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
> +	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },
>  	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY | NO_PARSEOPT },
>  	{ "cat-file", cmd_cat_file, RUN_SETUP },
>  	{ "check-attr", cmd_check_attr, RUN_SETUP },
