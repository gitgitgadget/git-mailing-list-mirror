From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/20] rename_tmp_log(): use raceproof_create_file()
Date: Wed, 17 Feb 2016 12:53:32 -0800
Message-ID: <xmqqmvqzhxdf.fsf@gitster.mtv.corp.google.com>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
	<a19192cb3219de9304af7d9b97be45a5e6f0895f.1455626201.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 17 21:53:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW96R-0002X5-7b
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 21:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965641AbcBQUxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 15:53:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965407AbcBQUxe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 15:53:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D38E4402A;
	Wed, 17 Feb 2016 15:53:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tiV6ErqHXDn+WBYj1e7ref+l6HA=; b=v27Q7i
	haIj6uwmHvgsTeEzdxxFD1WyGJZcdu2YfWSSi+xdq1fCDZeJuAeLICkafAOExayn
	NY6x57AmOJ8Ha1phy6pPPed9FJzoA2pFMHDoCRA0bFHF7anFIMCiTgpYUZkpvNLf
	xIrVPGPTaMlQRf86s3QT0Mgt0E6H3QZCmCo/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RsJe5x+/r2/n9vry1iN3rNIbAVWNFWI+
	6p4/C5nZlz13bV3JPomRmAAp9htNTlM+zn1kTZ1kR7+/vYi5M83+ZiZPBc0b4x4Q
	Oe71rVJmsPM8hUMAAHEujU0iCE19QeQd0Jj5jwRYEcvQcwWSq14PCUYLwUHgrCi+
	N3RgF/honwI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 03C9344028;
	Wed, 17 Feb 2016 15:53:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 61FB044024;
	Wed, 17 Feb 2016 15:53:33 -0500 (EST)
In-Reply-To: <a19192cb3219de9304af7d9b97be45a5e6f0895f.1455626201.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Tue, 16 Feb 2016 14:22:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 81E7D71C-D5B8-11E5-86C7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286550>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Besides shortening the code, this saves an unnecessary call to
> safe_create_leading_directories_const() in almost all cases.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs/files-backend.c | 76 ++++++++++++++++++++++------------------------------
>  1 file changed, 32 insertions(+), 44 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index a549942..e5f964c 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2400,55 +2400,43 @@ out:
>   */
>  #define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"
>  
> +static int rename_tmp_log_callback(const char *path, void *cb)
> +{
> +	int *true_errno = cb;
> +
> +	if (rename(git_path(TMP_RENAMED_LOG), path)) {
> +		/*
> +		 * rename(a, b) when b is an existing directory ought
> +		 * to result in ISDIR, but Solaris 5.8 gives ENOTDIR.
> +		 * Sheesh. Record the true errno for error reporting,
> +		 * but report EISDIR to raceproof_create_file() so
> +		 * that it knows to retry.
> +		 */
> +		*true_errno = errno;
> +		if (errno==ENOTDIR)
> +			errno = EISDIR;

Style: SP on both sides of a binary operator.

More importantly, is ENOTDIR expected only on a buggy platform?  

[ENOTDIR]
    A component of either path prefix names an existing file that is
    neither a directory nor a symbolic link to a directory; or the old
    argument names a directory and the new argument names a
    non-directory file; or the old argument contains at least one non-
    <slash> character and ends with one or more trailing <slash>
    characters and the last pathname component names an existing file
    that is neither a directory nor a symbolic link to a directory; or
    the old argument names an existing non-directory file and the new
    argument names a nonexistent file, contains at least one non-
    <slash> character, and ends with one or more trailing <slash>
    characters; or the new argument names an existing non-directory
    file, contains at least one non- <slash> character, and ends with
    one or more trailing <slash> characters.

i.e. when a leading component of "path" or TMP_RENAMED_LOG is an
existing non-directory, we could get ENOTDIR on a valid system.

If another instance of Git created a file A/B when this process is
trying to rename the temporary thing to its final location A/B/C,
isn't that the errno we would see here?

[EISDIR]
    The new argument points to a directory and the old argument
    points to a file that is not a directory.

Puzzled...

> +		return -1;
> +	} else {
> +		return 0;
> +	}
> +}
> +
>  static int rename_tmp_log(const char *newrefname)
>  {
> -	int attempts_remaining = 4;
> -	struct strbuf path = STRBUF_INIT;
> -	int ret = -1;
> +	char *path = git_pathdup("logs/%s", newrefname);
> +	int true_errno;
> +	int ret;
>  
> - retry:
> -	strbuf_reset(&path);
> -	strbuf_git_path(&path, "logs/%s", newrefname);
> -	switch (safe_create_leading_directories_const(path.buf)) {
> -	case SCLD_OK:
> -		break; /* success */
> -	case SCLD_VANISHED:
> -		if (--attempts_remaining > 0)
> -			goto retry;
> -		/* fall through */
> -	default:
> -		error("unable to create directory for %s", newrefname);
> -		goto out;
> -	}
> -
> -	if (rename(git_path(TMP_RENAMED_LOG), path.buf)) {
> -		if ((errno==EISDIR || errno==ENOTDIR) && --attempts_remaining > 0) {
> -			/*
> -			 * rename(a, b) when b is an existing
> -			 * directory ought to result in ISDIR, but
> -			 * Solaris 5.8 gives ENOTDIR.  Sheesh.
> -			 */
> -			if (remove_empty_directories(&path)) {
> -				error("Directory not empty: logs/%s", newrefname);
> -				goto out;
> -			}
> -			goto retry;
> -		} else if (errno == ENOENT && --attempts_remaining > 0) {
> -			/*
> -			 * Maybe another process just deleted one of
> -			 * the directories in the path to newrefname.
> -			 * Try again from the beginning.
> -			 */
> -			goto retry;
> -		} else {
> +	ret = raceproof_create_file(path, rename_tmp_log_callback, &true_errno);
> +	if (ret) {
> +		if (true_errno==EISDIR)
> +			error("Directory not empty: %s", path);
> +		else
>  			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
> -				newrefname, strerror(errno));
> -			goto out;
> -		}
> +				newrefname, strerror(true_errno));
>  	}
> -	ret = 0;
> -out:
> -	strbuf_release(&path);
> +
> +	free(path);
>  	return ret;
>  }
