From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] run-command: propagate EACCES errors to parent
Date: Tue, 27 Mar 2012 11:24:02 -0700
Message-ID: <7vhax9j41p.fsf@alter.siamese.dyndns.org>
References: <20120327175933.GA1716@sigill.intra.peff.net>
 <20120327180425.GA4659@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 20:24:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCb41-00043r-Jd
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 20:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509Ab2C0SYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 14:24:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50654 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755118Ab2C0SYG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 14:24:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABA146AC1;
	Tue, 27 Mar 2012 14:24:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DAAC+Lb5NG1mPgoaX+6DWrtpbsM=; b=oSNuXK
	Cy659UStjXIOWeQ7Yq90mSaBoivJhgIFpBGf/Lz43YAL6uHdf/KOflcm12uqvgg+
	t5TxHjDVzNSFXIDgdOoBHnZ3WfTnqrwr0iNrlFtqxgxQ1Ex0+Gw093c/G11RORS8
	j4rekEOEdKonKJRMNMXWH5w51r4XoSchrgtsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EKygFTXzM92HPayeLqTb7x2Oq/0Qcj1S
	LIDu4YT1ZH4Uq8e6xHhixkYOJUobw3lc6m7hnvyuCMSN/kaANfjZdghEGdHOD0+I
	UDpT/JHXDTGqLjbLmnAri8LQo9jG03JZRaVTBx1yIbyhPZbVuRe4xCwfITT3hzc3
	QXAgKC93VR0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2CCF6AC0;
	Tue, 27 Mar 2012 14:24:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36F346ABF; Tue, 27 Mar 2012
 14:24:04 -0400 (EDT)
In-Reply-To: <20120327180425.GA4659@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 27 Mar 2012 14:04:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0868F554-783A-11E1-A310-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194069>

Jeff King <peff@peff.net> writes:

> The caller of run_command does not directly get access to
> the errno from exec, because it happens in the forked child.
> However, knowing the specific reason for an exec failure can
> help the parent respond better or produce better error
> messages.
>
> We already propagate ENOENT to the parent via exit code 127.
> Let's do the same for EACCES with exit code 126, which is
> already used by bash to indicate the same thing.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Actually, there is a slight bending of the truth in the commit message.
> bash implements its own execvp, and it will only return 126/EACCES if a
> file is found via stat(), but is not executable. If there is an
> inaccessible directory in the PATH (meaning that stat() will fail), it
> will silently convert that to 127/ENOENT.

I am wondering what would happen if we treated EACCESS and ENOENT exactly
the same way.  Wouldn't the four breakage scenarios in the cover letter
end up being even better?  Case (3) will still say does-not-exist is not a
git command (instead of "permission denied", which this patch gives), but
your case (2) will see a much better diagnosis.

Take the above with a grain of salt, though, as this is written soon after
I wrote my response to James (the one with "I may be a mean person").

>  run-command.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/run-command.c b/run-command.c
> index 1db8abf..e303beb 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -185,6 +185,10 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
>  			code = -1;
>  			failed_errno = ENOENT;
>  		}
> +		else if (code == 126) {
> +			code = -1;
> +			failed_errno = EACCES;
> +		}
>  	} else {
>  		error("waitpid is confused (%s)", argv0);
>  	}
> @@ -346,6 +350,11 @@ fail_pipe:
>  				error("cannot run %s: %s", cmd->argv[0],
>  					strerror(ENOENT));
>  			exit(127);
> +		} else if (errno == EACCES) {
> +			if (!cmd->silent_exec_failure)
> +				error("cannot run %s: %s", cmd->argv[0],
> +					strerror(errno));
> +			exit(126);
>  		} else {
>  			die_errno("cannot exec '%s'", cmd->argv[0]);
>  		}
