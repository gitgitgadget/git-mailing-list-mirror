From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Include xmlparse.h instead of expat.h on QNX
Date: Mon, 11 Feb 2013 13:34:52 -0800
Message-ID: <7vip5ylekj.fsf@alter.siamese.dyndns.org>
References: <1360616395-18912-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matt Kraai <matt.kraai@amo.abbott.com>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:35:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5120-0001xm-Ob
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 22:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220Ab3BKVe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 16:34:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37777 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759394Ab3BKVez (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 16:34:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B42C1C239;
	Mon, 11 Feb 2013 16:34:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kzZgk5TNZmNaZwGd5xiUv9zi9HM=; b=Y2xL5u
	Nq7LkOK7AH8yu1Jmar105XfvqXnK5UzLuStLHb0i0d0//EXVQ1KdY1LI/AkjepeX
	ZX8hbsk2tWfJrMqZu6tdFN1rr9sUwaBOlbn3S0lb0jChZ3pFEBLQur3MUlPzllAt
	Q5d/KGw18djBpDyhWS1quOR4D7jOQ15jmXyLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d0nY9u2uqqBVJW2wqwB2zEjVGiDjtFex
	r7F4cqDfyB3drimO/m+FxpTyB9A1dhg1mUBdpJh3pEn4qn07we34aJ2mKVHNY3XC
	z2D2bp1VELVvRfGHlKL9nkvWyWRKWMFi0ZPYp0MqFmH3Z6aCLu01c5BEILTxHAwH
	NlXgubAMczM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EA7FC233;
	Mon, 11 Feb 2013 16:34:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8DB2C22E; Mon, 11 Feb 2013
 16:34:53 -0500 (EST)
In-Reply-To: <1360616395-18912-1-git-send-email-kraai@ftbfs.org> (Matt
 Kraai's message of "Mon, 11 Feb 2013 12:59:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF946630-7492-11E2-AC44-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216093>

Matt Kraai <kraai@ftbfs.org> writes:

> From: Matt Kraai <matt.kraai@amo.abbott.com>
>
> QNX 6.3.2 through 6.5.0 include Expat 1.1, which provides xmlparse.h
> instead of expat.h, so include the former on QNX systems.
>
> Signed-off-by: Matt Kraai <matt.kraai@amo.abbott.com>
> ---

Two points and a possibly irrelevant half:

 - If a fix is platform specific (i.e. tempts to use #ifdef
   PLATFORM_NAME), we would prefer to see a patch that that is
   isolated to platform-specific compatibility layer, which would
   involve:

   . add compat/qnx/expat.h file that #include <xmlparse.h>
   . to Makefile, add -Icompat/qnx/ to CFLAGS

 - Is this really a fix for a problem specific to QNX?  It looks
   like this is for any platform with expat 1, no?

 - What happens to people with QNX older than 6.3.2 or newer than
   6.5.0 (assuming they will eventually start shipping expat 2) with
   your patch?

Assuming that this change is about building with expat1, it would
probably be better to do something like this instead, I would think.


 Makefile         | 5 +++++
 config.mak.uname | 1 +
 http-push.c      | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index 5a2e02d..57032cc 100644
--- a/Makefile
+++ b/Makefile
@@ -43,6 +43,8 @@ all::
 # Define EXPATDIR=/foo/bar if your expat header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
+# Define EXPAT_VERSION=1 if you are trying to build with expat 1.x (e.g. QNX).
+#
 # Define NO_GETTEXT if you don't want Git output to be translated.
 # A translated Git requires GNU libintl or another gettext implementation,
 # plus libintl-perl at runtime.
@@ -1089,6 +1091,9 @@ else
 		else
 			EXPAT_LIBEXPAT = -lexpat
 		endif
+		ifdef EXPAT_VERSION
+		BASIC_CFLAGS += -DEXPAT_VERSION=$(EXPAT_VERSION)
+		endif
 	endif
 endif
 
diff --git a/config.mak.uname b/config.mak.uname
index bea34f0..281d834 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -536,4 +536,5 @@ ifeq ($(uname_S),QNX)
 	NO_R_TO_GCC_LINKER = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
+	EXPAT_VERSION = 1
 endif
diff --git a/http-push.c b/http-push.c
index 3e72e84..2fdb0cd 100644
--- a/http-push.c
+++ b/http-push.c
@@ -11,7 +11,11 @@
 #include "list-objects.h"
 #include "sigchain.h"
 
+#if EXPAT_VERSION == 1
+#include <xmlparse.h>
+#else
 #include <expat.h>
+#endif
 
 static const char http_push_usage[] =
 "git http-push [--all] [--dry-run] [--force] [--verbose] <remote> [<head>...]\n";
