From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-compat-util.h: avoid using c99 flex array feature with Sun compiler 5.8
Date: Mon,  8 Jun 2009 18:53:48 -0500
Message-ID: <nYAkmarcGRBhYLHbnRiCZXL6usjjeB6-Ay5jvqc8d36t-A-gMf9kF8a87yc3WwoOoSuGBCYDVLg@cipher.nrlssc.navy.mil>
References: <ee63ef30906052056le082bffrec078981dddaa013@mail.gmail.com>
Cc: nico@cam.org, git@vger.kernel.org, peff@peff.net,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 09 01:55:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDogR-0007m1-6F
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 01:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbZFHXzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 19:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbZFHXzK
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 19:55:10 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55197 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbZFHXzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 19:55:09 -0400
Received: by mail.nrlssc.navy.mil id n58NsFqB023320; Mon, 8 Jun 2009 18:54:15 -0500
In-Reply-To: <ee63ef30906052056le082bffrec078981dddaa013@mail.gmail.com>
X-OriginalArrivalTime: 08 Jun 2009 23:54:14.0126 (UTC) FILETIME=[6D2D50E0:01C9E894]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121133>

From: Brandon Casey <drafnel@gmail.com>

The Sun c99 compiler as recent as version 5.8 Patch 121016-06 2007/08/01
produces an error when compiling diff-delta.c.  This source file #includes
the delta.h header file which pre-declares a struct which is later defined
to contain a flex array member.  The Sun c99 compiler fails to compile
diff-delta.c and gives the following error:

  "diff-delta.c", line 314: identifier redeclared: create_delta
          current : function(pointer to const struct delta_index {unsigned long memsize, pointer to const void src_buf, unsigned long src_size, unsigned int hash_mask, array[-1] of pointer to struct index_entry {..} hash}, pointer to const void, unsigned long, pointer to unsigned long, unsigned long) returning pointer to void
          previous: function(pointer to const struct delta_index {unsigned long memsize, pointer to const void src_buf, unsigned long src_size, unsigned int hash_mask, array[-1] of pointer to struct index_entry {..} hash}, pointer to const void, unsigned long, pointer to unsigned long, unsigned long) returning pointer to void : "delta.h", line 44
  c99: acomp failed for diff-delta.c

So, avoid using this c99 feature when compiling with the Sun c compilers
version 5.8 and older (the most recent version tested).

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


This should avoid the flex array problems when using the Sun c99 compiler.

This patch is on top of the new bc/solaris (a7a24ee7).

Since this checks the version of the Sun compiler, it should give Sun the
opportunity to fix the compiler in newer releases.  If someone has Sun
Studio 12? where __SUNPRO_C is set to 0x590, maybe they can test.

-brandon


 git-compat-util.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 71197d9..48d99fa 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -7,7 +7,7 @@
 /*
  * See if our compiler is known to support flexible array members.
  */
-#if defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)
+#if defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) && (!defined(__SUNPRO_C) || (__SUNPRO_C > 0x580))
 # define FLEX_ARRAY /* empty */
 #elif defined(__GNUC__)
 # if (__GNUC__ >= 3)
-- 
1.6.3.1.24.g152f4
