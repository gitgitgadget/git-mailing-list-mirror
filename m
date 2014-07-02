From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Race condition in git push --mirror can cause silent ref rewinding
Date: Wed, 02 Jul 2014 15:20:08 -0700
Message-ID: <xmqqfvijflnr.fsf@gitster.dls.corp.google.com>
References: <53B47535.3020101@chmrr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Thu Jul 03 00:20:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2St4-0000k9-Mg
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 00:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbaGBWUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 18:20:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63578 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212AbaGBWUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 18:20:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6793323557;
	Wed,  2 Jul 2014 18:20:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yu+YCAN1DtsQhHQmFgDNnlNn3Uk=; b=C2KvC/
	l5covQz/o31SfvBuCtR9ZdkrWmKofQ1Yb6slwsVG0XoeDyVW2HVcT7jzSDiO2BUL
	hjn8rW6cugBJ5fKZyrTSD19kcIrtb0LZyOGhFyVUlmDNS+aUkPl+e7XYvoWQ+WxH
	g/1fZMvG68mowEsTZR7v1jFRKRt4IiAKDTV2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bknd26fr/HrAJJjzD2E+PoIPqla02xzK
	SdyzP/yyLidyUfqP5p6TuO75bskqbP6tZ7LuwSA6nTOrwG2DGUP4aV6yeRS0Qc95
	7LvKr+o2F4fUKbC6r2tnmvDs47Y9YrQEsAGqs8x50NQW8qBtC0T5QDeeTXsHvn/9
	vbaI8yV/2gQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B2D923556;
	Wed,  2 Jul 2014 18:20:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 49BEF23549;
	Wed,  2 Jul 2014 18:19:59 -0400 (EDT)
In-Reply-To: <53B47535.3020101@chmrr.net> (Alex Vandiver's message of "Wed, 02
	Jul 2014 17:10:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 011D3DDA-0237-11E4-ADF0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252845>

Alex Vandiver <alex@chmrr.net> writes:

>     [remote "github"]
>         url = git@github.com:bestpractical/rt.git
>         fetch = +refs/*:refs/*
>         mirror = yes

"git push github master^:master" must stay a usable way to update
the published repository to an arbitrary commit, so "if set to
mirror, do not pretend that a fetch in reverse has happened during
'git push'" will not be a solution to this issue.

Perhaps removing remote.github.fetch would be one sane way forward.
Otherwise, even if your "git push" does not pretend to immediately
fetch from there (i.e. even if the reported behaviour was a bug,
without doing anything to trigger it) somebody running "git fetch"
in this repository can destroy what other person pushes into this
repository at the same time exactly the same way, I would think.
