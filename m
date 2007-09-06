From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] basic threaded delta search
Date: Thu, 06 Sep 2007 00:01:16 -0700
Message-ID: <7vwsv4cm6b.fsf@gitster.siamese.dyndns.org>
References: <11890591912193-git-send-email-nico@cam.org>
	<11890591923123-git-send-email-nico@cam.org>
	<11890591923270-git-send-email-nico@cam.org>
	<1189059193250-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 09:01:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITBMm-0002Xs-Q5
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 09:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757249AbXIFHBW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 03:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756676AbXIFHBW
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 03:01:22 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:47371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756489AbXIFHBV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 03:01:21 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 2034512D9FA;
	Thu,  6 Sep 2007 03:01:40 -0400 (EDT)
In-Reply-To: <1189059193250-git-send-email-nico@cam.org> (Nicolas Pitre's
	message of "Thu, 06 Sep 2007 02:13:11 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57834>

Nicolas Pitre <nico@cam.org> writes:

> this is still rough, hence it is disabled by default.  You need to compile
> with "make THREADED_DELTA_SEARCH=1 ..." at the moment.
>
> Threading is done on different portions of the object list to be
> deltified. This is currently done by spliting the list into n parts and
> then a thread is spawned for each of them.  A better method would consist
> of spliting the list into more smaller parts and have the n threads
> pick the next part available.

Hmmm.  I wonder how the result is affected by such a partition;
aren't you going to have many objects that could have used
somebody else as a delta but gets stored as base because they
happen to be a very early part of their partition (and lacking
delta base candidates in the window)?  You cannot solve it with
overlapping partitions without busting the depth limit easily
either, I suspect.  Also how would this interact with the LRU
delta base window we discussed a week or two ago?

Separating the list into different object types would not have
any adverse impact coming from the "horizon" of delta base
candidates window (because we do not deltify across types), but
that is not very useful because we cannot gain much parallerism
from such a partition.
