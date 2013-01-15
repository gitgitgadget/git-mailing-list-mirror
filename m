From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] pre-push hook support
Date: Mon, 14 Jan 2013 16:24:00 -0800
Message-ID: <7vpq1770pr.fsf@alter.siamese.dyndns.org>
References: <1356735452-21667-1-git-send-email-aaron@schrab.com>
 <1358054224-7710-1-git-send-email-aaron@schrab.com>
 <7vk3rfek51.fsf@alter.siamese.dyndns.org>
 <7va9sb8jg7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 01:24:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuuKJ-00071K-74
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107Ab3AOAYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:24:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755913Ab3AOAYE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:24:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B94FC4F0;
	Mon, 14 Jan 2013 19:24:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qNz38C5aEZi563emFAWRPwtfvrc=; b=gtx45o
	hk9uJGKKZFYOUMCyyI/k1FDo7y8bSO6+3AKOoNwpLeTI5VL2iwy0C7x83cvJvBMz
	hQCEFXH/PgYEVImUtDSk1e2YSVUrmtlYG7eX3SNHvhpRutonNJjgPLeY2epsvpYM
	oviu4bdgbd4h9uARBbSKKJQkGGo6lp3psVTl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=chaS2A8pf6Zk9676L2fU1nxAzV2J+CF2
	gh6JDtTZt+zrkBjY+byCCLuuad/j/GXLX8LclaSlEnhlHJYunzEWes9XsHWkBx90
	wj0pBsMGUTg9ctsn8wkSEQTtHnMy4ius4EKj2UZijc4/LMEDTKBbAXfmb/DK+G4P
	uOkPVoU65d4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 195C0C4EF;
	Mon, 14 Jan 2013 19:24:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63A42C4EC; Mon, 14 Jan 2013
 19:24:02 -0500 (EST)
In-Reply-To: <7va9sb8jg7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 14 Jan 2013 14:54:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCF66698-5EA9-11E2-A2A6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213548>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Aaron Schrab <aaron@schrab.com> writes:
>>
>>> Main changes since the initial version:
>>>
>>>  * The first patch converts the existing hook callers to use the new
>>>    find_hook() function.
>>>  * Information about what is to be pushed is now sent over a pipe rather
>>>    than passed as command-line parameters.
>>>
>>> Aaron Schrab (3):
>>>   hooks: Add function to check if a hook exists
>>>   push: Add support for pre-push hooks
>>>   Add sample pre-push hook script
>>
>> Getting much nicer.  Thanks.
>
> Hmph, t5571 seems to be flaky in that it sometimes fails but passes
> when run again.  Something timing dependent is going on???

With this patch applied, repeatedly try to

 - make sure "foreign" ref does not exist; and
 - attempt pushing the HEAD:foreign to create the "foreign" ref

until it fails, I can get it stop before the output scrolls off of
my 114 line terminal.  Then when I revert the changes to transport.[ch]
and builtin/push.c in this series, the test will keep going.

Wait.  The sample hook used in the test _is_ fed some input but it
exits without reading any.  What happens when we fork it, and it
completes execution before we even have a chance to feed a single
byte?  Wont' we get a sigpipe and die?

Yup, I think that is what is missing from run_pre_push_hook()
implementation.

diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index d68fed7..050318b 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -16,8 +16,15 @@ test_expect_success 'setup' '
 	git init --bare repo1 &&
 	git remote add parent1 repo1 &&
 	test_commit one &&
-	git push parent1 HEAD:foreign
+	while :
+	do
+		git push parent1 :refs/heads/foreign &&
+		git push parent1 HEAD:foreign || break
+	done
 '
+
+exit
+
 write_script "$HOOK" <<EOF
 exit 1
 EOF
