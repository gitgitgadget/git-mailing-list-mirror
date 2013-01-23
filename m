From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Revoke write access to refs and odb after importing
 another repo's odb
Date: Wed, 23 Jan 2013 13:06:52 -0800
Message-ID: <7vwqv3fw2b.fsf@alter.siamese.dyndns.org>
References: <1358948067-2792-1-git-send-email-pclouds@gmail.com>
 <7v1udbj0kt.fsf@alter.siamese.dyndns.org> <51004A37.6040301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 22:07:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty7XR-0007ef-Q9
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 22:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388Ab3AWVG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 16:06:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41798 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899Ab3AWVG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 16:06:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48CBEC404;
	Wed, 23 Jan 2013 16:06:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CJ76oqSa9VYvG2mV1pr4hcrJyaI=; b=n2zUJo
	k/Q7HZEi5k/4bzBfXOaWeTDftXg3Wi++TkPCBW7CHjeaX/0R7CO0UbVNQI+MVxYl
	jdiEAdi9SHdrTr6F4GT2GtQmXjt0ocomSPhmMMTUYYUzukCdgXHcEqcOy/fqnTns
	cjpLHwBe0R4Ts3/F4KD07eV493DjDwrMLxhhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bocSuZE7fVNY0KklS34E9AgAakcitFYS
	DjMxYdb5OgAkd7dxFDjrHQkkmgUoSvA6ZzfxFy6A93vE8P7JDPxC0UQrGH+JS7lp
	lyHzh2xHQ4tb65CPTWalNmypZB1YJ4TArIyvoYG+NH1oZDnKptPlTWtxmGy212i6
	nFVSWBaJCqA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 369DCC403;
	Wed, 23 Jan 2013 16:06:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A845BC3FE; Wed, 23 Jan 2013
 16:06:54 -0500 (EST)
In-Reply-To: <51004A37.6040301@web.de> (Jens Lehmann's message of "Wed, 23
 Jan 2013 21:38:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0CF8EA0-65A0-11E2-A79F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214364>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> This is a false positive. The merge algorithm picked a fast-forward
> in a submodule as a proper merge result and records that in a
> gitlink. But as Duy pointed out this could be easily fixed by
> turning the readonly flag off in that case.

I see that as "easily circumvented and not an effective protection",
though.

In theory, adding a gitlink to the index, removing a gitlink to the
index and modifying an existing gitlink in the index to another
gitlink in the index and writing the resulting in-core index out to
the on-disk index should be allowed, even after objects from the
submodule object database have contaminated our in-core object pool,
as long as you do not run cache_tree_update().  I am not sure if that
single loophole would be sufficient, though.
