From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: [PATCH] t/test-lib.sh: minor readability improvements
Date: Fri, 29 Apr 2011 12:00:35 +0200
Message-ID: <4DBA8C43.4040804@debugon.org>
References: <4DB810E1.3080102@debugon.org> <7vmxjb8uyu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 12:02:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFkXD-0000OT-Ik
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 12:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627Ab1D2KCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 06:02:46 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:62928 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab1D2KCp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 06:02:45 -0400
Received: from [192.168.2.102] (dslb-088-071-229-195.pools.arcor-ip.net [88.71.229.195])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0Lio0b-1PfZs00Iof-00dL2V; Fri, 29 Apr 2011 12:00:37 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <7vmxjb8uyu.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:IYvgwvuSiIv0X+KnHNitxzy8Nsbwix0vlFIKD732PL4
 xBWHTLso91cByk+5198tcSsRCLAbvHQF3KsoZpHppUq0dNs70s
 8MgQgz5P6nMRmoYMEpYLqFlz4vD4xrZfgDEFyiOcSP96dZR4pH
 KN4o9hwz1KV6zvGlcQYq+crrgiKbfTarUrgLdSH/zZB8JX9Ccd
 KeuR49PXBSmHrUSzkjpgtjTzKU4oTqu6px6ELTsAp8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172445>

On 04/27/2011 07:28 PM, Junio C Hamano wrote:
> Mathias Lafeldt <misfire@debugon.org> writes:
> 
>> Tweak/apply parameter expansion. Also use here document to save
>> test results instead of appending each line with ">>".
> 
> Thanks.  A few minor nits.
> 
>> Signed-off-by: Mathias Lafeldt <misfire@debugon.org>
>> ---
>>  t/test-lib.sh |   18 ++++++++++--------
>>  1 files changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index abc47f3..b30725f 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -24,7 +24,7 @@ done,*)
>>  *' --tee '*|*' --va'*)
>>  	mkdir -p test-results
>>  	BASE=test-results/$(basename "$0" .sh)
>> -	(GIT_TEST_TEE_STARTED=done ${SHELL-sh} "$0" "$@" 2>&1;
>> +	(GIT_TEST_TEE_STARTED=done ${SHELL-"sh"} "$0" "$@" 2>&1;
> 
> Looks unnecessary.  Superstition?

IMHO, ${SHELL-sh} is kind of hard to read, especially when you
don't know about the ${parameter-word} format. In hindsight, I
understand that the change isn't really necessary.
 
>>  	 echo $? > $BASE.exit) | tee $BASE.out
>>  	test "$(cat $BASE.exit)" = 0
>>  	exit
>> @@ -575,7 +575,7 @@ test_external () {
>>  test_external_without_stderr () {
>>  	# The temporary file has no (and must have no) security
>>  	# implications.
>> -	tmp="$TMPDIR"; if [ -z "$tmp" ]; then tmp=/tmp; fi
>> +	tmp=${TMPDIR:-"/tmp"}

I guess, you'd prefer ${TMPDIR:-/tmp} here too.

>>  	stderr="$tmp/git-external-stderr.$$.tmp"
>>  	test_external "$@" 4> "$stderr"
>>  	[ -f "$stderr" ] || error "Internal error: $stderr disappeared."
>> @@ -801,12 +801,14 @@ test_done () {
>>  		mkdir -p "$test_results_dir"
>>  		test_results_path="$test_results_dir/${0%.sh}-$$.counts"
>>  
>> -		echo "total $test_count" >> $test_results_path
>> -		echo "success $test_success" >> $test_results_path
>> -		echo "fixed $test_fixed" >> $test_results_path
>> -		echo "broken $test_broken" >> $test_results_path
>> -		echo "failed $test_failure" >> $test_results_path
>> -		echo "" >> $test_results_path
>> +		cat >> "$test_results_path" <<EOF
>> +total $test_count
>> +success $test_success
>> +fixed $test_fixed
>> +broken $test_broken
>> +failed $test_failure
>> +
>> +EOF
> 
> It may probably be even easier to read if you indented the whole thing,
> using the dash before the here-doc marker, like so:
> 
> 	cat >>"$test_results_path" <<-EOF
> 	total $test_count
>         success $test_success
>         ...
>         EOF

OK, I'll be re-rolling the patch using "<<-EOF".

-Mathias
