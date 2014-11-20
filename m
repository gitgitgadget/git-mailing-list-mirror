From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] refs.c: add a function to append a reflog entry to a fd
Date: Thu, 20 Nov 2014 13:42:34 -0800
Message-ID: <xmqq4mtt35x1.fsf@gitster.dls.corp.google.com>
References: <20141120023655.GG6527@google.com>
	<1416508657-9057-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 22:42:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrZV2-0006KL-9s
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 22:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788AbaKTVmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 16:42:39 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751075AbaKTVmi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 16:42:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DBDB1E14C;
	Thu, 20 Nov 2014 16:42:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yfGK+PzpCnGeQ8luTC/NQTAqeDo=; b=V8DcCx
	PNf3guSMCiYOeqkxt72tniMmJ2Tk/CdYRHWPWmbejz8X1WxOF2nBLumqpt6mbnjh
	UZZgqmPB4LyZpkBfdqdvWbTnzJJkpBVaTGsYm1XO6RryWdsLd+IFSmqBjH+w+wYP
	xyTgLwQLSpz6udCsfykXx+3RnhkxFjX9I6sTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xMkmMJeMdfwZX4mpvmmseLQZtIYmkGjB
	BMCL7z5YuEMGxkbT8jYNAO7u8ewBDm5EYD295Oe8mq1T440bEU/Nk5d7fRFs6zc3
	MV58aYhn1oiYZMjYpkqhuv4tmUVFGTz+iT0G4XroGey3cPAVv0qWJpcBBmZS6vs+
	sDkHDLy52y8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 43B1C1E14A;
	Thu, 20 Nov 2014 16:42:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9F031E149;
	Thu, 20 Nov 2014 16:42:35 -0500 (EST)
In-Reply-To: <1416508657-9057-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 20 Nov 2014 10:37:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 241B005C-70FE-11E4-B2A8-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> From: Ronnie Sahlberg <sahlberg@google.com>
>
> Move code to create the string for a ref and write it to a file descriptor
> from log_ref_write and add it into a new dedicated function
> log_ref_write_fd.
>
> For now the new function is only used from log_ref_write, but later
> on we will call this function from reflog transactions too. That means
> that we will end up with only a single place, where we write a
> reflog entry to a file instead of the current two places
> (log_ref_write and builtin/reflog.c).
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Changes in version 3:
> * reword the commit message to make it more understandable.
> * no changes in code
> * wait for the follow up to address any changes in the code.
>
>  refs.c | 48 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 18 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 5ff457e..9948841 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2990,15 +2990,37 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
>  	return 0;
>  }
>  
> +static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
> +			    const unsigned char *new_sha1,
> +			    const char *committer, const char *msg)
> +{
> +	int msglen, written;
> +	unsigned maxlen, len;
> +	char *logrec;
> +
> +	msglen = msg ? strlen(msg) : 0;
> +	maxlen = strlen(committer) + msglen + 100;
> +	logrec = xmalloc(maxlen);
> +	len = sprintf(logrec, maxlen, "%s %s %s\n",

You cannot have maxlen here ;-)

> +		      sha1_to_hex(old_sha1),
> +		      sha1_to_hex(new_sha1),
> +		      committer);
> +	if (msglen)
> +		len += copy_msg(logrec + len - 1, msg) - 1;
> +
> +	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
> +	free(logrec);
> +	if (written != len)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int log_ref_write(const char *refname, const unsigned char *old_sha1,
>  			 const unsigned char *new_sha1, const char *msg)
>  {
> -	int logfd, result, written, oflags = O_APPEND | O_WRONLY;
> -	unsigned maxlen, len;
> -	int msglen;
> +	int logfd, result, oflags = O_APPEND | O_WRONLY;
>  	char log_file[PATH_MAX];
> -	char *logrec;
> -	const char *committer;
>  
>  	if (log_all_ref_updates < 0)
>  		log_all_ref_updates = !is_bare_repository();
> @@ -3010,19 +3032,9 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
>  	logfd = open(log_file, oflags);
>  	if (logfd < 0)
>  		return 0;
> -	msglen = msg ? strlen(msg) : 0;
> -	committer = git_committer_info(0);
> -	maxlen = strlen(committer) + msglen + 100;
> -	logrec = xmalloc(maxlen);
> -	len = sprintf(logrec, "%s %s %s\n",
> -		      sha1_to_hex(old_sha1),
> -		      sha1_to_hex(new_sha1),
> -		      committer);
> -	if (msglen)
> -		len += copy_msg(logrec + len - 1, msg) - 1;
> -	written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
> -	free(logrec);
> -	if (written != len) {
> +	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
> +				  git_committer_info(0), msg);
> +	if (result) {
>  		int save_errno = errno;
>  		close(logfd);
>  		error("Unable to append to %s", log_file);
