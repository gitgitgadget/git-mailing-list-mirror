From: Kyle McKay <mackyle@gmail.com>
Subject: Re: [PATCH 0/2] allow git-svn fetching to work using serf
Date: Sat, 6 Jul 2013 19:46:38 -0700
Message-ID: <FBCA37F9-4988-4773-8D8D-9CB041C35289@gmail.com>
References: <CB53C901-3643-46AE-AA80-CED5E20AC3B7@gmail.com> <51D7C47D.5070700@acm.org> <20130707002804.GF30132@google.com> <1D11122F-5C75-4FAC-80EA-D5DC65902403@gmail.com> <20130707013747.GM30132@google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: David Rothenberger <daveroth@acm.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 04:46:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvezw-0007QH-13
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 04:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400Ab3GGCqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 22:46:44 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:43394 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab3GGCqn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 22:46:43 -0400
Received: by mail-pa0-f45.google.com with SMTP id bi5so3272709pad.4
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 19:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer;
        bh=ydxapqaEwmiRX2LJl/UEo9tBJ4DaiAFgnZDSuIK3Tgo=;
        b=VaXrjyvoHdNedWAD+i8rpPS/8LrJf0Y2G5eZiL8zpbrybos7kp04YEaUEUHZwkC5c9
         dK4HgBfTS7DWfsyKx8FSBPTPloDuRqL9yp0BM8yL0+t3xLNgqanLs9KSxPHaN+FQni20
         mb9KZC4wo4mj/4rFs27Mft4XzTRmSniiRYB2q9xRxAEQGapuPDBQ+9dxTm228oz6mHu0
         MY54rsqbyPlCN6136Jqu96PkCcM+/mQQkHF/q84yDVIN54LioAAKQ0NGh3QuK5bsctIg
         OjQ5sPIOWEQrtffvEDSZI6QsnqtXib+9pnEeiusyjx/OeCNwSMka6Y/SDSStkmG/Sstc
         k3Zg==
X-Received: by 10.66.120.136 with SMTP id lc8mr346053pab.182.1373165202794;
        Sat, 06 Jul 2013 19:46:42 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id we2sm16119099pab.0.2013.07.06.19.46.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 19:46:42 -0700 (PDT)
In-Reply-To: <20130707013747.GM30132@google.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229718>

On Jul 6, 2013, at 18:37, Jonathan Nieder wrote:
> Kyle McKay wrote:
>> On Jul 6, 2013, at 17:28, Jonathan Nieder wrote:
>>> David Rothenberger wrote:
>>>> On 7/5/2013 8:41 PM, Kyle McKay wrote:
>
>>>>> Daniel Shahaf has suggested also setting
>>>>> "servers:global:http-bulk-updates=on".
>>>>
>>>> I have a patch that does this, but since turning on bulk updates  
>>>> has
>>>> a possible performance penalty, I prefer your approach.
>>>
>>> I assume that's because http-bulk-updates defeats caching.  If so,
>>> makes sense.
>>>
>>> Please forgive my ignorance: is there a bug filed about ra_serf's
>>> misbehavior here?  Is it eventually going to be fixed and this is
>>> just a workaround, or is the growth in temp file use something we'd
>>> live with permanently?
> [...]
>>
>> Begin forwarded message:
> [...]
>>> [2] http://subversion.tigris.org/issues/show_bug.cgi?id=2932
>
> Ah, thanks for the context.
>
> It's still not clear to me how we know that ra_serf driving the editor
> in a non depth-first manner is the problem here.  Has that explanation
> been confirmed somehow?
>
> For example, does the workaround mentioned by danielsh work?  Does
> using ra_neon instead of ra_serf avoid trouble as well?  Is there a
> simple explanation of why violating the depth-first constraint would
> lead to multiple blob (i.e., file, not directory) deltas being opened
> in a row without an intervening close?

Using ra_neon seams to eliminate the problem. Using ra_neon has always  
been the default until svn 1.8 which drops ra_neon support entirely  
and always uses ra_serf for https?: urls.

The workaround mentioned by danielsh won't work if the server has  
configured SVNAllowBulkUpdates Off because that will force use of  
skelta mode no matter what the client does.  However, since ra_neon  
only ever has a single connection to the server it probably doesn't  
matter.

Since ra_serf makes multiple connections to the server (hard-coded to  
4 prior to svn 1.8, defaults to 4 in svn 1.8 but can be set to between  
1 and 8) it makes sense there would be multiple active calls to  
apply_textdelta if processing is done as results are received on the  
multiple connections.

Kyle
