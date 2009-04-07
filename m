From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 1/6] send-email: Add --delay for separating emails
Date: Tue, 07 Apr 2009 16:17:38 -0700
Message-ID: <7vd4boxdd9.fsf@gitster.siamese.dyndns.org>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 01:20:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrKaI-0001hP-OJ
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 01:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760143AbZDGXRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 19:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758573AbZDGXRq
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 19:17:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758741AbZDGXRp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 19:17:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 533DAA86D3;
	Tue,  7 Apr 2009 19:17:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1F2ECA86CE; Tue,
  7 Apr 2009 19:17:39 -0400 (EDT)
In-Reply-To: <1239139522-24118-1-git-send-email-mfwitten@gmail.com> (Michael
 Witten's message of "Tue, 7 Apr 2009 16:25:17 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4C00CE9E-23CA-11DE-A13F-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116007>

Michael Witten <mfwitten@gmail.com> writes:

> When sending a patch series, the emails often arrive at the final
> destination out of order; though these emails should be chained
> via the In-Reply-To headers, some mail-viewing systems display
> by order of arrival instead.
>
> The --delay option provides a means for specifying that there
> should be a certain number of seconds of delay between sending
> emails, so that the arrival order can be controlled better.

If you are trying to force the order of messages that the client MUA
physically receives the messages, I do not think giving N second
interval at the sending end would help much in the real world.  Between
your submitting MUA (that's "git-send-email") and the client MUA, there
are many hops involved:

 * Your outgoing MSA (typically your ISP's sendmail) your MUA hands
   messages to;

 * Your ISP's internal mail routing chain of MTAs that forward the
   messages around;

 * The recipient's ISP's incoming MTA that receives the messages from
   your ISP's outgoing MTA;

 * The recipient's ISP's internal mail routing chain of MTAs that
   forward the messages around, until they reach...

 * ... the mailbox at recipient's ISP that stores the messages until the
   recipient picks them up;

 * And finally the recipient's MUA that reads from the mailbox.

Messages your MUA sends out can take different paths in the above chain
even though the final destination (mailbox at the recipient's ISP) may
be the same, and different mailpaths can and do have different
latencies.  Even if all the messages sent out by a single invocation of
your submitting MUA happened to take the same mailpath, any single hop
can batch the messages that arrive within a small time window before
passing them to the next hop, and it can reorder the messages when it
does so.

In short, the only thing your --delay can control is the arrival
interval at your outgoing MSA.  The arrival interval and order of
messages are outside your control for later hops.

On the other hand, I think send-email already has hacks to timestamp the
messages at least one-second apart by shifting the Date: field, so that
the recipient MUA can sort by the departure timestamp if it wants to (and
if it can), instead of the arrival timestamp.  Is it not working well for
you?
