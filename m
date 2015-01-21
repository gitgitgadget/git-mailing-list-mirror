From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] refs.c: write to a lock file only once
Date: Wed, 21 Jan 2015 18:44:28 -0500
Message-ID: <20150121234428.GD11115@peff.net>
References: <1421882625-916-1-git-send-email-sbeller@google.com>
 <1421882625-916-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
	loic@dachary.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 00:44:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE4ws-0005to-79
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 00:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbbAUXoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 18:44:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:37110 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751503AbbAUXo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 18:44:29 -0500
Received: (qmail 2579 invoked by uid 102); 21 Jan 2015 23:44:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 17:44:29 -0600
Received: (qmail 1949 invoked by uid 107); 21 Jan 2015 23:44:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 18:44:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2015 18:44:28 -0500
Content-Disposition: inline
In-Reply-To: <1421882625-916-6-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262786>

On Wed, Jan 21, 2015 at 03:23:44PM -0800, Stefan Beller wrote:

> +	const char *sha1_lf;
>  
>  	if (!lock) {
>  		errno = EINVAL;
> @@ -3104,8 +3104,9 @@ static int write_ref_sha1(struct ref_lock *lock,
>  		errno = EINVAL;
>  		return -1;
>  	}
> -	if (write_in_full_to_lockfile(lock->lk, sha1_to_hex(sha1), 40) != 40 ||
> -	    write_in_full_to_lockfile(lock->lk, &term, 1) != 1 ||
> +
> +	sha1_lf = xstrfmt("%s\n",  sha1_to_hex(sha1));
> +	if (write_in_full_to_lockfile(lock->lk, sha1_lf, 41) != 41 ||
>  	    close_ref(lock) < 0) {
>  		int save_errno = errno;
>  		error("Couldn't write %s", lock->lk->filename.buf);
> @@ -3113,6 +3114,7 @@ static int write_ref_sha1(struct ref_lock *lock,
>  		errno = save_errno;
>  		return -1;
>  	}
> +	free((void*)sha1_lf);

It looks like you leak sha1_lf in the error code path here.

It's a shame that we must allocate at all, when we are really just
passing through to a buffer. Lockfiles have a "FILE *" pointer these
days. Could we just allow:

  lockfile_printf(lock->lk, "%s\n", sha1_to_hex(sha1));

or similar?

-Peff
