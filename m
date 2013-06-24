From: Arnaud Fontaine <arnau@debian.org>
Subject: Re: [PATCH] Do not ignore merge options in interactive rebase
Date: Mon, 24 Jun 2013 16:40:28 +0900
Organization: Debian
Message-ID: <87bo6wyn0z.fsf@duckcorp.org>
References: <87bo70dokb.fsf@duckcorp.org>
	<7vr4fvkxew.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 09:40:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur1OC-0002ea-Qx
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 09:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742Ab3FXHkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 03:40:37 -0400
Received: from Orfeo.duckcorp.org ([193.17.192.211]:39950 "EHLO
	mx1.duckcorp.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab3FXHkg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 03:40:36 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mx1.duckcorp.org (Postfix) with ESMTPSA id 3bf2V70rvdz2J50;
	Mon, 24 Jun 2013 09:40:31 +0200 (CEST)
X-URL: http://www.debian.org
X-Operating-System: Debian GNU/Linux
X-GnuPG-KeyID: 5E3619D3
X-PGP-Fingerprint: D792 B8A5 A567 B001 C342  2613 BDF2 A220 5E36 19D3
In-Reply-To: <7vr4fvkxew.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 21 Jun 2013 13:43:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228783>

Junio C Hamano <gitster@pobox.com> writes:

> Arnaud Fontaine <arnau@debian.org> writes:
>
>> Merge strategy and its options can  be specified in `git rebase`, but
>> with `--interactive`, they were completely ignored.
>
> And why  is it a bad  thing?  If you meant  s/--interactive/-m/ in the
> above, then I can sort of understand the justification, though.

Sorry, it was not  clear. I meant that you can  do 'rebase -m --strategy
recursive'. But with 'rebase --interactive -m --strategy recursive', '-m
--strategy recursive' is ignored. To  me, this is not consistent because
the behavior is  different in interactive mode...   Personally, I needed
to specify the strategy and its options while using interactive mode and
it seems I'm not the only one[0].

>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> old mode 100644
>> new mode 100755
>
> I see an unjustifiable mode change here.

Sorry about that, I fixed it.

>> index f953d8d..c157fdf
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -239,7 +239,16 @@ pick_one () {
>>  
>>  	test -d "$rewritten" &&
>>  		pick_one_preserving_merges "$@" && return
>> -	output git cherry-pick $empty_args $ff "$@"
>> +
>> +	if test -n "$do_merge"
>> +	then
>
> So you _did_ mean "rebase -m"?

I really  meant 'rebase --interactive  -m'. do_merge  is set to  true if
either '--strategy' or '-m' or '-X' is given according to git-rebase.sh.

>> +		test -z "$strategy" && strategy=recursive
>> +		output git cherry-pick --strategy=$strategy \
>
> This is a bad change.
>
> I would understand if the above were:
>
> 	git cherry-pick ${strategy+--strategy=$strategy} ...
>
> in other  words, "if there is  no strategy specified, do  not override
> the  configured  default  that  might  be  different  from  recursive"
> (pull.twohead may be set to resolve).

Indeed, I did not know about that.  I wrongly thought it was a good idea
to  do   the  same   as  both   git-rebase  (when   -X  is   given)  and
git-rebase--merge  which  do the  same  test  ('test -z  "$strategy"  &&
strategy=recursive').  However  after checking  more carefully,  I guess
that, for the former case, it  is because only recursive currently takes
options,  whereas,  for  the  latter  case, it  is  to  call  a  default
git-rebase-$strategy.

>> +			$(echo $strategy_opts | sed "s/'--\([^']*\)'/-X\1/g") \
>
> Is it guaranteed $startegy_opts do not have a space in it?

strategy_opts may be something like (git-rebase.sh): "'--foo' '--bar'",
but I'm not sure what is wrong if there is a space in it though.

> There is a  call to "git merge" that  uses "${strategy+-s $strategy}",
> but it does not seem to propagate the strategy option.  Does it need a
> similar change?  It  seems that the first step might  be to factor out
> these  calls  to the  "git  cherry-pick"  and  "git merge"  to  helper
> functions  to make  it easier  to call  them with  -s/-X options  in a
> consistent way.

As far as I understand, yes. I changed it. As it is really short, I just
added an if/else inside the script itself, not sure if that's ok...

>> +			$empty_args $ff "$@"
>> +	else
>> +		output git cherry-pick $empty_args $ff "$@"
>> +	fi
>
> It seems that there is another call to "git cherry-pick" in the script
> ("git grep" for it).  Does it need a similar change?

As far as I understand, yes. So I changed it as well.

I  have sent  the fixed  patch in  my next  email. Many  thanks for  the
review!

Cheers,
-- 
Arnaud Fontaine

[0] http://git.661346.n2.nabble.com/git-rebase-interactive-does-not-respect-merge-options-td7500093.html
