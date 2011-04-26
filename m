From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] Add config variable for specifying default --dirstat
 behavior
Date: Tue, 26 Apr 2011 09:43:12 -0700
Message-ID: <7vtydlezfj.fsf@alter.siamese.dyndns.org>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <1303776102-9085-1-git-send-email-johan@herland.net>
 <1303776102-9085-5-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:43:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QElMH-0001XJ-Uz
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 18:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396Ab1DZQnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 12:43:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34715 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab1DZQnY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 12:43:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CCABC4CBB;
	Tue, 26 Apr 2011 12:45:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RnLH86QZCP3O/D3jB3BLl4PPRHQ=; b=qQ05qp
	z63JhuYYUz0qk54EeWCyDQShDf0WLPhKt7MyXORDuC5IY6qCO2K715voDeCgX3vG
	luW5mWwbdzYfwCLMfl0yGCx7xlXGkvxoHciB1M/QFJvA6P0OY+3qJmFAE/uLC+AU
	8q0gICcc1btb8WjcpuOlGdkBWavOGscC6mJ68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tTZWTGkgKGKADZDToTf6tyQSlCGuJbrO
	7HbF56ZmC2US26IT6FTwx109oTd9vPgfFvzD/htH3mTpA+VkN7GRZOsgIfZnyD/2
	My81ieLdvVt1oor0NDg8KgvIckFPQlQJIVfo1/TblGc0HRur/OEbyL12g6VqXa5F
	UgF9uQ5IKTM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 972C24CB8;
	Tue, 26 Apr 2011 12:45:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 141034CB7; Tue, 26 Apr 2011
 12:45:15 -0400 (EDT)
In-Reply-To: <1303776102-9085-5-git-send-email-johan@herland.net> (Johan
 Herland's message of "Tue, 26 Apr 2011 02:01:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9366CE5C-7024-11E0-BDD5-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172106>

Johan Herland <johan@herland.net> writes:

> diff --git a/diff.c b/diff.c
> index 08aaa47..20fe02c 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -45,6 +45,17 @@ static char diff_colors[][COLOR_MAXLEN] = {
>  	GIT_COLOR_NORMAL,	/* FUNCINFO */
>  };
>  
> +static void init_default_diff_options()
> +{
> +	static int initialized = 0;
> +	if (initialized)
> +		return;
> +
> +	default_diff_options.dirstat_percent = 3;
> +
> +	initialized = 1;
> +}

This smells fishy on two counts.

 . The rest of the diff machinery is designed to be callable multiple
   times by calling diff_setup(), and there should be no place for any
   call-once function like this one.

 . Why is dirstat-percent _so_ special that it is the only one that has to
   be initialized this way, when the function name implies that this is
   the central place to control the initialization of all diff related
   options?

> @@ -114,6 +125,44 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>  	return git_diff_basic_config(var, value, cb);
>  }
>  
> +static void dirstat_opt_args(struct diff_options *options, const char *args)
> +{
> +	const char *p = args;
> +	while (*p) {
> +		if (!prefixcmp(p, "changes")) {
> + ...
> +		}
> +	}
> +}

Please move this part to the previous patch in your reroll.  This helper
is what the previous patch should have been written with.
