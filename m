From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: stop sanitizing config options
Date: Wed, 04 May 2016 11:43:47 -0700
Message-ID: <xmqqzis5hdek.fsf@gitster.mtv.corp.google.com>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
	<cover.1462342213.git.johannes.schindelin@gmx.de>
	<20160504062618.GA9849@sigill.intra.peff.net>
	<20160504074559.GA3077@sigill.intra.peff.net>
	<20160504080047.GA2436@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 04 20:43:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay1m7-0001RE-Ey
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 20:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbcEDSnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 14:43:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750965AbcEDSnv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 14:43:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DDC4F1842E;
	Wed,  4 May 2016 14:43:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R2W2HsyJNdtR1GLoYeoVNbdRFRk=; b=UvFUxD
	VJjATi10bagS4t2x1hMHeKvNOq27/YAFzyforx6sWiTIC5XmnEkIxB6zIB1lunxs
	Nl3Y2BC7+1jR7m6P0nipZ0l8m532nDCesyrVp5+ijmu0QeLgikJrSFgAciSfnunt
	gp7jK8yM8EynVnoLVYgZctOD5zdtmrwQU2eQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=upeGA90tr1gBW+23JV85hUqrie+dQ5C+
	KeUXBPKQO1mWbNNbxoYyavbN8Hp5LB20gZGNrznrNGyIDO9QqeGiYHQk64slXefJ
	7YT5Sswt+BS3npm3njj9A+30xnsnzKUxwwuW3dxD9l0nOtFkUt0zd2Cgnjxi/3X8
	kW0aoO+Vdm4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D2F311842D;
	Wed,  4 May 2016 14:43:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5CBB51842C;
	Wed,  4 May 2016 14:43:49 -0400 (EDT)
In-Reply-To: <20160504080047.GA2436@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 4 May 2016 04:00:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2408B600-1228-11E6-B76D-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293565>

Jeff King <peff@peff.net> writes:

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 3a40d4b..c9d53e1 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -197,9 +197,9 @@ isnumber()
>  # of the settings from GIT_CONFIG_PARAMETERS.
>  sanitize_submodule_env()
>  {
> -	sanitized_config=$(git submodule--helper sanitize-config)
> +	save_config=$GIT_CONFIG_PARAMETERS
>  	clear_local_git_env
> -	GIT_CONFIG_PARAMETERS=$sanitized_config
> +	GIT_CONFIG_PARAMETERS=$save_config
>  	export GIT_CONFIG_PARAMETERS
>  }

This does "clear the obviously per-repository stuff, but add back in
anything that came from -c".  If it is easy to do "add anything that
came from -c, and then clear the obviously per-repository stuff", we
don't even have to say "exporting core.worktree down may hurt; do
not do it then", which may be the best of both worlds?

Or have we decided that even sharing core.worktree may have a valid
use case and it is better not to filter them?
