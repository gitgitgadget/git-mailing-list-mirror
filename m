From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] Fix definition of ARRAY_SIZE for non-gcc builds
Date: Wed, 24 Jun 2015 08:44:27 +0100
Message-ID: <1435131867-11361-1-git-send-email-charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 09:44:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7fMV-0000Dj-Pj
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 09:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbbFXHoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 03:44:44 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:42334 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbbFXHom (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 03:44:42 -0400
Received: from hashpling.plus.com ([212.159.69.125]:41155)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1Z7fMO-0007iz-8P; Wed, 24 Jun 2015 08:44:40 +0100
X-Mailer: git-send-email 2.4.0.53.g8440f74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272535>

From: Charles Bailey <cbailey32@bloomberg.net>

The improved ARRAY_SIZE macro uses BARF_UNLESS_AN_ARRAY which is expands
to a valid check for recent gcc versions and to 0 for older gcc
versions but is not defined on non-gcc builds.

Non-gcc builds need this macro to expand to 0 as well. The current
outer test (defined(__GNUC__) && (__GNUC__)) is a strictly weaker
condition than the inner test (GIT_GNUC_PREREQ(3, 1)) so we can omit the
outer test and cause the BARF_UNLESS_AN_ARRAY macro to be defined
correctly on non-gcc builds as well as gcc builds with older versions.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---

This fixes a build regression introduced in v2.4.4 so this patch is
based off that tag.

 git-compat-util.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index b45c75f..8c2b7aa 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -58,15 +58,13 @@
 #define BUILD_ASSERT_OR_ZERO(cond) \
 	(sizeof(char [1 - 2*!(cond)]) - 1)
 
-#if defined(__GNUC__) && (__GNUC__ >= 3)
-# if GIT_GNUC_PREREQ(3, 1)
+#if GIT_GNUC_PREREQ(3, 1)
  /* &arr[0] degrades to a pointer: a different type from an array */
 # define BARF_UNLESS_AN_ARRAY(arr)						\
 	BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(__typeof__(arr), \
 							   __typeof__(&(arr)[0])))
-# else
-#  define BARF_UNLESS_AN_ARRAY(arr) 0
-# endif
+#else
+# define BARF_UNLESS_AN_ARRAY(arr) 0
 #endif
 /*
  * ARRAY_SIZE - get the number of elements in a visible array
-- 
2.4.0.53.g8440f74
