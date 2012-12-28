From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 17/19] pathspec.c: extract new validate_path() for
 reuse
Date: Fri, 28 Dec 2012 12:44:43 -0800
Message-ID: <7v38ypj490.fsf@alter.siamese.dyndns.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-18-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 21:45:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tognh-0003fR-3t
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 21:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187Ab2L1Uoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 15:44:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63657 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689Ab2L1Uop (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 15:44:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49D27AC49;
	Fri, 28 Dec 2012 15:44:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qS5OBGFAQVQOfUQMyfN1NZrb2G4=; b=Yco7mj
	/X7AA0opd9XDIJnLC52LJi+38pfuJqVCsF2m7iuTBEmMBCLbB5O1S27vjYdXWmsw
	XyoRAFzSVNmPLrylKgKLDVNPS4EJEEOyvnNZIlODF3XuNvgFG5XP4fSvBaDEuJR2
	+F7NVqPdEP2+PacM3lHlJOhtTyLC3GZr9fY8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GFDfDJd3dOMc3VVII+BB2aPwI3ZbJXuS
	XAI2EpVDLuTxRXo2FTUfLlGnphSWkNQ+HkqG3cioXCbfVTHtr/oaqUQQa1Da07NU
	EKHorwfaLFI0ROvYtk8ABgV+5mgvYLziq+UdRfBxOO8IxU2/rIEMaAS+12fVqP95
	XV7ruuBMqaU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34997AC46;
	Fri, 28 Dec 2012 15:44:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92311AC43; Fri, 28 Dec 2012
 15:44:44 -0500 (EST)
In-Reply-To: <1356575558-2674-18-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Thu, 27 Dec 2012 02:32:36 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 694682AA-512F-11E2-96A9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212261>

Adam Spiers <git@adamspiers.org> writes:

> This will be reused by a new git check-ignore command.
>
> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---
>  pathspec.c | 20 ++++++++++++++------
>  pathspec.h |  1 +
>  2 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/pathspec.c b/pathspec.c
> index 8aea0d2..6724121 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -77,9 +77,20 @@ void treat_gitlinks(const char **pathspec)
>  }
>  
>  /*
> + * Dies if the given path refers to a file inside a symlinked
> + * directory.
> + */
> +void validate_path(const char *path, const char *prefix)

The name needs to be a lot more specific.

There may be 47 different kinds of "validations" various callers may
want to do on a path, but this function only caters to one kind of
callers that want to make sure that the path refers to something
that we would directly add to our index.

> +{
> +	if (has_symlink_leading_path(path, strlen(path))) {
> +		int len = prefix ? strlen(prefix) : 0;
> +		die(_("'%s' is beyond a symbolic link"), path + len);
> +	}
> +}
