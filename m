From: David Reiss <dreiss@facebook.com>
Subject: Re: [SQUASHED PATCH] Add support for GIT_CEILING_DIRECTORIES
Date: Fri, 16 May 2008 10:43:18 -0700
Message-ID: <482DC7B6.1080406@facebook.com>
References: <482C85C8.90804@facebook.com> <alpine.DEB.1.00.0805151958180.30431@racer> <alpine.DEB.1.00.0805152055280.30431@racer> <482CA693.3060602@facebook.com> <alpine.DEB.1.00.0805152327440.30431@racer> <482CBCF2.6030202@facebook.com> <alpine.DEB.1.00.0805160012310.30431@racer> <482D2F9D.4080809@viscovery.net> <alpine.DEB.1.00.0805161118160.30431@racer> <482D66DC.30602@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 16 19:47:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx41H-0001WV-Ld
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 19:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429AbYEPRqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 13:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755356AbYEPRqE
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 13:46:04 -0400
Received: from fw-sf2p.facebook.com ([204.15.23.140]:42928 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783AbYEPRqD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 13:46:03 -0400
Received: from sf2pmxf02.TheFacebook.com (sf2pmxf02.thefacebook.com [192.168.16.13])
	by pp01.sf2p.tfbnw.net (8.14.1/8.14.1) with ESMTP id m4GHigAp014834;
	Fri, 16 May 2008 10:44:42 -0700
Received: from [192.168.98.131] ([10.8.254.247]) by sf2pmxf02.TheFacebook.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 May 2008 10:41:48 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <482D66DC.30602@viscovery.net>
X-OriginalArrivalTime: 16 May 2008 17:41:48.0279 (UTC) FILETIME=[1DBCA870:01C8B77C]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7160:2.4.4,1.2.40,4.0.166 definitions=2008-05-16_02:2008-05-14,2008-05-16,2008-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0805090000 definitions=main-0805160134
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82311>

Sorry I missed this before.  As you said, in Johannes's version the
ceiling directories are the last directories we look in, whereas in my
implementation, they are the first directories we do not look in.  I
made this choice because it makes more sense for me to set my ceiling to
"/home", rather than "/home/dreiss", so it will work even if I am in
another user's homedir.

There is also a difference in how they handle the case where the cwd is
a ceiling directory, but I think it is worth sorting out the first issue
first.

--David


Johannes Sixt wrote:
> Johannes Schindelin schrieb:
>> Hi,
>>
>> On Fri, 16 May 2008, Johannes Sixt wrote:
>>
>>> Johannes Schindelin schrieb:
>>>> +'GIT_CEILING_DIRECTORIES'::
>>>> +   If set (to a colon delimited list of absolute directories), Git
>>>> +   will refuse to look for the .git/ directory further when hitting
>>>> +   one of those directories (otherwise it would traverse the parent
>>>> +   directories until hitting the root directory).
>>> Hmm.
>>>
>>> Looking at the current implementation, this should be written as:
>>>
>>>      If set to a colon delimited list of absolute directories,
>>>      and the current directory is in or below one of them, then
>>>      these are the top-most directories in which Git will look for
>>>      a .git/ directory (otherwise it would traverse the parent
>>>      directories until hitting the root directory).
>>
>> According to the test case
>>
>>         GIT_CEILING_DIRECTORIES="$CWD/X:$CWD/subdir" &&
>>         export GIT_CEILING_DIRECTORIES &&
>>         (cd subdir && test_must_fail git rev-parse --git-dir)
>>
>> this is not the case.  If you have something like /bla/subdir and you are
>> in /bla/subdir, it will not look for .git/.
> 
> No, the test just shows that it does not *find* a subdir/.git/, but it
> does not show that it doesn't even *look* for it.
> 
> Let's first clarify the semantics of GIT_CEILING_DIRECTORIES before we
> start fixing something: Can a directory that is named in
> GIT_CEILING_DIRECTORIES be a git repository or not?
> 
> David's original motivation was that it cannot; in your implementation
> it can.
> 
> -- Hannes
> 
