From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] ls-remote: optionally return non-zero on
 non-existing refs
Date: Wed, 18 May 2011 11:28:38 -0700
Message-ID: <7v7h9ndfs9.fsf@alter.siamese.dyndns.org>
References: <20110512120536.GA22033@camk.edu.pl>
 <7voc37dh4l.fsf@alter.siamese.dyndns.org>
 <7vk4dvdg6x.fsf@alter.siamese.dyndns.org> <4DD3D490.1090503@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed May 18 20:28:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMlUM-00043u-0T
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 20:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933433Ab1ERS2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 14:28:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933386Ab1ERS2s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 14:28:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 75B315A59;
	Wed, 18 May 2011 14:30:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0lcbduqOkKdBQpdRrXd/FlRjCBY=; b=rseyWG
	mqWLk9VgSBxB3yT5mualCVHzgH6kAzZ4U4XjWVTYmHJPU1zXiw7m+hWiSRp350qt
	bSJUklrQ3g2uhAEkWhhZZaO/qrudNEv1OTZWFAtQWfzJm5DGmUXaVfC0V9vNg0bd
	HMhfZPB64t7lA2bFe2yteRr3/uQlfTH+DIUQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kGg6b6MM54rjbvbz8AlcOEFaFHg6GZH4
	eARkg86MZLlhl94nvDEiX1A1yO/l8Ear+ePz0KPvfsQbGQeurcxdDWzIRCY3yWEJ
	LCJ9AU8lznI7VUE6wP/oLs5lvLeyHnTQWPkmfIGTxkTgBP1RiwjD9BezPOllW8C4
	021pwIZhM/c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 410B85A55;
	Wed, 18 May 2011 14:30:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D5D315A54; Wed, 18 May 2011
 14:30:46 -0400 (EDT)
In-Reply-To: <4DD3D490.1090503@elegosoft.com> (Michael Schubert's message of
 "Wed, 18 May 2011 16:15:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5429548-817C-11E0-985C-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173893>

Michael Schubert <mschub@elegosoft.com> writes:

> git ls-remote returns zero no matter if the given references were found
> or not. Teach ls-remote an option --exit-status to make it optionally
> returning a non-zero status.
>
> Signed-off-by: Michael Schubert <mschub@elegosoft.com>
> ---
>
> If there is just one existing ref in a list of non-exising refs, this will
> return zero though - as "git show-ref" does.

That's Ok, but...

> @@ -35,6 +35,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
> ...
> +	int exit_code = 0;
> ...
> @@ -74,6 +75,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
> ...
> +			if (!strcmp("--exit-code", arg) || !strcmp("-e", arg)) {
> +				exit_code = 1;
> +				continue;
> ...
> @@ -115,12 +120,15 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
> ...
> +	return (exit_code) ? 2 : 0;
>  }

What is this insanity?

Wouldn't it be a lot more straightforward to write it like this?

	int status = 0;

	...

		if (!strcmp("--exit-code", arg)) {
			/* when we do not find any, return this value */
 			status = 2;
                        continue;
		}

	...

	return status;
