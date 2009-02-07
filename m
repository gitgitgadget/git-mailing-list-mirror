From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use lock token in non-URI form in start_put
Date: Sat, 07 Feb 2009 12:40:10 -0800
Message-ID: <7v1vuavv4l.fsf@gitster.siamese.dyndns.org>
References: <498DE0B9.6080603@gmail.com>
 <alpine.DEB.1.00.0902072114360.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 07 21:44:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVu1r-00071A-AB
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 21:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbZBGUkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 15:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752919AbZBGUkS
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 15:40:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbZBGUkR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 15:40:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C74382AA65;
	Sat,  7 Feb 2009 15:40:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D28162AA64; Sat, 
 7 Feb 2009 15:40:11 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902072114360.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sat, 7 Feb 2009 21:20:54 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8678A886-F557-11DD-A1BC-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108879>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 8 Feb 2009, Tay Ray Chuan wrote:
>
>> After 753bc91 ("Remove the requirement opaquelocktoken uri scheme"),
>> lock tokens are in the URI forms in which they are received from the
>> server, eg. 'opaquelocktoken:', 'uuid:'
>>
>> However, "start_put" (and consequently "start_move"), which attempts to
>> create a unique temporary file using the UUID of the lock token,
>> inadvertently uses the lock token in its URI form. These file
>> operations on the server may not be successful (specifically, in
>> Windows), due to the colon ':' character from the URI form of the lock
>> token in the file path.
>
> If it is a prefix that happens to be part of the URI, but must not be used 
> by the client code as a lock token, would it not be better to store the 
> token in lock->token to begin with?

Let me show more of my ignorance around this codepath.

What is the real purpose of this appending?  My understanding is that it
is to ensure that a tentative PUT goes to a new file, so that a DAV server
whose PUT is not atomic (i.e. can leave a half-written bogosity when the
operation fails for whatever reason) won't leave a broken object in its
object store.  We MOVE it to its final destination and expect that to be
atomic.

Does the server side guarantee that the lock token string is unique in the
sense that it does not reuse a token that was used for a recent
transaction that was aborted?  If there is no such guarantee, then using
(a part of) the lock token as the string we append is no better than using
a random string we choose ourselves.

We may need to send the exact lock token back for unlocking the
transaction we started, but I do not think it necessarily is a good idea
to tie that to the random string we would use for PUT-then-MOVE operation.

RFC 4918 (section 6.5) explicitly states that the servers are free to use
any URI so long as it meets the uniqueness requirements, so relying on it
being any form of uuid does not sound like a good idea.  It can contain
not just a colon but other potentially problematic characters, such as a
slash, no?

That is why I asked in my previous question what in the codepath protects
ourselves from using problematic characters.
