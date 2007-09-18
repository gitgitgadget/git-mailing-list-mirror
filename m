From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diffcore-rename performance mode
Date: Tue, 18 Sep 2007 01:49:50 -0700
Message-ID: <7vsl5cwe6p.fsf@gitster.siamese.dyndns.org>
References: <20070918082321.GA9883@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:50:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXYmT-0008Ia-2n
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 10:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbXIRIt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 04:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752276AbXIRIt5
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 04:49:57 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:51223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbXIRIt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 04:49:56 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3CFB71373B0;
	Tue, 18 Sep 2007 04:50:14 -0400 (EDT)
In-Reply-To: <20070918082321.GA9883@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 18 Sep 2007 04:23:22 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58545>

Jeff King <peff@peff.net> writes:

> There seems to be a serious performance problem in diffcore-rename.
> There is infrastructure to cache the "cnt_data" member of each filespec,
> but it never gets used because we immediately free the filespec data
> after use. Oops.
>
> With this patch:
> ...
> My 20-minute diff becomes a 2-minute diff. The downside is that the
> memory usage is much increased (for obvious reasons, it should increase
> by the dataset size, since we are keeping pointers to the data around --
> in my case, around 1G extra).

Yes, these early freeing of filespec_data() were introducd later
specifically to address the memory usage issue.

> However, keeping around _just_ the
> cnt_data caused only about 100M of extra memory consumption (and gave
> the same performance boost).

That would be an interesting and relatively low-hanging optimization.

> The spanhash data structure is a bit confusing. At first, it looked like
> we were doing a linear search for a matching hash, but it's not quite,
> since we seem to start at some magic spot based on the hashval we're
> looking up.

I think it was just a hash table with linear overflow (if your
spot is occupied by somebody else, you look for the next
available vacant spot -- works only if you do not ever delete
items from the table) but sorry, I do not recall the rationale
for picking that data structure.  I vaguely recall I did some
measurement between that and the usual "an array that is indexed
with a hash value that holds heads of linked lists" and pointer
chasing appeared quite cache-unfriendly to the point that it
actually degraded performance, but did not try very hard to
optimize it.
