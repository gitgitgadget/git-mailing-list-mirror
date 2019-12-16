Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1701C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 19:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7E4207FF
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 19:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfLPTUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:20:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:47914 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726191AbfLPTUP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 14:20:15 -0500
Received: (qmail 25995 invoked by uid 109); 16 Dec 2019 19:20:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Dec 2019 19:20:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14286 invoked by uid 111); 16 Dec 2019 19:24:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Dec 2019 14:24:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Dec 2019 14:20:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] Makefile: drop GEN_HDRS
Message-ID: <20191216192014.GA2678964@coredump.intra.peff.net>
References: <xmqq1rt7hkp6.fsf@gitster-ct.c.googlers.com>
 <20191214003820.GA927924@coredump.intra.peff.net>
 <20191214010002.GA945704@coredump.intra.peff.net>
 <xmqqlfrcje1f.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfrcje1f.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 16, 2019 at 10:55:40AM -0800, Junio C Hamano wrote:

> LIB_H could contain command-list.h (and other GENERATED_H files) if
> we did this, but dups in dependency does not hurt in general, and I
> did not find anything potentially problematic in the existing use of
> $(LIB_H) in our Makefile.
> 
> How about doing this as a further clean-up?  I am reasonably sure
> the status-quo description is correct, but I find the justification
> a bit weak (in other words, I do not have a good answer to "who
> cares if those that depend on $(LIB_H) are not rebuilt when
> command-list.h gets rebuilt?")

Yeah, I don't think there's any change in behavior here, since with the
exception of hdr-check, every mention of $(LIB_H) also mentioned
$(GENERATED_H). And in the case of hdr-check, we explicitly exclude the
only item found in $(GENERATED_H).

But this would enable us to start checking command-list.h. I'm on the
fence on whether that's useful or not; the patch below makes it pass,
but I'm not sure if that is really turning up any useful problems. I
suppose somebody besides help.c could include command-list.h, in which
case some of those MAYBE_UNUSED bits could become useful.

I actually wonder if the whole thing would be simpler if command-list.h
was a static tracked file with the declarations, and we generated
command-list.c with "extern const char *command_list[]", etc.

> --- >8 ---
> Makefile: include GENERATED_H in LIB_H
> 
> $(LIB_H), which is meant to be the list of header files that can
> affect (hence trigger recompilation) the objects that go in
> libgit.a, in a directory extracted from a tarball is computed by
> running "find \*.h" but instead computed with "ls-files \*.h" in a
> working tree managed by a git repository.  The former can include
> generated header files after a build, and omit them in a clean
> state.  The latter would not, as generated header files are by
> definition not tracked.
> 
> Explicitly add $(GENERATED_H) to $(LIB_H) to make things consistent.

I do think this is slightly simpler to reason about than the existing
setup (though see my "should it just be a C file?" above).

Here's the patch that would make hdr-check work:

---
diff --git a/Makefile b/Makefile
index 87b68962ed..1eac8e7a7a 100644
--- a/Makefile
+++ b/Makefile
@@ -2780,7 +2780,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
-GEN_HDRS := command-list.h unicode-width.h
+GEN_HDRS := unicode-width.h
 EXCEPT_HDRS := $(GEN_HDRS) compat/% xdiff/%
 ifndef GCRYPT_SHA256
 	EXCEPT_HDRS += sha256/gcrypt.h
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 71158f7d8b..7b0751e3e1 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -48,6 +48,7 @@ define_categories () {
 define_category_names () {
 	echo
 	echo "/* Category names */"
+	echo "MAYBE_UNUSED"
 	echo "static const char *category_names[] = {"
 	bit=0
 	category_list "$1" |
@@ -61,6 +62,7 @@ define_category_names () {
 }
 
 print_command_list () {
+	echo "MAYBE_UNUSED"
 	echo "static struct cmdname_help command_list[] = {"
 
 	command_list "$1" |
@@ -78,6 +80,7 @@ print_command_list () {
 
 print_config_list () {
 	cat <<EOF
+MAYBE_UNUSED
 static const char *config_name_list[] = {
 EOF
 	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
@@ -101,7 +104,8 @@ do
 	shift
 done
 
-echo "/* Automatically generated by generate-cmdlist.sh */
+echo "#include \"gettext.h\"
+/* Automatically generated by generate-cmdlist.sh */
 struct cmdname_help {
 	const char *name;
 	const char *help;
