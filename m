From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 1/2] t0303: set reason for skipping tests
Date: Mon, 12 Mar 2012 22:07:58 +0100
Message-ID: <4F5E65AE.8050401@in.waw.pl>
References: <1331553907-19576-1-git-send-email-zbyszek@in.waw.pl> <1331553907-19576-2-git-send-email-zbyszek@in.waw.pl> <20120312123031.GA14456@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 22:08:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7CTW-0006mw-Es
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 22:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756951Ab2CLVIJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Mar 2012 17:08:09 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:55726 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756444Ab2CLVII (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 17:08:08 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S7CTM-00086W-KM; Mon, 12 Mar 2012 22:08:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <20120312123031.GA14456@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192947>

On 03/12/2012 01:30 PM, Jeff King wrote:
> On Mon, Mar 12, 2012 at 01:05:06PM +0100, Zbigniew J=C4=99drzejewski-=
Szmek wrote:
>
>> t0300-credential-helpers.sh runs two sets of tests. Each set is
>> controlled by an environment variable and is skipped if the variable
>> is not defined. If both sets are skipped, prove will say:
>>    ./t0303-credential-external.sh .. skipped: (no reason given)
>> which isn't very nice.
>>
>> Use skip_all=3D"..." to set the reason when both sets are skipped.
>
> Sounds reasonable. A few nits:
OK, it seems this might be more complicated than I expected. I admit=20
that I didn't test this (apart from failing without the variables=20
defined) and assumed that it more or less works already.

I think that the tests are not very robust:
     ln -s /bin/true ~/bin/git-credential-fooooooo
     GIT_TEST_CREDENTIAL_HELPER=3Dfooooooo\
       GIT_TEST_CREDENTIAL_HELPER_TIMEOUT=3Dfooooooo\
       ./t0303-credential-external.sh

gives me:
ok 1 - helper (fooooooo) has no existing data
ok 2 - helper (fooooooo) stores password
not ok - 3 helper (fooooooo) can retrieve password
ok 4 - helper (fooooooo) requires matching protocol
ok 5 - helper (fooooooo) requires matching host
ok 6 - helper (fooooooo) requires matching username
ok 7 - helper (fooooooo) requires matching path
ok 8 - helper (fooooooo) can forget host
not ok - 9 helper (fooooooo) can store multiple users
ok 10 - helper (fooooooo) can forget user
not ok - 11 helper (fooooooo) remembers other user
ok 12 - helper (fooooooo) times out
# failed 3 among 12 test(s)
1..12

I guess that the fact that #1 succeeds reflects reality, but e.g.
4-7 and 12 probably should fail.

>>   if test -z "$GIT_TEST_CREDENTIAL_HELPER"; then
>> -	say "# skipping external helper tests (set GIT_TEST_CREDENTIAL_HEL=
PER)"
>> +	say "# skipping external helper tests (GIT_TEST_CREDENTIAL_HELPER =
not set)"
>>   else
>> [...]
>>   if test -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
>> -	say "# skipping external helper timeout tests"
>> +	say "# skipping external helper timeout tests (GIT_TEST_CREDENTIAL=
_HELPER_TIMEOUT not set)"
>
> These don't affect prove at all, do they? I'm OK with the changes, bu=
t I
> was confused to see them after reading the commit message.
Right, this was just for symmetry when running test directly. Forgot
to mention this in the commit message.

> Should they actually say "# SKIP ..." to tell prove what's going on? =
I
> don't know very much about TAP.
# SKIP is used when skipping individual tests (IIUC), but when we skip =
a=20
group of tests, we simply jump over them and this message is purely=20
informative output that is not interpreted by the harness.

>> +if test -z "$GIT_TEST_CREDENTIAL_HELPER" \
>> +    -o -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
>> +    skip_all=3D"used to test external credential helpers"
>> +fi
>
> Actually, I think it is not OK to run t0303 with HELPER_TIMEOUT set, =
but
> HELPER not set. The "helper_test_clean" bits will fail badly. The
> documentation given in the commit message is actually wrong (I added =
the
> clean bits to the patch later, and failed to realize the dependency o=
r
> update the commit message).
>
> Also, our usual idiom is to check the prerequisites at the top of the
> script and bail immediately.
>
> So maybe the whole script should be restructured as:
>
>    if test -z "$GIT_TEST_CREDENTIAL_HELPER"; then
>            skip_all=3D"GIT_TEST_CREDENTIAL_HELPER not set"
>            test_done
>    fi
>
>    pre_test
>    helper_test "$GIT_TEST_CREDENTIAL_HELPER"
>    if test -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
>            say "# skipping timeout tests (GIT_TEST_CREDENTIAL_HELPER_=
TIMEOUT not set)"
>    else
>            helper_test_timeout "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"
>    fi
>    post_test
Yeah, this seems to be the right approach. I'll repost with a proper=20
commit message once my doubts about the tests are cleared up.

-
Zbyszek
