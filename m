From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Let "git submodule add" fail when
 .git/modules/<name> already exists
Date: Sat, 29 Sep 2012 21:47:33 -0700
Message-ID: <7vtxugglqy.fsf@alter.siamese.dyndns.org>
References: <BC634E06939C44239106E7A8DD229130@gmail.com>
 <50636C00.6080906@web.de> <50677E76.1050204@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Johnson <me@jondavidjohn.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Sep 30 06:48:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIBS9-0008T1-02
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 06:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402Ab2I3Erh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 00:47:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36095 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251Ab2I3Erg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 00:47:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B5578E7E;
	Sun, 30 Sep 2012 00:47:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sUVdk2npVV+K/GA/jupXtTiWZwk=; b=HuI05q
	sre0QcqTstj4NxOscw/Q7sHD550KW1dTFGw3Q5yT5rC8uB0UN6AJmpkyFKOPRiCV
	z/X5UPbEj+U388BeTkndGYfmT1qH8US41/UMulujbE7mCd0IF3zBwt8KdvwXCsSl
	BTcJcY42gY+8q5hQBsN0mQVI/DMFPI3Nw346Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LWYXE4pQ/CszH42BPYUBxaIDi9qWZWlR
	GB9RaNWyCFWlKtjoIqqKzMB6CvjrYWZCSTMsPlHY8lum68X763bDNctj19AEt1sc
	oQDVEDM6+jTTTr/iCklzAb8/NKhHQeG3S4y38LVix2twctMUzeIu2B8CB3Bz4iam
	BtcoXx/joeM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 594A18E7D;
	Sun, 30 Sep 2012 00:47:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A67C88E7C; Sun, 30 Sep 2012
 00:47:34 -0400 (EDT)
In-Reply-To: <50677E76.1050204@web.de> (Jens Lehmann's message of "Sun, 30
 Sep 2012 01:04:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F39CC386-0AB9-11E2-B964-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206666>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>> The only long term solution I can think of is to use some kind of UUID for
>> the name, so that the names of newly added submodules won't have a chance
>> to clash anymore. For the short term aborting "git submodule add" when a
>> submodule of that name already exists in .git/modules of the superproject
>> together with the ability to provide a custom name might at least solve
>> the local clashes.

That assumes that the addition of the submodule for the second time
is to add a completely different submodule at the same location and
is done on purpose, but is that a sensible assumption?

If a superproject that is about an embedded appliance used to have a
submodule A bound at its path "kernel", but for some reason stopped
shipping with "kernel" and then later reintroduced the directory
"kernel" bound to some submodule B, my gut feeling is that it is
just as likely (if not more likely) that A and B are indeed the same
submodule (i.e. it shares the same history) as they are totally
unrelated.

Could it be that it is a user error combined with the immaturity of
"git submodule" tool that does not yet support "it used to be here,
but it disappears for a while and then it reappears in the history
of the superproject" very well that caused the user to manually add
a "new" submodule which in fact is the same submodule at the same
path?

I think failing with a better error message is a good idea. It
should suggest to either resurrect the submodule that is stashed
away in "$GIT_DIR/modules/$name" if it indeed is the same, or to
give it a different name (perhaps "kernel" used to be pointing at
the Linux kernel history, then the user is replacing it with a
totally different implementation that is really from different
origin and do not share any history, perhaps BSD).  In such a case,
the user may want to pick bsd-kernel or something as its name, to
differentiate it.

> Using some kind of UUID can easily be added in a subsequent patch,...

I would suggest thinking really long and hard before saying UUID.
It is an easy cop-out to ensure uniqueness, but risks to allow two
people (or one person at two different time) to give two unrelated
names to a single thing that actually is the same.

A better alternative might be to use the commit object name at the
root of the history of the submodule, which would catch the simplest
and most common case of the mistake, I would think.
