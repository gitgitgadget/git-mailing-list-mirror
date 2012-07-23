From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Solve git-submodule issues with detached work trees
Date: Mon, 23 Jul 2012 11:21:27 -0700
Message-ID: <7v7gtumj88.fsf@alter.siamese.dyndns.org>
References: <CAHCkQtNfz8Kbn810LgXEQ_rkyk4qn5amGgHQsv2uR6H38sTSrg@mail.gmail.com>
 <7vsjcjnjvj.fsf@alter.siamese.dyndns.org> <500D8C30.9010807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>,
	git@vger.kernel.org,
	Richard Hartmann <richih.mailinglist@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:21:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNGC-000274-7z
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab2GWSVb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jul 2012 14:21:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45389 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754228Ab2GWSVa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2012 14:21:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70BC08107;
	Mon, 23 Jul 2012 14:21:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jFjc2fazfOvI
	7X7+qTyz1Gi6UpU=; b=YY7PdSyV/pipQiD+FwMLRs3WCs+SO4dEe/Wmh6rFzxm8
	GzBnUVs7WLv12DmuIzyo0N523ne1pLdpE9piu+H7CXx7XRIHD78FmiKi5bm+/kKr
	hycXqYX1Re5LBDrsgrmiXJNgXrzPVJyZ5I0HFlKrdz7biAq8bDAE28/U/g/JjtY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EElcAm
	vYyxBHVYjRXBYDW7awdfhM9i1Pro6KoOOkaDNXNx8iLzYSKeLPNu8dbemPpBMkNh
	TMuxhsNBpqEq2MccV/3tXU22OA2qgGWaurzOEI4w46KKJB4oQ1eyTVG4qRtQ0rhZ
	ryvb6dBm+RkScLo6LdiS4kSdv5usSAiKySqi0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DF318106;
	Mon, 23 Jul 2012 14:21:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B843C8105; Mon, 23 Jul 2012
 14:21:28 -0400 (EDT)
In-Reply-To: <500D8C30.9010807@web.de> (Jens Lehmann's message of "Mon, 23
 Jul 2012 19:38:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 387C52A2-D4F3-11E1-9D67-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201947>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 23.07.2012 07:09, schrieb Junio C Hamano:
>> Daniel Gra=C3=B1a <dangra@gmail.com> writes:
>>=20
>>> A common way to track dotfiles with git is using GIT_DIR and
>>> GIT_WORK_TREE to move repository out of ~/.git with something like:
>>>
>>>     git init --bare ~/.dotfiles
>>>     alias dotfiles=3D"GIT_DIR=3D~/.dotfiles GIT_WORK_TREE=3D~ git"
>>>
>>>     dotfiles add ~/.bashrc
>>>     dotfiles commit -a -m "add my bashrc"
>>>     ...
>>>
>>> but git-submodule complains when trying to add submodules:
>>>
>>>     dotfiles submodule add http://path.to/submodule
>>>     fatal: working tree '/home/user' already exists.
>>>
>>>     git --git-dir ~/.dotfiles submodule add http://path.to/submodul=
e
>>>     fatal: /usr/lib/git-core/git-submodule cannot be used without a
>>> working tree.
>>>
>>> Signed-off-by: Daniel Gra=C3=B1a <dangra@gmail.com>
>>> ---
>>=20
>> I think this is in line with what we discussed earlier on list when
>> the interaction between GIT_DIR/GIT_WORK_TREE and submodules came up
>> the last time.  Jens?
>
> Yes, I think this is the only way submodules in current git can
> be used with the GIT_DIR and GIT_WORK_TREE environment variables:
> set them when adding or initializing the submodule and always use
> the same settings when accessing them later. Daniel's dotfile
> alias achieves exactly that, so his fix looks good. But I agree
> the tests should be improved as you already pointed out.

Thanks for a quick review.  The "the only way ... in current git can
be used" part makes it sound as if it is a somewhat suboptimal ugly
workaround, but if that is what you meant, what is a more optimal
and less ugly way that you have in mind?

If you want to move .git out of way with GIT_DIR and if you want to
sit somewhere different from the top of your working tree, you must
use GIT_WORK_TREE (or core.worktree) to tell where the top resides,
whether your project use submodules or not, so I do not think it is
an ugly workaround but is the one true way to use such a dismembered
layout, I would think.
