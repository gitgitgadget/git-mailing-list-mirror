From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow git-mergetool to handle paths with a leading space
Date: Mon, 07 Jan 2008 01:09:45 -0800
Message-ID: <7v8x320zom.fsf@gitster.siamese.dyndns.org>
References: <47809E7E.2090708@dawes.za.net>
	<7vodbz5ka9.fsf@gitster.siamese.dyndns.org>
	<4780B2BD.6020109@dawes.za.net>
	<7v3atb5g5o.fsf@gitster.siamese.dyndns.org>
	<4781D6C2.9060305@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Rogan Dawes <rogan@dawes.za.net>, "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 07 10:10:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBnzy-0006Kc-33
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 10:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995AbYAGJJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 04:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753789AbYAGJJy
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 04:09:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbYAGJJw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 04:09:52 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C1D3A3BB;
	Mon,  7 Jan 2008 04:09:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E757A3B9;
	Mon,  7 Jan 2008 04:09:47 -0500 (EST)
In-Reply-To: <4781D6C2.9060305@dawes.za.net> (Rogan Dawes's message of "Mon,
	07 Jan 2008 09:37:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69773>

Rogan Dawes <rogan@dawes.za.net> writes:

> Yes, you are right. Maybe setting IFS to the empty string is better?

Yes.  POSIX XCU "2.6.5 Field Splitting" is quite clear about
this.  Empty IFS tells read not to split the fields, and such an
IFS does not have IFS white space in it so the SP at the
beginning of the input will not be stripped.

My limited test indicates that bash, dash and ksh do behave as
specified, so I think it is a reasonably safe thing to do.
Although I usually would say "I do not care about Solaris
default /bin/sh", I know even that shell at least gets this
right.

I think the patch is Ok as long as the user does not care any
character outside the portable filename character set (POSIX XBD
3.276) other than SP.  Because the rest of the mergetool is
written in such a way that it does not handle many characters
outside the portable filename character set well anyway, I think
the filename limitation that still remains after your patch may
be acceptable.

I did not however apply your patch to my tree tonight, as Ted as
the original and the primary author of the script may have
better ideas, and/or future directions for the patch.  He can
simply just Ack your patch if he chooses to.

I'd however write that overly long pipeline indented a bit more
sanely, like this, though:

	git ls-files -u |
        sed -e 's/^[^	]*	//' |
        sort -u |
        while IFS="" read i
	do
        	printf "\n"
                merge_file "$i" </dev/tty >/dev/tty
                ...

In the longer term, I'd probably suggest redoing the entire
command in a NUL safe scripting language (or even C, especially
if pressed by mingw or msys folks) to eliminate the issue
altogether, though.  But that would definitely be a post 1.5.4
item.


[Reference]

http://www.opengroup.org/onlinepubs/000095399/toc.htm
