From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Remove noreturn function pointers in usage.c
Date: Wed, 08 Jun 2011 17:36:03 -0700
Message-ID: <7v4o3z264s.fsf@alter.siamese.dyndns.org>
References: <1307569417-8924-1-git-send-email-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 02:36:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUTEQ-00034C-SV
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 02:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353Ab1FIAgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 20:36:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab1FIAgN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 20:36:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3ACC8556E;
	Wed,  8 Jun 2011 20:38:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ofyT0udd7y0Lcp4iFxF3mAW3Un8=; b=r/XS+6
	81iBVz2KxJ4A/iZSUMo2QtG9OKIdCilU+UVujKHTyAUXcEz1Ja5xoKtBmy1lTuzv
	eFG14wRtAJBPTrepXHZFhrJf5GkHnmudap2UFND0JoGdmgJV66PLY2wsWcayuKgE
	8Xpxnk9bt26VNiagNjk8xORnmXKIGhEjqxCIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OTXfFursLbDD6QKAcgxlRk6sukTy8/rq
	iqVf+gmNwLtv2SJ+BY/pwlwJJKVSCyaBNv0JyAjpBinf9rqpUK75BqdEles5bAT7
	/Zu2PWBHTKfoaDH8g+d3f89rjmsrNDkuMis1TO3pt0Tc6+evjsR+pS2w+cMFJUeE
	cmnDCL8Qb7Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05470556C;
	Wed,  8 Jun 2011 20:38:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A56D2556B; Wed,  8 Jun 2011
 20:38:14 -0400 (EDT)
In-Reply-To: <1307569417-8924-1-git-send-email-andi@firstfloor.org> (Andi
 Kleen's message of "Wed, 8 Jun 2011 14:43:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C569E852-9230-11E0-ACF8-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175478>

Andi Kleen <andi@firstfloor.org> writes:

> From: Andi Kleen <ak@linux.intel.com>
>
> Due to a bug in gcc 4.6+ it can crash when doing profile feedback
> with a noreturn function pointer
>
> (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
>
> Remove the NORETURNs from the die functions for now to work
> around this. Doesn't seem to make any difference.
>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

I would expect a better patch from a well respected kernel person, though.

 - There are many more NORETURN and NORETURN_PTR in the code, and the
   proposed commit log message does not explain why these two are the only
   ones that are problematic and needs to be worked around. It does not
   guide other people who might want to add NORETURN/NORETURN_PTR when
   deciding if their change would break the "fix" this change brought in.

 - Potential impact to people who do not use Gcc 4.6 with profile feedback
   is not explained away well, except for "Doesn't seem to make any
   difference."

 - If other NORETURN/NORETURN_PTR could/should also go (I don't know due
   to the first bullet point above) when using the problematic compiler
   with the profile feedback feature, wouldn't it be a better workaround
   would be to introduce a Makefile variable to ask git-compat-util.h to
   make these two a no-op, perhaps?

A patch to do so may look like this.

I did not like the triple negation "make NO_NORETURN=NoThanks" and wanted
to name this AVOID_NORETURN instead, but decided to go with other existing
Makefile variables.


 Makefile          |    6 ++++++
 git-compat-util.h |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index d2e2ea1..70c814c 100644
--- a/Makefile
+++ b/Makefile
@@ -144,6 +144,9 @@ all::
 # that tells runtime paths to dynamic libraries;
 # "-Wl,-rpath=/path/lib" is used instead.
 #
+# Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
+# as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
+#
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
 # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
 # it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
@@ -1349,6 +1352,9 @@ endif
 ifdef USE_ST_TIMESPEC
 	BASIC_CFLAGS += -DUSE_ST_TIMESPEC
 endif
+ifdef NO_NORETURN
+	BASIC_CFLAGS += -DNO_NORETURN
+endif
 ifdef NO_NSEC
 	BASIC_CFLAGS += -DNO_NSEC
 endif
diff --git a/git-compat-util.h b/git-compat-util.h
index 40498b3..13bc26f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -218,7 +218,7 @@ extern char *gitbasename(char *);
 #if __HP_cc >= 61000
 #define NORETURN __attribute__((noreturn))
 #define NORETURN_PTR
-#elif defined(__GNUC__)
+#elif defined(__GNUC__) && !defined(NO_NORETURN)
 #define NORETURN __attribute__((__noreturn__))
 #define NORETURN_PTR __attribute__((__noreturn__))
 #elif defined(_MSC_VER)
