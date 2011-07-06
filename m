From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 3/4] ref namespaces: Support remote repositories via
 upload-pack and receive-pack
Date: Wed, 06 Jul 2011 11:55:36 -0700
Message-ID: <7vy60bkzmf.fsf@alter.siamese.dyndns.org>
References: <cover.1309888001.git.josh@joshtriplett.org>
 <fff78c90d7f9deb0a8294fe3158ab0285e1610ff.1309888001.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 20:55:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeXGC-00048t-UQ
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 20:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417Ab1GFSzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 14:55:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749Ab1GFSzj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 14:55:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 70B3F596C;
	Wed,  6 Jul 2011 14:55:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=18lTD/rK/1QJ7DAL2HBngIKq40o=; b=bSDYXaehOUVjw6jvtSG3
	AQ4kYAFXRdT2GCLm3+dtljvwvZxfQLSNSQrInS0vIkSiUNzxvRjwR/PNe7YEZcFk
	oPQfX/YFyTK/XTzhKT5o3rKu3P63fQHv5vc3AwjFgULjrpnWFj6Dbf9gmybRp3d/
	JGTeNt+hKgUuVnfhjYyCst4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=gDByOZjwlFZgkPdwkmuYPPiatyEVz4MF9yfo0swa0H9uYg
	oTUN2vHs5NLTvPXq42r/7rY4lFYBhKcVmTurH0yQPMZqw/PRhyouRt5/ftvHtF1A
	3tnZZL3vs1r9IbCvkkclr6uPKsicdGKKJ8wQ/RkbsRy+yvCfBXt+njmqb9Sxo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 67481596B;
	Wed,  6 Jul 2011 14:55:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 962A45967; Wed,  6 Jul 2011
 14:55:37 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 898A908E-A801-11E0-A5B0-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176724>

Josh Triplett <josh@joshtriplett.org> writes:

> Change upload-pack and receive-pack to use the namespace-prefixed refs
> when working with the repository, and use the unprefixed refs when
> talking to the client, maintaining the masquerade.  This allows
> clone, pull, fetch, and push to work with a suitably configured
> GIT_NAMESPACE.
>
> With appropriate configuration, this also allows http-backend to expose
> namespaces as multiple repositories with different paths.  This only
> requires setting GIT_NAMESPACE, which http-backend passes through to
> upload-pack and receive-pack.
>
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Jamey Sharp <jamey@minilop.net>
> ---
>  builtin/receive-pack.c |   37 +++++++++++++++++++++++++++++++------
>  upload-pack.c          |   15 ++++++++-------
>  2 files changed, 39 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index e1a687a..2d36378 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -120,9 +120,17 @@ static int show_ref(const char *path, const unsigned char *sha1, int flag, void
>  	return 0;
>  }
>  
> +static int show_ref_cb(const char *path, const unsigned char *sha1, int flag, void *cb_data)
> +{
> +	path = strip_namespace(path);
> +	if (!path)
> +		path = ".have";
> +	return show_ref(path, sha1, flag, cb_data);

At the first glance, this felt somewhat unoptimal as it forbids us from
stuffing fake "ref" entries other than ".have" via the add_extra_ref()
interface, and I wondered if it would make sense to do something like this
instead:

	const char *ns_path = strip_namespace(path);
        if (!ns_path)
        	ns_path = path;
	return show_ref(ns_path, sha1, flag, cb_data);

But that is flawed, and I think your patch does the right thing.  The
justification is a bit subtle [*1*] and I think it needs to be explained
in a comment around here, not just in the 0/4 cover letter message.

Thanks.

[Footnote]

*1* If this callback was called for a genuine ".have" that is there only
to tell the other side that the history leading to the commit needs not to
be sent to us, we want to send it as ".have". On the other hand, if this
callback were called for a real ref that is outside the current scope, we
want to tell the other side that it is not something they can update but
we still also want to tell the other side that the history leading to the
commit needs not to be sent to us.  It is the _right_ thing to do to
demotes refs outside the current scope as something that the pusher can
use to reduce network traffic yet something that the cannot update by
using the existing ".have" mechanism.
