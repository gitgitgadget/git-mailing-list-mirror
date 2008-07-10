From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] apply: fix copy/rename breakage
Date: Thu, 10 Jul 2008 17:22:01 +0200
Message-ID: <48762919.6070902@viscovery.net>
References: <7vy74aqvr1.fsf@gitster.siamese.dyndns.org> <20080710140154.GN26957@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 17:23:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGxzB-0000QI-N0
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 17:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770AbYGJPWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 11:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753320AbYGJPWK
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 11:22:10 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:36141 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463AbYGJPWK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 11:22:10 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KGxy6-0005C7-Q8; Thu, 10 Jul 2008 17:22:03 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 78E296D9; Thu, 10 Jul 2008 17:22:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080710140154.GN26957@redhat.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87980>

Don Zickus schrieb:
> On Wed, Jul 09, 2008 at 08:10:58PM -0700, Junio C Hamano wrote:
>> However, this "incremental" mode of patch application contradicts with the
>> way git rename/copy patches are fundamentally designed.  When a git patch
>> talks about a file A getting modified, and a new file B created out of B,
>> like this:
>>
>> 	diff --git a/A b/A
>> 	--- a/A
>> 	+++ b/A
>> 	... change text X here ...
>> 	diff --git a/A b/B
>> 	copy from A
>> 	copy to B
>> 	--- a/A
>> 	+++ b/B
>> 	... change text Y here ...
>>
>> the second change to produce B does not depend on what is done to A with
>> the first change (this is explicitly done so for reviewability of
>> individual patches).
>>
>> With this patch, we disable the postimage record 'fn_table' when applying
>> a patch to produce new files out of existing file by copying to fix this
>> issue.
> 
> Odd.  I guess the way I read this workflow is
> 
> apply change X to A, copy A' to B, apply change Y to B => B' now has changes X+Y
> 
> But instead you are saying B' only has change Y because A is copied to B
> not A'.
> 
> Regardless, it doesn't affect my workflow.

Oh, it does. It's a normal git diff where a copy was detected!

Don't let you distract by the word "incremental" and by the names A and B.
In the example above, the change X comes first because 'A' is sorted
before 'B'. If the roles of A and B were swapped, then you have this patch:

 	diff --git a/A b/A
 	copy from B
 	copy to A
 	--- a/A
 	+++ b/A
 	... change text Y here ...
 	diff --git a/A b/B
 	--- a/A
 	+++ b/B
 	... change text X here ...

See?

-- Hannes
