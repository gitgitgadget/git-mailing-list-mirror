From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: --ancestry-path
Date: Wed, 21 Apr 2010 01:01:34 -0700
Message-ID: <7vochdcjz5.fsf@alter.siamese.dyndns.org>
References: <201004201649.31084.johan@herland.net>
 <7viq7lg8f2.fsf@alter.siamese.dyndns.org>
 <7v39ypg4gm.fsf_-_@alter.siamese.dyndns.org>
 <201004210934.30226.johan@herland.net> <4BCEADA3.7090504@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 21 10:02:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Usn-0003qS-Pw
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 10:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527Ab0DUIBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 04:01:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59129 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab0DUIBs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 04:01:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7370BA9694;
	Wed, 21 Apr 2010 04:01:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PcRfytm8Jo49wDD9MAocDc5Qp+o=; b=FtYsjF
	fwaK4kIXIGYnxfSSD53dCRg6z+4eOJl6xAqKJcJUi6fNPLNNyWN+LmFIXzZLxofv
	S7dME3zPXV9hvlUhvRvYzd5E6FloISV80XLcLHtHV6gAjQjylPkrq/qWrI1l9ipY
	1LJtq94/g7vnZ1trO4whwqqy9VDe/7tydJidc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ww5IQhlqmpXgoCbN1zqRCmtZD87SGubC
	96oy5MV43/6Aj3fHuTDTI477i65XPrveINabr8lktSX5M+JtFRkst61NQ4f80Oo6
	ZWzpiXdPy/jnXjZhkSdAyRbd1tadIqUk3D3SoQsDhL0nDOagortdVgkG2T81Ie03
	YClRoLyp35o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 10B42A968F;
	Wed, 21 Apr 2010 04:01:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2071FA968D; Wed, 21 Apr
 2010 04:01:35 -0400 (EDT)
In-Reply-To: <4BCEADA3.7090504@viscovery.net> (Johannes Sixt's message of
 "Wed\, 21 Apr 2010 09\:47\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1F164A0E-4D1C-11DF-944D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145416>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 4/21/2010 9:34, schrieb Johan Herland:
>> I can confirm that this patch works with my original (more complicated) 
>> scenario. I've also played around with combinations of --ancestry-path, --
>> graph and --parents (and even --boundary), and AFAICS, the new option does 
>> not clobber the other options, and (IMHO) it all behaves correctly in the 
>> scenarios I've tested.
>
> How about possible interactions with --reverse; --date-order/--topo-order,
> --parents (important for gitk); --simplify-by-decoration (useful for your
> problem that triggered this); --full-history and --simplify-merges with
> path limiting?

These are all good points.

I am reasonably sure that parents (specifically, "rewrite_parents") is
broken.  The new function should cull parents that do not appear on the
ancestry path from merges (that is what "NEEDSWORK" is about).  It may or
may not break gitk, though---these off-path parents are shown as parents
of an on-path merge but will be marked as UNINTERESTING.

I do not think reverse/date-order/topo-order would be affected by this
change, as they only change the presentation order of what limit_list()
returns;

Also simplify-merges and full-history should be Ok, as they control what
is done in the current logic in limit_list(), which is an input to the new
logic, meaning that the new logic will work on already simplified history.

This is not a new problem, but I strongly suspect that cherry-pick is
broken the same way wrt "rewrite_parents".
