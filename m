From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] branch: add --unset-upstream option
Date: Tue, 10 Jul 2012 11:02:25 -0700
Message-ID: <7v629vijf2.fsf@alter.siamese.dyndns.org>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
 <1341939181-8962-4-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 20:02:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Soelj-0007jS-OS
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 20:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906Ab2GJSC2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jul 2012 14:02:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59280 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab2GJSC1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jul 2012 14:02:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AAB38C47;
	Tue, 10 Jul 2012 14:02:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BEA2gw7rBNDp
	N5FIyTpMqb/zVeQ=; b=BvTfeXY+b037MNbbKUBh488iv4/zHe6pi0GZVw4u1TWI
	VW2bv/tyksnMFif06LxHYpjiSg/zsxW5tGWRCOzD3DnuwQRiAv9WXAu2DyUxTKbO
	zO09bV+LnZhK9viy1nsUO8oloHKC0SUfgCkzL4F4i47xqvIZEr/iKBB+44mE4/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eMk6KI
	THlvro9n4yglIqr8q1p6v7OqYQbAXrWYxZ/93uEv1oWYC0r+AMQitWefnqf5efg8
	zeCLp7qK7hPdkAQIKqwO2A1ByfNCl3IpFMZTuC0NDWKdV5wjhlQjmFh/NlqSBvS/
	FYZ4/TYgSI0IzCI/TVAC4tuw5cAnoqZSvqnTg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 527488C46;
	Tue, 10 Jul 2012 14:02:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3DD08C45; Tue, 10 Jul 2012
 14:02:26 -0400 (EDT)
In-Reply-To: <1341939181-8962-4-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Tue, 10 Jul 2012 18:53:01
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6861AB5A-CAB9-11E1-B052-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201269>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> We have ways of setting the upstream information, but if we want to
> unset it, we need to resort to modifying the configuration manually.
>
> Teach branch an --unset-upstream option that unsets this information.
>
> ---
>
> create_branch() uses install_branch_config() which may also set
> branch.foo.rebase, so this version might leave some configuration
> laying around.
>
> I wonder if deleting the whole branch.foo section would be better. Ca=
n
> we be sure that nothing else shows up there?

"branch.foo.$unknown" may not be related to upstream at all, so that
will not fly.  Besides, we already have unknown=3Ddescription, no?

If you are removing the branch "foo", it would make sense, though.

> +	} else if (unset_upstream) {
> +		struct branch *branch =3D branch_get(argv[0]);
> +		struct strbuf buf =3D STRBUF_INIT;
> +
> +		strbuf_addf(&buf, "branch.%s.remote", branch->name);
> +		git_config_set_multivar(buf.buf, NULL, NULL, 1);

This part makes sense, as "--set-upstream" is about setting the
value of branch.foo.remote to 'origin' or whatever.

> +		strbuf_reset(&buf);
> +		strbuf_addf(&buf, "branch.%s.merge", branch->name);
> +		git_config_set_multivar(buf.buf, NULL, NULL, 1);

This also makes sense because "branch.foo.merge" names a ref in the
context of the remote.  A branch may have integrated with the "dev"
branch at "origin" repository; when it is modified to slurp changes
from "central" repository from now on, there is nothing that says
that the branch "dev" at this different remote corresponds to the
"dev" branch at the original "origin" repository (such a branch may
not even exist at the new "central" repository).  There is no point
leaving the "branch.foo.merge" configuration behind when you unset
the upstream information.



> +		strbuf_release(&buf);
>  	} else if (argc > 0 && argc <=3D 2) {
>  		struct branch *branch =3D branch_get(argv[0]);
>  		const char *old_upstream =3D NULL;
