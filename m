From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 2/4] Clean: Remove superfluous strbuf 'docs'
Date: Tue, 15 Feb 2011 23:12:04 +0000
Message-ID: <5bddd028-bf38-46b9-a189-bdb09038dfdd-mfwitten@gmail.com>
References: <1fbceaa8-398c-44ec-8833-a03e4cca6805-mfwitten@gmail.com>
            <ca8eabbf-ed1b-4b46-a7f7-4b068a2de5b7-mfwitten@gmail.com>
            <a59d19d0-f279-43fe-8ac6-06c4bd13c941-mfwitten@gmail.com>
            <d92be3a1-6f30-4b04-ac38-39058e5a6959-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:03:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4ynH-0001ck-NT
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 19:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989Ab1C3RCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 13:02:50 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35334 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932909Ab1C3RCt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 13:02:49 -0400
Received: by pwi15 with SMTP id 15so240949pwi.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id:in-reply-to
         :references;
        bh=trcgukICWxMGzWFYndxxayNrvV3LH+iK8XwMVrRGi+M=;
        b=cWB2FdRMLJzL7Hc4MdDCaseoG9hXU48oHXZkzquGdztqnOsHkp61q/4z79e8ne2Ruh
         QNwgkTyjPq2WLf6luNPXh4JxLCNI+OFnvBA+hKKFxi+tZ4w/zP2xQUNuyp0E4pRVIAGk
         DoPndhG783jXGi+U3swxHsjtKaGLhM1u72s8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        b=u+Qnm3d18QDX/hJMKnf9dfdreTk2zP77imb+fGha9obtYkdu+rpp56w+AsCOidEa8f
         cI1m4NQKAtiLEZFhbvSJtcbewKdahBQbelptVIRz6rnuHNU3ej2LmglEEgB0QE8E1GCV
         pqKdW/4s8gg82s1wufURL4iIaHbP8m3i8r+IQ=
Received: by 10.142.43.7 with SMTP id q7mr1057965wfq.142.1301504568783;
        Wed, 30 Mar 2011 10:02:48 -0700 (PDT)
Received: from gmail.com ([109.123.119.163])
        by mx.google.com with ESMTPS id d35sm308838wfj.21.2011.03.30.10.02.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 10:02:48 -0700 (PDT)
In-Reply-To: <1fbceaa8-398c-44ec-8833-a03e4cca6805-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170393>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 strbuf.h |   37 +------------------------------------
 1 files changed, 1 insertions(+), 36 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index f722331..07060ce 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,42 +1,7 @@
 #ifndef STRBUF_H
 #define STRBUF_H
 
-/*
- * Strbuf's can be use in many ways: as a byte array, or to store arbitrary
- * long, overflow safe strings.
- *
- * Strbufs has some invariants that are very important to keep in mind:
- *
- * 1. the ->buf member is always malloc-ed, hence strbuf's can be used to
- *    build complex strings/buffers whose final size isn't easily known.
- *
- *    It is NOT legal to copy the ->buf pointer away.
- *    `strbuf_detach' is the operation that detaches a buffer from its shell
- *    while keeping the shell valid wrt its invariants.
- *
- * 2. the ->buf member is a byte array that has at least ->len + 1 bytes
- *    allocated. The extra byte is used to store a '\0', allowing the ->buf
- *    member to be a valid C-string. Every strbuf function ensures this
- *    invariant is preserved.
- *
- *    Note that it is OK to "play" with the buffer directly if you work it
- *    that way:
- *
- *    strbuf_grow(sb, SOME_SIZE);
- *       ... Here, the memory array starting at sb->buf, and of length
- *       ... strbuf_avail(sb) is all yours, and you are sure that
- *       ... strbuf_avail(sb) is at least SOME_SIZE.
- *    strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
- *
- *    Of course, SOME_OTHER_SIZE must be smaller or equal to strbuf_avail(sb).
- *
- *    Doing so is safe, though if it has to be done in many places, adding the
- *    missing API to the strbuf module is the way to go.
- *
- *    XXX: do _not_ assume that the area that is yours is of size ->alloc - 1
- *         even if it's true in the current implementation. Alloc is somehow a
- *         "private" member that should not be messed with.
- */
+/* See Documentation/technical/api-strbuf.txt */
 
 #include <assert.h>
 
-- 
1.7.4.18.g68fe8
