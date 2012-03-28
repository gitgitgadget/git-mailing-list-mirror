From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 13:43:39 -0700
Message-ID: <7vzkb0tq10.fsf@alter.siamese.dyndns.org>
References: <20120327180503.GB4659@sigill.intra.peff.net>
 <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
 <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino> <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
 <20120328194516.GD8982@burratino>
 <20120328201851.GA29315@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 22:43:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCzie-0000rK-0I
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 22:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746Ab2C1Unn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 16:43:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35180 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758014Ab2C1Unm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 16:43:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4D6C65EF;
	Wed, 28 Mar 2012 16:43:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tw5GCOUkKYutEzlrOq927YXs3AM=; b=pFQuoy
	K2PqY/X/AU0cx0wlnvNS3FXRAcuXxkoWzqBH21hEk/vwWOm9+ahfRQ5YZ5mFbTXL
	pamSysy25Ev8V4YWZqMhCyNkupJwMytk8y/kGs9NrOie1VPvxaziD7l5TRRZ/Djn
	ZbHNhRfZxRdMnSs1IPU5+WlPHrKAaRrK0m+VQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QT6fIqQJCniR8Y2EEAzlbROoezVpygFF
	kbq4S2i50SA1quaNDyFp6EWLCm3kWPUfYbDw3qJ7w8uogyUhhee6FwnLDCeey9wG
	HMA5KCMKgdfa5EyJYSdy8KTGZ7uAnZWTjmlQjKP84B3D8IQ3fBtU1IFrRhhApTsb
	U1DOHpGIe6o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC32065EE;
	Wed, 28 Mar 2012 16:43:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 595F065ED; Wed, 28 Mar 2012
 16:43:41 -0400 (EDT)
In-Reply-To: <20120328201851.GA29315@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 28 Mar 2012 16:18:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B3FD6CD8-7916-11E1-AE77-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194191>

Jeff King <peff@peff.net> writes:

> +static int file_in_path_is_nonexecutable(const char *file)
> +{
> +	const char *p = getenv("PATH");
> +
> +	if (!p)
> +		return 0;
> +
> +	while (1) {
> +		const char *end = strchrnul(p, ':');
> +		const char *path;
> +		struct stat st;
> +
> +		path = mkpath("%.*s/%s", (int)(end - p), p, file);

Given PATH=":/usr/bin:/bin" and file "frotz" (please call it "cmd" or
something, by the way), end points at the first colon and path becomes
"/frotz".  Oops?

> +		if (!stat(path, &st) && access(path, X_OK) < 0)
> +			return 1;
> +
> +		if (!*end)
> +			break;
> +
> +		p = end + 1;
> +	}
> +
> +	return 0;
> +}
> +
> +int sane_execvp(const char *file, char * const argv[])
> +{
> +	int ret = execvp(file, argv);
> +	if (ret < 0 && errno == EACCES && !file_in_path_is_nonexecutable(file))
> +		errno = ENOENT;
> +	return ret;

Double negation makes my head hurt, but unfortunately, we cannot rename it
to "executable_exists_on_path()" and negate its return value.

Anyway, the logic is to set errno to ENOENT when

 - We tried to exec, and got EACCES; and
 - There is a file on the PATH that lacks executable bit.

In such a case, the error from execvp() is not about the file it tried to
execute lacked executable bit, but there was nothing that match the name,
but it couldn't be certain because some directories were not readable.

OK.  I think I can follow that logic.

If there are more than one entry on PATH, and a system call made during
first round of the loop fails but a later round finds a non-executable
file, i.e.

	$ PATH=/nosuch:/home/peff/bin; export PATH
        $ >/home/peff/bin/frotz; chmod -x /home/peff/bin/frotz
        git frotz

we would get EACCES from execvp(), the first round runs stat("/nosuch/frotz")
and sets errno to ENOTDIR, and the second round runs stat() and access()
on "/home/peff/bin/frotz" and returns 1 to say "Yeah, there is a plain
file frotz that cannot be executed".

And sane_execvp() will return ENOTDIR?

So sane_execvp() would probably need to do a bit more (but not that much).

	if (ret < 0 && errno == EACCES)
		errno = file_in_path_is_nonexecutable(file) ? EACCES : ENOENT;
	return ret;

or something.
