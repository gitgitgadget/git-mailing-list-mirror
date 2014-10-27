From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] difftool: add support for --trust-exit-code
Date: Mon, 27 Oct 2014 11:45:14 -0700
Message-ID: <xmqq38a9tkqt.fsf@gitster.dls.corp.google.com>
References: <544CAC30.7000607@kdbg.org>
	<1414372542-3485-1-git-send-email-davvid@gmail.com>
	<1414372542-3485-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Adri Farr <14farresa@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 19:45:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XipIC-0002V8-NO
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 19:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbaJ0SpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 14:45:19 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751745AbaJ0SpS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 14:45:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FA3A19FE2;
	Mon, 27 Oct 2014 14:45:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0z6fvGU4IpRcXIFy1Plltc6dZ9E=; b=DxRQge
	3s6ydUddybTSzU+RZziWaQcTncAeNGN9uJG3OEWMJKpev3ZeJaBSDfFSYxCZ3Cll
	U9cn7GyE7Se8ggRW+WFDSUezGb8bBhQNn+FsaBN0ohnrb8F17dDvd5F5Bsenq45X
	HQvrJwml1TEKf5fz5FBxPKQkGla7LqR/17KU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mSpdj7SG1DNEUlM/qDgmEh04migLb6Xt
	ciF7QiV5I8vCLz9IbZNSglf/b/VzKY7i+4lbW/tilLgmwVc+tdFXw9KuAHja5hO6
	S64b/3uXrOhTfrgoxz2CvSoadT4V1FwzYtfF0tUSyrxfKVO072T3nhC8H9yD/Jcv
	LojEnolYkRs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 052D019FE1;
	Mon, 27 Oct 2014 14:45:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4EE9B19FE0;
	Mon, 27 Oct 2014 14:45:16 -0400 (EDT)
In-Reply-To: <1414372542-3485-2-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Sun, 26 Oct 2014 18:15:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 64A34F7E-5E09-11E4-B889-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> +write_script .git/fail-right-file <<\EOF
> +echo "$2"
> +exit 1
> +EOF

This should be inside the next one, no?

> +test_expect_success PERL 'difftool stops on error with --trust-exit-code' '
> +	>for-diff &&
> +	git add for-diff &&
> +	echo file>expect &&
> +	test_must_fail git difftool -y --trust-exit-code \
> +		--extcmd .git/fail-right-file branch >actual &&
> +	test_cmp expect actual &&
> +	git reset -- for-diff &&
> +	rm -f for-diff .git/fail-right-file
> +'

In other words, this squashed in.

 t/t7800-difftool.sh | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 4b2f611..69bde7a 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -104,20 +104,19 @@ test_expect_success PERL 'difftool ignores exit code with --no-trust-exit-code'
 	git difftool -y --no-trust-exit-code -t error branch
 '
 
-write_script .git/fail-right-file <<\EOF
-echo "$2"
-exit 1
-EOF
-
 test_expect_success PERL 'difftool stops on error with --trust-exit-code' '
+	test_when_finished "rm -f for-diff .git/fail-right-file" &&
+	test_when_finished "git reset -- for-diff" &&
+	write_script .git/fail-right-file <<-\EOF &&
+	echo "$2"
+	exit 1
+	EOF
 	>for-diff &&
 	git add for-diff &&
-	echo file>expect &&
+	echo file >expect &&
 	test_must_fail git difftool -y --trust-exit-code \
 		--extcmd .git/fail-right-file branch >actual &&
-	test_cmp expect actual &&
-	git reset -- for-diff &&
-	rm -f for-diff .git/fail-right-file
+	test_cmp expect actual
 '
 
 test_expect_success PERL 'difftool honors --gui' '
