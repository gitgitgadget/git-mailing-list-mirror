Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1530C20248
	for <e@80x24.org>; Sun, 21 Apr 2019 13:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfDUNTI (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 09:19:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52275 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDUNTI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 09:19:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so11482922wma.2
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=kwFF80w7GGZewmrFHItnLTgpZEgBJ734V3U5HX2aGiw=;
        b=ZudLOGd9Bn5Y/em/kcPmeR+/SYRG6PxdW3HIBST+vOmWVhVsOMBdEW/QXFkePhmO+d
         NEkqw+rjIqBjSkYTbNg7O6A79cQss0wJZVbcIyubuAVveURRnmHjue8S2jeKepp/Oab8
         NEE07zxI2VLQU4rGYXxRLu3G0OLHuxmgX5atwSE4QizortcX2SF++2D+6/KJRj3NSDBW
         0YqPjgrvatKuMrtE+1iLYWAlNlBigu8MpLtQRvwgEdSQxrKUUJEzHe4ycydO/RSygOpU
         WgkJitVM9e+EqJWKLwZhfPgqFqyNG1dugb9yIeGPZiufwzEqZTzbiwaGDRhKEUlX+tn4
         9uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=kwFF80w7GGZewmrFHItnLTgpZEgBJ734V3U5HX2aGiw=;
        b=Tbwnfc404BcUXId3mX38A3OassFk1qPAAzINF72j0rqWNoFF7pI21bx8J2Uzoq06NT
         YoKRGTg1bkFjt+8ZtQLNIgNq4BD9ntdmGRxjF0A1wmz0C2rkD11HLKfw4dJEqoRnv46E
         QSSe7GHipZwbCRA4sUkoZGd2QcRZ0TfwD5zuZdy1i27MWbFb62nstAnuoAw7blcEBj21
         lt/64+2H4XZLO8Jx2xbhVnjkpL77bERsHw+tCRO85ZdngB8uki9X+y5qZM68b+3fBomO
         fG31FdZ4tbWNk7Fgd8jPlq63WhzFsLUK+z6Yc8EMo+nv8vWAe014F9V+TL5D54taYhYT
         0PEg==
X-Gm-Message-State: APjAAAVREf+duqm68jKXGFkVQFesD1IZy0W4Rll7PgvNDHIFP3CcWBRb
        TMCmJFS8QtKj5XrTTbrAMg6i08IH5Xk=
X-Google-Smtp-Source: APXvYqxTTvR0x0W1LoKebYEFGX1+AE0HMBJ0fmKUjVtk3TZyA2DgP0YvojirAkfAx1Cd8nzwJMcjbg==
X-Received: by 2002:a1c:9ad6:: with SMTP id c205mr8759286wme.46.1555852745823;
        Sun, 21 Apr 2019 06:19:05 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id i28sm22928866wrc.32.2019.04.21.06.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 06:19:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH/RFC] Makefile: dedup list of files obtained from ls-files 
Date:   Sun, 21 Apr 2019 22:19:04 +0900
Message-ID: <xmqqy343a43b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 33533975 ("Makefile: ask "ls-files" to list source files if
available", 2011-10-18), we optionally asked "ls-files" to list the
source files that ought to exist, as a faster approximation for
"find" on working tree files.

This works reasonably well, except that it ends up listing the same
path multiple times if the index is unmerged.  Because the original
use of this construct was to name files to run etags over, and the
etags command happily takes the same filename multiple times without
causing any harm, there was no problem (other than perhaps spending
slightly more cycles, but who cares how fast the TAGS file gets
updated).

We however recently added a similar call to "ls-files" to list *.h
files, instead of using "find", in 92b88eba ("Makefile: use `git
ls-files` to list header files, if possible", 2019-03-04).  In this
new use of "ls-files", the resulting list $(LIB_H) is used for,
among other things, generating the header files to run hdr-check
target, and the duplicate unfortunately becomes a true problem.  It
causes $(MAKE) to notice that there are multiple %.hco targets and
complain.

Feed the resulting list to "| sort -u" before using it as a list of
files to fix this.

---

 * I very often have to (1) perform a merge, which conflicts, (2)
   manually resolve new conflicts that are yet unknown to the rerere
   database, (3) before running "git add", run a trial build and
   optionally test, and then (4) commit the result (or just say "git
   rerere" and then "git reset --hard").

   In the step (3), we have (hopefully) good *.h files that are the
   result of conflict resolution in the working tree, over which we
   do want to run header check, but the whole point of running a
   trial build is to validate the result, the resolution is not yet
   registered to the index (or to the rerere database).  These paths
   have multiple stages in the index, and that is when $(MAKE)
   complained to make me notice this buglet.

   I am not fan of adding the "| sort -u" of the whole thing,
   because there is no need to dedup the output of the $(FIND) side
   of the alternative, but "(ls-files | sort -u) || (find)" would
   obviously not work.  If we truly care, perhaps we should add a
   new option to ls-files to show each path only once, unless it is
   showing the stage number (i.e. "ls-files -s" or "ls-files -u"),
   but this gets the problem go away without code change, hence this
   RFC ;-)

diff --git a/Makefile b/Makefile
index 9f1b6e8926..40716c0f81 100644
--- a/Makefile
+++ b/Makefile
@@ -822,12 +822,12 @@ VCSSVN_LIB = vcs-svn/lib.a
 
 GENERATED_H += command-list.h
 
-LIB_H := $(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
+LIB_H := $(shell (git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
 	$(FIND) . \
 	-name .git -prune -o \
 	-name t -prune -o \
 	-name Documentation -prune -o \
-	-name '*.h' -print)
+	-name '*.h' -print) | sort -u)
 
 LIB_OBJS += abspath.o
 LIB_OBJS += advice.o
@@ -2588,7 +2588,7 @@ FIND_SOURCE_FILES = ( \
 		-o \( -name 'trash*' -type d -prune \) \
 		-o \( -name '*.[hcS]' -type f -print \) \
 		-o \( -name '*.sh' -type f -print \) \
-	)
+	| sort -u )
 
 $(ETAGS_TARGET): FORCE
 	$(RM) $(ETAGS_TARGET)
