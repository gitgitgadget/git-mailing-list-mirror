From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: support atomic operation with --separate-git-dir
Date: Sat, 05 Jan 2013 22:43:35 -0800
Message-ID: <7vfw2eq0a0.fsf@alter.siamese.dyndns.org>
References: <50E74145.4020701@gmail.com>
 <7vzk0osjli.fsf@alter.siamese.dyndns.org> <50E83224.2070701@web.de>
 <50E83DAE.1080500@web.de> <50E88A40.9010904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 06 07:44:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trjxh-0002mT-32
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974Ab3AFGnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 01:43:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38834 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab3AFGni (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:43:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEC1E6EA4;
	Sun,  6 Jan 2013 01:43:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZR17rNdLzuLj1tm/tw19cKbnJR8=; b=L3nBWR
	k3jR5VCKm3OgerSxf+VRiPtpw0zzk/ZlZ3tBoAEBPy+hEY0VNZd9KhVeceYm/hAU
	jpKWMKyRlkzxLyiSmb5iLT2UieAd/1vNUsL8msfpTuIbmtGt6wpAKOH7i9CtEGON
	J2P0cR7M+L7S27zJkbTs89bpWWnlEnVtPqz08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nv4pwwnr3XG/Nm1vD2jwtWwkuDEJ9xZp
	RZoh6mYuak63UyZCdN8WFe1Venm9bvwOIH/6yNk9NrlfslRyP8sWMCvQhawED6U7
	bOMAulanxKB5L1DlZh9dSbk3N2kAXTAUlDxAdFbJ1B56mGJpyJTo4N7QmeQYF6aS
	raRaY+9oSeI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B02A46EA3;
	Sun,  6 Jan 2013 01:43:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 328EA6EA1; Sun,  6 Jan 2013
 01:43:37 -0500 (EST)
In-Reply-To: <50E88A40.9010904@web.de> (Jens Lehmann's message of "Sat, 05
 Jan 2013 21:17:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66184F66-57CC-11E2-8F42-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212778>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Since b57fb80a7d (init, clone: support --separate-git-dir for .git file)
> git clone supports the --separate-git-dir option to create the git dir
> outside the work tree. But when that option is used, the git dir won't be
> deleted in case the clone fails like it would be without this option. This
> makes clone lose its atomicity as in case of a failure a partly set up git
> dir is left behind. A real world example where this leads to problems is
> when "git submodule update" fails to clone a submodule and later calls to
> "git submodule update" stumble over the partially set up git dir and try
> to revive the submodule from there, which then fails with a not very user
> friendly error message.
>
> Fix that by updating the junk_git_dir variable (used to remember if and
> what git dir should be removed in case of failure) to the new value given
> with the --seperate-git-dir option. Also add a test for this to t5600 (and
> while at it fix the former last test to not cd into a directory to test
> for its existence but use "test -d" instead).
>
> Reported-by: Manlio Perillo <manlio.perillo@gmail.com>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---

I hate to see that git_link is not an argument to init_db() but is a
file-scope static in init-db.c to be used to communicate between
set_git_dir_init() and init_db(), but that would be a separate thing
to be cleaned up, I guess.

How is the file that points at the real git dir removed with this
fix, by the way?

Thanks.
