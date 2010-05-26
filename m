From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] refs: split log_ref_write logic into log_ref_setup
Date: Tue, 25 May 2010 22:07:03 -0700
Message-ID: <7v632bs13c.fsf@alter.siamese.dyndns.org>
References: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com>
 <1274488119-6989-3-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 07:07:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH8pp-0005GL-OU
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 07:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab0EZFHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 01:07:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab0EZFHL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 01:07:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE86CB679D;
	Wed, 26 May 2010 01:07:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=+Uy3WII6mE+d72AN2NwfBJ3acE8=; b=fwx1qhWYZjOlJLtiwe/S87k
	nEwpHu6iRNYdAHAvZqUAXkQagPLdrlX04WFwjN9jyXmYM+NTd/CAmnhSpCRIyiL/
	BiKwtQm5Ud7eaor82pYU85CxAc4URcSxli33+FPtBkh3H3vf0gFHN8aTWzT8SLwX
	baYSWA2XECQGIvgOBAic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=mYQa9PWWn1LLqvsc6EX3AHiAgM/Z6N/YHxgco6kwM7/Zk3Wyx
	rPxFhBgl1Am+YDGAxIT0t2FhCMzJR1GemBIDvWHsqwoL5hE29JlAiQmLoj0WH17A
	mCBUnBmJNfnJaQAo9gNxsLzN4qZ5GWflBGNs0dRnU6/TDuLgTHKs8LPI6g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD003B6798;
	Wed, 26 May 2010 01:07:08 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF948B6797; Wed, 26 May
 2010 01:07:04 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 88EF0636-6884-11DF-8037-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147734>

Erick Mattos <erick.mattos@gmail.com> writes:

> -static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
> -			 const unsigned char *new_sha1, const char *msg)
> +int log_ref_setup(const char *ref_name, char **log_file)
>  {
> -	int logfd, written, oflags = O_APPEND | O_WRONLY;
> -	unsigned maxlen, len;
> -	int msglen;
> -	char log_file[PATH_MAX];
> -	char *logrec;
> -	const char *committer;
> -
> -	if (log_all_ref_updates < 0)
> -		log_all_ref_updates = !is_bare_repository();
> -
> -	git_snpath(log_file, sizeof(log_file), "logs/%s", ref_name);
> +	int logfd, oflags = O_APPEND | O_WRONLY;
> +	char logfile[PATH_MAX];
> +	git_snpath(logfile, sizeof(logfile), "logs/%s", ref_name);
> +	*log_file = logfile;
> ...

I have a slight suspicion that it would have made the patch smaller and
easier to read if you kept the name of the on-stack log_file[] as-is, and
named the retval parameter logfile_p or soemthing.  Also you would need to
make this buffer "static char log_file[]", no?  Otherwise you would be
returning a pointer to a dead buffer to the caller.

> +static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
> +			 const unsigned char *new_sha1, const char *msg)
> +{
> + ...
> +	result = log_ref_setup(ref_name, &log_file);
> +	if (result)
> +		return result;
> +
> +	logfd = open(log_file, oflags);

Yuck, the caller needs to call "setup" which discards the file descriptor
opened for writing and then open it again itself?
