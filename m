From: Benny Halevy <bhalevy@tonian.com>
Subject: Re: [PATCH] git-remote rename should match whole string when renaming
 remote ref directory
Date: Tue, 27 Sep 2011 12:38:46 +0300
Message-ID: <4E8199A6.5010804@tonian.com>
References: <1317045186-25206-1-git-send-email-benny@tonian.com> <7v62kf41ud.fsf@alter.siamese.dyndns.org> <4E8138B3.9090909@tonian.com> <7voby6y0vs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 11:38:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8U7s-0005pp-LE
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 11:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788Ab1I0Jiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 05:38:52 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50654 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab1I0Jiv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 05:38:51 -0400
Received: by wyg34 with SMTP id 34so6976585wyg.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 02:38:50 -0700 (PDT)
Received: by 10.227.154.19 with SMTP id m19mr7300460wbw.2.1317116330258;
        Tue, 27 Sep 2011 02:38:50 -0700 (PDT)
Received: from lt.bhalevy.com ([62.90.159.144])
        by mx.google.com with ESMTPS id en9sm35059244wbb.24.2011.09.27.02.38.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Sep 2011 02:38:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <7voby6y0vs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182228>

On 2011-09-27 09:07, Junio C Hamano wrote:
> Benny Halevy <bhalevy@tonian.com> writes:
> 
>> On 2011-09-26 21:04, Junio C Hamano wrote:
>>> Benny Halevy <benny@tonian.com> writes:
>>> ...
>>>> -	if (!prefixcmp(refname, buf.buf)) {
>>>> +	if (!strcmp(refname, buf.buf)) {
>>>
>>> At this point of the code, refname has "refs/remotes/test/foo" and it is
>>> queued to later rename it to "refs/remotes/test-/foo" (the next invocation
>>> of this function will see "refs/remotes/test/bar" in refname). And the
>>> strbuf buf.buf has "refs/remotes/test"; your !strcmp(refname, buf.buf)
>>> would never trigger, I suspect.
>>>
>>> Isn't 60e5eee (remote: "rename o foo" should not rename ref "origin/bar",
>>> 2011-09-01) the correct fix for this issue?...
>>
>> OK, 60e5eee solves the problem too.
> 
> Hmm, what do you mean by "too" here?  Martin's patch fixes the issue, but
> does yours, too?
> 

correct.

>> FWIW, here's the test I used:
>> ...
>> cd main || fail cd main failed
>> for i in test test-2; do
>> 	$git remote add $i file://$cwd/$i || fail git remote add $i failed
>> done
>> $git remote update || fail git remote update fail
>> $git remote rename test test-
>> $git show test-2/master || fail FAILED
>> echo PASSED
> 
> Before your last "echo PASSED", add this line:
> 
> 	$git show test-/master || fail FAILED
> 
> and see what happens with your patch.

Yup, with my patch this test indeed fails, and with Martin's
it passes.

Thanks!

Benny

> 
> It is unfortunately a rather common trap to fall into, so I wouldn't blame
> you too much. People tend to concentrate only on an aspect of the problem
> that originally motivated them, and forget about the other issues that are
> equally important, if not more. In this case, you were too thrilled to see
> that your updated code no longer renames "test-2" mistakenly to "test--2",
> and you forgot that the primary task of the resulting code was to rename
> "test" to "test-" correctly. The additional line I gave you above is to
> test that.
> 
> When testing your own code, make it a habit to _always_ test both sides of
> the coin. It is somewhat difficult until you get used to it [*1*], but it
> is a skill that is really worth acquiring.
> 
> Thanks.
> 
> 
> [Footnote]
> 
> *1* ...and I do not claim that I myself never forget to fully enumerate
> other sides; even experienced people still overlook and embarrass
> themselves in public ;-)
