From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/51] is_dup_ref(): extract function from
 sort_ref_array()
Date: Mon, 12 Dec 2011 14:33:12 -0800
Message-ID: <7vvcplxq4r.fsf@alter.siamese.dyndns.org>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
 <1323668338-1764-9-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Dec 13 01:38:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaGNv-00013P-Af
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 01:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab1LMAiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 19:38:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62290 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592Ab1LMAiO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 19:38:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 152457994;
	Mon, 12 Dec 2011 19:38:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=UUqY/3P4zr3RedrfcbgPmJxGNVk=; b=lLjYWkMXmTIii1DTt28q
	4J0q7XK+CPcuXpUYYbRiTQz9mXtiMbbdhbNGe+QY/Mo0BUiYyHoav5C6/QoGA7ee
	hQjZ/XUqVJZSYAu0b4jot445ZvVDptt+DqrdSpTGslSC6zjOzboGrM//3Dr+U/ZB
	Bh839NXnsrPUuO2bBXDkXh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hVh1Du8WGELOpqSjvQJ2SrKL5Dbp5yJajRlztHQZKd6mlB
	4HDLYCbXONuuczz5nR+uQtvOsITuP+hNPCmHHfD438VXO7WbbyQ4z98AfiptKVN5
	JWSBGBMLtqTXWsW6M54Yj9c5mPll5MLPL5vdw3v7w9oOCDilnMUl+L+I9qPN0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B60E7993;
	Mon, 12 Dec 2011 19:38:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 866BE7992; Mon, 12 Dec 2011
 19:38:13 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD7D05C2-2522-11E1-88A8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186983>

mhagger@alum.mit.edu writes:

> +/*
> + * Emit a warning and return true iff ref1 and ref2 have the same name
> + * and the same sha1.  Die if they have the same name but different
> + * sha1s.
> + */
> +static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2)
> +{
> +	if (!strcmp(ref1->name, ref2->name)) {
> +		/* Duplicate name; make sure that the SHA1s match: */
> +		if (hashcmp(ref1->sha1, ref2->sha1))
> +			die("Duplicated ref, and SHA1s don't match: %s",
> +			    ref1->name);
> +		warning("Duplicated ref: %s", ref1->name);
> +		return 1;
> +	} else {
> +		return 0;
> +	}
> +}

At this step, is_dup_ref() is only called from sort_ref_array() which in
turn is only called on either a collection of loose or packed refs, so
warning is warranted. IOW I do not see anything wrong with _this_ patch.

Later in the series, however, the collection of extra refs seems to be
shoved into a phoney "direntry" and made to go through the same add_ref()
machinery that uses find_containing_direntry() which in turn calls
search_ref_dir() that smells like a definite no-no.
