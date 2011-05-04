From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/4] t5541-http-push: add test for chunked
Date: Wed, 04 May 2011 11:44:22 -0700
Message-ID: <7vr58ee261.fsf@alter.siamese.dyndns.org>
References: <1304503896-5988-2-git-send-email-rctay89@gmail.com>
 <1304437649-7052-1-git-send-email-rctay89@gmail.com>
 <1304503896-5988-1-git-send-email-rctay89@gmail.com>
 <1304529590-1032-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 20:44:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHh45-0001t2-Ej
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 20:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab1EDSok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 14:44:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603Ab1EDSoh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 14:44:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 22A34517C;
	Wed,  4 May 2011 14:46:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=15JH00wlc9uzuynQEgUfkq1pK5Y=; b=QaCPMu
	anrNtz2LYt9ChtcviXfJqCZ53aEcw6QHVV78X4fjSWfq8xzWCEfnfTk3qZQhyEFl
	N8x1NrOy0PtR+vqM5wdovbVmLaF9cnu/iPalKLGV+CKEKOlT9voBixrE+EgmDJO8
	n7nDbFLd9PH0VgoCGRBcAyf5PUDl9CqPWMMn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L3U81IjpVm+y2QRKN1H4z83ZFJLKDu4b
	A0/67J1q+mCMzyeFiCO6SRSbc2Yx/WY932n+xM1JiRH7yQF1Yev6tcdOxgMs6nUn
	5F52X0Vr7BEjknFgbeQjqICr+Ni5da3BpfThCIZnIptOe/Ex5NnAsbG8thlfgIYS
	BVQ2EesqCGY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D0CE3516C;
	Wed,  4 May 2011 14:46:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4BA3A5169; Wed,  4 May 2011
 14:46:29 -0400 (EDT)
In-Reply-To: <1304529590-1032-1-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Thu, 5 May 2011 01:19:50 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5E4E79A-767E-11E0-B920-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172759>

Tay Ray Chuan <rctay89@gmail.com> writes:

> +	GIT_CURL_VERBOSE=1 git push -v -v 2>err &&
> +	! grep "Expect: 100-continue" err &&
> +	grep "POST git-receive-pack (376 bytes)" err &&

This "376 bytes" bothers me. Can our packing algorithm never improve?

>  	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
>  	 test $HEAD = $(git rev-parse --verify HEAD))
>  '
> @@ -140,5 +142,17 @@ test_expect_success C_LOCALE_OUTPUT 'push fails for non-fast-forward refs unmatc
>  		output
>  '
>  
> +test_expect_success 'push (chunked)' '
> +	git checkout master &&
> +	test_commit commit path3 &&
> +	HEAD=$(git rev-parse --verify HEAD) &&
> +	git config http.postbuffer 4 &&
> +	test_when_finished git config --unset http.postbuffer &&

It probably is a good style to send the command line as a single
argument.  There are a few violations in the existing code but that is not
an excuse to add more violations.

> +	git push -v -v origin $BRANCH 2>err &&
> +	grep "POST git-receive-pack (chunked)" err &&
> +	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
> +	 test $HEAD = $(git rev-parse --verify HEAD))
> +'
> +
>  stop_httpd
>  test_done

I'll queue this with the following trivial fix-up.

By the way, the "(chunked) test" is failing for me, with

  Pushing to http://127.0.0.1:5541/smart/test_repo.git
  POST git-receive-pack (chunked)
  POST git-receive-pack (chunked)
  POST git-receive-pack (chunked)
  fatal: The remote end hung up unexpectedly
  fatal: The remote end hung up unexpectedly

in trash/test_repo_clone/err; sometimes with two POSTs and sometimes with
three POSTs before we get the "fatal:".

---

 t/t5541-http-push.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index fec552c..4b93fa1 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -74,7 +74,7 @@ test_expect_success 'push to remote repository (standard)' '
 	HEAD=$(git rev-parse --verify HEAD) &&
 	GIT_CURL_VERBOSE=1 git push -v -v 2>err &&
 	! grep "Expect: 100-continue" err &&
-	grep "POST git-receive-pack (376 bytes)" err &&
+	grep "POST git-receive-pack ([0-9]* bytes)" err &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
@@ -147,7 +147,7 @@ test_expect_success 'push (chunked)' '
 	test_commit commit path3 &&
 	HEAD=$(git rev-parse --verify HEAD) &&
 	git config http.postbuffer 4 &&
-	test_when_finished git config --unset http.postbuffer &&
+	test_when_finished "git config --unset http.postbuffer" &&
 	git push -v -v origin $BRANCH 2>err &&
 	grep "POST git-receive-pack (chunked)" err &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
