From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH alt-v3] Improve function dir.c:trim_trailing_spaces()
Date: Fri, 13 Jun 2014 13:23:47 -0700
Message-ID: <xmqqoaxw1ru4.fsf@gitster.dls.corp.google.com>
References: <1401748616-14632-1-git-send-email-pasha.bolokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 22:23:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvY11-0001xX-8f
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 22:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbaFMUXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 16:23:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55802 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811AbaFMUXy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 16:23:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EB3DE1F9DC;
	Fri, 13 Jun 2014 16:23:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bf12fOXbMnHHI91vfsjJLngbJ4I=; b=w2tPoT
	l0WNrUnFoK+cENZunR6jgmXk2S0N4EO76KhGZARSS7+VMk7dVfX/q0p07rVvVMQ1
	kNPNWVty+RqGf5bt1RtcnfurGEhO/CZ9VIxuTWPahaCer3KKqUNwWl/uSm7wWjcS
	k94Eh0kfiE/CbqhA81Jsa/s1OgIt+wL/LjJoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pjz/OiE7zL3bH77bQZDtHBZeyehXyH/O
	hXS5+56bB6N/UqBVg57nFA/HsbPvsUbc/i+Io+6PTcotJVoQYeDmJ3jAhJMVpxDt
	viO39+wTSeshHzRrV9cfU31edFAigOrSbLFVdnn1VJSf9VpChZqJdH3/eYDxc/0k
	xnZS4ehEbG4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E11471F9DA;
	Fri, 13 Jun 2014 16:23:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BFE9B1F9CD;
	Fri, 13 Jun 2014 16:23:48 -0400 (EDT)
In-Reply-To: <1401748616-14632-1-git-send-email-pasha.bolokhov@gmail.com>
	(Pasha Bolokhov's message of "Mon, 2 Jun 2014 15:36:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A084060A-F338-11E3-A947-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251634>

Pasha Bolokhov <pasha.bolokhov@gmail.com> writes:

> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index 63beb99..5ef5ad3 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -806,4 +806,27 @@ test_expect_success !MINGW 'quoting allows trailing whitespace' '
>  	test_cmp err.expect err
>  '
>  
> +test_expect_success NOT_MINGW,NOT_CYGWIN 'correct handling of backslashes' '
> +	rm -rf whitespace &&
> +	mkdir whitespace &&
> +	>"whitespace/trailing 1  " &&
> +	>"whitespace/trailing 2 \\\\" &&
> +	>"whitespace/trailing 3 \\\\" &&
> +	>"whitespace/trailing 4   \\ " &&
> +	>"whitespace/trailing 5 \\ \\ " &&
> +	>"whitespace/trailing 6 \\a\\" &&
> +	>whitespace/untracked &&
> +	echo "whitespace/trailing 1 \\    " >ignore  &&
> +	echo "whitespace/trailing 2 \\\\\\\\\\\\\\\\" >>ignore &&
> +	echo "whitespace/trailing 3 \\\\\\\\\\\\\\\\ " >>ignore &&
> +	echo "whitespace/trailing 4   \\\\\\\\\\\\    " >>ignore &&
> +	echo "whitespace/trailing 5 \\\\\\\\ \\\\\\\\\\\\   " >>ignore &&
> +	echo "whitespace/trailing 6 \\\\\\\\a\\\\\\\\" >>ignore &&
> +	echo whitespace/untracked >expect &&
> +	>err.expect &&
> +	git ls-files -o -X ignore whitespace >actual 2>err &&
> +	test_cmp expect actual &&
> +	test_cmp err.expect err
> +'

This passes with your shell set to dash but fails with bash.

Let's fix it up like so.

 t/t0008-ignores.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 5ef5ad3..39e55a1 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -816,12 +816,14 @@ test_expect_success NOT_MINGW,NOT_CYGWIN 'correct handling of backslashes' '
 	>"whitespace/trailing 5 \\ \\ " &&
 	>"whitespace/trailing 6 \\a\\" &&
 	>whitespace/untracked &&
-	echo "whitespace/trailing 1 \\    " >ignore  &&
-	echo "whitespace/trailing 2 \\\\\\\\\\\\\\\\" >>ignore &&
-	echo "whitespace/trailing 3 \\\\\\\\\\\\\\\\ " >>ignore &&
-	echo "whitespace/trailing 4   \\\\\\\\\\\\    " >>ignore &&
-	echo "whitespace/trailing 5 \\\\\\\\ \\\\\\\\\\\\   " >>ignore &&
-	echo "whitespace/trailing 6 \\\\\\\\a\\\\\\\\" >>ignore &&
+	sed -e "s/Z$//" >ignore <<-\EOF &&
+	whitespace/trailing 1 \    Z
+	whitespace/trailing 2 \\\\Z
+	whitespace/trailing 3 \\\\ Z
+	whitespace/trailing 4   \\\    Z
+	whitespace/trailing 5 \\ \\\   Z
+	whitespace/trailing 6 \\a\\Z
+	EOF
 	echo whitespace/untracked >expect &&
 	>err.expect &&
 	git ls-files -o -X ignore whitespace >actual 2>err &&
