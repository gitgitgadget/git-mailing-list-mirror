From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/3] Avoid using 'lstat()' to figure out directories
Date: Thu, 09 Jul 2009 16:37:24 -0700
Message-ID: <7vd489zavf.fsf@alter.siamese.dyndns.org>
References: <20090707000500.GA5594@dpotapov.dyndns.org>
 <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain>
 <7vskh646bw.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain>
 <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain>
 <7vab3d3dpc.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091153130.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091344340.3352@localhost.localdomain>
 <4A5670F3.9020309@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 01:37:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP3BO-0008Rj-RA
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 01:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbZGIXhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 19:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbZGIXhf
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 19:37:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43202 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbZGIXhf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 19:37:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9F6A526385;
	Thu,  9 Jul 2009 19:37:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7449C26384; Thu, 
 9 Jul 2009 19:37:26 -0400 (EDT)
In-Reply-To: <4A5670F3.9020309@gnu.org> (Paolo Bonzini's message of "Fri\, 10
 Jul 2009 00\:36\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 79E8831E-6CE1-11DE-BE7A-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123023>

Paolo Bonzini <bonzini@gnu.org> writes:

>> +		if (ce->name[len]>  '/')
>> +			break;
>> +		if (ce->name[len]<  '/')
>> +			continue;
>
> What about
>
> 	if (ce->name[len] < '/') {
> 		if (strchr(ce->name + len + 1, '/'))
> 			break;
> 		else
> 			continue;
> 	}
>
> to just punt if we'd go into a directory?  I'm not much worried about
> accessing foo-0001, foo-0002, foo-0003 while looking for foo/a (that
> would be O(number of files in a directory), which is bearable), but
> risking to go down a huge subtree is not very nice.

I am not so sure about "go down" part.  After all, what the loop does is
to scan an array of pointers to cache entries and the "continue" causes
the loop to iterate until you find a path that is in the directory in
question.  It is all in userspace code walking on a flat namespace and
there is no "we are going down into a subdirectory and need to open
another directory node" kind of overhead associated with it.

How expensive is it to do this, compared to an lstat() on a system that
does not have dtype in "struct stat" (which means "lstat() is very cheap
on Linux" does not even get into the picture)?  IOW, how many cache
entries can we afford to check their names with strncmp, before the cost
of doing so gets more expensive than a single lstat() on say Cygwin?

I am hoping that the userland is userland and even on Windows it will run
at full CPU speed, while lstat() may need to pay penalty on Windows due to
POSIXy emulation layer, so the tradeoff might turn out to be that we can
afford to test quite many cache entries and still win if we can save a
single lstat().
