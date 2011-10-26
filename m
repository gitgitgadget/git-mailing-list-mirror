From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git grep: be careful to use mutices only when they are
 initialized
Date: Wed, 26 Oct 2011 13:02:40 -0700
Message-ID: <7v39ef34in.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1110251223500.32316@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 26 22:02:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ9gX-0000Ck-Gt
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 22:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396Ab1JZUCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 16:02:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59098 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499Ab1JZUCn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 16:02:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5DC86C48;
	Wed, 26 Oct 2011 16:02:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=bqygMi6nwkyUG+BcQXyqf0FT2Gs=; b=YXQBPExIMGhwKveXRm6+
	YP3qdy1YaVmKB9mirKTeAMb/LBXIEvt/FCkRfCgGCjwBudRgzeT1e6d9W4+v4sQn
	e69m2gvB7h3kjFRIxwfl1PDuf+SkHI+pqEazp7MWlz1TDFY2v5qTzYDmJAAwaVoE
	K6gVPmFUbmMTGNZtDpFeZmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=xN50x5tva+/OpeU6qtvqpxseFnbE5q0MeOHQKvARjrkHa2
	XixeleF9+ezIFCalmujTfzqxYkjfowzRUHuY6LM57D7dJ1pRljSfxx0a+IAZpskE
	WIg4V4/PVVrgofOdB0O9bth4COeBKft2RjaF0aRCKy/DdYwiVND+5m/wbJ4x8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD2296C47;
	Wed, 26 Oct 2011 16:02:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E1A76C46; Wed, 26 Oct 2011
 16:02:42 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7696F364-000D-11E1-B582-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184274>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	I looked around a bit but ran out of time to identify the reason why
> 	this was not caught earlier.
>
>  builtin/grep.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 92eeada..e94c5fe 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -78,10 +78,11 @@ static pthread_mutex_t grep_mutex;
>  /* Used to serialize calls to read_sha1_file. */
>  static pthread_mutex_t read_sha1_mutex;
>  
> -#define grep_lock() pthread_mutex_lock(&grep_mutex)
> -#define grep_unlock() pthread_mutex_unlock(&grep_mutex)
> -#define read_sha1_lock() pthread_mutex_lock(&read_sha1_mutex)
> -#define read_sha1_unlock() pthread_mutex_unlock(&read_sha1_mutex)
> +#define WHEN_THREADED(x) do { if (use_threads) (x); } while (0)
> +#define grep_lock() WHEN_THREADED(pthread_mutex_lock(&grep_mutex))
> +#define grep_unlock() WHEN_THREADED(pthread_mutex_unlock(&grep_mutex))
> +#define read_sha1_lock() WHEN_THREADED(pthread_mutex_lock(&read_sha1_mutex))
> +#define read_sha1_unlock() WHEN_THREADED(pthread_mutex_unlock(&read_sha1_mutex))

I think, from a quick glance, this is a good first step.

The remainder of this message are hints and random thoughts on potential
follow-up patches that may want to build on top of this patch for further
clean-ups (not specifically meant for Dscho but for other people on both
mailing lists).

 - The patch makes the check for use_threads in lock_and_read_sha1_file()
   redundant. The other user of read_sha1_lock/unlock in grep_object() can
   take advantage of this change (see below).

 - It makes me wonder if it is simpler to initialize mutexes even in
   !use_threads case.

 - Wouldn't the result be more readable to make these into static inline
   functions?

 - Could we lose "#ifndef NO_PTHREADS" inside grep_sha1(), grep_file(),
   and possibly cmd_grep() functions and let the compiler optimize things
   away under NO_PTHREADS compilation?

diff --git a/builtin/grep.c b/builtin/grep.c
index 7d0779f..60daa85 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -354,13 +354,9 @@ static void *lock_and_read_sha1_file(const unsigned char *sha1, enum object_type
 {
 	void *data;
 
-	if (use_threads) {
-		read_sha1_lock();
-		data = read_sha1_file(sha1, type, size);
-		read_sha1_unlock();
-	} else {
-		data = read_sha1_file(sha1, type, size);
-	}
+	read_sha1_lock();
+	data = read_sha1_file(sha1, type, size);
+	read_sha1_unlock();
 	return data;
 }
 
