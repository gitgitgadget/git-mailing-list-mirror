Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A024B1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 12:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbeHXPyv (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 11:54:51 -0400
Received: from waltz.apk.li ([185.177.140.48]:59951 "EHLO waltz.apk.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbeHXPyu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 11:54:50 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Aug 2018 11:54:49 EDT
Received: from continuum.iocl.org (localhost [IPv6:::1])
        by waltz.apk.li (Postfix) with ESMTP id B303959804E;
        Fri, 24 Aug 2018 14:14:31 +0200 (CEST)
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id w7OCE7919690;
        Fri, 24 Aug 2018 14:14:07 +0200
Date:   Fri, 24 Aug 2018 14:14:07 +0200
From:   Andreas Krey <a.krey@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: clone, hardlinks, and file modes (and CAP_FOWNER)
Message-ID: <20180824121407.GA19597@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everybody,

I'm currently looking into more aggressively sharing space between multiple repositories,
and into getting them to share again after one did a repack (which costs us 15G space).

One thing I stumbled on is the /proc/sys/fs/protected_hardlinks stuff which disallows
hardlinking pack files belonging to someone else. This consequently inhibits sharing
when first cloning from a common shared cache repo.

Installing git with CAP_FOWNER is probably too dangerous;
at least the capability should only be enabled during the directory copying.

*

And the next thing is that copied object/pack files are created with mode rw-rw-r--,
unlike those that come out of the regular transports.

Apparent patch:

diff --git a/builtin/clone.c b/builtin/clone.c
index fd2c3ef090..6ffb4db4da 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -448,7 +448,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
                                die_errno(_("failed to create link '%s'"), dest->buf);
                        option_no_hardlinks = 1;
                }
-               if (copy_file_with_time(dest->buf, src->buf, 0666))
+               if (copy_file_with_time(dest->buf, src->buf, 0444))
                        die_errno(_("failed to copy file to '%s'"), dest->buf);
        }
        closedir(dir);

Alas, copy_file takes the mode just as a crude hint to executability, so also:

diff --git a/copy.c b/copy.c
index 4de6a110f0..883060009c 100644
--- a/copy.c
+++ b/copy.c
@@ -32,7 +32,7 @@ int copy_file(const char *dst, const char *src, int mode)
 {
        int fdi, fdo, status;
 
-       mode = (mode & 0111) ? 0777 : 0666;
+       mode = (mode & 0111) ? 0777 : (mode & 0222) ? 0666 : 0444;
        if ((fdi = open(src, O_RDONLY)) < 0)
                return fdi;
        if ((fdo = open(dst, O_WRONLY | O_CREAT | O_EXCL, mode)) < 0) {

(copy_file is also used with 0644 instead of the usual 0666 in refs/files-backend.c)

Will submit as patch if acceptable; I'm not sure what the mode casing will
do with other users.

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
