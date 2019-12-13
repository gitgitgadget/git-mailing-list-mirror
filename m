Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CB7C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4691F205C9
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E0pZn1AQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLMXZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:25:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60244 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfLMXZr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 18:25:47 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 27B38251BA;
        Fri, 13 Dec 2019 18:25:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:cc:date:message-id:mime-version:content-type; s=sasl;
         bh=RrEnQZFv+g40+mEnIRXKSR4MzwI=; b=E0pZn1AQtpVYLNeFbd3MTfm4n3yV
        5CGWwa1T7g9/MPBFZiauJ3fTKwUv0dJtRyGLaSRXt5StzN8y5PnQIriPMVs3aYeL
        fPBfw4opPFb66XokbSnwIAwAHHsRiAzjDpNO+8oagHO8h1bS3WBfmZ5cAOGh4uEo
        i3ZmcPRktBK2Jso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
        ofGzAGf0sU9jJJ8HsnKrWZX7wZLquS+sQFDDNs2agFkLgL5IbAAT8M74Z6vyVGc7
        lBIX7Y7Ade4b7GbCj1Y8hWwn1fnXaPNX1Zu5v0b3xD5/0xtyTOYybGN9SyGHIxgn
        Xby+ZDBNS0g+lOCnaI7Tr90V2F/EZQbxgU0p5IiI12Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D704251B7;
        Fri, 13 Dec 2019 18:25:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 71EBB251B6;
        Fri, 13 Dec 2019 18:25:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] Makefile: drop GEN_HDRS
cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Date:   Fri, 13 Dec 2019 15:25:41 -0800
Message-ID: <xmqq1rt7hkp6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E178141A-1DFF-11EA-9653-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When ebb7baf0 ("Makefile: add a hdr-check target", 2018-09-19)
implemented hdr-check target, it wanted to leave some header files
exempt from the stricter check the target implements, and added
GEN_HDRS macro to list them

This however was probably a bad move for two and half reasons:

 - If we value the header cleanliness check, we eventually want to
   teach our header generating scripts to produce clean headers.
   Keeping the blanket "generated headers can be left as dirty as we
   want" exception does not nudge us in the right direction.

 - There is a list of generated header files, GENERATED_H, which is
   used to keep track of dependencies.  Presence of GEN_HDRS that is
   too similarly named would confuse developers who are adding new
   generated header files which list to add theirs.

 - Even though unicode-width.h could be generated using a contrib/
   script, as far as our build infrastructure is concerned, it is a
   source file that is tracked in the source control system.  Its
   presence in GEN_HDRS list is doubly misleading.

Get rid of GEN_HDRS, which is used only once to list the headers we
do not run hdr-check test on, and instead explicitly list that the
ones, either tracked or generated, that we exempt from the test.

This allows GENERATED_H to be the sole "here are build artifact
header files that are expendable" list, so use it in the clean
target to $(RM) them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index b7d7374dac..9a9d35637d 100644
--- a/Makefile
+++ b/Makefile
@@ -2779,8 +2779,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
-GEN_HDRS := command-list.h unicode-width.h
-EXCEPT_HDRS := $(GEN_HDRS) compat/% xdiff/%
+EXCEPT_HDRS := command-list.h unicode-width.h compat/% xdiff/%
 ifndef GCRYPT_SHA256
 	EXCEPT_HDRS += sha256/gcrypt.h
 endif
@@ -3105,7 +3104,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs)
 	$(RM) -r po/build/
-	$(RM) *.pyc *.pyo */*.pyc */*.pyo command-list.h $(ETAGS_TARGET) tags cscope*
+	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
-- 
2.24.1-672-gdc02b1e6c6

