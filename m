From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Thu, 21 Jan 2010 12:07:57 -0800
Message-ID: <7vljfrp6g2.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 21 21:08:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY3K6-0001MP-M3
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 21:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011Ab0AUUIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 15:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754902Ab0AUUIF
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 15:08:05 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44170 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab0AUUIE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 15:08:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AF401927FF;
	Thu, 21 Jan 2010 15:08:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kscfm9Ten89uv6/vheirH+R3ulM=; b=J21dqU
	CNRPDB03VK5ZVi5HCrZ83lrBdr9+d+a0NzFZaTOeBO0rWWtAojG5XYhj+LihzNbx
	YaRDOQtDQ2rHekR0UXQFeaEHRtIbVva1HAa/FPT4bdZGj8FrfCeXWJmCYy/VFlI2
	DGYUdzFgdexyaCd7h0pzARgN+6V+YNRbNnkJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ODD9NDw/zfbeP2xI1wXjqFYNPwDZOFzm
	MvSth96stA8dtDlm12JnXI9EMCrEsqDNKksmCkCOPzthcr9certmf7+uXWtANdfm
	P7A+hSzAVY3yvhamclZ9iBJYvA3106Z7/5Zm0qNdi+igcCfjgqEjo9XbylEL0xV9
	/Mio+ke5Axc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8ACC0927FE;
	Thu, 21 Jan 2010 15:08:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE95D927FD; Thu, 21 Jan
 2010 15:07:58 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain>
 (Linus Torvalds's message of "Thu\, 21 Jan 2010 11\:37\:38 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AD4F6ED0-06C8-11DF-BE45-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137688>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This trivial cleanup results in pretty stunning file size differences. 
> The diff machinery really is mostly used by just the builtin programs, and 
> you have things like these trivial before-and-after numbers:
>
>   -rwxr-xr-x 1 torvalds torvalds 1727420 2010-01-21 10:53 git-hash-object
>   -rwxrwxr-x 1 torvalds torvalds  940265 2010-01-21 11:16 git-hash-object
>
> Now, I'm not saying that 940kB is good either, but that's mostly all the 
> debug information - you can see the real code with 'size':
>
>    text	   data	    bss	    dec	    hex	filename
>  418675	   3920	 127408	 550003	  86473	git-hash-object (before)
>  230650	   2288	 111728	 344666	  5425a	git-hash-object (after)
>
> ie we have a nice 24% size reduction from this trivial cleanup.


The patch itself to move add_files_to_cache() to builtin-add.c (or to its
own file) makes sense from the code placement POV, but if the goal is to
shrink the on-disk footprint, isn't an alternative approach be to make
hash-object built-in?  You can lose the whole 1.7M from the filesystem
footprint that way, no?
