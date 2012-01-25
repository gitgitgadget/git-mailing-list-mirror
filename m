From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH 2/5] t0061: Add tests
Date: Wed, 25 Jan 2012 07:47:37 +0100
Message-ID: <op.v8mntno90aolir@keputer>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-3-git-send-email-fransklaver@gmail.com>
 <20120124225636.GF8222@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j6t@kdbg.org>
To: "Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 07:48:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpweO-0001Sj-In
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 07:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123Ab2AYGrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 01:47:42 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61686 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab2AYGrm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 01:47:42 -0500
Received: by eaac13 with SMTP id c13so1435606eaa.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 22:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=WqLwb2CKvlgFV+2BvEGRyQp7yP4fVRv1Uhnr9Q0YlAQ=;
        b=oYVGk4dh/3FhD+Htn6VzW1194FaptqfSkeNAIIUK4aTaoWEH7YJTrNpse/jeRtvSRv
         5dw0BTfyU2UuWwhLV9HZicwkp7sLli1dvyyHPLwtXuMn1cvPpV2RIQZ2j+NSGncas9Yk
         2xrco2C/eudS9qHT06oJl7X4OqJtMHbjZS7Ig=
Received: by 10.213.34.83 with SMTP id k19mr179373ebd.98.1327474060667;
        Tue, 24 Jan 2012 22:47:40 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id c16sm77677440eei.1.2012.01.24.22.47.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jan 2012 22:47:39 -0800 (PST)
In-Reply-To: <20120124225636.GF8222@burratino>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189098>

On Tue, 24 Jan 2012 23:56:36 +0100, Jonathan Nieder <jrnieder@gmail.com>  
wrote:

>> +>empty
>> +
>> +cat >incorrect-interpreter-script <<-EOF
>> +#!someinterpreter
>> +cat hello-script
>> +EOF
>> +>empty
>
> What is the point of repreatedly writing an empty file named "empty"?

There isn't. I copied it along with the hello-script lines and didn't pay  
it much heed. I'll remove the excessive '>empty's.


> I think this would be easier to read and maintain if scripts not
> shared between multiple tests were written in the body of the relevant
> tests.  For example, that way it is easier to remember to remove a
> helper script if the relevant test assertion changes to no longer need
> it.

Makes sense. I'll reorder.


>
> [...]
>> @@ -26,7 +44,7 @@ test_expect_success 'run_command can run a command' '
>>  	test_cmp empty err
>>  '
>>
>>  test_expect_success POSIXPERM 'run_command reports EACCES' '
>>  	cat hello-script >hello.sh &&
>>  	chmod -x hello.sh &&
>>  	test_must_fail test-run-command run-command ./hello.sh 2>err &&
> [...]
>> +test_expect_success POSIXPERM 'run_command reports EACCES, search path  
>> perms' '
>> +	mkdir -p inaccessible &&
>> +	PATH=$(pwd)/inaccessible:$PATH &&
>> +	export PATH &&
>> +
>> +	cat hello-script >inaccessible/hello.sh &&
>> +	chmod 400 inaccessible &&
>> +	test_must_fail test-run-command run-command hello.sh 2>err &&
>> +	chmod 755 inaccessible &&
>> +
>> +	grep "fatal: cannot exec.*hello.sh" err
>> +'
>
> (*) These tests would be easier to understand if squashed with the
> relevant later patch in the series that changes the error message.

You mean "Elaborate execvp error checking"?


> Maybe they could be less repetitive that way, too.
>
> 	test_expect_success POSIXPERM 'diagnose command in inaccessible part of  
> $PATH' '
> 		mkdir -p subdir &&
> 		cat hello-script >subdir/hello.sh &&
> 		chmod +x subdir/hello.sh &&
> 		chmod -x subdir &&
> 		(
> 			PATH=$(pwd)/inaccessible:$PATH &&
> 			test_must_fail test-run-command run-command hello.sh 2>err
> 		) &&
> 		test_i18ngrep ...
> 	'
>
> [...]
>> +test_expect_success POSIXPERM 'run_command reports EACCES, interpreter  
>> fails' '
>> +	cat incorrect-interpreter-script >hello.sh &&
>> +	chmod +x hello.sh &&
>> +	chmod -x someinterpreter &&
>> +	test_must_fail test-run-command run-command ./hello.sh 2>err &&
>> +
>> +	grep "fatal: cannot exec.*hello.sh" err
>> +'
>
> Is this the common case?  Why would my interpreter be in the designated
> spot but not marked executable?  Is there some other motivating
> example?  (I'm genuinely curious; it's ok if the answer is "no".)

I wouldn't think so. This particular one is addressing a concern raised by  
Johannes Sixt in reaction to a patch from Junio.

http://article.gmane.org/gmane.comp.version-control.git/171848


>
> [...]
>> +
>> +test_expect_failure POSIXPERM 'run_command reports ENOENT,  
>> interpreter' '
>> +	cat non-existing-interpreter >hello.sh &&
>> +	chmod +x hello.sh &&
>> +	test_must_fail test-run-command start-command-ENOENT ./hello.sh 2>err  
>> &&
>> +
>> +	grep "error: cannot exec.*hello.sh" err
>> +'
>
> Maybe:
>
> 	test_expect_success POSIXPERM 'diagnose missing interpreter' '
> 		echo "#!/nonexistent/interpreter" >hello.sh &&
> 		chmod +x hello.sh &&
> 		test_must_fail test-run-command run-command hello.sh 2>err &&
> 		test_i18ngrep ...
> 	'

Will check.


> Hope that helps,
> Jonathan
