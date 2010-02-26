From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] git-svn: Support retrieving passwords with
 GIT_ASKPASS
Date: Thu, 25 Feb 2010 22:33:11 -0800
Message-ID: <7vzl2wa4m0.fsf@alter.siamese.dyndns.org>
References: <3.SQo> <1267142845-3040-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com, Johannes Sixt <j6t@kdbg.org>
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 07:33:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NktlS-0006iH-Iv
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 07:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935330Ab0BZGdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 01:33:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935284Ab0BZGdY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 01:33:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B39F9D446;
	Fri, 26 Feb 2010 01:33:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=02AGhzQi4jueBWjJtlpcOqe3vgA=; b=wrEQmm
	8zLQP+9LrawJSsc3czblHqAggTi6I9mPklt/wylqRbHpsRcgqaWIZakoBgm4PthY
	xz52IZWW4oFYRONFGcrgrZNw+TCfzhQ4pQ+qNzOydoZ6l7tMQFuKtizeJ1alMBBR
	I1/9tVolsqZIFbt7ceFwg16IjuvUtGqN2ezIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mMYSd2bSde9IQg3yUEbYEVaDDFTCcRoG
	FQhBswsWluLxjVD2UTEFQJXKuKItDjIHmGmiHg7sPji0zVNqMK3oePYcoxmWqEER
	+wqQTcJV+s8wLq5Hdlf9pCEhKEKH3DnP5G7Zh8wrl0Q8sy6vS7YAmDcaAg+KkW04
	GsM2z2lcLr0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 475359D442;
	Fri, 26 Feb 2010 01:33:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 071A09D43D; Fri, 26 Feb
 2010 01:33:13 -0500 (EST)
In-Reply-To: <1267142845-3040-1-git-send-email-lznuaa@gmail.com> (Frank Li's
 message of "Fri\, 26 Feb 2010 08\:07\:25 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D4146676-22A0-11DF-B5BC-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141110>

Frank Li <lznuaa@gmail.com> writes:

> +if (! exists $ENV{GIT_ASKPASS}) {
> +	if (exists $ENV{SSH_ASKPASS}) {
> +		$ENV{GIT_ASKPASS} = $ENV{SSH_ASKPASS};
> +		if ($^O eq 'msys') {
> +                        $ENV{GIT_ASKPASS} =~ s/\\/\\\\/g;
> +                        $ENV{GIT_ASKPASS} =~ s/(.*)/"$1"/;
> +                }
> +	}
> +}

I've seen this code before, and you may not be the best person to answer
this question, but this worries me and puzzles me a bit.

On msys (and nowhere else), SSH_ASKPASS can be used as given by the user
to launch the prompter, but GIT_ASKPASS must be quoted in some funny way.

Why is that?  Does this mean they must be given differently by the end
user?  In other words, if the end user wants to set GIT_ASKPASS himself,
s/he needs to do this funny quoting, that is different from SSH_ASKPASS.

I also notice that git-gui has support for SSH_ASKPASS (and its own
implementation).  Does it have the same quoting issues on msys?

The reason I am asking is because:

 (1) if SSH_ASKPASS and GIT_ASKPASS cannot be specified exactly the same
     way, then [PATCH 3/3] would probably need a similar quoting magic?

 (2) With [PATCH 3/3], with quoting magic if necessary, we wouldn't need
     the above hunk, as it has already be done by the "git" potty.
