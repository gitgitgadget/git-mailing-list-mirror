From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-blame.c: Use utf8_strwidth for author's names
Date: Sun, 01 Feb 2009 22:48:51 -0800
Message-ID: <7v8wopmizw.fsf@gitster.siamese.dyndns.org>
References: <1233308489-2656-1-git-send-email-geofft@mit.edu>
 <1233308489-2656-2-git-send-email-geofft@mit.edu>
 <alpine.DEB.1.00.0901301811180.3586@pacific.mpi-cbg.de>
 <alpine.DEB.2.00.0901301710130.1984@vinegar-pot.mit.edu>
 <alpine.DEB.1.00.0902012333060.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geoffrey Thomas <geofft@MIT.EDU>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 02 07:50:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTsdX-0000le-So
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 07:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbZBBGtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 01:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbZBBGtA
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 01:49:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbZBBGs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 01:48:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7AFB31D510;
	Mon,  2 Feb 2009 01:48:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5861D2A453; Mon, 
 2 Feb 2009 01:48:53 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902012333060.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sun, 1 Feb 2009 23:34:21 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9136B2A6-F0F5-11DD-A80A-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108055>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 30 Jan 2009, Geoffrey Thomas wrote:
>
>> Currently, however, printf("%*.*s", width, width, author) is simply 
>> wrong, because printf only cares about bytes, not screen columns. Do you 
>> think I should fall back on the old behavior if i18n.commitencoding is 
>> set, or if at least one of the author names isn't parseable as UTF-8, or 
>> something? Or should I be doing this with iconv and assuming all commits 
>> are encoded in the current encoding specified via $LANG or $LC_whatever?
>
> I do not know what encoding the author is at that point, but if you cannot 
> be sure that it is UTF-8, using utf8_strwidth() is just as wrong as the 
> current code, IMHO.

That is true, but then we are not losing anything.

This codepath is not about the payload (the contents of the files) but the
author name part of the commit log message, and UTF-8 would probably be
the only sensible encoding to standardize on.

If your project uses UTF-8 for everybody, great, we will align them better
than we did before.  If not, sorry, you will get a different misaligned
names.

That assumes utf8_width() does not barf when fed an invalid byte sequence,
but I did not think it is that fragile (I didn't actually audit the
codepath, though).
