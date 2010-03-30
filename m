From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] fast textconv
Date: Mon, 29 Mar 2010 20:52:04 -0700
Message-ID: <7vtyryxy8r.fsf@alter.siamese.dyndns.org>
References: <20100328145301.GA26213@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 30 05:52:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwSV0-0000UX-P3
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 05:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361Ab0C3DwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 23:52:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38189 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349Ab0C3DwM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 23:52:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B325A6678;
	Mon, 29 Mar 2010 23:52:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EcwP/Rgz/5klCOEVoY4YkR53g+E=; b=VyX8VJ
	Y4C10ldQaR1AZKmVHVSpnqQ/WxkGbGJ9krpmh0d7pWkVNPoHJsIg4ZAjRzZroEVe
	nNbaPCvAqWjNsjojoqW7TXUQyZXPy0GabM5RVZBqHdAlbzMtIEqk52tC31BwucmM
	BxN/pe7mkRZIL3JNPi431D4sayBKhZBSRMOcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=trDqH7wDTO9Uaj0pZ+zVjMbZxn/ts1UP
	kF+uYf3PqJt2LGwRjHbMFWcLQPRQIAPYuQN3kkWWM9a7Urgp81AUUPo+WTt2m+sN
	RlGOydNuY+aMryzKEvksSPj7d31503EHGAb0SFRSv0CKof4pvQkqVnttpiz/dIdS
	zkB2yxRV7uY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B938A6677;
	Mon, 29 Mar 2010 23:52:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 324C6A6675; Mon, 29 Mar
 2010 23:52:06 -0400 (EDT)
In-Reply-To: <20100328145301.GA26213@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 28 Mar 2010 10\:53\:02 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9D751746-3BAF-11DF-9899-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143541>

Jeff King <peff@peff.net> writes:

> The speedup is purely from caching; I am not using the "we only need to
> read the first part of the file" optimization.

This made me wonder if the end result might be easier to use if the
interface does not change "textconv", but adds some property to the
filter, i.e. "the output from this filter is stable and it is safe to
reuse a cached conversion result for a given blob object", boolean.  E.g.

        [diff "jpg"]
                textconv = exif
                textconv_stable = true

and let the calling side handle the caching.  I further suspect that
an unstable textconv filter would be an anomaly, so this could even be on
by default.

If we do so, stock conversion filters people have accumulated in the past
could be sped up without any additional change from the end user's side.

I guess that I am suggesting to postpone the potential speed-up that could
come from being able to inspect the header information as a separate
topic.  Besides, some file format has metadata at the end, which won't
help you.

About the caching scheme; to help invalidating the cache, it probably is a
good idea to use not just the blob object name but also at least the name
(command line) of the textconv filter as the key for the caching layer.

Instead of the "textconv_stable" boolean depicted above, you could add a
"textconv_filter_version" variable there, compute a hash over blob object
name, textconv filter name and textconv filter version, and use that as
the key to look into the cache (filters lacking textconv_filter_version
would then get no caching, and if you update your "exif" program you bump
the "textconv_filter_version" variable).
