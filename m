From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] grep: enable threading with -p and -W using lazy
 attribute lookup
Date: Fri, 16 Dec 2011 09:34:07 -0800
Message-ID: <7vvcpgifow.fsf@alter.siamese.dyndns.org>
References: <cover.1323723759.git.trast@student.ethz.ch>
 <138b930c0c96029f2fb9a816e73e70a4d5bce1de.1323723759.git.trast@student.ethz.ch> <4EEAFFAF.8030003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Jeff King <peff@peff.net>, Eric Herman <eric@freesa.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 16 18:34:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbbfx-0004ZL-DQ
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 18:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760279Ab1LPReS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 12:34:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63918 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760275Ab1LPReL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 12:34:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C57A7F7C;
	Fri, 16 Dec 2011 12:34:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=//bwMfqYdDqb9T6LteAXjTZFECQ=; b=qeHCoh
	HaJ0PDfz0JWU6g+XTpsnP9L9h51QR1CPTshhUyVpPOjjR0HiMi2F9EDYr43oSTlO
	dQONJoWpiQfFkg5byOIaQc5foI7bdzQotJ9AFzSJHVEPKjaOAP77W6kqkZs8/LkN
	Tayr4EbAGPcYhIEzFvqTobf+HCQDxhSqWz8n4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yy09Uhg6O1onKP62JPntiUsaizvWoIkH
	pe3HuTWkqCDLIYOvi9PKKWbPqRdhoK+jemNypC/YMiaTr4Rd3E3ezSDwOFw+O4AD
	c5p/8R8BNnFr+/TV8tdZZEDuVzZKyrz+aWUR96ViN6SV90U3Cu0pwDGzFwNQ2Quo
	+GDZNtgm5Io=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42BF47F7B;
	Fri, 16 Dec 2011 12:34:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC25A7F7A; Fri, 16 Dec 2011
 12:34:09 -0500 (EST)
In-Reply-To: <4EEAFFAF.8030003@viscovery.net> (Johannes Sixt's message of
 "Fri, 16 Dec 2011 09:22:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 297140D6-280C-11E1-A86D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187289>

Johannes Sixt <j.sixt@viscovery.net> writes:

> This is the first time we use pthread_mutex_t in a header file. We need at
> least the following squashed in. An alternative would be to include
> "thread-utils.h", but thread-utils is really more about implementation
> helpers functions, not about types,...

builtin/grep.c already uses thread-utils.h since 5b594f4 (Threaded grep,
2010-01-25), so does builtin/pack-objects.c since 833e3df (pack-objects:
Add runtime detection of online CPU's, 2008-02-22), so it may be simpler
to do so in grep.h instead.

diff --git a/builtin/grep.c b/builtin/grep.c
index bc23c3c..6474eed 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -17,7 +17,6 @@
 #include "grep.h"
 #include "quote.h"
 #include "dir.h"
-#include "thread-utils.h"
 
 static char const * const grep_usage[] = {
 	"git grep [options] [-e] <pattern> [<rev>...] [[--] <path>...]",
diff --git a/grep.h b/grep.h
index 15d227c..dd4c65e 100644
--- a/grep.h
+++ b/grep.h
@@ -133,8 +133,11 @@ extern struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
 extern int grep_threads_ok(const struct grep_opt *opt);
 
 #ifndef NO_PTHREADS
-/* Mutex used around access to the attributes machinery if
- * opt->use_threads.  Must be initialized/destroyed by callers! */
+#include "thread-utils.h"
+/*
+ * Mutex used around access to the attributes machinery if
+ * opt->use_threads.  Must be initialized/destroyed by callers!
+ */
 extern pthread_mutex_t grep_attr_mutex;
 #endif
 
