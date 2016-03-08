From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] rebase -p: avoid grep on potentailly non-ASCII data
Date: Tue, 8 Mar 2016 14:45:20 +0100
Message-ID: <56DED770.4050603@drmicha.warpmail.net>
References: <alpine.DEB.2.10.1603080255030.2674@buzzword-bingo.mit.edu>
 <56DEC4B4.2000902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Anders Kaseorg <andersk@mit.edu>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 08 14:46:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adHy9-0005kv-BZ
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 14:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbcCHNp0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2016 08:45:26 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59011 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751431AbcCHNpW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2016 08:45:22 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id B040220416
	for <git@vger.kernel.org>; Tue,  8 Mar 2016 08:45:21 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 08 Mar 2016 08:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=HAB+5WhakN1GAiB1CVIU8jjH+Kg=; b=e3veYl
	12w+Pp5TSWI3NFA4f4OPWFJJ2ZfukfyIV3UECpwXbJR9i2e/uulQybv5rjDHN6vx
	0rLsEMvpuQGKpTpTristtbDz2o3bfs8hUm98z78BqGR+5FjaKMoOdiV5juGSTDjN
	rLJYPDYH/MrEPTOyNHlhTeazjT04o1c7Pr5Rs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=HAB+5WhakN1GAiB
	1CVIU8jjH+Kg=; b=dkH05TApqYSgpjP0qVeXnoO8ur6+k2Kq7UWImWM1VHR74xC
	vxJlAKfAK8Q93XzZ8D4p4Sbv828XK8zd4FMTCvhkydy7VUX288BgOKZbFWn50nhs
	tQdY/dlwM6z0LRvouQfUlIhQdQfe3WsRQZfdJXCgdIALT88+Ubjj/a8EVxkU=
X-Sasl-enc: 9Q1MAYcWFOMCHLcpL+YJjh5bAGkMnd41ykX4axrqFsf4 1457444721
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 072C5C00012;
	Tue,  8 Mar 2016 08:45:20 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <56DEC4B4.2000902@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288435>

Torsten B=F6gershausen venit, vidit, dixit 08.03.2016 13:25:
> On 03/08/2016 08:59 AM, Anders Kaseorg wrote:
>> The included test case, which uses rebase -p with non-ASCII commit
>> messages, was failing as follows:
>>
>>    Warning: the command isn't recognized in the following line:
>>     - Binary file (standard input) matches
>>
>>    You can fix this with 'git rebase --edit-todo'.
>>    Or you can abort the rebase with 'git rebase --abort'.
>>
>> Possibly related to recent GNU grep changes, as with commit
>> 316336379cf7937c2ecf122c7197cfe5da6b2061.  Avoid the issue by using =
sed
>> instead.
>>
>> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
>> ---
>>   git-rebase--interactive.sh        |  2 +-
>>   t/t3409-rebase-preserve-merges.sh | 21 +++++++++++++++++++++
>>   2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index c0cfe88..0efc65c 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -1241,7 +1241,7 @@ then
>>   			# be rebasing on top of it
>>   			git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$dropped"/=
$rev
>>   			sha1=3D$(git rev-list -1 $rev)
>> -			sane_grep -v "^[a-z][a-z]* $sha1" <"$todo" > "${todo}2" ; mv "${=
todo}2" "$todo"
>> +			sed "/^[a-z][a-z]* $sha1/d" <"$todo" > "${todo}2" ; mv "${todo}2=
" "$todo"
>>   			rm "$rewritten"/$rev
>>   		fi
>>   	done
>> diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-pres=
erve-merges.sh
>> index 8c251c5..1f01b29 100755
>> --- a/t/t3409-rebase-preserve-merges.sh
>> +++ b/t/t3409-rebase-preserve-merges.sh
>> @@ -119,4 +119,25 @@ test_expect_success 'rebase -p ignores merge.lo=
g config' '
>>   	)
>>   '
>>  =20
>> +test_expect_success 'rebase -p works with non-ASCII commit message'=
 '
>> +	(
>> +	mkdir non-ascii &&
> #The cd should be done in a subshell:
> (
>> +	cd non-ascii &&
>> +	git init &&
>> +	echo a > a &&
>> +	git add a &&
>> +	git commit -m a &&
>> +	echo b > b &&
> #Style: No space after ">" (and even above and below)

And also on the sane_grep/sed line.

>=20
> echo b >b
>=20
>=20
>> +	git add b &&
>> +	git commit -m b &&
>> +	git branch foo &&
>> +	git reset --hard HEAD^ &&
>> +	git cherry-pick -x foo &&
>> +	echo c > c &&
>> +	git add c &&
>> +	git commit -m "$(printf "I \\342\\231\\245 Unicode")" &&
>> +	git rebase -p foo
>> +	)
>> +
> #end of subshell
> )

The whole test is in a subshell already, although that is easy to miss
(missing indentation).

>> '
>> +
>>   test_done
>=20

It may be worth noting whether other occurrences of "sane_grep" are saf=
e
from binary input.

After all, one my question the degree of sanity of our sane_grep, or
whether we need asane_grep and bisane_grep in our shell library - "make
our grep sane again".

Michael
