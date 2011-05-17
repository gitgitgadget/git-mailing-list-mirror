From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add log.abbrevCommit config variable
Date: Tue, 17 May 2011 11:50:47 -0700
Message-ID: <7vy625f9fc.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=og+e6JW8t+sCvkFJUnR=SrFtWGg@mail.gmail.com>
 <1305413341-56450-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 20:51:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMPMH-0007fI-Qm
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 20:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482Ab1EQSu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 14:50:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756469Ab1EQSu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 14:50:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6F3DF58EE;
	Tue, 17 May 2011 14:53:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TYt8RMw3YPWShEw9pKOXOxLFEF0=; b=XyoXmC
	dtz5i6t3h7Bo4QuRdNzbHAzKtsc5q3lOJMw73tTSg5C+xrDsWvRu3+f9XYYN771r
	9d502G6TE43FA3biTzdIEHV2tpDrmLJglq/yQ0rEHmnOnZQsqs9L+Yb4emkvw9KE
	26M6wOHvWPSqM+ySxs+uU4FPTDfRk/i4SBvu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IG1URmgNEX8t0ozvm6BJ4QZR2E4oY3Ba
	OF28DoYMKOF+gsVHvitscU6rwP0SpXYMSXYZBsS5T4tqX0NuV7+ZR4T0WnXKQ0Io
	c7SjZmqZqZURUXPCY8PDaJqeUG/QpIiLbSd11ffyUhk3t3PtSNKbX/TuWMy9Sxqd
	j5s5HOt+87E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3145058ED;
	Tue, 17 May 2011 14:53:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0DEAD58E5; Tue, 17 May 2011
 14:52:55 -0400 (EDT)
In-Reply-To: <1305413341-56450-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Sat, 14 May 2011 18:49:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2F40348-80B6-11E0-B2DD-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173818>

Jay Soffian <jaysoffian@gmail.com> writes:

> @@ -137,6 +139,12 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  	    && rev->commit_format == CMIT_FMT_RAW)
>  		decoration_style = 0;
>  
> +	/* ditto for log.abbrevCommit */
> +	if (!rev->abbrev_commit_given && rev->abbrev_commit
> +	    && rev->commit_format == CMIT_FMT_RAW)
> +		rev->abbrev_commit = 0;
> +
> +

This is not exactly "ditto"; the lines before this hunk look like this:

	/*
	 * defeat log.decorate configuration interacting with --pretty=raw
	 * from the command line.
	 */
	if (!decoration_given && rev->pretty_given
	    && rev->commit_format == CMIT_FMT_RAW)
		decoration_style = 0;

The check for pretty-given and commit-format being raw is to catch only
the case where the command line said --pretty=raw, excluding any case the
commit-format is set to raw without any explicit --pretty=raw on the
command line.  So at the logical level, this one should be read as if it
was written like this:

	if (rev->pretty_given && rev->commit_format == CMIT_FMT_RAW) {
        	/* "log --pretty=raw" is special */
        	if (!decoration_given)
			decoration_style = 0;
	}

even though the existing one makes it look as if checking decoration-given
and pretty-given together when commit-format is set to raw.

Care to explain why your check has to be different?  If there is no reason
to use a different logic, then a natural thing to do is to rewrite the
existing decoration logic and add yours like this:

	if (rev->pretty_given && rev->commit_format == CMIT_FMT_RAW) {
        	/* "log --pretty=raw" is special */
        	if (!decoration_given)
			decoration_style = 0;
		if (!abbrev_commit_given)
			rev->abbrev_commit = 0;
	}
