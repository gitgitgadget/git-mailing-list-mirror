From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t6302: drop unnecessary GPG requirement
Date: Sun, 31 Jan 2016 18:07:24 -0800
Message-ID: <xmqq4mdtxjxf.fsf@gitster.mtv.corp.google.com>
References: <1454271562-24291-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 03:07:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ3tr-000169-6i
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 03:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933419AbcBACH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 21:07:27 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933224AbcBACH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 21:07:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B7684416E7;
	Sun, 31 Jan 2016 21:07:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wd93ytjL795/ve8VtAB9YAC5IKY=; b=FMe5hd
	gSrM5HKkLcyrAYFWIQ9eIw8O61/U0xTRfR0eho26V3oR+AK7oYAqIl3QX1u5pICL
	x+JeGXvAOOUkEQUEWczMMXHpU88FhwqAHhWUvJqQJJATJMMLqspg9boeQlz6XKva
	QgP+p2jtvFc7IU1bgenVlpQp/9CGoveubWvqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ODY3RLHRYu9FxVC35uuoc/aaqZRM9QFo
	9hlDkQXsvGkp8ZEqT7/3apcnMJuBgCwPM1PWaxsSH5MrxhYPxDpCUJ1MolUOLKaR
	kRgpee00JeORbySvRVa3MAaKKyIa0Fm3gcx7tAX8hneOHEThT5Tab6AWoEkPt2FY
	LLJF8ZgrkSA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ACE3B416E6;
	Sun, 31 Jan 2016 21:07:25 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 27798416E3;
	Sun, 31 Jan 2016 21:07:25 -0500 (EST)
In-Reply-To: <1454271562-24291-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Sun, 31 Jan 2016 15:19:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 897204D6-C888-11E5-BD0C-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285176>

Eric Sunshine <sunshine@sunshineco.com> writes:

> These tests are concerned specifically with filtering, sorting,
> formatting behavior of git-for-each-ref, yet if GPG is not present, the
> entire test script is skipped even though none of the tests depend upon
> or care whether the tags are signed. This unnecessary dependency upon
> GPG may prevent these tests from being more widely run, so drop it.

It is conceivable, if not highly plausible, that a change to the
code that does the filtering and formatting can become buggy because
payload with GPG signature looks somewhat differently from what is
in an annotated but not signed tag.  Even if "these are specifically
filtering..."  is true, including tests for signed tags is valuable.

It seems that we are not currently testing with unsigned but
annotated tags, and tests that use them would be good, too.

Would it make sense to introduce a helper function specific to this
script to be used to prepare the expected output, to replace cat <<,
that goes like this?

    test_prepare_expect () {
	if test_have_prereq GPG
        then
		cat
	else
        	sed -e '/signed/d'
	fi
    }

And then use it like this?

    test_expect_success 'check "%(contents:lines=99999)"' '
        test_prepare_expect <<-\EOF &&
	master |three
        ...
        signed-tag |A signed tag message
        ...
        EOF
	git for-each-ref --format=... >actual &&
        test_cmp expect actual
    '

The setup part would need to make GPG conditional, e.g.

test_expect_success 'setup some history and refs' '
	test_commit one &&
	test_commit two &&
	test_commit three &&
	git checkout -b side &&
	test_commit four &&
	git tag -m "An annotated tag" annotated-tag &&
        git tag -m "Annotated doubly" doubly-annotated-tag annotated-tag &&
	if test_have_prereq GPG
	then
                git tag -s -m "A signed tag message" signed-tag &&
                git tag -s -m "Annonated doubly" doubly-signed-tag signed-tag
	fi &&
	git checkout master &&
	git update-ref refs/odd/spot master
'

Perhaps?
