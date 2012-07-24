From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH] t3300-*.sh: Fix a TAP parse error
Date: Tue, 24 Jul 2012 19:34:18 +0100
Message-ID: <500EEAAA.8030604@ramsay1.demon.co.uk>
References: <500AEB11.4050006@ramsay1.demon.co.uk> <20120721182049.GL19860@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 21:21:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StkfT-0004EX-EG
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 21:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015Ab2GXTVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 15:21:09 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:43038 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755830Ab2GXTVI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 15:21:08 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 03700400259;
	Tue, 24 Jul 2012 20:13:58 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])	by mdfmta010.tch.inty.net (Postfix) with ESMTP id CE649400253;	Tue, 24 Jul 2012 20:13:56 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tch.inty.net (Postfix) with ESMTP;	Tue, 24 Jul 2012 20:13:55 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120721182049.GL19860@burratino>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202057>

Jonathan Nieder wrote:
>> Needless to say, I much prefer the patch below. :-D
> 
> Thanks for a nice explanation.  In general I definitely like getting
> rid of these setup tests when possible.  Let's see:
> 
> [...]
>> --- a/t/t3300-funny-names.sh
>> +++ b/t/t3300-funny-names.sh
>> @@ -15,28 +15,20 @@ p0='no-funny'
>>  p1='tabs	," (dq) and spaces'
>>  p2='just space'
>>  
>> -test_expect_success 'setup' '
>> -	cat >"$p0" <<-\EOF &&
>> -	1. A quick brown fox jumps over the lazy cat, oops dog.
>> -	2. A quick brown fox jumps over the lazy cat, oops dog.
>> -	3. A quick brown fox jumps over the lazy cat, oops dog.
>> -	EOF
>> +cat >"$p0" <<\EOF
>> +1. A quick brown fox jumps over the lazy cat, oops dog.
>> +2. A quick brown fox jumps over the lazy cat, oops dog.
>> +3. A quick brown fox jumps over the lazy cat, oops dog.
>> +EOF
> 
> The problem is that on platforms not supporting funny filenames, it
> will write a complaint to stderr and because the code is not guarded
> by test_expect_success, that output goes to the terminal.  So I think
> this is a wrong approach.

Huh? Which platforms are we talking about?

The only problematic platforms I test on are "NTFS/bash" on cygwin and MinGW.
Since commit 2b843732 ("Suppress some bash redirection error messages",
26-08-2008), I have not noticed any complaints regarding this problem.
What have I missed?

Assuming we are not talking about errors like ENOSPC, EROFS etc., then the
only command which would issue a complaint to stderr would be the line
following the above snippet, thus:

    +cat 2>/dev/null >"$p1" "$p0"

(note the stderr redirection). This does not output an error to the terminal
when using bash (I think I also tested with dash). However, this does rely
on the shell performing the redirections in the order, left to right, on the
command line. [I had intended to check with POSIX to see if this order was
mandated or not, but didn't get around to it ...]

Have you found a shell were this does not work?

> Would it make sense to avoid the "# SKIP" comment when a test has
> been run, like this?
> 
> diff --git i/t/test-lib.sh w/t/test-lib.sh
> index acda33d1..038f6e9f 100644
> --- i/t/test-lib.sh
> +++ w/t/test-lib.sh
> @@ -354,6 +354,11 @@ test_done () {
>  	case "$test_failure" in
>  	0)
>  		# Maybe print SKIP message
> +		if test -n "$skip_all" && test "$test_count" != 0
> +		then
> +			say "# SKIP $skill_all"
> +			skip_all=
> +		fi
>  		[ -z "$skip_all" ] || skip_all=" # SKIP $skip_all"
>  
>  		if test $test_external_has_tap -eq 0; then

No, I don't think this would be a good direction to go in. This may
not be a good idea either, but if you wanted to add a check here, then
maybe something like this (totally untested):

diff --git a/t/test-lib.sh b/t/test-lib.sh
index acda33d..53a2422 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -354,6 +354,9 @@ test_done () {
 	case "$test_failure" in
 	0)
 		# Maybe print SKIP message
+		if test -n "$skip_all" && test $test_count -gt 0; then
+			error "Can't use skip_all after running some tests"
+		fi
 		[ -z "$skip_all" ] || skip_all=" # SKIP $skip_all"
 
 		if test $test_external_has_tap -eq 0; then

Dunno! :-D

I will be sending a v2 patch soon.

ATB,
Ramsay Jones
