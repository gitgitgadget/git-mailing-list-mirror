From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-new-workdir: support submodules
Date: Tue, 23 Dec 2014 11:08:48 -0800
Message-ID: <xmqqzjae18vz.fsf@gitster.dls.corp.google.com>
References: <1419360673.196271.13944.nullmailer@meta>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Craig Silverstein <csilvers.mail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 20:09:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3UpL-0005mT-CT
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 20:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245AbaLWTIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 14:08:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750725AbaLWTIu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 14:08:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F3C0529814;
	Tue, 23 Dec 2014 14:08:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v1l/TYRLidWgdzzmQx6c60BgGcg=; b=dNxgZe
	5t134rK0FgRHiskFaq0osPrB1/sO1z8u+1r2CAvihvsQ6gxubD0yWBVcdLh6g3Ka
	G82/DCRS691L3nqxzs+IEEgYTdfbNvEqxColumlEFfaa/Yj/D+R8vQ/QaelrGKDE
	soau4WczH5wJB6dfhie0Mkf61NJmlTihTrpNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TgHd/j+PHa2Cy+4C2CSliaKUI1A58/aF
	29F3FGVbBkGpUcHJN2+iSx7pp+DfbSpElHjuXIUr18L0Ks+1o7J3/sUMRoHaSWcM
	a25f9Os4gxvLruvpAY3YEtqNPHb418xKBy2pyBoHuCpqTHer0s8vRLEEM38OBuww
	LbY7R5qGh8I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA2E129812;
	Tue, 23 Dec 2014 14:08:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6DB2C29811;
	Tue, 23 Dec 2014 14:08:49 -0500 (EST)
In-Reply-To: <1419360673.196271.13944.nullmailer@meta> (Craig Silverstein's
	message of "Mon, 22 Dec 2014 18:10:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 206D9152-8AD7-11E4-BC67-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261767>

Craig Silverstein <csilvers.mail@gmail.com> writes:

> The basic problem with submodules, from git-new-workdir's point of
> view, is that instead of having a .git directory, they have a .git
> file with contents `gitdir: <some other path>`.  This is a problem
> because the submodule's config file has an entry like `worktree =
> ../../../khan-exercises` which is relative to "<some other path>"
> rather than to "submodule_dir/.git".
>
> As a result, if we want the new workdir to work properly, it needs to
> keep the same directory structure as the original repository: it
> should also contain a .git file with a 'gitdir', and the actual .git
> contents should be in the place mentioned therein.

Hmmmm, does that mean that the submodule S in the original
repository O's working tree and its checkout in the secondary
working tree W created from O using git-new-workdir share the same
repository location?  More specifically:

	O/.git/                 - original repository
        O/.git/index            - worktree state in O
        O/S                     - submodule S's checkout in O
        O/S/.git                - a gitfile pointing to O/.git/modules/S
	O/.git/modules/S        - submodule S's repository contents
        O/.git/modules/S/config - submodule S's config

	W/.git/                 - secondary working tree
        W/.git/config           - symlink to O/.git/config
        W/.git/index            - worktree state in W (independent of O)
	W/S                     - submodule S's checkout in W (independent of O)
	W/S/.git                - a gitfile pointing to O/.git/modules/S

Doesn't a submodule checkout keep some state tied to the working
tree in its repository configuration file?  Wouldn't this change
introduce problems by sharing O/.git/modules/S/config between the
two checkouts?
