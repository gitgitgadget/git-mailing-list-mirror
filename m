From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Prefer sysconf(_SC_OPEN_MAX) over
 getrlimit(RLIMIT_NOFILE,...)
Date: Fri, 24 Aug 2012 09:43:42 -0700
Message-ID: <7v393c1br5.fsf@alter.siamese.dyndns.org>
References: <002f01cd81de$28f43bf0$7adcb3d0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Fri Aug 24 18:43:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4wzB-0008Tm-6F
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 18:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759744Ab2HXQnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 12:43:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48993 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759709Ab2HXQnp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 12:43:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 721C493DB;
	Fri, 24 Aug 2012 12:43:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=PxnYXJx8L4FgVq1+UkICIHAyk10=; b=Tsj+V856mVTO6Gxjg8tn
	Jo3aTNl5xBj8ao6bVRAerp16pJzGJbaRTutlYmloVpbJhTLYgw4CjOx8jVYUcwel
	ZtJGVZ6RoRn2gAwQQuFUJT8W8RJhI2v0AuGj7UpW0ccMjUwOyerJGQGNKAwXVXO8
	B977++JYYJ/zJYcqP4obS5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=mFIGuaqurcnbmVIKcXnYVJqvqKbOeQI9l+lEvgLeS7e++l
	uWRaUbQIq8FArlF9Hllf5hhphGq9IlvGkI4LnX+XqGp3tfayg67vKXcbRB4k6mTh
	ZQzwmzyajf8g8hQSrZ8HryMfhByg6HYzRgWH5qzIGgeQgWW4bYGIuH4iY8pYU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F5F893DA;
	Fri, 24 Aug 2012 12:43:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B18CA93D8; Fri, 24 Aug 2012
 12:43:43 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DDDFDE5A-EE0A-11E1-80F6-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204220>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> ---
> As discussed now as a small helper function rather than #ifdef/#endif in the primary flow of the code.
> And hopefully without having screwed up whitespace and line breaks

The formatting looks fine.

Perhaps I am being overly paranoid, but I would prefer not to change
things for people who have been using getrlimit().  For them, if
they also have sysconf(_SC_OPEN_MAX), your code _ought to_ work, but
if it does not work for whatever reason (perhaps some platforms
claim to have both, but getrlimit() works and sysconf(_SC_OPEN_MAX)
is broken), it will given them an unnecessary regression.

So how about doing it this way instead?

-- >8 --
Subject: sha1_file.c: introduce get_max_fd_limit() helper

Not all platforms have getrlimit(), but there are other ways to see
the maximum number of files that a process can have open.  If
getrlimit() is unavailable, fall back to sysconf(_SC_OPEN_MAX) if
available, and use OPEN_MAX from <limits.h>.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git c/sha1_file.c w/sha1_file.c
index af5cfbd..9152974 100644
--- c/sha1_file.c
+++ w/sha1_file.c
@@ -731,6 +731,24 @@ void free_pack_by_name(const char *pack_name)
 	}
 }
 
+static unsigned int get_max_fd_limit(void)
+{
+#ifdef RLIMIT_NOFILE
+	struct rlimit lim;
+
+	if (getrlimit(RLIMIT_NOFILE, &lim))
+		die_errno("cannot get RLIMIT_NOFILE");
+
+	return lim.rlim_cur;
+#elif defined(_SC_OPEN_MAX)
+	return sysconf(_SC_OPEN_MAX);
+#elif defined(OPEN_MAX)
+	return OPEN_MAX;
+#else
+	return 1; /* see the caller ;-) */
+#endif
+}
+
 /*
  * Do not call this directly as this leaks p->pack_fd on error return;
  * call open_packed_git() instead.
@@ -747,13 +765,7 @@ static int open_packed_git_1(struct packed_git *p)
 		return error("packfile %s index unavailable", p->pack_name);
 
 	if (!pack_max_fds) {
-		struct rlimit lim;
-		unsigned int max_fds;
-
-		if (getrlimit(RLIMIT_NOFILE, &lim))
-			die_errno("cannot get RLIMIT_NOFILE");
-
-		max_fds = lim.rlim_cur;
+		unsigned int max_fds = get_max_fd_limit();
 
 		/* Save 3 for stdin/stdout/stderr, 22 for work */
 		if (25 < max_fds)
