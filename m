From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git grep: be careful to use mutices only when they are
 initialized
Date: Wed, 26 Oct 2011 13:04:17 -0700
Message-ID: <7vr51z1pvi.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1110251223500.32316@s15462909.onlinehome-server.info>
 <7v39ef34in.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 22:04:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ9i4-0000ss-G9
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 22:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab1JZUEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 16:04:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60073 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338Ab1JZUET (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 16:04:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D0586C9A;
	Wed, 26 Oct 2011 16:04:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z4vndUZTgkjU3FfsZgotJggB0dI=; b=PQTQ2L
	ZWpCvYTaLnWPHtnbrVcK8JqvVW7Xzj5njR/yXVPIZGyKAYG2B5M1Vxjv9kQKmk0y
	XDnaNbVRcdtJx3UVX8VGcRPWmKm0kanhw8ANVSI2L5BcPoVLi4NA1bSzFvhmzGRs
	1D2GucTujP9KdZEQGITySJ9L7Srs60nrbJ5Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y8bDsV0CtmTRznGJxXHuGcdeGl187e18
	BDxUd4IMSydKrptfuhjfPu8MwSF+jp5i1QI3iK1U4FOGmmZ02G60Dgkmf+PXcQrU
	J9MUPwHOtNrnOt/QAnpfIwZ5XQWQMt/47C+mvvYhF+ptqq4f1Kkh/hYUZDo2RXR0
	903cuD8jzcQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04D8F6C98;
	Wed, 26 Oct 2011 16:04:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8872D6C97; Wed, 26 Oct 2011
 16:04:18 -0400 (EDT)
In-Reply-To: <7v39ef34in.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 26 Oct 2011 13:02:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B007A7A6-000D-11E1-83F7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184276>

Junio C Hamano <gitster@pobox.com> writes:

> The remainder of this message are hints and random thoughts on potential
> follow-up patches that may want to build on top of this patch for further
> clean-ups (not specifically meant for Dscho but for other people on both
> mailing lists).
> ...
>  - Wouldn't the result be more readable to make these into static inline
>    functions?

That would look like this.

-- >8 --
Subject: [PATCH] builtin/grep: make lock/unlock into static inline

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 88b0c80..3ddfae4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -74,14 +74,32 @@ static int all_work_added;
 /* This lock protects all the variables above. */
 static pthread_mutex_t grep_mutex;
 
+static inline void grep_lock(void)
+{
+	if (use_threads)
+		pthread_mutex_lock(&grep_mutex);
+}
+
+static inline void grep_unlock(void)
+{
+	if (use_threads)
+		pthread_mutex_unlock(&grep_mutex);
+}
+
 /* Used to serialize calls to read_sha1_file. */
 static pthread_mutex_t read_sha1_mutex;
 
-#define WHEN_THREADED(x) do { if (use_threads) (x); } while (0)
-#define grep_lock() WHEN_THREADED(pthread_mutex_lock(&grep_mutex))
-#define grep_unlock() WHEN_THREADED(pthread_mutex_unlock(&grep_mutex))
-#define read_sha1_lock() WHEN_THREADED(pthread_mutex_lock(&read_sha1_mutex))
-#define read_sha1_unlock() WHEN_THREADED(pthread_mutex_unlock(&read_sha1_mutex))
+static inline void read_sha1_lock(void)
+{
+	if (use_threads)
+		pthread_mutex_lock(&read_sha1_mutex);
+}
+
+static inline void read_sha1_unlock(void)
+{
+	if (use_threads)
+		pthread_mutex_unlock(&read_sha1_mutex);
+}
 
 /* Signalled when a new work_item is added to todo. */
 static pthread_cond_t cond_add;
-- 
1.7.7.1.504.gcc718
