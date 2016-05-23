From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t4204-patch-id failures
Date: Mon, 23 May 2016 15:23:56 -0700
Message-ID: <xmqqbn3w76rn.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEgf_FiGWs=45+n8uzKEiXU7yKDsP+CjOUAWu1CnUXZbPw@mail.gmail.com>
	<xmqqiny48ps8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 24 00:24:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4yGc-0008ET-Jf
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 00:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbcEWWYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 18:24:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56023 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751699AbcEWWYA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 18:24:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 62A431DAC7;
	Mon, 23 May 2016 18:23:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q7KRtO+eQr1/+qOKgvnWOFzwv2A=; b=yikln2
	hFl9lK4AjGLVsTU78+gAVrEUybp0Q+aPXFLDdQw5LQQDU8xm3Zo5SALTpYFzx5iA
	imB3ZEYgqfRMjAJ7JO4SrmQtPLHff97jbNkxig1AXiqVY/aDlgBMNQBpE1Nrtzz+
	THNa6QB62WMR1YHQKBzlHIq9Yn+98HOvzBBN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XzCHFn/BhWVRkzK09+4VjK5+ISFUQJVy
	hGJVFRoTwj59VibCu2icdoakM4x9euhOZsR88GOlJ9UgpzcwPFGyuJd6T3uOPNVs
	Gym2jgUdXANy3VqYbJq1ruUcEA8TKJQQ/jeAR96qMo6rKkD3xQi9OeAT8Fe8Ex9h
	I5sYowucLRM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AE2E1DAC6;
	Mon, 23 May 2016 18:23:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C61331DAC5;
	Mon, 23 May 2016 18:23:58 -0400 (EDT)
In-Reply-To: <xmqqiny48ps8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 May 2016 13:47:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0B5130A8-2135-11E6-9FED-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295404>

Junio C Hamano <gitster@pobox.com> writes:

> Both bash and dash seem to run the func1 in the downstream of the
> pipe in a separate process, and $name used in "func2 again" is not
> affected.  But it seems that ksh93 behaves differently (I do not
> have access to ksh88).
>
> An obvious workaround is to replace your func1 to
>
> func1 () (
> 	name=$1
>         echo "func1 name=$name"
> )
>
> to force it to be run in its own process without disrupting $name.
>
> Perhaps like this?
> ...
>  t/t4204-patch-id.sh | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
> index baa9d3c..b8bd467 100755
> --- a/t/t4204-patch-id.sh
> +++ b/t/t4204-patch-id.sh
> @@ -28,14 +28,18 @@ test_expect_success 'patch-id output is well-formed' '
>  	grep "^[a-f0-9]\{40\} $(git rev-parse HEAD)$" output
>  '
>  
> -#calculate patch id. Make sure output is not empty.
> -calc_patch_id () {
> +# calculate patch id. Make sure output is not empty.
> +# Because ksh lets this helper run as a downstream of a pipe in
> +# test_patch_id_file_order and ends up clobbering $name, make
> +# sure it is run as a separate process by using (body) not {body}
> +
> +calc_patch_id () (
>  	name="$1"
>  	shift
>  	git patch-id "$@" |
>  	sed "s/ .*//" >patch-id_"$name" &&
>  	test_line_count -gt 0 patch-id_"$name"
> -}
> +)
>  
>  get_top_diff () {
>  	git log -p -1 "$@" -O bar-then-foo --

Having said all that, this illustrates the root cause of different
behaviours better, but it is harder to reason about than simply
changing the variable name used in this shell function.  POSIX reads
a bit fuzzy to me around here:

    ... each command of a multi-command pipeline is in a subshell
    environment; as an extension, however, any or all commands in a
    pipeline may be executed in the current environment. All other
    commands shall be executed in the current shell environment.

That essentially says nothing useful; it does not guarantee that
each command on a pipeline runs in its own subshell environment, and
a portable script must be prepared to see some of them run in the
current shell environment.

So let's do this instead:

-- >8 --
Subject: t4204: do not let $name variable clobbered

test_patch_id_file_order shell function uses $name variable to hold
one filename, and calls another shell function calc_patch_id as a
downstream of one pipeline.  The called function, however, also uses
the same $name variable.  With a shell implementation that runs the
callee in the current shell environment, the caller's $name would
be clobbered by the callee's use of the same variable.

This hasn't been an issue with dash and bash.  ksh93 reveals the
breakage in the test script.

Fix it by using a distinct variable name in the callee.

Reported-by: Armin Kunaschik <megabreit@googlemail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4204-patch-id.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index baa9d3c..84a8096 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -30,11 +30,11 @@ test_expect_success 'patch-id output is well-formed' '
 
 #calculate patch id. Make sure output is not empty.
 calc_patch_id () {
-	name="$1"
+	patch_name="$1"
 	shift
 	git patch-id "$@" |
-	sed "s/ .*//" >patch-id_"$name" &&
-	test_line_count -gt 0 patch-id_"$name"
+	sed "s/ .*//" >patch-id_"$patch_name" &&
+	test_line_count -gt 0 patch-id_"$patch_name"
 }
 
 get_top_diff () {
