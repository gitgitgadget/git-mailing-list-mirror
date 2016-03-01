From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 7/7] git: submodule honor -c credential.* from command line
Date: Tue, 01 Mar 2016 09:26:51 -0800
Message-ID: <xmqqh9gq85yc.fsf@gitster.mtv.corp.google.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
	<1456786715-24256-8-git-send-email-jacob.e.keller@intel.com>
	<CAGZ79kbDaV=i0augzh5RgGYpTWXOuTLx=7Occhc-6iE+0pBVNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 18:27:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aao4Z-0003ew-Fa
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 18:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbcCAR0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 12:26:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750813AbcCAR0y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 12:26:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 51BDF48007;
	Tue,  1 Mar 2016 12:26:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VNbkVn0CAqPlSqxNF22qNq85hkU=; b=tjz21s
	su27OSBKMYEejmzavQDlrJ8qstAxmKyejqbQ+X6cNdOc17FLHH4Lk1xHoiSp0+Hq
	ykdtcYx9Dn44r2IxdKTtUqJM6HaJDQibC2AxZTwboy3vTi9g8CQyL5zNRodTY3Kc
	qmoEhXDt/VfSbpX3XEFitDQDsvizmvhBR8PNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mzaKp0u4/PIjYC0WRd2HS5BkCH87/dSu
	aNVEb0PKStddrT2+RC1g/BrysgTPrw08CduxZE4UHgTWiRNmRLnrOAp5vrQKtfz1
	9dgBRYEAhfsB5Jgoqt1gZLrTQ0Lpg99IfU31/hnNFl32GN7KCtgy0xWm/8g0XkLy
	NZh9KBHLvtU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4735948006;
	Tue,  1 Mar 2016 12:26:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A412B48005;
	Tue,  1 Mar 2016 12:26:52 -0500 (EST)
In-Reply-To: <CAGZ79kbDaV=i0augzh5RgGYpTWXOuTLx=7Occhc-6iE+0pBVNg@mail.gmail.com>
	(Stefan Beller's message of "Mon, 29 Feb 2016 15:39:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C9DE4578-DFD2-11E5-9C3E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288043>

Stefan Beller <sbeller@google.com> writes:

> On Mon, Feb 29, 2016 at 2:58 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>>
>> +test_expect_success 'cmdline credential config passes into submodules' '
>> +       git init super &&
>> +       set_askpass user@host pass@host &&
>
> I wonder why we use pass@host as a password, it seems confusing to me.
> p@ssword would have worked if we wanted to test a password containing an @,
> pass@host doesn't quite fit my mental model of how passwords work.
> No need to change anything, better be consistent with the rest of the tests.
>
>
>> +       (
>> +               cd super &&
>> +               git submodule add "$HTTPD_URL/auth/dumb/repo.git" sub &&
>> +               git commit -m "add submodule"
>> +       ) &&
>> +       set_askpass wrong pass@host &&
>> +       test_must_fail git clone --recursive super super-clone &&
>> +       rm -rf super-clone &&
>> +       set_askpass wrong pass@host &&
>
> Why set set_askpass a second time here?

I find this in t/lib-httpd.sh:

        set_askpass() {
                >"$TRASH_DIRECTORY/askpass-query" &&
                echo "$1" >"$TRASH_DIRECTORY/askpass-user" &&
                echo "$2" >"$TRASH_DIRECTORY/askpass-pass"
        }

and expect_askpass peeks at askpass-query to see if Git asked the
right questions.

I think askpass-query is cleared here because the author of the test
suite expected that the helpers are used in such a way that you
always (1) set-askpass once, (2) run a Git command that asks
credentials, (3) use expect_askpass to validate and do these three
steps as a logical unit?

That "clone" the test expects to fail does ask the credential, so
even though the test does not check if the "clone" asked the right
question, it finishes the three-step logical unit, and then you need
to clear askpass-query.

It may have been cleaner if you had clear_askpass_query helper that
is called (1) at the beginning of set_askpass instead of this manual
clearing, (2) at the end of expect_askpass, as the exchange has been
tested already at that point, and (3) in place of expect_askpass if
you choose not to call it (e.g. this place, instead of the second
set_askpass, you would say clear_askpass_query), perhaps, but I do
know if that is worth it.
