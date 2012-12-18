From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH/PATCH] git-compat-util.h: do not #include <sys/param.h> by
 default
Date: Tue, 18 Dec 2012 09:35:33 -0800
Message-ID: <7v623zgt5m.fsf_-_@alter.siamese.dyndns.org>
References: <20121217213730.GA17212@ftbfs.org>
 <50D02B9A.1040906@viscovery.net> <7vobhrgupr.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 18:36:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl15K-0001gD-Ri
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 18:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277Ab2LRRfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 12:35:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35342 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232Ab2LRRfh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 12:35:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58B9597FC;
	Tue, 18 Dec 2012 12:35:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lm01Bfuyqr0jcllqGKmm3QRDGjM=; b=CsPCTl
	anV55L8uyoTJwWH1CkDBXmU2IVKZF6OIW5jXIGaMtPtudppGOREOhmyvqpVFKAAY
	kxNpgkd+lKcSoeCBO2kJ9iBtwf1gxFbPpDnEFE5Vr55S5VSp0W5iTQ4GL91/wsiy
	JDDcT7Y8XF7q0x2OMq+v4gbEVTrCf88Zn1Pa8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m5erOMv5LBaVK+WT9HOxt/1acI/oefKq
	nAp8kH8QSTL8xo1xl8DAwMV0+vwpHqm5FpIMcXFIWUYATDNOx1B2hPrZQY2C9off
	rFqpURhfOggHkEat5ZpQGMQtkfiKBedwj5x19dEK0QYEKUels/SBnGJrDoXMn4m6
	dWgAdTtsFvY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EAD197FB;
	Tue, 18 Dec 2012 12:35:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BA5697FA; Tue, 18 Dec 2012
 12:35:35 -0500 (EST)
In-Reply-To: <7vobhrgupr.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 18 Dec 2012 09:01:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 547AA304-4939-11E2-AA5E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211765>

Earlier we allowed platforms that lack <sys/param.h> not to include
the header file from git-compat-util.h; we have included this header
file since the early days back when we used MAXPATHLEN (which we no
longer use) and also depended on it slurping ULONG_MAX (which we get
by including stdint.h or inttypes.h these days).

It turns out that we can compile our modern codebase just file
without including it on many platforms (so far, Debian, Ubuntu,
MinGW, HP-Nonstop, QNX and z/OS are reported to be OK).

Let's stop including it by default, and on platforms that need it to
be included, leave "make NEEDS_SYS_PARAM_H=YesPlease" as an escape
hatch and ask them to report to us, so that we can find out about
the real dependency and fix it in a more platform agnostic way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I'd propose queuing this on top of dm/port topic, cook it in
   'next' for a while and then unleash it to the public.

 Makefile          | 8 +++++---
 configure.ac      | 6 ------
 git-compat-util.h | 2 +-
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 5cd1de0..2c1f04f 100644
--- a/Makefile
+++ b/Makefile
@@ -167,7 +167,9 @@ all::
 # Define NO_POLL if you do not have or don't want to use poll().
 # This also implies NO_SYS_POLL_H.
 #
-# Define NO_SYS_PARAM_H if you don't have sys/param.h.
+# Define NEEDS_SYS_PARAM_H if you need to include sys/param.h to compile,
+# *PLEASE* REPORT to git@vger.kernel.org if your platform needs this;
+# we want to know more about the issue.
 #
 # Define NO_PTHREADS if you do not have or do not want to use Pthreads.
 #
@@ -1747,8 +1749,8 @@ endif
 ifdef NO_SYS_POLL_H
 	BASIC_CFLAGS += -DNO_SYS_POLL_H
 endif
-ifdef NO_SYS_PARAM_H
-	BASIC_CFLAGS += -DNO_SYS_PARAM_H
+ifdef NEEDS_SYS_PARAM_H
+	BASIC_CFLAGS += -DNEEDS_SYS_PARAM_H
 endif
 ifdef NO_INTTYPES_H
 	BASIC_CFLAGS += -DNO_INTTYPES_H
diff --git a/configure.ac b/configure.ac
index e3ab6fe..8fbb533 100644
--- a/configure.ac
+++ b/configure.ac
@@ -699,12 +699,6 @@ AC_CHECK_HEADER([sys/poll.h],
 [NO_SYS_POLL_H=UnfortunatelyYes])
 GIT_CONF_SUBST([NO_SYS_POLL_H])
 #
-# Define NO_SYS_PARAM_H if you don't have sys/param.h
-AC_CHECK_HEADER([sys/param.h],
-[NO_SYS_PARAM_H=],
-[NO_SYS_PARAM_H=UnfortunatelyYes])
-GIT_CONF_SUBST([NO_SYS_PARAM_H])
-#
 # Define NO_INTTYPES_H if you don't have inttypes.h
 AC_CHECK_HEADER([inttypes.h],
 [NO_INTTYPES_H=],
diff --git a/git-compat-util.h b/git-compat-util.h
index d7359ef..a88147b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -104,7 +104,7 @@
 #endif
 #include <errno.h>
 #include <limits.h>
-#ifndef NO_SYS_PARAM_H
+#ifdef NEEDS_SYS_PARAM_H
 #include <sys/param.h>
 #endif
 #include <sys/types.h>
-- 
1.8.1.rc2.136.gb42b73a
