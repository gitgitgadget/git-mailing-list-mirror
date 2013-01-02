From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: Honor prepare-commit-msg return code
Date: Wed, 02 Jan 2013 13:21:21 -0800
Message-ID: <7vwqvv1dta.fsf@alter.siamese.dyndns.org>
References: <1357152170-5511-1-git-send-email-apelisse@gmail.com>
 <7v623f2uam.fsf@alter.siamese.dyndns.org>
 <CALWbr2wWjwUnHFq1icMRuW=vjQDhTO1e_chffqUvDWY5za1Kiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Jay Soffian <jaysoffian@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 22:21:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqVl3-0005BP-3H
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 22:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab3ABVV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 16:21:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50291 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867Ab3ABVVX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 16:21:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4735CA74D;
	Wed,  2 Jan 2013 16:21:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1KF5dGzJI0vh7PRVK5UOn23D2es=; b=RiIAam
	XjOThjXudhqgilIw4TqsKE/Ku6O8uzlHVgcdyKjKQ/le16unGzDdDVdl1ecpbNiD
	TyHhpSBYq5mX1tFMglyVXXSiw0wm8iZwGy6y+I8rmYOORZGL7Wv2choPCupKytOZ
	uoJVbsZCkeTsFPw9XLyK0NvGtVfVnsYKJ7YLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h+KFZ94td9CPnnRVMV4cINcqF097w5EP
	WeRIiEdklqz+Oy63in2KsBZ1cDVNA97eAqm3xmtMB5/URiaSI9VXSvGlagNh1tWD
	OcJF4+tdi05o8TJ8DjIabSmLVUe4EkPhGYGGqbc3Rei95dgPRrW67KeTaMjfeds3
	Dl0+vaTSo80=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3767DA74C;
	Wed,  2 Jan 2013 16:21:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFD30A74B; Wed,  2 Jan 2013
 16:21:22 -0500 (EST)
In-Reply-To: <CALWbr2wWjwUnHFq1icMRuW=vjQDhTO1e_chffqUvDWY5za1Kiw@mail.gmail.com> (Antoine
 Pelisse's message of "Wed, 2 Jan 2013 22:02:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B85CC92-5522-11E2-B8E7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212544>

Antoine Pelisse <apelisse@gmail.com> writes:

>>> prepare-commit-msg hook is run when committing to prepare the log
>>> message. If the exit-status is non-zero, the commit should be aborted.
>>
>> I was scratching my head why you CC'ed Jay, until I dug up 65969d4
>> (merge: honor prepare-commit-msg hook, 2011-02-14).
>
> I did as suggested in "SubmittingPatches" :)

Oh, that wasn't meant as a complaint.  I am tempted to rewrite the
log message like so, though:

    65969d4 (merge: honor prepare-commit-msg hook, 2011-02-14) tried to
    make "git commit" and "git merge" consistent, because a merge that
    required user assistance has to be concluded with "git commit", but
    only "git commit" triggered prepare-commit-msg hook.  When it added
    a call to run the prepare-commit-msg hook, however, it forgot to
    check the exit code from the hook like "git commit" does, and ended
    up replacing one inconsistency with another.

>> diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
>> index bc497bc..3573751 100755
>> --- a/t/t7505-prepare-commit-msg-hook.sh
>> +++ b/t/t7505-prepare-commit-msg-hook.sh
>> @@ -172,11 +172,12 @@ test_expect_success 'with failing hook (merge)' '
>>         git checkout -B other HEAD@{1} &&
>>         echo "more" >> file &&
>>         git add file &&
>> -       chmod -x $HOOK &&
>> +       rm -f "$HOOK" &&
>>         git commit -m other &&
>> -       chmod +x $HOOK &&
>> +       write_script "$HOOK" <<-EOF
>> +       exit 1
>> +       EOF
>>         git checkout - &&
>> -       head=`git rev-parse HEAD` &&
>>         test_must_fail git merge other
>>
>>  '
>
> What about moving the hook file then ? Not very important to me, just
> a suggestion as it would keep the shebang.

Strictly speaking, the way $HOOK is prepared in the original is
wrong.  The script is always run under "#!/bin/sh" instead of the
shell the user told us to use with $SHELL_PATH.  For a simple one
liner that only exits with 1, it does not matter, though.

Many test scripts got this wrong and that was the reason we later
added write_script helper function to the test suite.
