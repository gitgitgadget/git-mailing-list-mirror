From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff-tree does not use alternate objects for submodules
Date: Wed, 09 May 2012 15:53:34 -0700
Message-ID: <7vwr4lotjl.fsf@alter.siamese.dyndns.org>
References: <CAGHpTBLfbMU1WevW6XnY_N2BnfwPZ0_6jJDf45rCkVjWGwA9xg@mail.gmail.com>
 <7v1umuznuj.fsf@alter.siamese.dyndns.org>
 <20120509215815.GC74366@book.hvoigt.net>
 <7v1umtq9pm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Orgad and Raizel Shaneh <orgads@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu May 10 00:53:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSFlW-0000Qf-8s
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 00:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757353Ab2EIWxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 18:53:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45037 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756028Ab2EIWxh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 18:53:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F82A845D;
	Wed,  9 May 2012 18:53:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bCnSazqpBpcvmYW84TY6N3VPuAE=; b=GZ08BK
	08K/90U0pC3cClaQlYFGFm++R/ogyUjdJiTjPuhTeVtA2ynu4ZrDzMgbguZEq69m
	jnD+fN36V/T/RSAPU43407Por2INhydEAdBkRQusU0QExnmjgRsT1r2H5IH9lYDg
	mp2gscaysrcDLCp7NRYY6IF+dMvqWbjmM0GHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XiRW3Xp3N6NQ2JAv2bNT2ZUpp1DId1SZ
	FLTEKijAtwjVLLr018WP2dyfQZDHrlxxmwd4AWEcG1Or8xhOyoS0Lw4WDTVi3Zp9
	5GqcLKcWSFdlgHlyABIj7jcmk9LRGGPVdJaIWSBbwiIP1X8MuhnQJPelHW6qhrrC
	QgviK+8j4Wc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4326C845C;
	Wed,  9 May 2012 18:53:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C069B845B; Wed,  9 May 2012
 18:53:35 -0400 (EDT)
In-Reply-To: <7v1umtq9pm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 09 May 2012 15:19:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF2CE180-9A29-11E1-8C9E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197527>

Junio C Hamano <gitster@pobox.com> writes:

> Heiko Voigt <hvoigt@hvoigt.net> writes:
> ...
>> I will have a look if I can come up with something that reads the
>> submodules alternate config and uses it. Do you have other config
>> related things in mind that might be missing?
>
> No, I do not, and that is exactly the point.
>
> Making the process that works in the top-level superproject to imitate
> what would happen if the processing happened inside the submodule is what
> invited a bug like this.  Who knows what other discrepancies remain there.
>
> If we forked a separate process,...

Having said all that, we seem to have come too far and it is probably too
painful to revert the approach to contaminate the obj_hash (in object.c),
the set of refs (in refs.c) and the like in the top-level superproject
process with data borrowed from submodules repository [*1*].  So not only
I do not mind seeing you try solving it inside the superproject process, I
would appreciate and encourage the attempt.  One thing to be careful about
is relative paths stored in the objects/info/alternates; they are relative
to the object database of the repository the "alternates" is specified,
not relative to the superproject that happens to contain the submodule.

Thanks.


[Footnote]

*1* This is a wrong approach not only because it will invite this kind of
bug, but also because it will bloat the process working on the
superproject.  When taken alone, either of the superproject or the
submodule repository may be of comfortably workable size, but a single
process that is working on the superproject may ran out of a per-process
resource limit if it is made to also slurp data for the submodules,
especially when working on a project with dozens of submodules.
