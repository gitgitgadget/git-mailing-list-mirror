From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/7] t5528-push-default.sh: add helper functions
Date: Mon, 23 Apr 2012 18:02:10 +0200
Message-ID: <vpqobqil9ml.fsf@bauges.imag.fr>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-4-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqipgqlass.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 18:02:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMLit-0008Q5-63
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 18:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910Ab2DWQCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 12:02:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48160 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276Ab2DWQCi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 12:02:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3NFtpjt012736
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2012 17:55:51 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SMLiN-0005iz-2i; Mon, 23 Apr 2012 18:02:11 +0200
In-Reply-To: <xmqqipgqlass.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 Apr 2012 08:36:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 23 Apr 2012 17:55:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3NFtpjt012736
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1335801353.44083@+0Or4nXgw9YjttCICci8KA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196134>

Junio C Hamano <gitster@pobox.com> writes:

> Hmph.  How is $1 used in the above to make it compare between local and
> remote?  Does the first one need to have "$1" before " >expect"?

Yes, good catch.

>> +	test_must_fail git -c push.default="$1" &&
>
> What subcommand does this run with one-shot override configuration?  Do
> we need " push" before " &&"?

Right.

Plus the "$1" should have been "$push_default" since we just did a
shift.

*sigh* this was supposed not to be a draft :-(.

>>  test_expect_success '"upstream" does not push on unconfigured remote' '
>> @@ -30,7 +61,7 @@ test_expect_success '"upstream" does not push on unconfigured remote' '
>>  	test_unconfig branch.master.remote &&
>>  	test_config push.default upstream &&
>>  	test_commit three &&
>> -	test_must_fail git push
>> +	test_push_failure upstream master
>>  '
>
> ... and we can use --all not master here, right?

Actually, we can even use --all everywhere. And then, we don't even need
the second argument, and we can simplify greatly the function:

# $1 = push.default value
# check that push fails and does not modify any remote branch
test_push_failure () {
	git --git-dir=repo1 log --no-walk --format='%h %s' --all >expect &&
	test_must_fail git -c push.default="$1" push &&
	git --git-dir=repo1 log --no-walk --format='%h %s' --all >actual &&
	test_cmp expect actual
}

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
