From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Having Git follow symlinks
Date: Fri, 31 Jan 2014 09:23:15 -0800
Message-ID: <xmqq38k4hxq4.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.2.02.1401281443330.17426@perkele.intern.softwolves.pp.se>
	<CALKQrgf5o-ZcaeqXLm3P7RpK2yPcFd_HnG4ewwoEGESduyDSjQ@mail.gmail.com>
	<alpine.DEB.2.00.1401300958320.30100@ds9.cixit.se>
	<vpqa9ed1w8y.fsf@anie.imag.fr>
	<alpine.DEB.2.00.1401311052370.3993@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Jan 31 18:23:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9HoM-0008Ar-7y
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 18:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbaAaRXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 12:23:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60708 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932236AbaAaRXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 12:23:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C92E3667A4;
	Fri, 31 Jan 2014 12:23:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YB5d7RccfHbnOtP6RJnu2kyWQRg=; b=ErNaN+
	GzCIxYCHSPPh74mRBUpyVqEKR2HvBX/z4rKC/7hsrJL2Qe9qHD181FiNYVk1Lam8
	5h5NrdTvbDF0DHL5jeGntolc1ecYuH+e2hIBfpOUB8FmRVxsNb5Cq10cgg4vOOS4
	WgiyHb5lQaC9zfiyvaIKZIM5lnVMimbJSHI1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M8CGBgURxfv/ur3Fgv2o9WGavD2gzi7V
	fNpDk49tTxVEMBrls5NvUIslRaUuB3p0LvUbTbeN+2Bsoc3wU4Bh3NvbB7GfBAZB
	4h85Xx2ADKZR7JIstB4P6seym1nnUDeywhBQciaoZ7pXSPvaINwf4TdhbgebO19J
	20Col/P7vo0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 293AC667A2;
	Fri, 31 Jan 2014 12:23:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B71D46679F;
	Fri, 31 Jan 2014 12:23:17 -0500 (EST)
In-Reply-To: <alpine.DEB.2.00.1401311052370.3993@ds9.cixit.se> (Peter
	Krefting's message of "Fri, 31 Jan 2014 10:56:41 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5FC62698-8A9C-11E3-84A6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241307>

Peter Krefting <peter@softwolves.pp.se> writes:

> ...if I have the time, maybe I can come up with a patch. There is
> already some hacks in the "core.symlinks" setting, so I guess it
> should be possible.

That is totally unrelated.  The variable only says "on this platform
and/or filesystem, you cannot symlink(2), so instead create a
regular file with the symlink contents when checking out a symlink
blob".  Most importantly, the variable does not change the fact that
symbolic links are explicitly tracked without dereferencing.

If you have, under a directory foo/, a symbolic link foo/bar that
points at "../baz", a directory foo/baz/, and you have a file at
foo/baz/hello:

 1. "git add foo" and "git add foo/bar" will add foo/bar as a
    symlink; and
 2. "git add foo/bar/hello" is an error.

The variable does not have any interactions with the logic to make
sure 2. errors out correctly, so the presense of it does not imply
anything.
