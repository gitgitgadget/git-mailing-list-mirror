From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Thu, 28 Jan 2010 21:29:27 -0800
Message-ID: <7vockdjx6w.fsf@alter.siamese.dyndns.org>
References: <20100129012350.GD20488@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 06:32:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NajSd-0004ua-Lk
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 06:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928Ab0A2F3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 00:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869Ab0A2F3k
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 00:29:40 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab0A2F3i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 00:29:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E7DE0956A2;
	Fri, 29 Jan 2010 00:29:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7SyPBrymPI4Slte2Xx2ZNX4/bp4=; b=iuPD1E
	E4ed5/cFzZ896YhxGStvABw23uQY0JT4nEqCqa9PVPE568ADGmKUSdsZ4nSF+6y0
	oQtNYfuNAc8oDQ5OXZS0OjouU62Gl9VcGhqYEfZx2IXIiM1lKBkBktQYQHGBS4RK
	WBVKwZJOGVzLEagJ5tBoJg4Mg/2piq4WIHdIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tlpvYoIJV6cpea8QpSeVXT8n+8QehhUW
	1fkkp5n4PsUiLlek4wJNTbv/4sacA7YHRB4MLPcOFm4Ibnd9d94R4mBiWT0A+JVZ
	U8EJZGS3ZI/vI5+HEhmdYfPMKrgbDlWiwG6WGIXIMf/j6a/3Hh9IbU0ot4Uufcb6
	l+sfg5/Fu20=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B6343956A1;
	Fri, 29 Jan 2010 00:29:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 096CC9569F; Fri, 29 Jan
 2010 00:29:28 -0500 (EST)
In-Reply-To: <20100129012350.GD20488@spearce.org> (Shawn O. Pearce's message
 of "Thu\, 28 Jan 2010 17\:23\:50 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 47B7177E-0C97-11DF-972D-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138300>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> +static void stream_blob(
> +	uintmax_t len,
> +	unsigned char *sha1out,
> +	uintmax_t mark)

A funny way to indent and line wrap...

> +{
> + ...
> +	/* Determine if we should auto-checkpoint. */
> +	if ((pack_size + 60 + len) > max_packsize
> +		|| (pack_size + 60 + len) < pack_size)
> +		cycle_packfile();

What's "60" in this math?

If the data is not compressible, we could even grow and the end result
might be more than (pack_size + len), busting max_packsize.  As we are
streaming out, we cannot say "oops, let me try again after truncating and
closing the current file and then opening a new file", and instead may
have to copy the data from the current one to a new one, and truncate the
current one.  Is this something worth worrying about?
