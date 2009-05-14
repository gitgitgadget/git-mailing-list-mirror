From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: Re: [PATCH 3/6] Fix tests to work with core.autocrlf=true
Date: Thu, 14 May 2009 09:49:52 -0400
Message-ID: <4A0C2180.6030000@SierraAtlantic.com>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com> <1242070141-2936-2-git-send-email-Don.Slutz@SierraAtlantic.com> <1242070141-2936-3-git-send-email-Don.Slutz@SierraAtlantic.com> <1242070141-2936-4-git-send-email-Don.Slutz@SierraAtlantic.com> <20090511222011.GA7609@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu May 14 15:50:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4bKG-0000fb-30
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 15:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbZENNuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 09:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbZENNuL
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 09:50:11 -0400
Received: from mail37.messagelabs.com ([216.82.241.83]:14939 "HELO
	mail37.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752412AbZENNuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 09:50:09 -0400
X-VirusChecked: Checked
X-Env-Sender: Don.Slutz@SierraAtlantic.com
X-Msg-Ref: server-14.tower-37.messagelabs.com!1242309007!20163194!1
X-StarScan-Version: 6.0.0; banners=sierraatlantic.com,-,-
X-Originating-IP: [206.86.29.5]
Received: (qmail 6384 invoked from network); 14 May 2009 13:50:10 -0000
Received: from seng.sierraatl.com (HELO USFREEX1.us.corp.sa) (206.86.29.5)
  by server-14.tower-37.messagelabs.com with SMTP; 14 May 2009 13:50:10 -0000
Received: from usbosex1.us.corp.sa ([192.168.17.34]) by USFREEX1.us.corp.sa with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 14 May 2009 06:50:06 -0700
Received: from [127.0.0.1] ([208.37.241.146]) by usbosex1.us.corp.sa with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 14 May 2009 09:50:05 -0400
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090511222011.GA7609@hashpling.org>
X-OriginalArrivalTime: 14 May 2009 13:50:05.0583 (UTC) FILETIME=[E308D9F0:01C9D49A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119192>

On 5/11/2009 6:20 PM, Charles Bailey wrote:
> On Mon, May 11, 2009 at 03:28:58PM -0400, Don Slutz wrote:
>   
>> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
>> index e768c3e..bf39e45 100755
>> --- a/t/t7610-mergetool.sh
>> +++ b/t/t7610-mergetool.sh
>> @@ -45,9 +45,9 @@ test_expect_success 'custom mergetool' '
>>      ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
>>      ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
>>      ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
>> -    test "$(cat file1)" = "master updated" &&
>> -    test "$(cat file2)" = "master new" &&
>> -    test "$(cat subdir/file3)" = "master new sub" &&
>> +    test_cat_eq file1 "master updated" &&
>> +    test_cat_eq file2 "master new" &&
>> +    test_cat_eq subdir/file3 "master new sub" &&
>>      git commit -m "branch1 resolved with mergetool"
>>  '
>>     
>
> This change concerns me. At the moment, the mergetool test assumes
> that globally autocrlf is true and has further tests that attempt to
> verify its behaviour with autocrlf set to true.
Assuming that should have been false and then true for the setting of 
autocrlf.  I would say that
this code does not fully check for autocrlf=false.  For version 1 of the 
patch I did not look for
other tests that dis not include crlf in their name that had tests for 
changing autocrlf.
>  See the very next
> test:
>
> test_expect_success 'mergetool crlf' '
>     git config core.autocrlf true &&
>     git checkout -b test2 branch1
>     test_must_fail git merge master >/dev/null 2>&1 &&
>     ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
>     ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
>     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
>     test "$(printf x | cat file1 -)" = "$(printf "master updated\r\nx")" &&
>     test "$(printf x | cat file2 -)" = "$(printf "master new\r\nx")" &&
>     test "$(printf x | cat subdir/file3 -)" = "$(printf "master new sub\r\nx")" &&
>     git commit -m "branch1 resolved with mergetool - autocrlf" &&
>     git config core.autocrlf false &&
>     git reset --hard
> '
>
> Does the resetting of core.autocrlf to false not break the subsequent
> tests?
>
>   
It does cause the subsequent tests to not be tested in autocrlf=true.  
However I have verified that the sequence:

git config core.autocrlf false && git reset --hard

Does not do what you might expect.  A "touch file1" can cause "git diff" 
to start reporting a difference!

Patch set v2 out soon.
   -Don



__________________________________________________________________________________________________________________
DISCLAIMER:"The information contained in this message and the attachments (if any) may be privileged and confidential and protected from disclosure. You are hereby notified that any unauthorized use, dissemination, distribution or copying of this communication, review, retransmission, or taking of any action based upon this information, by persons or entities other than the intended recipient, is strictly prohibited. If you are not the intended recipient or an employee or agent responsible for delivering this message, and have received this communication in error, please notify us immediately by replying to the message and kindly delete the original message, attachments, if any, and all its copies from your computer system. Thank you for your cooperation." 
________________________________________________________________________________________________________________
