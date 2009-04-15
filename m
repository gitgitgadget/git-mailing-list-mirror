From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] fetch: Strip usernames from url's before storing them
Date: Wed, 15 Apr 2009 10:19:50 -0700
Message-ID: <7vbpqxvnpl.fsf@gitster.siamese.dyndns.org>
References: <49E5EBD2.1070704@op5.se>
 <1239805814-21340-1-git-send-email-ae@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Apr 15 19:21:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu8nl-0003mz-EU
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 19:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbZDORTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 13:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbZDORTz
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 13:19:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbZDORTy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 13:19:54 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 46538FDEC;
	Wed, 15 Apr 2009 13:19:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 89449FDEB; Wed,
 15 Apr 2009 13:19:51 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A2C3262E-29E1-11DE-8D78-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116633>

Andreas Ericsson <ae@op5.se> writes:

> When pulling from a remote, the full URL including username
> is by default added to the commit message. Since it adds
> very little value but could be used by malicious people to
> glean valid usernames (with matching hostnames), we're far
> better off just stripping the username before storing the
> remote URL locally.

Sounds like a sensible thing to do.

> +/*
> + * Strip username information from the url and return it in a
> + * newly allocated string which the caller has to free.
> + *
> + * The url's we want to catch are the following:
> + *   ssh://[user@]host.xz[:port]/path/to/repo.git/
> + *   [user@]host.xz:/path/to/repo.git/
> + *   http[s]://[user[:password]@]host.xz/path/to/repo.git

If this is a valid URL:

	scheme://host.xz/path@with@at@sign.git/

we do not want to mistakenly trigger this logic.

I do not know if rsync://me@there/path is supported, but we should
generalize to support any scheme://me@there/path to keep the code simpler.
You do not do anything special based on the URL scheme other than learning
how long the scheme:// part is to copy it anyway.  Perhaps like...

char *transport_anonymize_url(const char *url)
{
	char *anon_url, *scheme_prefix, *anon_part;
	size_t len, prefix_len = 0;

	anon_part = strchr(url, '@');
	if (is_local(url) || !anon_part)
		goto literal_copy;

	anon_part++;
	scheme_prefix = strstr(url, "://");
	if (scheme_prefix) {
		const char *cp;
		/* make sure scheme is reasonable */
		for (cp = url; cp < scheme_prefix; cp++) {
			switch (*cp) { /* RFC 1738 2.1 */
			case '+':
			case '.':
			case '-':
				break; /* ok */
			default:
				if (isalnum(*cp))
					break;
				/* it isn't */
				goto literal_copy;
			}
		}
		/* @ past the first slash does not count */
		cp = strchr(scheme_prefix + 3, '/');
		if (cp < anon_part)
			goto literal_copy;
		prefix_len = scheme_prefix - url + 3;
	}
	else if (!strchr(anon_part, ':'))
		/* cannot be "me@there:/path/name" */
		goto literal_copy;
	len = prefix_len + strlen(anon_part);
	anon_url = xmalloc(len + 1);
	memcpy(anon_url, url, prefix_len);
	memcpy(anon_url + prefix_len, anon_part, strlen(anon_part));
	return anon_url;
 literal_copy:
	return xstrdup(url);
}
