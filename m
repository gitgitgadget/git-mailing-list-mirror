From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Verbose git-daemon logging
Date: Thu, 22 Sep 2005 16:42:39 -0700
Message-ID: <7vd5n0lle8.fsf@assigned-by-dhcp.cox.net>
References: <20050921213933.GB10575@pasky.or.cz>
	<7vwtl9mqm5.fsf@assigned-by-dhcp.cox.net>
	<20050922092528.GB21019@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 01:43:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIaiD-0008G2-Ee
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 01:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVIVXmm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 19:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbVIVXmm
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 19:42:42 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:30179 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751209AbVIVXmm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 19:42:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050922234241.OJQS6597.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Sep 2005 19:42:41 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9153>

Petr Baudis <pasky@suse.cz> writes:

> What would be knowing parent PID be useful for? (It's not really the PID
> number that's useful anyway (at least mostly), it's just a good unique
> identifier to distinguish between several simultaneous sessions.)

Maybe running two daemons serving two sets of repos?  But anyway
what you have look more consistent so let's keep that.

> Fixed up patch follows.

Thanks.

> +static void logreport(const char *err, va_list params)
> +{
> +	/* We should do a single write so that it is atomic and output
> +	 * of several processes does not get intermangled. */
> +	char buf[1024];
> +	int buflen;
> +	int maxlen, msglen;
> +
> +	buflen = snprintf(buf, sizeof(buf), "[%d] ", getpid());
> +
> +	maxlen = sizeof(buf) - buflen - 1;
> +	msglen = vsnprintf(buf + buflen, maxlen, err, params);
> +	if (msglen > maxlen)
> +		msglen = maxlen;
> +	else if (msglen < 0)
> +		msglen = -1; /* Protect against weird return values. */
> +	buflen += msglen;
> +
> +	buf[buflen++] = '\n';
> +	buf[buflen] = '\0';
> +
> +	fputs(buf, stderr);
> +}

The tail part still looks odd here.  Maybe something like this?

+static void logreport(const char *err, va_list params)
+{
+	/* We should do a single write so that it is atomic and output
+	 * of several processes does not get intermangled. */
+	char buf[1024];
+	int buflen;
+	int maxlen, msglen;
+
+	/* sizeof(buf) should be big enough for "[pid] \n" */
+	buflen = snprintf(buf, sizeof(buf), "[%d] ", getpid());
+
+	maxlen = sizeof(buf) - buflen - 1; /* -1 for our own LF */
+	msglen = vsnprintf(buf + buflen, maxlen, err, params);
+
+	/* maxlen counted our own LF but also counts space given to
+	 * vsnprintf for the terminating NUL.  We want to make sure that
+	 * we have space for our own LF and NUL after the "meat" of the
+	 * message, so truncate it at maxlen - 1.
+	 */
+	if (msglen > maxlen - 1)
+		msglen = maxlen - 1;
+	else if (msglen < 0)
+		msglen = 0; /* Protect against weird return values. */
+	buflen += msglen;
+
+	buf[buflen++] = '\n';
+	buf[buflen] = '\0';
+
+	fputs(buf, stderr);
+}
