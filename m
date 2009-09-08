From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Improving merge failure message
Date: Tue, 08 Sep 2009 10:24:02 +0200
Message-ID: <4AA614A2.2060908@viscovery.net>
References: <20090908153101.6117@nanako3.lavabit.com> <7vbplmhr0i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 10:25:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mkw0n-0001un-N8
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 10:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbZIHIZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 04:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbZIHIZA
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 04:25:00 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:2718 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbZIHIY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 04:24:59 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mkvzh-0001Ql-4c; Tue, 08 Sep 2009 10:24:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 978D69F88; Tue,  8 Sep 2009 10:24:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7vbplmhr0i.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127990>

Junio C Hamano schrieb:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
> 
>> [2]% git merge feature
>> error: Entry 'cool' not uptodate. Cannot merge.
>> fatal: merging of trees 8ec1d96451ff05451720e4e8968812c46b35e5e4 and aad8d5cef3915ab78b3227abaaac99b62db9eb54 failed
>>
>> ... the messages look unnecessarily scary, with two
>> "error" and "fatal" comments, and long sha1 commit names.
> 
>> It would be nice if the message in the latter case can be toned down.
> 
> Yeah, it would be nice.  This actually was something that bothered me as
> well while trying to explain the recovery procedure for these two cases.
> Give me half an hour or so to cook up something...

I think that this is a symptom of a much more involved issue about error
handling.

Currently, it is customary in the code to report an error at each location
where an exceptional condition is detected:

	if (frotz())
		ret = error("frotz messed up");

If frotz() is a "low-level" routine, like a C library function, then this
is the right thing to do. However, if frotz() is our own function
("high-level") which itself calls low-level functions with the same
pattern, then this is obviously the wrong thing to do, because it results
into two error messages.

We need a guideline how errors are reported. This guideline could be:

(1) Low-level functions do not print error messages, but set an error code
and leave the reporting to the caller.

(2) High-level functions must print an error message (through error() or
die()) when they detect a failure of a low-level function that was called
directly.

(3) High-level functions must not print an error message when they detect
a failure of another high-level function that was called directly.

There remains to classify our functions into high-level or low-level. But
I think we won't have a lot of low-level functions.

BTW, I applied this guideline when I worked on {start,finish,run}_command
recently, and IMHO it worked out quite nicely because exactly one error is
reported after a failure.

-- Hannes
