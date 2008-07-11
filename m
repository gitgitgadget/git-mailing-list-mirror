From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix backwards-incompatible handling of
 core.sharedRepository
Date: Thu, 10 Jul 2008 22:34:57 -0700
Message-ID: <7vr6a1kmpq.fsf@gitster.siamese.dyndns.org>
References: <20080710231853.21448.18643.stgit@rover.dkm.cz>
 <7vr6a1mhqi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jul 11 07:36:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHBIn-0005rX-LU
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 07:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbYGKFfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 01:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752280AbYGKFfS
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 01:35:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbYGKFfR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 01:35:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 79F8F26DB2;
	Fri, 11 Jul 2008 01:35:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 575DC26DB1; Fri, 11 Jul 2008 01:35:10 -0400 (EDT)
In-Reply-To: <7vr6a1mhqi.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 10 Jul 2008 16:39:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 23CDA99A-4F0B-11DD-8425-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88083>

Junio C Hamano <gitster@pobox.com> writes:

> Petr Baudis <pasky@suse.cz> writes:
>
>> The 06cbe8550324e0fd2290839bf3b9a92aa53b70ab core.sharedRepository
>> handling extension broke backwards compatibility; before, shared=1 meant
>> that Git merely ensured the repository is group-writable, not that it's
>> _only_ group-writable, which is the current behaviour.
>
> Donn't our existing tests catch this, and if the answer is no because we
> don't have any, could you add some?
> ...
>> diff --git a/path.c b/path.c
>> index 5983255..75c5915 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -269,7 +269,7 @@ int adjust_shared_perm(const char *path)
>>  	mode = st.st_mode;
>>  
>>  	if (shared_repository) {
>> -		int tweak = shared_repository;
>> +		int tweak = (mode & 0777) | shared_repository;
>>  		if (!(mode & S_IWUSR))
>>  			tweak &= ~0222;
>>  		mode = (mode & ~0777) | tweak;
>
> I think this change is good.  shared_repository has always been about
> widening the access and not about limiting.

Having said that, you really should protect this behaviour from regression
with a test case.  I do not see practical difference for sane umask
values.

What umask are you using, and which file in the repository gets affected?
In the old code I see we do have checks for S_IXUSR and tweaks on S_IXGRP
and S_IXOTH, but this should make a difference only if your umask blocks
executable bit and the file in question is executable.  Was it an
executable hook copied from template?
