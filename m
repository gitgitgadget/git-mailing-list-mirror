From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] push: Add support for pre-push hooks
Date: Mon, 14 Jan 2013 16:36:21 -0800
Message-ID: <7vip6z7056.fsf@alter.siamese.dyndns.org>
References: <1358054224-7710-1-git-send-email-aaron@schrab.com>
 <1358054224-7710-3-git-send-email-aaron@schrab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 01:37:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuuWR-0008TA-I2
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756756Ab3AOAgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:36:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51966 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756684Ab3AOAgY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:36:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 909D4CC85;
	Mon, 14 Jan 2013 19:36:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8YD6Nd++v02S6Uj2lt7LqpWSo/I=; b=UOanTI
	TxUU9xdodHwWCNwrhX6L3bkdbZMidSydWzIQomqRtzO0VzZ9Hgw/rejduE4tXr8F
	TStUmt8Dk/oARZkGd/h7z7dUAiUzT3z6S7ZZQ6BHOfEGiNfIOHOtvhVqOAxQ2Uj4
	WZauJdSe54GSDBhqa3XqxRI5hP82QYq4fWmnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N1yY4/FMIlb3hlLlh/BO/x/PjAaHh2eb
	xB565o8/y6sKfthSQLiuH92kHj1Q1ZAhYSQOa9glajlgyaYVgrdcKXMDH87nivVR
	NrOTdKkzi6DZynxVdFiQI1ve/Db/2AYJAhZg90nGFAaLgL4Vb5GTSWzcLV8dccex
	5uhnCv+U3So=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85839CC84;
	Mon, 14 Jan 2013 19:36:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2025CC7F; Mon, 14 Jan 2013
 19:36:22 -0500 (EST)
In-Reply-To: <1358054224-7710-3-git-send-email-aaron@schrab.com> (Aaron
 Schrab's message of "Sun, 13 Jan 2013 00:17:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96446B3A-5EAB-11E2-811B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213549>

Aaron Schrab <aaron@schrab.com> writes:

>  t/t5571-pre-push-hook.sh   | 129 +++++++++++++++++++++++++++++++++++++++++++++
> diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
> new file mode 100755
> index 0000000..d68fed7
> --- /dev/null
> +++ b/t/t5571-pre-push-hook.sh
> @@ -0,0 +1,129 @@
> +#!/bin/sh
> +
> +test_description='check pre-push hooks'
> +. ./test-lib.sh
> +
> +# Setup hook that always succeeds
> +HOOKDIR="$(git rev-parse --git-dir)/hooks"
> +HOOK="$HOOKDIR/pre-push"
> +mkdir -p "$HOOKDIR"
> +write_script "$HOOK" <<EOF
> +exit 0
> +EOF

As this script is expected to read from the pipe, if this exits
before the parent has a chance to write to the pipe, the parent can
be killed with sigpipe.

At least the attached patch is necessary.

In the longer term, we may want to discuss what should happen when
the hook exited without even reading what we fed.  My gut feeling is
that we can still trust its exit status (a hook that was badly coded
so it wanted to read from us and use that information to decide but
somehow died before fully reading from us is not likely to exit with
zero status, so we wouldn't diagnosing breakage as a success), but
there may be downsides for being that lax.

If we decide we want to be lax, then the call site of this hook and
the pre-receive hook (is there any other "take info from the
standard input" hook?) need to be modified so that they ignore
sigpipe, I think.

There was a related discussion around this issue about a year ago.

http://thread.gmane.org/gmane.comp.version-control.git/180346/focus=186291


 t/t5571-pre-push-hook.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index d68fed7..577d252 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -8,6 +8,7 @@ HOOKDIR="$(git rev-parse --git-dir)/hooks"
 HOOK="$HOOKDIR/pre-push"
 mkdir -p "$HOOKDIR"
 write_script "$HOOK" <<EOF
+cat >/dev/null
 exit 0
 EOF
 
@@ -19,6 +20,7 @@ test_expect_success 'setup' '
 	git push parent1 HEAD:foreign
 '
 write_script "$HOOK" <<EOF
+cat >/dev/null
 exit 1
 EOF
 
@@ -38,6 +40,7 @@ COMMIT2="$(git rev-parse HEAD)"
 export COMMIT2
 
 write_script "$HOOK" <<'EOF'
+cat >/dev/null
 echo "$1" >actual
 echo "$2" >>actual
 cat >>actual
