From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pre-push hook does not get input on non-fast-forward pushes
Date: Mon, 28 Mar 2016 14:44:20 -0700
Message-ID: <xmqq1t6uxop7.fsf@gitster.mtv.corp.google.com>
References: <201603282056.u2SKuqDf031459@mail2.student.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Tauner <stefan.tauner@alumni.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Mar 28 23:44:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akexs-0000Mj-3i
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 23:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148AbcC1VoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 17:44:24 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54684 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752252AbcC1VoX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 17:44:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7D5CB4F31B;
	Mon, 28 Mar 2016 17:44:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=elrMLZiqmqCyk/xfALWlE+sYOas=; b=mqE00n
	k1d0lJuUDGuI+C7qQCFPPRVMVt3dyPriFaehlyzhRBT/nARJ3kQRd1GQ9/z26VM/
	oNUr1FPYoRGM6H1RgPPw4FdYWy1lbQzeg01ILcLI3chcHR/7/OwyKMMPAhnDIjjy
	2OfS5hmILcuNR4kEU7RIdwZc3l2ZkcmufwakE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ukA4OaiVhiLt6vUpIloAyUocH/VJnWm7
	M6iv3rUiLkrPcgYm8/hxcHonT77DG8vbT7aWbPdwPwydPTnxqjPEPpv/iFy3VZaG
	a6N4H+wbkCIWoU8LG/LVLPBv1UeqQO9cFQ2VhmQU6N8sWzukbPUkBkOrdlRRKj7h
	rcV2EFRtRVg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 73A844F31A;
	Mon, 28 Mar 2016 17:44:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E71EF4F319;
	Mon, 28 Mar 2016 17:44:21 -0400 (EDT)
In-Reply-To: <201603282056.u2SKuqDf031459@mail2.student.tuwien.ac.at> (Stefan
	Tauner's message of "Mon, 28 Mar 2016 22:56:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3B76816C-F52E-11E5-81E5-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290065>

Stefan Tauner <stefan.tauner@alumni.tuwien.ac.at> writes:

> I noticed that without an additional --force the pre-push hook does not
> get any input on stdin if a push would result in non-fast-forward
> uploads. This is not a problem per se (although I don't get the
> rationale) but it is undocumented and the latter left me puzzled.
>
> (Please keep me in CC since I am not subscribed, thanks)

Thanks (no need to say "please cc me", as that is the norm here).

The pre-push hook is not the only thing that may prevent you from
pushing a ref update.  As you noticed, non-fast-forward check may
trigger and decide that a ref is not going to be pushed, and that
may happen before we call the pre-push hook.

    Information about what is to be pushed is provided on the hook's
    standard input with lines of the form ...

So when the pre-push is called, the refs that will not fast-forward
may not be among the "what is to be pushed", hence not reported.

We _could_ add something like this to the documentation, but we do
not necessarily want to promise that the order of checks to stay
"internal checks like non-ff check first before pre-push hook", so
this update may not be an improvement.  The current text conveys
enough information without making such a promise, but you need to
read it carefully.

So I dunno.

 Documentation/githooks.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 9ef2469..605ba4d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -201,7 +201,9 @@ does not yet exist the `<remote SHA-1>` will be 40 `0`.  If a ref is to be
 deleted, the `<local ref>` will be supplied as `(delete)` and the `<local
 SHA-1>` will be 40 `0`.  If the local commit was specified by something other
 than a name which could be expanded (such as `HEAD~`, or a SHA-1) it will be
-supplied as it was originally given.
+supplied as it was originally given.  A request to update remote ref that has
+already been rejected for other reasons (e.g. failing to pass a fast-forward
+test) does not appear in the input.
 
 If this hook exits with a non-zero status, 'git push' will abort without
 pushing anything.  Information about why the push is rejected may be sent
