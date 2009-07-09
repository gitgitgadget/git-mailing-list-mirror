From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Avoid doing extra 'lstat()'s for d_type if we have
 an up-to-date cache entry
Date: Thu, 09 Jul 2009 11:34:50 -0700
Message-ID: <7vbpnt3dth.fsf@alter.siamese.dyndns.org>
References: <20090707000500.GA5594@dpotapov.dyndns.org>
 <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain>
 <7vskh646bw.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain>
 <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907090954090.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 20:35:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOySc-0006K0-GF
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 20:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816AbZGISe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 14:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753298AbZGISe6
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 14:34:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbZGISe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 14:34:58 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3CA9C267AC;
	Thu,  9 Jul 2009 14:34:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 61391267AA; Thu, 
 9 Jul 2009 14:34:52 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907090954090.3352@localhost.localdomain>
 (Linus Torvalds's message of "Thu\, 9 Jul 2009 09\:59\:10 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 33D8F176-6CB7-11DE-B754-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123000>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>> > +		if (!ce_uptodate(ce))
>> > +			break;	/* continue? */
>> 
>> I think this should be continue, as the directory D you are interested in
>> may have two files, one modified, the other uptodate.
>
> The thing is, the directory may have subdirectories, and there may be 
> tens of thousands of files there. And maybe this gets called by code that 
> hasn't done any cache preloading at all, so nothing will be up-to-date.
>
> Do we want to loop over thousands of entries? Or do we want to loop as 
> little as possible, and just say "most of the time the first entry will be 
> representative".

Ah, I see.

It depends on how expensive it is to iterate over an in-core array to
check a single bit (that may not even have been updated) in the cache
entries, compared to an extra lstat().  Perhaps we could autotune that,
but it probably is not worth it. ;-)
