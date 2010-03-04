From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/3] git-core: Support retrieving passwords with
 GIT_ASKPASS
Date: Thu, 04 Mar 2010 10:26:22 -0800
Message-ID: <7vd3zk6j01.fsf@alter.siamese.dyndns.org>
References: <1267713364-2976-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j6t@kdbg.org, j.sixt@viscovery.net
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 19:26:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnFkv-0007X4-Tm
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 19:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671Ab0CDS0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 13:26:36 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab0CDS0f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 13:26:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EAEB9F8CC;
	Thu,  4 Mar 2010 13:26:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/91L1U9+Bf/WclRhUsSojLtAmj0=; b=h6XGYb
	Rgxqa/EgxY5ox9bfrUw/VYtPII6sSS1Nf2iIa3+Q1B19dndmvUh+Rtoi7Q2SVg7q
	f9M09ionuby8krnVqXCqcJLFmd00RenlHiSS3c+Z2heFwDZa6ZxtN4cmaOOXy07t
	KTwA6yRodToT1r2h9ULvTNImSBiLvE2uzOplI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cjIhXA77bajUyx4tJHhBT0uTtAzwYBmD
	rA0UA7PtRLdh/7fITfpiwqEAIuiwzi3Ysh/T3xOlZ4Q2GAWZ47YcUzkIVrXoFGAT
	S7BGMjY0EsungvY1JW1P1jJwOs/g4h8aPdvsGoyTA/ojJc6vy91RPfM1N2Kljh9Q
	XxmxBUJqgLE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E07F69F8C7;
	Thu,  4 Mar 2010 13:26:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11F389F8C5; Thu,  4 Mar
 2010 13:26:23 -0500 (EST)
In-Reply-To: <1267713364-2976-1-git-send-email-lznuaa@gmail.com> (Frank Li's
 message of "Thu\,  4 Mar 2010 22\:36\:04 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 732A1D0E-27BB-11DF-ACD8-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141538>

Frank Li <lznuaa@gmail.com> writes:

> imap-send and authority http connect reads passwords from an interactive
> terminal. This behavious cause GUIs to hang waiting for git complete.

"authority http"?  Perhaps...

    git tries to read a password from the terminal in imap-send and
    talking to http server that requires authentication.

    When a GUI is driving git, however, the end user is not paying
    attention to the terminal (there may not even be a terminal).  GUI
    would appear to hang forever.

> Fix this problem by allowing a password-retrieving command
> to be specified in GIT_ASKPASS
>
> Signed-off-by: Frank Li <lznuaa@gmail.com>
> ---

Here after three-dash lines, could you describe the changes (what changed
and why) since the last round, when sending a revised version?  Saying
"This round addressed such and such issues raised and I think it is ready
for inclusion" (when you think it is ready) would also help.

> +	if (start_command(&pass))
> +		exit(1);
> +
> +	if (strbuf_read(&buffer, pass.out, 20) < 0)
> +		die("fail get password from %s\n", askpass);

"failed to get..."

> +	close(pass.out);
> +
> +	if (finish_command(&pass))
> +		exit(1);
> +
> +	strbuf_setlen(&buffer, strcspn(buffer.buf, "\r\n"));
> +
> +	if (pd) {
> +		free(pd);
> +		pd = NULL;
> +	}
> +	/*it maybe memory leak because getpass return a static buffer*/

Hmph, why not do this at the beginning?  Is the "maybe leak" comment still
valid?
