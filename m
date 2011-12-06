From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] run-command: Add checks after execvp fails with
 EACCES
Date: Tue, 06 Dec 2011 14:35:53 -0800
Message-ID: <7vpqg1e3au.fsf@alter.siamese.dyndns.org>
References: <op.v5e8mgbc0aolir@keputer>
 <1323207503-26581-1-git-send-email-fransklaver@gmail.com>
 <1323207503-26581-2-git-send-email-fransklaver@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 23:36:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY3cI-0002MY-DM
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 23:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030Ab1LFWf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 17:35:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46374 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753421Ab1LFWf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 17:35:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C11035EA1;
	Tue,  6 Dec 2011 17:35:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VuBnp+Rpbe2aH75Zc2CMD7ZhSO8=; b=e5rHfN
	T4/vGC/OhlBMV29r/DUKYeNEdInKEo6A/WwPG3vmnUWujPGCOmyxASFsbtDlo3Kc
	PWrCheJhESwMJ80LwI2YCc5FjBMjm1Mo45WpNfVo3qcwyoMGVQBacApXHa2ci046
	yRpf+aKX+/GUADa7cGbc/ygoMugPqoR+otd1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MN7Uv8VZAvJnqURPWu4iaODfLt3bRoqh
	rPSZr2hnOibPaU27v7g/QgoI5TpDgvnYwYufLF9qdGT9E0W+JSGsmf50o7P0Dd2u
	WLndeBxvQCaS20fMp1WZdpGJpHqmL6jKxc9MCLHFwMEmswclSq7gbp7zcAWDK3OD
	7lhL86ESefA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B953B5EA0;
	Tue,  6 Dec 2011 17:35:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 301C45E9E; Tue,  6 Dec 2011
 17:35:55 -0500 (EST)
In-Reply-To: <1323207503-26581-2-git-send-email-fransklaver@gmail.com> (Frans
 Klaver's message of "Tue, 6 Dec 2011 22:38:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8FC5E80-205A-11E1-9AB9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186398>

Frans Klaver <fransklaver@gmail.com> writes:

> +#ifndef WIN32
> +static int is_in_group(gid_t gid)
> ...
> +static int have_read_execute_permissions(const char *path)
> +{
> +	struct stat s;
> +	trace_printf("checking '%s'\n", path);
> +
> +	if (stat(path, &s) < 0) {
> + ...
> +	/* check world permissions */
> +	if ((s.st_mode&(S_IXOTH|S_IROTH)) == (S_IXOTH|S_IROTH))
> +		return 1;

Hmm, do you need to do this with stat(2)?

Wouldn't access(2) with R_OK|X_OK give you exactly what you want without
this much trouble?

I also think that your permission check is incorrectly implemented.

    $ cd /var/tmp && date >j && chmod 044 j && ls -l j
    ----r--r-- 1 junio junio 29 Dec  6 14:32 j
    $ cat j
    cat: j: Permission denied
    $ su pogo
    Password:
    $ cat j
    Tue Dec  6 14:32:23 PST 2011
    
That's a world-readable but unreadable-only-to-me file.

> +static void diagnose_execvp_eacces(const char *cmd, const char **argv)
> +{
> +	/* man 2 execve states that EACCES is returned for:

	/*
         * Just a style, but we tend to write multi-line comment like
         * this, without anything else on opening and closing lines of
         * the comment block.
         */

> +	 * - The file system is mounted noexec
> +	 */
> +	struct strbuf sb = STRBUF_INIT;
> +	char *path = getenv("PATH");
> +	char *next;
> +
> +	if (strchr(cmd, '/')) {
> +		if (!have_read_execute_permissions(cmd))
> +			error("no read/execute permissions on '%s'\n", cmd);
> +		return;
> +	}

Ok, execvp() failed and "cmd" has at least one slash, so we know we did
not look for it in $PATH.  We check only one and return (did you need
getenv() in that case?).

> +	for (;;) {
> +		next = strchrnul(path, ':');
> +		if (path < next)
> +			strbuf_add(&sb, path, next - path);
> +		else
> +			strbuf_addch(&sb, '.');

Nice touch that you did not forget an empty component on $PATH.

> +		if (!have_read_execute_permissions(sb.buf))
> +			error("no read/execute permissions on '%s'\n", sb.buf);

Don't you want to continue here upon error, after resetting sb? You just
saw the directory is unreadble, so you know next file_exists() will fail
before you try it.

> +		if (sb.len && sb.buf[sb.len - 1] != '/')
> +			strbuf_addch(&sb, '/');
> +		strbuf_addstr(&sb, cmd);
> +
> +		if (file_exists(sb.buf)) {
> +			if (!have_read_execute_permissions(sb.buf))
> +				error("no read/execute permissions on '%s'\n",
> +						sb.buf);
> +			else
> +				warn("file '%s' exists and permissions "
> +				"seem OK.\nIf this is a script, see if you "
> +				"have sufficient privileges to run the "
> +				"interpreter", sb.buf);

Does "warn()" do the right thing for multi-line strings like this?
