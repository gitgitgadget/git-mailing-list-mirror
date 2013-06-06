From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/9] sequencer: run post-rewrite hook
Date: Thu, 06 Jun 2013 11:40:25 -0700
Message-ID: <7v7gi7yteu.fsf@alter.siamese.dyndns.org>
References: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
	<1370509144-31974-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 20:40:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukf6u-0005Bk-TQ
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 20:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326Ab3FFSk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 14:40:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57192 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971Ab3FFSk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 14:40:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9BDD22E72;
	Thu,  6 Jun 2013 18:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fb1OW5o/umnx3OdwHXHou5pNjYs=; b=qtRue9
	fFw3G1hRb0nfg612NcVLbs1nS1PTfL6+6w4hYbXZ8KtQhUmMDVdHxYZrBPu6sd3R
	kHl8C3BssAZ0tzIHTwYarRGL9oz9rYT8VQqe8FTCtNzQ+5cguZGFRPPU9m6GpRbp
	/wvgt0rksQs1PHY+fr43Y2LOvnpzWsjd2Q7LY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l7gWud//LW9GzH/EBHEKBzdGUlYCojia
	TKj6mtr7KSYzjGAPExmWjWku2+r9Kt5oatcqvkjgCg2CQpsNmFKRroeAbmBCEop/
	/tWIKuR5x2omQNh0GjemSLMrqMcDbXbinP8+IX6ztr8AvZu/Z2MBY/U4eYI4d5RJ
	SUUDDn1R3bM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DE6D22E70;
	Thu,  6 Jun 2013 18:40:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B09922E6F;
	Thu,  6 Jun 2013 18:40:27 +0000 (UTC)
In-Reply-To: <1370509144-31974-6-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 6 Jun 2013 03:59:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E5C264A-CED8-11E2-A433-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226527>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> As we should.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  sequencer.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 76ff2ff..74480d7 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -127,6 +127,37 @@ static void add_rewritten(unsigned char *from, unsigned char *to)
>  	rewritten.nr++;
>  }
>  
> +static void run_rewrite_hook(const char *name)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct child_process proc;
> +	const char *argv[3];
> +	int code, i;
> +
> +	argv[0] = find_hook("post-rewrite");
> +	if (!argv[0])
> +		return;
> +
> +	argv[1] = name;
> +	argv[2] = NULL;
> +
> +	memset(&proc, 0, sizeof(proc));
> +	proc.argv = argv;
> +	proc.in = -1;
> +	proc.stdout_to_stderr = 1;
> +
> +	code = start_command(&proc);
> +	if (code)
> +		return;
> +	for (i = 0; i < rewritten.nr; i++) {
> +		struct rewritten_list_item *item = &rewritten.items[i];
> +		strbuf_addf(&buf, "%s %s\n", sha1_to_hex(item->from), sha1_to_hex(item->to));
> +	}
> +	write_in_full(proc.in, buf.buf, buf.len);
> +	close(proc.in);
> +	finish_command(&proc);
> +}

It probably is worth inserting a commit before 4/9 that adds
rewrite.[ch], and

 - introduces "struct rewritten_list[_item]";

 - moves run_rewrite_hook() in builtin/commit.c to rewrite.c;

 - changes its function signature so that it takes "char
   *action_name" and "struct rewritten *" as parameters; and

 - adjust its sole call site in cmd_commit() to feed a single-item
   rewritten_list to it.

Then 4/9 can teach cherry-pick to prepare the rewritten-list and
probably this commit can be part of that to call run_rewrite_hook().
