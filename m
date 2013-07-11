From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Priming git clone with a local repo?
Date: Thu, 11 Jul 2013 09:01:15 -0700
Message-ID: <7vtxk1rsqc.fsf@alter.siamese.dyndns.org>
References: <20130708130355.647fffb6e5b6a453bfa0fa6e@canb.auug.org.au>
	<20130708073041.GA25072@sigill.intra.peff.net>
	<CACsJy8Chmm0=wDV4NQ+4Gh7KZYpbd9qkb=pNzkPeG-a-xiwVmw@mail.gmail.com>
	<7vbo6d2j2e.fsf@alter.siamese.dyndns.org>
	<20130711093532.GA28255@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 11 18:01:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxJJ4-0006oO-WD
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 18:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087Ab3GKQBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 12:01:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755735Ab3GKQBS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 12:01:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B1D32FC90;
	Thu, 11 Jul 2013 16:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C17MkeLU8ar5zlHBQSjFCiVW4j0=; b=pDeu48
	hh5kjMSK5OBCfZYJvSgXVUjn74t/f8O9Uo/a3NddnUiOghCFSXjJG+dlOqZ/cAzj
	1g9yZBdvBgZigwqyeahetGaBjxYJKPGCj0JbUS37PDIqTqujGDL0IV1lbD59kT+c
	E9i3jumiFmQsenrswTicn2WSvmiWHCPCXZ+K8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qrCO6g4iKmycGLn7woiDDm9c3svnSldh
	K9+WXRFJrNAPyj64TIkwmE1Rx2RvpfuIDT30s+/sNJSio1eUR833XPKyya3H8mu/
	OFHKlSooCFQDwocS8UdrReGtIGxRj2kIjqORcf9yeNGp5ZGlTY7MqF4Mm8WPtUIy
	uJsCMJkF5B8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 716D62FC8F;
	Thu, 11 Jul 2013 16:01:17 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D67FD2FC8E;
	Thu, 11 Jul 2013 16:01:16 +0000 (UTC)
In-Reply-To: <20130711093532.GA28255@inner.h.apk.li> (Andreas Krey's message
	of "Thu, 11 Jul 2013 11:35:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E6F8DC8-EA43-11E2-BC37-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230110>

Andreas Krey <a.krey@gmx.de> writes:

> I'm wondering if there is (or will be) a way of doing almost
>
>   git clone --reference localrepo host:canonrep
>
> Basically, I don't want the implications of --reference but still the
> performance advantages of reusing local objects/pack files.

I think the standard operating procedure for that is to still clone
with the "--reference" option first, and then do "repack -a -d" in
the resulting clone (note the lack of "-l" option in "repack").

After that repack, you should be able to discard the alternates
file.

    $ git clone --reference ../there otherhost:repo ours.git
    $ cd ours.git
    $ git repack -a -d ;# no "-l"!!!
    $ mv .git/objects/info/alternates .git/objects/info/alter-nates
    $ git fsck
    $ rm .git/objects/info/alter-nates
