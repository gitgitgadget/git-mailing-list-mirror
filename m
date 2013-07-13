From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Sat, 13 Jul 2013 08:52:42 +0200
Message-ID: <51E0F93A.8050201@kdbg.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org> <1373399610-8588-1-git-send-email-gitster@pobox.com> <1373399610-8588-8-git-send-email-gitster@pobox.com> <51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org> <51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org> <7vvc4jtjqa.fsf@alter.siamese.dyndns.org> <51DF1F56.9000705@kdbg.org> <7vzjtspwvo.fsf@alter.siamese.dyndns.org> <51E03B18.5040502@kdbg.org> <7vli5bllsd.fsf@alter.siamese.dyndns.org> <51E0605E.9020902@kdbg.org> <7vy59biih4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 08:52:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxthL-0002IQ-HB
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 08:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357Ab3GMGwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 02:52:47 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:27380 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751469Ab3GMGwr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 02:52:47 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D634513004C;
	Sat, 13 Jul 2013 08:52:43 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D2B2719F618;
	Sat, 13 Jul 2013 08:52:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vy59biih4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230277>

Am 12.07.2013 23:19, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> We have three independent options that the user can choose in any
>> combination:
>>
>>  o --force given or not;
>>
>>  o --lockref semantics enabled or not;
>>
>>  o refspec with or without +;
>>
>> and these two orthogonal preconditions of the push
>>
>>  o push is fast-forward or it is not ("ff", "noff");
>>
>>  o the branch at the remote is at the expected rev or it is not
>>    ("match", "mismatch").
>>
>> Here is a table with the expected outcome. "ok" means that the push is
>> allowed(*), "fail" means that the push is denied. (Four more lines with
>> --force are omitted because they have "ok" in all spots.)
>>
>>                        ff   noff     ff      noff
>>                       match match mismatch mismatch
>>
>> --lockref +refspec     ok    ok    denied   denied
>> --lockref  refspec     ok  denied  denied   denied
> 
> I am confused with these.  The latter is the most typical:
> 
> 	git fetch
>         git checkout topic
>         git rebase topic
> 	git push --lockref topic
> 
> where we know it is "noff" already, and we just want to make sure
> that nobody mucked with our remote while we are rebasing.

Today (without --lockref), the above sequence would fail to push.
(Because there is no + and no --force.)

> If nobody updated the remote, why should this push be denied?  And in
> order to make it succeed, you need to force with +refspec or --force,
> but that would bypass match/mismatch safety, which makes the whole
> "make sure the other end is unchanged" safety meaningless, no?

I am suggesting that +refspec would *not* override the match/mismatch
safety, but --force would.

> 
>>           +refspec     ok    ok      ok       ok
> 
> This is traditional --force.
> 
>>            refspec     ok  denied    ok     denied
> 
> We are not asking for --lockref, so match/mismatch does not affect
> the outcome.

I think you are worried that a deviation from the principle that
+refspec == --force hurts current users. But I am arguing that this is
not the case because "current" users do not use --lockref. As you have
seen from the table, without --lockref there is *no change* in behavior.

I still have not seen an example where +refspec != --force would have
unexpected consequences. (The inequality is merely that +refspec fails
on mismatch when --lockref was also given while --force does not.)

>> Notice that without --lockref semantics enabled, +refspec and refspec
>> keep the current behavior.
> 
> But I do not think the above table with --lockref makes much sense.
> 
> Let's look at noff/match case.  That is the only interesting one.
> 
> This should fail:
> 
> 	git push topic
> 
> due to no-ff.

Yes.

> Your table above makes this fail:
> 
>         git push --lockref topic
> 
> and the user has to force it,

Of course.

> like this?
> 
> 	git push --lockref --force topic ;# or alternatively
>         git push --lockref +topic
> 
> Why is it even necessary?

Because it is no-ff. How do you achieve the push today (without
--lockref)? You use one of these two options. It does not change with
--lockref.

> If you make
> 
> 	git push --lockref topic
> 
> succeed in noff/match case, everything makes more sense to me.

Not to me, obviously ;)

> The --lockref option is merely a weaker form of --force but still a
> way to override the noff check.

No; --lockref only adds the check that the destination is at the
expected revision, but does *NOT* override the no-ff check. Why should
it? (This is not a rethoric question.)

(I think I said differently in an earlier messages, but back then things
were still blurry. The table in my previous message is what I mean.)

>  If the user wants to keep noff
> check, the user can simply choose not to use the option.

No. If the user wants to keep the no-ff check, she does not use the + in
the refspec and does not use --force. (Just like today.)

> Of course, that form should fail if "mismatch".  And then you can
> force it,
> 
> 	git push --force [--lockref] topic
> 
> As "--force" is "anything goes", it does not matter if you give the
> other option on the command line.

... or the + in the refsepc.

-- Hannes
