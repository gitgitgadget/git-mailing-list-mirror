From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git rm -u
Date: Sun, 20 Jan 2013 13:27:51 -0800
Message-ID: <7vobgjk0iw.fsf@alter.siamese.dyndns.org>
References: <50FB1196.2090309@gmail.com> <20130119214921.GE4009@elie.Belkin>
 <vpq622s9jk1.fsf@grenoble-inp.fr> <7v622rn1bh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	git@vger.kernel.org, Tomas Carnecky <tomas.carnecky@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jan 20 22:28:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx2R6-0000wj-HH
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 22:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab3ATV1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 16:27:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49582 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752508Ab3ATV1y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 16:27:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3459B8D9;
	Sun, 20 Jan 2013 16:27:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BR0Pp42FS7rUhETJA4gmXBp95kU=; b=JC2Zdz
	Wz4LT0ugU/ittCcC+DXkDpGQCXR+yBP6yg+DiI1xgGVK6+Wc8S05yRh+q82R8+V1
	0/X79uogRrgj1PNFo6HoyrcXtP3hW3sESCM+gzs+hj5NtrmlItPIqYL0V/+hoVSx
	VsM1ZUeaNdc5RcOwg93c09b4Pb++MiXEmS6Q8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i+1is6Xqm7WArXdL82H0rprryCFfI1uG
	WSz2u6AvKl/Rxu90bWjtf6rG2pZbB+BYqu1ZY6VB9AJ5G0s1BioKEvbrjqynlZTM
	lVG2pAzDkG2mfnGS/flytP+s9y4Tm85gpPu3xf2GwBdNr1JlgIef7iyIgKu7nJPY
	dKU6XEv4AXI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8693B8D8;
	Sun, 20 Jan 2013 16:27:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 643F2B8D0; Sun, 20 Jan 2013
 16:27:53 -0500 (EST)
In-Reply-To: <7v622rn1bh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 20 Jan 2013 10:42:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3FD85D8C-6348-11E2-BFA9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214053>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> "git add -u" is one of the only exceptions (with "git grep"). I consider
>> this as a bug, and think this should be changed. This has been discussed
>> several times here, but no one took the time to actually do the change
>
> Did we ever agree that it is a good change to begin with?  Pointers?

I think you can guess but I no longer need pointers.  Others may
still be helped, though.

The argument IIRC boils down to

 - "git add -u" was made a whole-tree operation when there weren't
   the ":/" magic pathspec, but "add -u" is very often something you
   want to do whole tree, and "(cd ../../..; git add -u)" or "git
   add -u ../../.." are too cumbersome to type.

 - "git add -u ." to limit it to the current directory is easy to
   type.

 - As we have the "from the root" magic pathspec these days,
   requiring "git add -u :/" when the user really means to add
   everything is no longer too much of a burden, but if we suddenly
   changed "git add -u" to mean "git add -u .", that is too much of
   a change in the semantics.
