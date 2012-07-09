From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/2] rm: don't fail when removing populated
 submodules
Date: Mon, 09 Jul 2012 12:38:22 -0700
Message-ID: <7vpq84k9n5.fsf@alter.siamese.dyndns.org>
References: <4FF4AAE7.40604@web.de> <4FF4AB1B.60805@web.de>
 <7v1ukppear.fsf@alter.siamese.dyndns.org> <4FF830D6.7080708@web.de>
 <7vsjd2n1wt.fsf@alter.siamese.dyndns.org> <4FF9A261.3040907@web.de>
 <7vhathn0f4.fsf@alter.siamese.dyndns.org> <4FFB23EB.8060409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 21:38:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoJmx-00017C-8Z
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 21:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487Ab2GITi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 15:38:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260Ab2GITiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 15:38:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01F149EF2;
	Mon,  9 Jul 2012 15:38:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kHhNiSy+beC1x0sH12sV1Nusxlc=; b=x1IZbl
	RhQlcuhRFCAywiEkk3wMZTvJLbSWXdsCxh+iITumWMFQYs0lPW/lTxt1TgCfXUMl
	KcIYKGllUZJFKFiE7eCINev91ijOt+G8G5fTipmOcuSYAwx+TXV2iBQ3vdFSjemh
	the+10mPsPaW5YzkAffZVhE0GQz2PyFMWgers=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IMUXRuqndZIGgkbwUZ/xqlUU3Slq52SH
	SkngenBULfPKx1RBPCiX8a9ZxVrhaRvuIdHnogpwgmtm1+HWsClgYvqFAyGNNiyz
	E5WFy3WqtU4pM6dfSmqLP84pd6yoj2MxyEZFF2+BMvn5OBdLUMNyofaapXUZv0XX
	UfxRBG5Jkx8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED5869EF1;
	Mon,  9 Jul 2012 15:38:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 583579EF0; Mon,  9 Jul 2012
 15:38:24 -0400 (EDT)
In-Reply-To: <4FFB23EB.8060409@web.de> (Jens Lehmann's message of "Mon, 09
 Jul 2012 20:33:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5D1CE1E-C9FD-11E1-8B28-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201220>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Cool, so let's drop this patch and I'll teach "rm" to handle
> populated submodules according to what we do for regular files:
> Make sure there are no modifications which could get lost (unless
> "-f") and remove all tracked files and the gitfile from the work
> tree (unless "--cached") before removing the submodule from the
> index. If the submodule uses the old layout with the .git
> directory instead of a gitfile we error out just like we do today.

Alternatively we could "mv" .git directory out of the way and the
next "git checkout" of a branch that still has the submodule can
make a gitfile to point there, no?

Or we can just error out and tell the user to do so herself.

> And we didn't talk about untracked or ignored files which may live
> inside the submodules work tree so far, but according to what a
> "rm -r" does in the superproject they should still be around after
> using "rm" on a populated submodule, right?

Until we add the "precious" class, untracked and ignored files are
expendable, so if a submodule working tree has no modification and
only has leftover *.o files, they can be nuked as part of submodule
removal, but if it has an untracked and unignored *.c file for
example, the "rm" operation without "-f" should be stopped, no?
