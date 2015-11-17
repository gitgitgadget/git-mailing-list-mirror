From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v5 3/6] git-p4: retry kill/cleanup operations in tests with timeout
Date: Tue, 17 Nov 2015 09:22:03 +0100
Message-ID: <90549E9A-205A-4848-B794-23E44F325F1E@gmail.com>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com> <1447592920-89228-4-git-send-email-larsxschneider@gmail.com> <5649958F.2010407@diamand.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 09:22:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZybWo-0006mX-JX
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 09:22:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbbKQIWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 03:22:09 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35091 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbbKQIWH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2015 03:22:07 -0500
Received: by wmdw130 with SMTP id w130so143819988wmd.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 00:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qsczBnBH12TSptW+rLJ4mS957N4F+WPq/82AFHjwFas=;
        b=MmcaPHz1KePk5vFbc9KKggDvH7AE2xq8mCIfAiIT/QHAshSOHWKUjJrfws4/Yy6xrZ
         fhjux93jTsFm180WPIghvSVbSoDpALHoudm5m8WocQbhL2irN+BVUaCypvXuQ7nkdGiu
         t6uzaWsB2LQTXKlwWjAiM65dtcp9noUBji/s9ZWAnj/geUBVJs+oCZCDwbsRSN3HzAql
         INE12elJKWyJiorl90HRlc/r+wCAIE4KkKWc1oY3IZjdqvF0tIAApcJEuRRO1M6s7Djz
         fyHo+hLN3fwCZgbfX0je+TmzMwKsKqcGQEq+ZUslftxrvBQi0/K5O1MhkpWxZZNaKwZ6
         9mLw==
X-Received: by 10.194.120.226 with SMTP id lf2mr7707335wjb.108.1447748526363;
        Tue, 17 Nov 2015 00:22:06 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4D5B.dip0.t-ipconnect.de. [93.219.77.91])
        by smtp.gmail.com with ESMTPSA id bk2sm38656520wjc.3.2015.11.17.00.22.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Nov 2015 00:22:05 -0800 (PST)
In-Reply-To: <5649958F.2010407@diamand.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281386>


On 16 Nov 2015, at 09:36, Luke Diamand <luke@diamand.org> wrote:

> On 15/11/15 13:08, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> In rare cases kill/cleanup operations in tests fail. Retry these
>> operations with a timeout to make the test less flaky.
> 
> Should there be a sleep in that retry_until_success loop so that it doesn't spin sending signals to p4d?
Agreed. I will add a sleep in the next roll!


> 
> Do we need to worry about the time offset being updated (e.g. NTP) while this is running?
Interesting question! I would consider this an edge case but I can see how it could happen.
Do you see a way to handle that in an easy way?

Thanks,
Lars

> 
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>>  t/lib-git-p4.sh | 31 +++++++++++++++++++++++--------
>>  1 file changed, 23 insertions(+), 8 deletions(-)
>> 
>> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
>> index 7548225..8d6b48f 100644
>> --- a/t/lib-git-p4.sh
>> +++ b/t/lib-git-p4.sh
>> @@ -6,6 +6,10 @@
>>  # a subdirectory called "$git"
>>  TEST_NO_CREATE_REPO=NoThanks
>> 
>> +# Some operations require multiple attempts to be successful. Define
>> +# here the maximal retry timeout in seconds.
>> +RETRY_TIMEOUT=60
>> +
>>  . ./test-lib.sh
>> 
>>  if ! test_have_prereq PYTHON
>> @@ -121,22 +125,33 @@ p4_add_user() {
>>  	EOF
>>  }
>> 
>> +retry_until_success() {
>> +    timeout=$(($(date +%s) + $RETRY_TIMEOUT))
>> +    until "$@" 2>/dev/null || test $(date +%s) -gt $timeout
>> +    do :
> 
> sleep here?
> 
>> +    done
>> +}
>> +
>> +retry_until_fail() {
>> +    timeout=$(($(date +%s) + $RETRY_TIMEOUT))
>> +    until ! "$@" 2>/dev/null || test $(date +%s) -gt $timeout
>> +    do :
> 
> sleep here?
> 
>> +    done
>> +}
>> +
>>  kill_p4d() {
>>  	pid=$(cat "$pidfile")
>> -	# it had better exist for the first kill
>> -	kill $pid &&
>> -	for i in 1 2 3 4 5 ; do
>> -		kill $pid >/dev/null 2>&1 || break
>> -		sleep 1
>> -	done &&
>> +	retry_until_fail kill $pid
>> +	retry_until_fail kill -9 $pid
>>  	# complain if it would not die
>>  	test_must_fail kill $pid >/dev/null 2>&1 &&
>>  	rm -rf "$db" "$cli" "$pidfile"
>>  }
>> 
>>  cleanup_git() {
>> -	rm -rf "$git" &&
>> -	mkdir "$git"
>> +	retry_until_success rm -r "$git"
>> +	test_must_fail test -d "$git" &&
>> +	retry_until_success mkdir "$git"
>>  }
>> 
>>  marshal_dump() {
