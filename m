From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] diffcore-pickaxe: optimize by trimming common
 initial and trailing parts
Date: Thu, 26 Feb 2009 01:05:18 -0800
Message-ID: <7vy6vtva9d.fsf@gitster.siamese.dyndns.org>
References: <cover.1235629933.git.gitster@pobox.com>
 <30c0d4d9b64924679c9af00796f7e0b562020ddf.1235629933.git.gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 10:07:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LccCn-0005lf-3p
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 10:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbZBZJFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 04:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752910AbZBZJF2
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 04:05:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbZBZJFY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 04:05:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D47F1789;
	Fri, 27 Feb 2009 04:05:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0ADAA1788; Fri,
 27 Feb 2009 04:05:19 -0500 (EST)
In-Reply-To: <30c0d4d9b64924679c9af00796f7e0b562020ddf.1235629933.git.gitster@pobox.com>
 (Junio C. Hamano's message of "Wed, 25 Feb 2009 22:52:06 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C308FF34-04AD-11DE-AB9D-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111540>

Junio C Hamano <gitster@pobox.com> writes:

> With this optimization in place, the following query in the Linux kernel
> repository on my machine becomes about 40% faster:
>
> $ STRING='Ensure that the real time constraints are schedulable.'
> $ git log -S"$STRING" HEAD -- kernel/sched.c >/dev/null
>
> (Before the patch, best of 5 runs)
> 5.59user 0.15system 0:05.74elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+39956minor)pagefaults 0swaps
>
> (After the patch, best of 5 runs)
> 3.04user 0.17system 0:03.23elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+49697minor)pagefaults 0swaps
    
The file "kernel/sched.c" has roughly 900 changes applied to it, and over
its lifetime, it has grown from 5kB to 9kB in size.

I suspect a larger file might see a bigger performance boost.
