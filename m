From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] start refactoring binary search function
Date: Sun, 05 Apr 2009 02:45:07 -0700
Message-ID: <7veiw7wi1o.fsf@gitster.siamese.dyndns.org>
References: <20090404225920.6a10fe78.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 11:47:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqOwV-0007Mk-V2
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 11:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761AbZDEJpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 05:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754350AbZDEJpS
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 05:45:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbZDEJpR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 05:45:17 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F1B4EC1BE;
	Sun,  5 Apr 2009 05:45:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 40C18C1BC; Sun, 
 5 Apr 2009 05:45:09 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 764E17B6-21C6-11DE-BF40-DD19768B9EAE-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115643>

Christian Couder <chriscool@tuxfamily.org> writes:

> There are many binary search functions in the code base and I have been
> asked to refactor them in these message:
>
> http://thread.gmane.org/gmane.comp.version-control.git/105363/focus=105436
> http://thread.gmane.org/gmane.comp.version-control.git/114735/focus=115391
>
> so here is a start
>
> The following patch applies on top of pu where they can be squashed into other
> patches:
>
>   sha1-lookup: add new "sha1_pos" function to efficiently lookup sha1
>   patch-ids: use the new generic "sha1_pos" function to lookup sha1
>   bisect: use the new generic "sha1_pos" function to lookup sha1
>   replace_object: use the new generic "sha1_pos" function to lookup
>     sha1

I think the refactoring itself does make sense.  Less duplicated code has
better chance to be improved further if there is demonstrated need, and
I like the series for that "clean-up" value alone.

In the last two patches, however, you advertised the use of this new API
for gaining better performance (in exchange for simpler copy-pasted
implementation), but changing a simple (base + index * sizeof(struct that
contains the sha-1 field)) into a call to a function whose address is
passed _may_ have larger negative impact to the performance, than what is
gained by the better initial midpoint selection the new code uses.

If the extra indirect call turns to degrade the performance too much, we
could always reimplement it as a macro, I think, but let's not go there
before somebody runs benchmarks and demonstrates that it is a problem.

I've restructured your existing two branches to take advantage of the
first two patches.

Thanks.
