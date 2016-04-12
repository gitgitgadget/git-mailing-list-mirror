From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Hardcoded #!/bin/sh in t5532 causes problems on Solaris
Date: Tue, 12 Apr 2016 10:12:39 -0700
Message-ID: <xmqqoa9erbso.fsf@gitster.mtv.corp.google.com>
References: <570965B9.9040207@jupiterrise.com>
	<20160409210429.GB18989@sigill.intra.peff.net>
	<57098259.1060608@jupiterrise.com>
	<20160409223738.GA1738@sigill.intra.peff.net>
	<xmqqmvp2ti20.fsf@gitster.mtv.corp.google.com>
	<20160411173224.GE4011@sigill.intra.peff.net>
	<xmqqvb3mrcgj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Tom G. Christensen" <tgc@jupiterrise.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 12 19:12:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq1rr-0002yo-Qa
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 19:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965488AbcDLRMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 13:12:43 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965082AbcDLRMm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 13:12:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A2D23556B6;
	Tue, 12 Apr 2016 13:12:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EErnxTJlzk7HmwicsE+RP1zKxpQ=; b=o7NpX3
	t6hP1YhkP2eG9M38kEKAX0ZaaTIdIQNKjgQ/Aw8SOf0vBiXo2kQniKgYU8uA6nSt
	uSV/g8zALX42JgWVw78vAB0qjXy3AxV3/TPBhBhrgZZzjXLepb7s+rfPuFw8lMs8
	Rk8NbxvPj7vBkCsDwjXQtJEADhbBrYyJmnVWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eIGSIP+o4akuaC05AniIgINNG0c1u/Wz
	oSuSd/RsWQob2skaLZkei0SIhh9YlMSTpOV66gwVrc9c2hDUQm5QJu7tSSSyus2S
	DjtdZhE8n5KbM+r7xcUcv9m227ECGyzW4SX3QLzKG7zmet3iQlPeaZUHjmL727mQ
	t3lBcYhhY1o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9A2C6556B5;
	Tue, 12 Apr 2016 13:12:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0C82F556B3;
	Tue, 12 Apr 2016 13:12:40 -0400 (EDT)
In-Reply-To: <xmqqvb3mrcgj.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 12 Apr 2016 09:58:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C391D066-00D1-11E6-82CB-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291281>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
> ...
>> Looks good and is the minimal change. I kind of wonder if the example
>> would be more clear, though, as just:
>>
>>   write_script .git/hooks/pre-commit <<-\EOF &&
>>   exit 1
>>   EOF
>>   echo whatever >file1 &&
>>   ...
>>
>> I don't think we ever actually need the pre-commit check to pass, as we
>> simply override it with --no-verify. But I dunno. Maybe people find it
>> easier to read with a pseudo-realistic example (it took me a minute to
>> realize the trailing whitespace in the content was important).
>
> I was mostly worried about closing the door for future enhancement
> where there are multiple commits to be replayed, some of which fail
> and others pass the test.  Unconditional "exit 1" would have to be
> reverted when it happens.
>
>> It could also stand to clean up its hook with test_when_finished. The
>> next test resorts to "rm -rf" on the hooks directory at the beginning.
>> Yuck.
>
> Yeah, that may be an accident waiting to happen.

In any case, lest we forget...

-- >8 --
Subject: [PATCH] t3404: use write_script

The test uses hardcoded #!/bin/sh to create a pre-commit hook
script.  Because the generated script uses $(command substitution),
which is not supported by /bin/sh on some platforms (e.g. Solaris),
the resulting pre-commit always fails.

Which is not noticeable as the test that uses the hook is about
checking the behaviour of the command when the hook fails ;-), but
nevertheless it is not testing what we wanted to test.

Use write_script so that the resulting script is run under the same
shell our scripted Porcelain commands are run, which must support
the necessary $(construct).

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3404-rebase-interactive.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 544f9ad..d6d65a3 100755
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
-- 
2.8.1-339-gc925d85
