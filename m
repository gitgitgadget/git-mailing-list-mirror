From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Hardcoded #!/bin/sh in t5532 causes problems on Solaris
Date: Sat, 09 Apr 2016 17:37:43 -0700
Message-ID: <xmqqmvp2ti20.fsf@gitster.mtv.corp.google.com>
References: <570965B9.9040207@jupiterrise.com>
	<20160409210429.GB18989@sigill.intra.peff.net>
	<57098259.1060608@jupiterrise.com>
	<20160409223738.GA1738@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Tom G. Christensen" <tgc@jupiterrise.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 10 02:37:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ap3O0-0004pa-Dl
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 02:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbcDJAhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 20:37:47 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751225AbcDJAhq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 20:37:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0CCDE51A40;
	Sat,  9 Apr 2016 20:37:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0mp/XpotN2noyLeQW50Dg4ug/jA=; b=hmCWX+
	k3ANeOn6o7LR8IuGsgwwqNA+7W+49Pd/4tIqnVLjXipIDQSkvGDxhF1DOQD/0NTp
	uM+ENxG3t652qttE9h4hqCwWw9vAuzilSc8wVVMdRYXepBdJTMeUzRlAs500BMRt
	HuQ3WmehWM9Nio7DPicbgas/5V4wbHdQry/Ps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IYTQNKDDhLB34cnkVpq4hncTxBnxObB5
	xoOKJEPsbbHln69YUEhCF8Yt3KQlq7aJao8koQXjYNDgZ2nDIC3K9FVavAz0ofD9
	RZAW41ZjwL0Xqb2+dHsLk6XqwGGOjrMiIPCz1pZR+ILos4c4i6NdHcVFVKWSVCHR
	vt/xXJG3DjY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 030A951A3F;
	Sat,  9 Apr 2016 20:37:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7834351A3E;
	Sat,  9 Apr 2016 20:37:44 -0400 (EDT)
In-Reply-To: <20160409223738.GA1738@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 9 Apr 2016 18:37:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 70D221CE-FEB4-11E5-98D8-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291137>

Jeff King <peff@peff.net> writes:

> Hmm. t3404.40 does this:
>
>         echo "#!/bin/sh" > $PRE_COMMIT &&
> 	echo "test -z \"\$(git diff --cached --check)\"" >>$PRE_COMMIT &&
> 	chmod a+x $PRE_COMMIT &&
>
> So I'm pretty sure that $PRE_COMMIT script should be barfing each time
> it is called on Solaris. I think the test itself doesn't notice because
> "/bin/sh barfed" and "the pre-commit check said no" look the same from
> git's perspective (both non-zero exits), and we test only cases where we
> expect the hook to fail.

I looked at

    $ git grep -c '#! */bin/sh' t | grep -v ':1$'

and did a few just for fun.  Doing it fully may be a good
microproject for next year ;-)

 t/t1020-subdirectory.sh       |  6 +++---
 t/t2050-git-dir-relative.sh   | 11 ++++++-----
 t/t3404-rebase-interactive.sh |  7 +++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 8e22b03..6dedb1c 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -142,9 +142,9 @@ test_expect_success 'GIT_PREFIX for built-ins' '
 	# Use GIT_EXTERNAL_DIFF to test that the "diff" built-in
 	# receives the GIT_PREFIX variable.
 	printf "dir/" >expect &&
-	printf "#!/bin/sh\n" >diff &&
-	printf "printf \"\$GIT_PREFIX\"" >>diff &&
-	chmod +x diff &&
+	write_script diff <<-\EOF &&
+	printf "%s" "$GIT_PREFIX"
+	EOF
 	(
 		cd dir &&
 		printf "change" >two &&
diff --git a/t/t2050-git-dir-relative.sh b/t/t2050-git-dir-relative.sh
index 21f4659..7a05b20 100755
--- a/t/t2050-git-dir-relative.sh
+++ b/t/t2050-git-dir-relative.sh
@@ -18,11 +18,12 @@ COMMIT_FILE="$(pwd)/output"
 export COMMIT_FILE
 
 test_expect_success 'Setting up post-commit hook' '
-mkdir -p .git/hooks &&
-echo >.git/hooks/post-commit "#!/bin/sh
-touch \"\${COMMIT_FILE}\"
-echo Post commit hook was called." &&
-chmod +x .git/hooks/post-commit'
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/post-commit <<-\EOF
+	>"${COMMIT_FILE}"
+	echo Post commit hook was called.
+	EOF
+'
 
 test_expect_success 'post-commit hook used ordinarily' '
 echo initial >top &&
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b79f442..d96d0e4 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -555,10 +555,9 @@ test_expect_success 'rebase a detached HEAD' '
 test_expect_success 'rebase a commit violating pre-commit' '
 
 	mkdir -p .git/hooks &&
-	PRE_COMMIT=.git/hooks/pre-commit &&
-	echo "#!/bin/sh" > $PRE_COMMIT &&
-	echo "test -z \"\$(git diff --cached --check)\"" >> $PRE_COMMIT &&
-	chmod a+x $PRE_COMMIT &&
+	write_script .git/hooks/pre-commit <<-\EOF &&
+	test -z "$(git diff --cached --check)"
+	EOF
 	echo "monde! " >> file1 &&
 	test_tick &&
 	test_must_fail git commit -m doesnt-verify file1 &&
