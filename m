From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/18] signed push: final protocol update
Date: Fri, 22 Aug 2014 10:59:56 -0700
Message-ID: <xmqqa96wpfqb.fsf@gitster.dls.corp.google.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	<1408485987-3590-19-git-send-email-gitster@pobox.com>
	<CAJo=hJuToRQDTkccV9BfVbs1YnjCrr2iPrG-HmTbJ=ds4r6MzA@mail.gmail.com>
	<xmqqvbplpg2s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 20:00:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKt8Q-0006x9-8w
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 20:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932783AbaHVSAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 14:00:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52769 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932410AbaHVSAL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 14:00:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B1657323E8;
	Fri, 22 Aug 2014 14:00:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YVwaZEIobHWozSsaCmEH0vzHpbA=; b=SN8qPh
	Su7F94pj8u+KH6ZIukcFDDe0mKcN/Kp42uAgrZUEsTHrfcH+FhR3NmoqvX5aCqs6
	bcLHitQov7hWO8hEVnuujHqTn/ag2Iu/QCtUe9yZqbhnnGe3zh++06PNpsVtglMW
	OM688OnUu+m/pafexGbG+E09fteCHYZtzEn8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g4t6bAPmvxtENFgEtbF/MOBtySLlNMIk
	/PTvYVveUDKDvUhe2spGp0Fuv7oxVNNoUahv3C992S8v70feuUH6qu9CaxzW5PsK
	CVRimaFQi0JnxIbARKrRFLohrjRDFWlFGAilQhb75apcV/CVjJ7bMf9PDxec/wPH
	lP0AKUimfko=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9F35F323E7;
	Fri, 22 Aug 2014 14:00:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D4C41323CD;
	Fri, 22 Aug 2014 13:59:57 -0400 (EDT)
In-Reply-To: <xmqqvbplpg2s.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 21 Aug 2014 16:40:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 210144FE-2A26-11E4-87DC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255686>

Junio C Hamano <gitster@pobox.com> writes:

> There are a few gotchas I can certainly use help on, especially from
> a smart-http expert ;-).
>
>  * "pushed-to <URL>" will identify the site and the repository, so
>    you cannot MITM my push to an experimental server and replay it
>    against the authoritative server.
>
>    However, the receiving end may not even know what name its users
>    call the repository being pushed into.  Obviously gethostname()
>    may not be what the pusher called us, and getcwd() may not match
>    the repository name without leading "/var/repos/shard3/" path
>    components stripped, for example.
>
>    I am not sure if we even have the necessary information at
>    send-pack.c::send_pack() level, where it already has an
>    established connection to the server (hence it does not need to
>    know to whom it is talking to).
>
>
>  * The receiving end will issue "push-cert=<nonce>" in its initial
>    capability advertisement, and this <nonce> will be given on the
>    PUSH_CERT_NONCE environment to the pre/post-receive hooks, to
>    allow the "nonce <nonce>" header in the signed certificate to be
>    checked against it.  You cannot capture my an earlier push to the
>    authoritative server and replay it later.
>
>    That would all work well within a single receive-pack process,
>    but with "stateless" RPC, it is unclear to me how we should
>    arrange the <nonce> the initial instance of receive-pack placed
>    on its capability advertisement to be securely passed to the
>    instance of receive-pack that actually receives the push
>    certificate.

A good <nonce> may be something like taking the SHA-1 hash of the
concatenation of the sitename, repo-path and the timestamp when the
receive-pack generated the <nonce>.  Replaying a push certificate
for a push to a repository at a site that gives such a <nonce> can
succeed at the same chance of finding a SHA-1 collision [*1*].  As
long as you exercise good hygiene and only push to repositories that
give such <nonce>, we can do without checking "pushed-to" that says
where the push went.

So "nonce <nonce>" is the only thing that is necessary to make them
impossible to replay.  For auditing purposes, "pushed-to <URL>" that
records the repository the pusher intended to push to may help but
probably not necessary [*2*].


[Footnote]

*1* And the old-sha1s recorded in the certificate has to match what
    the repository being attacked currently has; otherwise the push
    will fail with "the ref moved while you were trying to push".

*2* When auditing the history for a repository at a site, the
    certificate the auditors examine would be the ones accumulated
    at that site for the repository, so we would implicitly know the
    value for <URL> already.
