From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t4204-patch-id failures
Date: Mon, 23 May 2016 13:47:51 -0700
Message-ID: <xmqqiny48ps8.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEgf_FiGWs=45+n8uzKEiXU7yKDsP+CjOUAWu1CnUXZbPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 23 22:48:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4wld-0004HQ-3r
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 22:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbcEWUr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 16:47:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59416 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750882AbcEWUr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 16:47:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6E361C496;
	Mon, 23 May 2016 16:47:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QcZub+gdcc6izGgt6GFunmt5O6o=; b=Wwzj73
	S2WYlnr/RDTbF804ItOWxq2K6Wm0Owuw0zsnRm6pTZ/ucammPgWSgLt0FNxvqjks
	AX/RfnI+i70dpb3r/INZUIm6pgSbNtD1cMmBrsuwWBMl74EolKOvYuOiew6C8ltx
	UTpjGTUSNyv002zf/nY04PaRDgQvSR43Ipj6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PVpo+gcynnqNSlPgOC/C2jUCgMBnjDGT
	5eSbs3MXAifQTKpDJP+Fat5LYM0XMXqAfti7EvbuK89Bi7o2XFP5tuojyx5A+4H8
	23YKZy3zgAVvSBa1nYNNjAZ6yCVCZMM5pSBCiT9TmFRg1FZmDph4YU1awB2gip11
	hYmLMzWyENs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABE731C495;
	Mon, 23 May 2016 16:47:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 137B81C494;
	Mon, 23 May 2016 16:47:54 -0400 (EDT)
In-Reply-To: <CALR6jEgf_FiGWs=45+n8uzKEiXU7yKDsP+CjOUAWu1CnUXZbPw@mail.gmail.com>
	(Armin Kunaschik's message of "Mon, 23 May 2016 18:30:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9F45384E-2127-11E6-9C33-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295390>

Armin Kunaschik <megabreit@googlemail.com> writes:

> Essentially it's working like this:
> <snip>
> #!/bin/bash
>
> func1() {
>         name=${1}
>         echo "func1 name=$name"
> }
>
> func2() {
>         name=${1}
>         echo "func2 name=$name"
>         func1 "ordered-$name"
>         echo "func2 again name=$name"
> }
>
> func2 foo
> <snip>


I think what you have are these two functions interacting in an
unexpected way:

test_patch_id_file_order () {
	relevant="$1"
	shift
	name="order-${1}-$relevant"
	shift
	get_top_diff "master" | calc_patch_id "$name" "$@" &&
	git checkout same &&
	git format-patch -1 --stdout -O foo-then-bar |
		calc_patch_id "ordered-$name" "$@" &&
	cmp_patch_id $relevant "$name" "ordered-$name"

}

calc_patch_id () {
	name="$1"
	shift
	git patch-id "$@" |
	sed "s/ .*//" >patch-id_"$name" &&
	test_line_count -gt 0 patch-id_"$name"
}


The first call to calc_patch_id passes $name and the called helper
receives it as $name, but the second call to it passes "ordered-$name"
which is assigned by the function to $name.

Your example over-simplified these two and lacks the pipeline to
make the invocation of func1 as downstream of a pipe in func2; that
is why your simplified example makes you wonder why these two work
on other people's shells; i.e. you need to replace your func2 to
this in order to mimick what is really going on:

func2 () {
        name=${1}
        echo "func2 name=$name"
        echo foo | func1 "ordered-$name"
        echo "func2 again name=$name"
}

Both bash and dash seem to run the func1 in the downstream of the
pipe in a separate process, and $name used in "func2 again" is not
affected.  But it seems that ksh93 behaves differently (I do not
have access to ksh88).

An obvious workaround is to replace your func1 to

func1 () (
	name=$1
        echo "func1 name=$name"
)

to force it to be run in its own process without disrupting $name.

Perhaps like this?

 t/t4204-patch-id.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index baa9d3c..b8bd467 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -28,14 +28,18 @@ test_expect_success 'patch-id output is well-formed' '
 	grep "^[a-f0-9]\{40\} $(git rev-parse HEAD)$" output
 '
 
-#calculate patch id. Make sure output is not empty.
-calc_patch_id () {
+# calculate patch id. Make sure output is not empty.
+# Because ksh lets this helper run as a downstream of a pipe in
+# test_patch_id_file_order and ends up clobbering $name, make
+# sure it is run as a separate process by using (body) not {body}
+
+calc_patch_id () (
 	name="$1"
 	shift
 	git patch-id "$@" |
 	sed "s/ .*//" >patch-id_"$name" &&
 	test_line_count -gt 0 patch-id_"$name"
-}
+)
 
 get_top_diff () {
 	git log -p -1 "$@" -O bar-then-foo --
