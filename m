From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 22/24] Let usage() take a printf-style format
Date: Tue, 10 Nov 2009 12:16:47 -0800
Message-ID: <7veio66spc.fsf@alter.siamese.dyndns.org>
References: <20091109150235.GA23871@progeny.tock>
 <1257779104-23884-22-git-send-email-jrnieder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 21:17:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7x9S-0002z6-7Z
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 21:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758037AbZKJUQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 15:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758036AbZKJUQs
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 15:16:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758031AbZKJUQs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 15:16:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D17137B030;
	Tue, 10 Nov 2009 15:16:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=2tgZkHzKeQwENz+yvqDXWMcIJgI=; b=fCflkoFyRCGtcg4xOFfL1yi
	L2g6NjHYh0IewZcWTgXEK3OiE/f8zj8hQyS8NhGm75PpqD4e0BgggznBuC5o4GQ/
	BPUa/Ej+osFPdfEOd6GIjr9O1aPjfzwROuG/Y+ItfbmulFePhJaCX9OqrY9Q1rjy
	FOMXNTFVApTzgU/vwyFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=TeWWWZ2IOaeyZhWTZdOYiPv41dgAMi2tGUNrdXJoxUzcJxs7t
	G/FeAlUFfc2+vhMFnXxPiLiA9UOz66i3AEPzMSB7DJkrje5tGBti18peAA0z6DZ+
	9PAO9Vm/k9mNqbMszgeV+XSj5VMC0hb3nPcqqZbdcI2HYGa3KiEImuA3sw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B097B7B02F;
	Tue, 10 Nov 2009 15:16:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 066757B02D; Tue, 10 Nov
 2009 15:16:48 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FB91DFEA-CE35-11DE-9A99-7B3EEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132592>

Jonathan Nieder <jrnieder@gmail.com> writes:

> merge-recursive and diff --no-index are not able to use usage()
> because their usage strings depend on the circumstances in which
> they are called.

Since die() and warn() are already printf-like, it may be tempting
to do this, but this is wrong.

I do not want to vet all the existing call sites to usage() of make sure
that all of them _happen_ to pass constant strings that do not have any
'%' in them.

Much more importantly, without a patch to future-proof all existing
callsites to modify from

	usage(blame_usage);

to

	usage("%s", blame_usage);

everybody needs to remember that some *_usage strings are special and have
to double % in it forever, which is a maintenance nightmare.

Besides, the majority of usage strings are _expected_ to be constant.
That is an important difference from die/warn whose purpose is to diagnose
and give appropriate message to the situation (hence they benefit from
formatting).

I've renamed this to usagef() and updated your two callers to use it in
the version I queued to 'pu'.

Thanks.
