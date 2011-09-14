From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] credential-osxkeychain: load Security framework
 dynamically
Date: Wed, 14 Sep 2011 16:18:07 -0700
Message-ID: <7vhb4esogg.fsf@alter.siamese.dyndns.org>
References: <1316023117-84755-1-git-send-email-jaysoffian@gmail.com>
 <1316040926-89429-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 01:18:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3yih-0007oa-4U
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 01:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066Ab1INXSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 19:18:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36887 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab1INXSK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 19:18:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62FC5475D;
	Wed, 14 Sep 2011 19:18:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kRBMjr61QJWEDrGwF8R4k4rEPyI=; b=l/FSvo
	F106N0SewqirA8H8cRcMAh+jThSWs7sBuG7KuxWtab1rqYIPeJ2DtTZ1QNgaJ/U9
	tp+Q6u2XbH2sXr249mYg7PJ5YY8VMVTlzX6d8m6wuSj7ipk5Pryi6lDfrfa6N4CG
	QbWHoYhbiayJRGi62NjaaWxrpXDpQP++GAYMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WQ2AxDd1EmvxKVzo00UJ/HEjA89gfgo3
	yZ84lAUyhs2qhem69iDJfzgwwlXPAydGy7zfX3O6onskTpJ5OKIBgAdA8HikixPl
	9ZdKXvL8B0n5ZMxn3KkuPXsxIW57eVE453yATv7zMGV3u5PHoGpa8jUHzQ5fT0S9
	WFvS3D7/pnw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59B83475C;
	Wed, 14 Sep 2011 19:18:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1EC9475B; Wed, 14 Sep 2011
 19:18:08 -0400 (EDT)
In-Reply-To: <1316040926-89429-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Wed, 14 Sep 2011 18:55:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CEEB65EC-DF27-11E0-B442-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181410>

Jay Soffian <jaysoffian@gmail.com> writes:

> Something like this. I'm going to pause here for feedback. Is the (not yet
> existant) followup commit referenced above allowing git-credential-osxkeychain
> to be a hard link to git a worthwhile endeavor? Or would a better approach be
> to make git-credential-osxkeychain.c not use any git code?

Most definitely the latter, I would think.

The whole point of making the Git credential code talk with a defined
interface with external programs is so that these keychain helpers can be
written independently from the rest of Git.

If the reason why your keychain helper benefits from linking with the rest
of Git is because some pieces of information you need in order to respond
to the requests from credential interface is hard to get if your helper is
built as an independent program, that is a sign that we are not exposing
enough information to scripts, iow, the failure in the design of the
credential interface. If that is the case (and I doubt it is), we would
need to fix the interface (either the credential interface, or perhaps
"git config") so that such an independent program does not have to peek
inside the internals of Git.

If the reason is because you want to reuse some generic C API we have that
are not necessarily tied to Git (e.g. strbuf, string-list, etc.), on the
other hand, please resist the temptation to do so. It would not help your
program to serve as an example of independent external keychain helpers,
i.e. a demonstration of how simple to write them.
