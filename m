From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] bisect: parse revs before passing them to
 check_expected_revs()
Date: Mon, 29 Dec 2014 23:01:50 +0100 (CET)
Message-ID: <20141229.230150.1211587976341702383.chriscool@tuxfamily.org>
References: <20141225182534.32540.83491.chriscool@tuxfamily.org>
	<xmqqegriz1wi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, schwab@linux-m68k.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 29 23:02:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5iOK-0005t1-0P
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 23:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbaL2WCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 17:02:15 -0500
Received: from [194.158.98.15] ([194.158.98.15]:41388 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751542AbaL2WCO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 17:02:14 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 5ADEA4F;
	Mon, 29 Dec 2014 23:01:51 +0100 (CET)
In-Reply-To: <xmqqegriz1wi.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261892>

From: Junio C Hamano <gitster@pobox.com>

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> When running for example "git bisect bad HEAD" or
>> "git bisect good master", the parameter passed to
>> "git bisect (bad|good)" has to be parsed into a
>> commit hash before checking if it is the expected
>> commit or not.
> 
> Hmm, is that because you wrote commit object name in 40-hex in the
> EXPECTED_REV and you need to compare with what the user gave you
> which could be symbolic?

Yes, that's the reason.
 
> The conversion makes sense, but why is it a bad thing to say
> 
> 	git bisect bad maint
> 
> when 'maint' is not what you checked out in the current bisect run
> in the first place (perhaps you checked if it is good or bad manually
> before you started bisecting)?

It is not a "bad thing" to test another commit than the one that has
been checked out and then to say if it is "good" or "bad". But if you
do that then it is safer to check if a merge base should be tested.

I can discuss this point further and there are indeed some
optimisations we could implement in this area, but I think it is
better to try to just fix the bug first.

>> diff --git a/git-bisect.sh b/git-bisect.sh
>> index 6cda2b5..2fc07ac 100755
>> --- a/git-bisect.sh
>> +++ b/git-bisect.sh
>> @@ -237,15 +237,18 @@ bisect_state() {
>>  		check_expected_revs "$rev" ;;
>>  	2,bad|*,good|*,skip)
> 
> This part accepts arbitrary number of revs when running good and
> skip, e.g.
> 
> 	git bisect good maint master next
> 
> and it loops

Yeah.

>>  		shift
>> -		eval=''
>> +		hash_list=''
>>  		for rev in "$@"
>> ...
>> +		for rev in $hash_list
>> +		do
>> +			bisect_write "$state" "$rev"
>> +		done
>> +		check_expected_revs $hash_list ;;
> 
> But check_expected_revs loops and leaves the loop early when it
> finds anything that is not expected.
> 
> ... goes and looks ...
> 
> Hmph, I think the logic in check_expected_revs is not wrong, but
> this helper function is grossly misnamed.  It is not checking and
> rejecting the user input---it is checking to see if it can bypass
> check_good_are_ancestors_of_bad() which is expensive, so when it
> sees any one of the input is not what it checked out, it just
> disables the "optimization".

Yeah, that's the idea. If you have a better name for
check_expected_revs(), I can change it in another patch.

And yeah, check_good_are_ancestors_of_bad() is expensive to compute
and also expensive because it might mean that more tests have to be
performed by the user to be safe.

> OK, will queue.

Thanks,
Christian.
