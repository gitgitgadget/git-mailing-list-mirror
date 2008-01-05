From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tree-walk: don't parse incorrect entries
Date: Sat, 05 Jan 2008 12:50:28 -0800
Message-ID: <7v1w8w80a3.fsf@gitster.siamese.dyndns.org>
References: <1199555243534-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sat Jan 05 21:51:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBFz3-0003de-Pz
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 21:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768AbYAEUuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 15:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756654AbYAEUuf
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 15:50:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756692AbYAEUue (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 15:50:34 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EA15573A3;
	Sat,  5 Jan 2008 15:50:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5646F6DE2;
	Sat,  5 Jan 2008 15:50:30 -0500 (EST)
In-Reply-To: <1199555243534-git-send-email-mkoegler@auto.tuwien.ac.at> (Martin
	Koegler's message of "Sat, 5 Jan 2008 18:47:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69684>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> The current code can access memory outside of the tree
> buffer in the case of malformed tree entries.
>
> This patch prevent this by:
> * The rest of the buffer must be at least 24 bytes
>   (at least 1 byte mode, 1 blank, at least one byte path name,
>    1 zero, 20 bytes sha1).

Good ("zero" in this context is better spelled as "NUL").

> * Check that the last zero (21 bytes before the end) is present.
>   This ensurse, that strlen and get_mode stay within the buffer.

Good (ditto).

> * The mode may not be empty. We have only to reject a blank at the begin,
>   as the rest is handled by if (c < '0' || c > '7').

I initially thought this was slightly iffy as tree objects were
written with padding for mode bits, but that was padding with
zero ('0') to the left and not with SP, so it is a good change,
I think (I am saying this primarily so that others can say "you
are wrong, there are valid old trees with SP there" to stop me).

> * The blank is ensured by get_mode.

Ok.

> * The start of the path may not be after the last zero (21 bytes before the end).

How can that be possible?

 - you know end points at NUL and buf < end;

 - get_mode() starts scanning from buf, stops at the first SP if
   returns a non NULL pointer; anything non octal digit before
   it sees that SP results in a NULL return;

 - the return value of get_mode() is the beginning of the path.

The second point above means when get_mode() scans buf, it would
never go beyond end which you already made sure is NUL (which is
not SP and not an octal digit).  If it hits end, you would get NULL
pointer back, wouldn't you?

Rejecting an empty path may be sensible (i.e. checking "!*path"
instead), though.
