From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] git apply: option to ignore whitespace differences
Date: Tue, 04 Aug 2009 00:25:02 -0700
Message-ID: <7v8wi03usx.fsf@alter.siamese.dyndns.org>
References: <1249072858-21894-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 09:25:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYEP2-0003ut-8O
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 09:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbZHDHZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 03:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbZHDHZK
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 03:25:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932519AbZHDHZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 03:25:09 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7D4661C0E9;
	Tue,  4 Aug 2009 03:25:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B8B9F1C0E8; Tue,  4 Aug 2009
 03:25:04 -0400 (EDT)
In-Reply-To: <1249072858-21894-1-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Fri\, 31 Jul 2009 22\:40\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F16A2600-80C7-11DE-A012-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124765>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> diff --git a/t/t4107-apply-ignore-whitespace.sh b/t/t4107-apply-ignore-whitespace.sh
> new file mode 100755
> index 0000000..8e3fce3
> --- /dev/null
> +++ b/t/t4107-apply-ignore-whitespace.sh
> @@ -0,0 +1,149 @@
> ...
> +cat > patch3.patch <<\EOF
> +diff --git a/main.c b/main.c
> +--- a/main.c
> ++++ b/main.c
> +@@ -10,1 +10,1 @@
> + 		print_int(func(i)); 
> +EOF

This part is triply troublesome in that:

 (1) the payload ends with trailing whitespace which can be eaten by MUAs
     (and I almost always use "git am" with --whitespace=fix);
 
 (2) even if we apply your patch correctly, it is very unobvious that you
     are testing the case where the line has an unwanted trailing
     whitespace; and

 (3) a hunk without any added/deleted lines is an obviously artificial
     test input that would not appear in real life, something one would
     never think of doing unless one knows how "git apply" internally
     works.  It makes the test too knowledgable about the implementation.

You can fix the first two issues by doing:

	sed -e 's/Z/ /g' >patch3.patch <<\EOF
        ...
        +Z 	print_int(func(i));Z
        EOF

to make invisible SP stand out more for the benefit of people reading the
test script (I know you did not have leading SP before HT in yours, but
the above illustrates the visibility issues).  For other tests with test
vector patches, visibility of whitespace is not much an issue, but this
script is _all about_ whitespace, so anything that clarifies what is going
on better would help.

> +test_expect_success "S = patch1" \
> +    'git-apply patch1.patch'
> +
> +test_expect_failure "F = patch2" \
> +    'git-apply patch2.patch'

Please say

	test_expect_success "whitespace corrupted patch does not apply" '
		test_must_fail git apply patch2.patch
        '

instead.

"test_expect_failure" is a declaration that the command being tested (in
this case "git apply") is faulty.  It also is a request for somebody
interested to later fix it (again, in this case "git apply") to make this
test pass.

But you do _not_ want this to pass without an explicit ignore option, so
test_expect_failure is inappropriate here.
