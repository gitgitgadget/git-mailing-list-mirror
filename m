From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Prefer sysconf(_SC_OPEN_MAX) over
 getrlimit(RLIMIT_NOFILE,...)
Date: Wed, 22 Aug 2012 11:07:09 -0700
Message-ID: <7vboi294xe.fsf@alter.siamese.dyndns.org>
References: <002301cd807f$4e19ad80$ea4d0880$@schmitz-digital.de>
 <7v4nnualjf.fsf@alter.siamese.dyndns.org>
 <003b01cd808f$0a5bf610$1f13e230$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 20:07:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4FKp-0004j9-94
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 20:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758342Ab2HVSHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 14:07:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38038 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756293Ab2HVSHM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 14:07:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BFD49CA7;
	Wed, 22 Aug 2012 14:07:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EdGBEkm6B8hHoSEkRGedqQoKzW8=; b=P7COBf
	QSLEizNKSqUQOfiX9kGi18tl5bk+uY5zS4WupIv4FXfKMfOOVGdHNoQS4BFw2jWA
	SUHGpfUXRyFNXDoFmgIAX4ZJKYXvhw3T9+yBu7vXhQlnnE67HxS/2V3/4Ewvmozv
	u+1/fbw3vGLkDvj4o/WZX/WoYkfudUFmdIunQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XUbLrGC1S5SPeyGnH4ezQdLNprDuFXrf
	/T+7nTSILFDuigzmuYrbo9+sfxdU7g3CcWhVkynUkK7zbh7hod6btRJ/omr1tq47
	UvCKygr/r6Jnpk1muBbwZpSo25fJW0BaeL2pv4+QZjuUTPNYtCVLkqvX/NnGZgjy
	TIHQ4kOEkKg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 391279CA6;
	Wed, 22 Aug 2012 14:07:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90D709CA5; Wed, 22 Aug 2012
 14:07:10 -0400 (EDT)
In-Reply-To: <003b01cd808f$0a5bf610$1f13e230$@schmitz-digital.de> (Joachim
 Schmitz's message of "Wed, 22 Aug 2012 19:53:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 315F94AE-EC84-11E1-BAE6-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204055>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> Looks sane but it would be more readable to make this a small helper
> function,
>> so that we do not need to have #ifdef/#endif in the primary flow of the
> code.
>
> Hmm, in compat/? Worth the effort fort hat single occrence?

Compat/ is to have some systems that lack an interface we deem to be
common on platforms emulate that interface, but in this case, we
just want something like:

	static int get_max_fd_limit(void)
        {
        #ifdef _SC_OPEN_MAX
        	...
	#else
		...
	#endif
		return max_fds;
	}

and that is not emulating anybody's standard interface.

Such a helper before the definition of the function that your patch
is touching, in the same file as a file-scope static, was what I
meant.  If other places in the code want to open tons of pipes or
file descriptors for some reason, we may want to make it part of the
supporting infrastructure, and drop "static " at the beginning and
add "extern int get_max_fd_limit(void);" to cache.h for others to
use, but as you said, there is currently only one place that uses
it, so it can stay static to the file.
