From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shell portability: Use sed instead of non-portable
 variable expansion
Date: Mon, 05 Sep 2011 00:09:07 -0700
Message-ID: <7vbouzxy7g.fsf@alter.siamese.dyndns.org>
References: <8762l73758.fsf@elisp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tarmigan+git@gmail.com,
	David Barr <davidbarr@google.com>
To: Naohiro Aota <naota@elisp.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 09:09:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0TIz-0007xY-4l
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 09:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958Ab1IEHJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 03:09:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47429 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762Ab1IEHJK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 03:09:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88F365F65;
	Mon,  5 Sep 2011 03:09:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dcgRPzUXVrPQrZxQpFsZoc/1bu4=; b=HOpyyK
	3WcSAT7HjRLvAic6MAb9Vcb/QGucBKgJICiKtu5Ows2uszPss7RLtzZffZrkz6Xk
	S/SkqjciiyYUg3qoFuEqV7renYCajqJkedU4esNFXNIs8/zqbIg/i5vSFfhkDxJv
	fQIDTv4TKOmauibhux1GOkrb0tG4y0vNp97hM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AgZ9YTydS0n9fCep5nAXKStxCBcXaMbM
	pITUfLle7owmNxa1f9YBKLwLZay9ACdkWO6hZ+FO46xfsB+hNbib2ggTJC8tpQYC
	Di5Qvw3VETsmMjysFVPn7PjRHhLAkv2Ars2T1mui48q3isUczURKmffCKjFnTYlU
	l9gJEtkHmbw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7021E5F64;
	Mon,  5 Sep 2011 03:09:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C99655F63; Mon,  5 Sep 2011
 03:09:08 -0400 (EDT)
In-Reply-To: <8762l73758.fsf@elisp.net> (Naohiro Aota's message of "Mon, 05
 Sep 2011 14:11:47 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F3007D24-D78D-11E0-B6B3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180720>

Naohiro Aota <naota@elisp.net> writes:

> Variable expansions like "${foo#bar}" or "${foo%bar}" doesn't work on
> shells like FreeBSD sh and they made the test to fail.

Sorry, I do appreciate the effort, but a patch like this takes us in the
wrong direction.

While we do not allow blatant bashisms like ${parameter:offset:length}
(substring expansion), ${parameter/pattern/string} (pattern substitution),
"local" variables, "function" noiseword, and shell arrays in our shell
scripts, the two kinds of substitution you quoted above are purely POSIX,
and our coding guideline does allow them to be used in the scripts.

Even though you may be able to rewrite trivial cases easily in some
scripts (either tests or Porcelain), some Porcelain scripts we ship
(e.g. "git bisect", "git stash", "git pull", etc.) do use these POSIX
constructs, and we do not want to butcher them with extra forks and
reduced readability.

Please use $SHELL_PATH and point to a POSIX compliant shell on your
platform instead. "make test" should pick it up and pass it down to
t/Makefile to be used when it runs these test scripts.

Besides, even inside t/ directory, there are many other instances of these
prefix/postfix substitution, not just 5560. Do the following tests pass on
your box without a similar patch?

$ git grep -n -e '\${[^}]*[#%]' -- t/\*.sh
t/t1410-reflog.sh:33:	aa=${1%??????????????????????????????????????} zz=${1#??}
t/t1410-reflog.sh:38:	aa=${1%??????????????????????????????????????} zz=${1#??}
t/t2030-unresolve-info.sh:125:	rerere_id=${rerere_id%/postimage} &&
t/t2030-unresolve-info.sh:151:	rerere_id=${rerere_id%/postimage} &&
t/t5560-http-backend-noserver.sh:12:	QUERY_STRING="${1#*\?}" \
t/t5560-http-backend-noserver.sh:13:	PATH_TRANSLATED="$HTTPD_DOCUMENT_ROOT_PATH/${1%%\?*}" \
t/t6050-replace.sh:124:     aa=${HASH2%??????????????????????????????????????} &&
t/t9010-svn-fe.sh:17:		printf "%s\n" "K ${#property}" &&
t/t9010-svn-fe.sh:19:		printf "%s\n" "V ${#value}" &&
t/t9010-svn-fe.sh:30:	printf "%s\n" "Text-content-length: ${#text}" &&
t/t9010-svn-fe.sh:31:	printf "%s\n" "Content-length: $((${#text} + 10))" &&
t/test-lib.sh:838:		test_results_path="$test_results_dir/${0%.sh}-$$.counts"
t/test-lib.sh:1047:this_test=${0##*/}
t/test-lib.sh:1048:this_test=${this_test%%-*}
t/valgrind/analyze.sh:98:				test $output = ${output%.message} &&

Looking at the above output, I suspect that it _might_ be that your shell
is almost POSIX but does not handle the backslash-quoted question mark
correctly or something silly like that, in which case a stupid patch like
the attached might be an acceptable compromise, until the shell is fixed.

By the way, t9010 uses ${#parameter} (strlen) which is bashism we forbid,
and it needs to be rewritten (David CC'ed).

Thanks.

diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index 0ad7ce0..c8bbacc 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -9,8 +9,8 @@ test_have_prereq MINGW && export GREP_OPTIONS=-U
 
 run_backend() {
 	echo "$2" |
-	QUERY_STRING="${1#*\?}" \
-	PATH_TRANSLATED="$HTTPD_DOCUMENT_ROOT_PATH/${1%%\?*}" \
+	QUERY_STRING="${1#*[?]}" \
+	PATH_TRANSLATED="$HTTPD_DOCUMENT_ROOT_PATH/${1%%[?]*}" \
 	git http-backend >act.out 2>act.err
 }
 
