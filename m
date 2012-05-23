From: Phil Hord <hordp@cisco.com>
Subject: Re: Cherry-pick dangles and forgets helpful advice in next
Date: Wed, 23 May 2012 19:12:02 -0400
Message-ID: <4FBD6EC2.3000804@cisco.com>
References: <4FBD4904.9090000@cisco.com> <7vipfmzfel.fsf@alter.siamese.dyndns.org> <7vehqazf9d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 24 01:22:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXKsq-0001hX-6y
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 01:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779Ab2EWXWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 19:22:12 -0400
Received: from bgl-iport-1.cisco.com ([72.163.197.25]:9488 "EHLO
	bgl-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab2EWXWK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 19:22:10 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 May 2012 19:22:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2043; q=dns/txt;
  s=iport; t=1337815330; x=1339024930;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=O19u7+d3SWHSwWAk5loLnRBmmw7FMAAsiA6ERkv9Qn0=;
  b=VF2237Vfp88QXLXFifmpnh3rtbBBNM2WdJfRsKcVlMTA6oQWmzVnKRAh
   Z8SI697Nph8T1mTD7WMkFnLt4mTv9AlRqApX15vIZ4LvWm7vxJpKSOcVt
   Ucl0ZAG+6NjHuFiO46vib9jGg/7jiUWPg5w2u2Ov3yQGDetKZitW81wS8
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ap4EAKdtvU9Io8UY/2dsb2JhbABDtTSCFQEBAQQSAWUBEAsUBAkWDwkDAgECAUUGDQEFAgEBHodrmzCfcIp9hSADlRiFT4g9gWSDBg
X-IronPort-AV: E=Sophos;i="4.75,647,1330905600"; 
   d="scan'208";a="12864887"
Received: from vla196-nat.cisco.com (HELO bgl-core-2.cisco.com) ([72.163.197.24])
  by bgl-iport-1.cisco.com with ESMTP; 23 May 2012 23:12:04 +0000
Received: from [64.100.104.83] (dhcp-64-100-104-83.cisco.com [64.100.104.83])
	by bgl-core-2.cisco.com (8.14.3/8.14.3) with ESMTP id q4NNC1Z6010299;
	Wed, 23 May 2012 23:12:02 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <7vehqazf9d.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.1
X-TagToolbar-Keys: D20120523191202339
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198335>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Phil Hord <hordp@cisco.com> writes:
>>
>>> In git.git 'master' when I cherry-pick a commit which is eventually
>>> empty, git gives me a friendly description of my supposed error, leaves
>>> my cherry-pick "pending" and exits with an error code.
>>>
>>>
>>> $ git cherry-pick a0aff2d                          
>>> # On branch master
>>> nothing to commit (working directory clean)
>>> The previous cherry-pick is now empty, possibly due to conflict resolution.
>>> If you wish to commit it anyway, use:
>>>
>>>     git commit --allow-empty
>>>
>>> Otherwise, please use 'git reset'
>>>
>>> In 'next' this is broken.  Now git does not tell me anything and it does
>>> not exit with an error code.
>> ...  The test
>> t3505.2 is about failing an attempt to cherry-pick an empty commit:
> Ahh, disregard that one.  It is not testing the case where a cherry-pick
> results in empty.
>

Yes, but the last one checks for something similar.  However, I tried
this and it does not trigger the same failure.

$ git cherry-pick HEAD^                              
# On branch master
nothing to commit (working directory clean)
The previous cherry-pick is now empty, possibly due to conflict resolution.
If you wish to commit it anyway, use:

    git commit --allow-empty

Otherwise, please use 'git reset'



So I think I need to be more specific about the error condition I am seeing.

mkdir repo && cd repo && git init &&
touch foo && git add foo && git commit -mfoo &&
echo foo > foo && git add foo && git commit -mnewfoo && git branch newfoo &&
git commit --amend -m"new foo" &&
git cherry-pick newfoo

This sequence fails to report an error as of this commit:

commit b27cfb0d8d4cbb6d079c70ffeadac9c0dcfff250
Author: Neil Horman <nhorman@tuxdriver.com>
Date:   Fri Apr 20 10:36:15 2012 -0400

    git-cherry-pick: Add keep-redundant-commits option

But it does report the problem and 'exit 1' prior to that.

Phil
