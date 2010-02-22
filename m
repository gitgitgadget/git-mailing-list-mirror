From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file: don't malloc the whole compressed result when
 writing out objects
Date: Sun, 21 Feb 2010 22:31:54 -0800
Message-ID: <7v4ol9vl0l.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1002202323500.1946@xanadu.home>
 <7vd3zys79d.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002211522120.1946@xanadu.home>
 <7v3a0umdb8.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002211950250.1946@xanadu.home>
 <7v635p4z26.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002220034540.1946@xanadu.home>
 <7v8walyesu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 08:25:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjRq1-0003zd-6y
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 07:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628Ab0BVGcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 01:32:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab0BVGcH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 01:32:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F3FDD9B869;
	Mon, 22 Feb 2010 01:32:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ci8zPjFRXoJ/+lVy5D+qYWmlQwk=; b=tHWZ2C
	AmFjOVERGqQvIrwzD7yEp5jUAPEXhz6ThcomTrQZsHfzo9P2C1c7InBGgGajKLsA
	Tu7p8a2oMHOQesgdbSIEszu9lI4Wl5n9JDPemfmF2wd0ElITt5QLiT9NZf/YzN4E
	0HU3q9B89NSt3kTKKnK/An/9kRKsI8vBYE4GY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OPXiWnwwTASwmngmsjBeLLRTW7fGyDCT
	ygatRXKucWB6CBZ9J/dLV+GF3fL0ENISfHgJrTX9D1PdYpTJi7WA88KPRgnQojPy
	fG+EF7LRE2e8w7rGBbHCR6yIlZDWmqIVhlj4nIZbWk0NLBqECZQBiukoKDT8mZkf
	jR5SEhyBmKI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 290F29B866;
	Mon, 22 Feb 2010 01:32:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EDFA9B865; Mon, 22 Feb
 2010 01:31:57 -0500 (EST)
In-Reply-To: <7v8walyesu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 21 Feb 2010 22\:17\:53 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FBB7BE6C-1F7B-11DF-BAF4-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140637>

Junio C Hamano <gitster@pobox.com> writes:

> Nicolas Pitre <nico@fluxnic.net> writes:
>
>> And what real life case would trigger this?  Given the size of the 
>> window for this to happen, what are your chances?
>
>> Of course the odds for me to be struck by lightning also exist.  And if 
>> I work really really hard at it then I might be able to trigger that 
>> pathological case above even before the next thunderstorm.  But in 
>> practice I'm hardly concerned by either of those possibilities.
>
> The real life case for any of this triggers for me is zero, as I won't be
> mistreating git as a continuous & asynchronous back-up tool.
>
> But then that would make the whole discussion moot.  There are people who
> file "bug reports" with an artificial reproduction recipe built around a
> loop that runs dd continuously overwriting a file while "git add" is asked
> to add it.

Having said all that, I like your approach better.  It is not worth paying
the price of unnecessary memcpy(3) that would _only_ help catching the
insanely artificial test case, but your patch strikes a good balance of
small overhead to catch the easier-to-trigger (either by stupidity, malice
or mistake) cases.

So I am tempted to discard the "paranoia" patch, and replace with your two
patches, with the following caveats in the log message.

--- /var/tmp/2	2010-02-21 22:23:30.000000000 -0800
+++ /var/tmp/1	2010-02-21 22:23:22.000000000 -0800
@@ -21,7 +21,9 @@
     deflate operation has consumed that data, and make sure it matches
     with the expected SHA1.  This way we can rely on the CRC32 checked by
     the inflate operation to provide a good indication that the data is still
-    coherent with its SHA1 hash.
+    coherent with its SHA1 hash.  One pathological case we ignore is when
+    the data is modified before (or during) deflate call, but changed back
+    before it is hashed.
     
     There is some overhead of course. Using 'git add' on a set of large files:
     
