From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] gpg-interface: check good signature in a reliable
 way
Date: Thu, 14 Feb 2013 09:22:36 -0800
Message-ID: <7vzjz624kj.fsf@alter.siamese.dyndns.org>
References: <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com>
 <e0f3c48e474c64e33c67c772468bbf7bba0169af.1360857415.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mariusz Gronczewski <xani666@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 18:23:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U62WY-0000It-Et
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 18:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931Ab3BNRWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 12:22:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44751 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964846Ab3BNRWl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 12:22:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DB31C1E6;
	Thu, 14 Feb 2013 12:22:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zjH/4Hgm3Fo4NWewhfpfvhEguHA=; b=L1Dkvd
	B8aKTw/tkmSzrkVjy30E62cjP+ieqJmpHQQL1nC2rV57GD4ZOCc7l/YbTK5t8dTN
	dM6jmycCf1SnnPHKakbQMJNAilRfiePb7pebrRJFoTB8ZnG8wHWYJ2zJKe5uwhpl
	ILEYpwCgarEoQIhQlJjhQRaixd5pM49MNgOvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rT9mj7udt/t8s3uEV1FCE6yOxC8nWHKK
	Avra3oOILxMJXsEpbITLaVgLGadj89IriCmQMzdGipgVTOnLE1gI21NVw+AFoR8Y
	Up9LcYT6xiOLbmzW99Fh9aQVwfB973PQscLB/15gaJhEROwLaPSHXaTDAG+PzJDM
	fxXK6lgmRFM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFEE0C1E4;
	Thu, 14 Feb 2013 12:22:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21748C1D1; Thu, 14 Feb 2013
 12:22:40 -0500 (EST)
In-Reply-To: <e0f3c48e474c64e33c67c772468bbf7bba0169af.1360857415.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu, 14 Feb 2013 17:04:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22613D3C-76CB-11E2-8873-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216325>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, verify_signed_buffer() only checks the return code of gpg,
> and some callers implement additional unreliable checks for "Good
> signature" in the gpg output meant for the user.
>
> Use the status output instead and parse for a line beinning with
> "[GNUPG:] GOODSIG ". This is the only reliable way of checking for a
> good gpg signature.
>
> If needed we can change this easily to "[GNUPG:] VALIDSIG " if we want
> to take into account the trust model.

Thanks.  I didn't look beyond "man gpg" nor bother looking at
DETAILS file in its source, which the manpage refers to.

I think GOODSIG is a good starting point.  Depending on the context
(e.g. "%G?") we may also want to consider EXPSIG (but not EXPKEYSIG
or REVKEYSIG) acceptable, while reading "log --show-signature" on
ancient part of the history, no?

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  gpg-interface.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 4559033..c582b2e 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -96,15 +96,17 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
>  /*
>   * Run "gpg" to see if the payload matches the detached signature.
>   * gpg_output, when set, receives the diagnostic output from GPG.
> + * gpg_status, when set, receives the status output from GPG.
>   */
>  int verify_signed_buffer(const char *payload, size_t payload_size,
>  			 const char *signature, size_t signature_size,
>  			 struct strbuf *gpg_output)
>  {
>  	struct child_process gpg;
> -	const char *args_gpg[] = {NULL, "--verify", "FILE", "-", NULL};
> +	const char *args_gpg[] = {NULL, "--status-fd=1", "--verify", "FILE", "-", NULL};
>  	char path[PATH_MAX];
>  	int fd, ret;
> +	struct strbuf buf = STRBUF_INIT;
>  
>  	args_gpg[0] = gpg_program;
>  	fd = git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
> @@ -119,9 +121,10 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
>  	memset(&gpg, 0, sizeof(gpg));
>  	gpg.argv = args_gpg;
>  	gpg.in = -1;
> +	gpg.out = -1;
>  	if (gpg_output)
>  		gpg.err = -1;
> -	args_gpg[2] = path;
> +	args_gpg[3] = path;
>  	if (start_command(&gpg)) {
>  		unlink(path);
>  		return error(_("could not run gpg."));
> @@ -134,9 +137,15 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
>  		strbuf_read(gpg_output, gpg.err, 0);
>  		close(gpg.err);
>  	}
> +	strbuf_read(&buf, gpg.out, 0);
> +	close(gpg.out);
> +
>  	ret = finish_command(&gpg);
>  
>  	unlink_or_warn(path);
>  
> +	ret |= !strstr(buf.buf, "\n[GNUPG:] GOODSIG ");
> +	strbuf_release(&buf);
> +
>  	return ret;
>  }
