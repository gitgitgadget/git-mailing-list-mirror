From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fixing path quoting issues
Date: Fri, 12 Oct 2007 08:43:29 +0200
Message-ID: <470F1791.9010601@viscovery.net>
References: <11920508172434-git-send-email-jon.delStrother@bestbefore.tv> <470DC05A.8020209@viscovery.net> <854pgytafi.fsf@lola.goethe.zz> <470DCC76.7070809@viscovery.net> <81156EED-7AC0-4C8B-98B1-8338262459A6@bestbefore.tv> <470DD3B8.1080809@viscovery.net> <85k5pts796.fsf@lola.goethe.zz> <63D5CE5B-51DD-4017-B2E2-2ADC5DCBE849@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 08:44:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgEFO-0004Xr-7q
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 08:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756978AbXJLGng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 02:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754968AbXJLGng
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 02:43:36 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:53582 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbXJLGnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 02:43:35 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IgEEz-0003yN-IN; Fri, 12 Oct 2007 08:43:21 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C02954E4; Fri, 12 Oct 2007 08:43:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <63D5CE5B-51DD-4017-B2E2-2ADC5DCBE849@steelskies.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60658>

Jonathan del Strother schrieb:
> 
> On 11 Oct 2007, at 21:53, David Kastrup wrote:
> 
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>
>>> Jonathan del Strother schrieb:
>>>> How are you going to test that git works on paths with spaces if the
>>>> test suite doesn't run there?
>>>
>>> By writing a specific test?
>>
>> This is going to be much less thorough.  And it does no harm if the
>> test scripts demonstrate defensive programming.
> 
> I would also point out that most tests have already been written to 
> handle this case - ones that don't quote their paths are in the minority.

Actually, reconsidering your proposed patch, there are only a handful of 
problematic cases, namely those where the test script is quoted with 
double-quotes, like this:

  test_expect_success 'load repository with strange names' "
-	svnadmin load -q $rawsvnrepo < ../t9115/funky-names.dump &&
+	svnadmin load -q '$rawsvnrepo' < ../t9115/funky-names.dump &&
  	start_httpd
  	"

The problem is that here $rawsvnrepo will be expanded before the entire test 
script is passed as argument to test_expect_success. Consider the case where 
$rawsvnrepo contains a single-quote (say, a directory named "Joe's git"): 
then the 'eval' inside test_expect_success sees a syntax error. The proper 
change is:

  test_expect_success 'load repository with strange names' "
-	svnadmin load -q $rawsvnrepo < ../t9115/funky-names.dump &&
+	svnadmin load -q \"\$rawsvnrepo\" < ../t9115/funky-names.dump &&
  	start_httpd
  	"

So, what I think you should do is:

1. Submit the change to git-rebase.sh in a separate patch.
2. Fix the patch for the double-quoted test scriptlets.

That should remove all my concerns.

-- Hannes
