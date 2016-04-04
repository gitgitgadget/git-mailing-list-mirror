From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 5/5] t/t5520: test --[no-]autostash with pull.rebase=true
Date: Mon, 04 Apr 2016 18:52:51 +0200
Message-ID: <vpq4mbhmi3g.fsf@anie.imag.fr>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
	<1459258200-32444-6-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cQ93+dCqJMRcQYSRHLDuYtwkeK_aSrfv2=2=g7ZhO85TQ@mail.gmail.com>
	<CA+DCAeQPr2vxvm6MKiOLpDtmpC2d=RcvYhuFeimSn+xX2TAvtQ@mail.gmail.com>
	<CAPig+cQyHu1J=FYOtgsmi3ghuN7YyjNgAz-VgO06isfrS+kUSg@mail.gmail.com>
	<CA+DCAeT1DQvHnRpJeApcm2vO6KhXaMaRXZg9HCUmiiBv=hfxzw@mail.gmail.com>
	<CAPig+cSR9Um5FUWzkzHGAM5RanaKssAysA5hGOP4+E5oA0Y5oA@mail.gmail.com>
	<CA+DCAeRqY7-qZt-upa5=nY8OkUL4Q76ogk5nrF_WAaiFiWOy1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 18:53:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an7kT-0007pb-HT
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 18:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbcDDQxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 12:53:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33242 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751902AbcDDQxC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 12:53:02 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u34GqmQu004294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 4 Apr 2016 18:52:48 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u34GqpQn032049;
	Mon, 4 Apr 2016 18:52:51 +0200
In-Reply-To: <CA+DCAeRqY7-qZt-upa5=nY8OkUL4Q76ogk5nrF_WAaiFiWOy1A@mail.gmail.com>
	(Mehul Jain's message of "Mon, 4 Apr 2016 22:12:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 04 Apr 2016 18:52:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u34GqmQu004294
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1460393573.25736@+lGPKpEekjFoZqrmgq2Dow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290698>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> On Mon, Apr 4, 2016 at 12:58 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Fri, Apr 1, 2016 at 6:27 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
>>> In test_autostash() there's a line
>>>
>>>     echo test_cmp_rev HEAD^ copy &&
>>>
>>> Originally it should have been
>>>
>>>     test_cmp_rev HEAD^ copy &&
>>>
>>> but this raise following error while testing
>>>
>>>     ./t5520-pull.sh: 684: eval: diff -u: not found
>>
>> This is caused by the custom IFS=',\t=' which is still in effect when
>> test_cmp_rev() is invoked. You need to restore IFS within the loop
>> itself.
>
> Thanks for pointing it out. I made a mistake by not considering
> the consequences of setting IFS=',\t='. I tried it out again and
> this time all tests passed perfectly.

I think it would be much simpler to drop the loop, and write instead
something like (untested):

test_autostash () {
	expect="$1"
        cmd="$2"
        config_variable="$3"
        value="$4"
        test_expect_success "$cmd, $config_variable=$value" '
            if [ "$value" = "" ]; then
                test_unconfig $config_variable
            else
                test_config $config_variable $value
            fi &&

            git reset --hard before-rebase &&
            echo dirty >new_file &&
            git add new_file &&

            if [ $expect = "ok" ]; then
                git pull '$cmd' . copy &&
                test_cmp_rev HEAD^ copy &&
                test "$(cat new_file)" = dirty &&
                test "$(cat file)" = "modified again"
            else
                test_must_fail git pull '$cmd' . copy 2>err &&
                test_i18ngrep "uncommitted changes." err
            fi
        '
}

test_autostash ok --rebase rebase.autostash=true
test_autostash ok '--rebase --autostash' rebase.autostash=true
test_autostash ok '--rebase --autostash' rebase.autostash=false
test_autostash ok '--rebase --autostash' rebase.autostash=
test_autostash err '--rebase --no-autostash' rebase.autostash=true
test_autostash err '--rebase --no-autostash' rebase.autostash=false
test_autostash err '--rebase --no-autostash' rebase.autostash=
test_autostash ok --autostash pull.rebase=true
test_autostash err --no-autostash pull.rebase=true

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
