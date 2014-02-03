From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/9] cherry-pick, revert: add the --gpg-sign option
Date: Mon, 03 Feb 2014 12:50:55 -0800
Message-ID: <xmqq8utrex8w.fsf@gitster.dls.corp.google.com>
References: <1391221086-1044384-1-git-send-email-sandals@crustytoothpaste.net>
	<1391221086-1044384-2-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Vigier <boklm@mars-attacks.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Feb 03 21:51:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAQUH-0004aZ-1k
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 21:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbaBCUvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 15:51:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35389 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbaBCUvA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 15:51:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC48469B20;
	Mon,  3 Feb 2014 15:50:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qnswHnm9tNg4itG7g9ZUbr8COWA=; b=NkRLh0
	+hxloZsZfg8mx3DSYkw0UT+EwqLxWDUhpJH7wLH+0vyHyt5uFGiyTAQikGHbXBA1
	GFDNP2xon2uJ6QEpc2o0iV3KHZRlUCRR6J+UUOHg5k36yFA1MQN1xkhrD+q8JWMA
	Mtg10Xl99YMVmk6fSx9tsdRMlws+rCKL/ir5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=do/kZb0f4HrA2qO2y6vUw4y9XtyVA3+s
	OXf438WMfaV0Jk4RSykzstyJHTN3sULLDtGCSi9HEwkcOe0wDK7FkSYbWzHFQyXf
	Lo5jaBf6hbeGzCGOtUiLzlDLx82JxHdBbuxE/JJgKJR5cvK7cZgCo6xuH0JLWjSm
	+WOVf7PDy2E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DD2F69B1D;
	Mon,  3 Feb 2014 15:50:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E616269B13;
	Mon,  3 Feb 2014 15:50:57 -0500 (EST)
In-Reply-To: <1391221086-1044384-2-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sat, 1 Feb 2014 02:17:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E1DDE074-8D14-11E3-BA82-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241476>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/sequencer.c b/sequencer.c
> index 90cac7b..bde5f04 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -392,11 +392,18 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  {
>  	struct argv_array array;
>  	int rc;
> +	char *gpg_sign;
>  
>  	argv_array_init(&array);
>  	argv_array_push(&array, "commit");
>  	argv_array_push(&array, "-n");
>  
> +	if (opts->gpg_sign) {
> +		gpg_sign = xmalloc(3 + strlen(opts->gpg_sign));
> +		sprintf(gpg_sign, "-S%s", opts->gpg_sign);
> +		argv_array_push(&array, gpg_sign);
> +		free(gpg_sign);

Perhaps

	argv_array_pushf(&array, "-S%s", opts->gpg_sign);

without any temporary?  That would save 5 lines in total.

> +	}
>  	if (opts->signoff)
>  		argv_array_push(&array, "-s");
>  	if (!opts->edit) {


diff --git a/sequencer.c b/sequencer.c
index bde5f04..b200dce 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -392,18 +392,13 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 {
 	struct argv_array array;
 	int rc;
-	char *gpg_sign;
 
 	argv_array_init(&array);
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
 
-	if (opts->gpg_sign) {
-		gpg_sign = xmalloc(3 + strlen(opts->gpg_sign));
-		sprintf(gpg_sign, "-S%s", opts->gpg_sign);
-		argv_array_push(&array, gpg_sign);
-		free(gpg_sign);
-	}
+	if (opts->gpg_sign)
+		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
 	if (opts->signoff)
 		argv_array_push(&array, "-s");
 	if (!opts->edit) {
