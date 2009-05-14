From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: Re: Random failure after "git config core.autocrlf false" then	"git
 reset --hard"
Date: Thu, 14 May 2009 10:53:32 -0400
Message-ID: <4A0C306C.7000200@SierraAtlantic.com>
References: <4A0A34E3.9050801@SierraAtlantic.com> <20090514074925.GB8713@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu May 14 16:53:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4cJf-0004s9-HN
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 16:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbZENOxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 10:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbZENOxj
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 10:53:39 -0400
Received: from mail51.messagelabs.com ([216.82.241.99]:54182 "HELO
	mail51.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751788AbZENOxi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 10:53:38 -0400
X-VirusChecked: Checked
X-Env-Sender: Don.Slutz@SierraAtlantic.com
X-Msg-Ref: server-11.tower-51.messagelabs.com!1242312817!40089376!1
X-StarScan-Version: 6.0.0; banners=sierraatlantic.com,-,-
X-Originating-IP: [206.86.29.5]
Received: (qmail 19695 invoked from network); 14 May 2009 14:53:39 -0000
Received: from seng.sierraatl.com (HELO USFREEX1.us.corp.sa) (206.86.29.5)
  by server-11.tower-51.messagelabs.com with SMTP; 14 May 2009 14:53:39 -0000
Received: from usbosex1.us.corp.sa ([192.168.17.34]) by USFREEX1.us.corp.sa with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 14 May 2009 07:53:37 -0700
Received: from [127.0.0.1] ([208.37.241.146]) by usbosex1.us.corp.sa with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 14 May 2009 10:53:35 -0400
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090514074925.GB8713@hashpling.org>
X-OriginalArrivalTime: 14 May 2009 14:53:35.0808 (UTC) FILETIME=[C21B0C00:01C9D4A3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119200>

On 5/14/2009 3:49 AM, Charles Bailey wrote:

> On Tue, May 12, 2009 at 10:48:03PM -0400, Don Slutz wrote:
>   
>> This both works and fails with either file2 & subdir/file3 "modified" or  
>> just subdir/file3.  I have found that "git reset --hard" looks to be the  
>> issue.  If you have autocrlf=true, and a clean work tree and then set  
>> autocrlf=false; then
>> "git reset --hard" does not change the work tree files.  However  
>> sometimes (which so far I have only been able to reproduce with this  
>> test) git diff will report the difference.
>>     
>
> It shouldn't be random. git reset --hard should only reset those
> working tree files for which the appropriate index entry has been
> change or which have been change on disk since checkout from the
> index. Changing the core.autocrlf setting doesn't count as in index
> change (although perhaps it should??).
>
>   
I have tracked this down to racy-git fix.  See 
Documentation/technical/racy-git.txt
The "randomness" is all caused by git only full checks files that could 
be racy.  And it is all related to the fact that changing core.autocrlf 
is not correctly seen by git.  I have looked at the code and adding 
filter state of the file into the index looks to be a big amount of code 
change, and it is not clear that the change is need most of the time.

I have been thinking that adding a message to "git config" when the 
value of any of the filter values (autocrlf is one of these, but there 
are more) that warns about the fact that the working tree is not changed 
and that git will report a change to files if a full recheckout is not 
done.  None of the commands "git reset --hard", "git checkout -f", and 
"git checkout-index -u -a -f" will do this by default.  The only way I 
have found so far is to do "rm .git/index;git reset --hard".
> The point of git reset --hard in these tests was to throw away any
> uncommitted merge resolutions and/or conflicts, not about rechecking
> out everything. Admittedly the tests are probably a bit fast and loose
> and they should probably force a complete refresh from the index when
> the core.autocrlf setting is changed.
>
>   
That is how I have changed them for v2.
   -Don


__________________________________________________________________________________________________________________
DISCLAIMER:"The information contained in this message and the attachments (if any) may be privileged and confidential and protected from disclosure. You are hereby notified that any unauthorized use, dissemination, distribution or copying of this communication, review, retransmission, or taking of any action based upon this information, by persons or entities other than the intended recipient, is strictly prohibited. If you are not the intended recipient or an employee or agent responsible for delivering this message, and have received this communication in error, please notify us immediately by replying to the message and kindly delete the original message, attachments, if any, and all its copies from your computer system. Thank you for your cooperation." 
________________________________________________________________________________________________________________
