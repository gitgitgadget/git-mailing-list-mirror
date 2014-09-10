From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] Make sure that index-pack --strict fails upon invalid tag objects
Date: Wed, 10 Sep 2014 14:54:12 -0700
Message-ID: <xmqqoaunf8fv.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
	<cover.1410356761.git.johannes.schindelin@gmx.de>
	<alpine.DEB.1.00.1409101553140.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 10 23:54:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRpqN-0006Xc-H1
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 23:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbaIJVyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 17:54:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54584 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668AbaIJVyP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 17:54:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A792439580;
	Wed, 10 Sep 2014 17:54:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UC5+FJ3msA15Qf+s0qVsAXVCorg=; b=h/PtX3
	NDlniMkhuIDctwEqfarzyYgcfArRy+VeLqtQ4P3zH+WWO3p7IfelEWd+xzDaGhFG
	GwPqxMlq299zHpNsepBN1axu7P2aMlT/FPXTg8QU1L3eIgo93ODqD/eQ71BgswCt
	CKt4swAnw6A9ug9ILJul3PVhFLlsC+suv5N5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eKHOD7v5mfne4P2fnrQ0cKDIElW66C/6
	BykTfrJu8cwgA/+8a0r9nY00Mhd7PSDD2wcwUdv1JwgYYIxb1F4N9F/9JPfbBpnA
	5k9uRT51IzYs3TDCqY/EL4EQVriUecInciVs/beZmwG+S4Us2RB/l65G57PAC7z2
	bFP1R0HMZr0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B78B3957F;
	Wed, 10 Sep 2014 17:54:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 199D53957E;
	Wed, 10 Sep 2014 17:54:14 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1409101553140.990@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Wed, 10 Sep 2014 15:53:15 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 01058700-3935-11E4-8A64-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256770>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +test_expect_success 'index-pack --strict fails upon invalid tag' '
> +    sha=$(git rev-parse HEAD) &&
> +    cat >wrong-tag <<EOF &&
> +object $sha
> +type commit
> +tag guten tag
> +
> +This is an invalid tag.
> +EOF

Missing tagger is merely a warning event (thanks for a good comment
in the code, by the way, to explain the reason why it is so is
because of annotated tags in earlier versions of Git).  tag names
that are not ref-formed is only a warning event in this reroll.

So this is not really "invalid" in the sense that index-pack can
notice it as an error, no?

> +
> +    tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
> +    pack1=$(echo $tag | git pack-objects tag-test) &&
> +    echo remove tag object &&
> +    thirtyeight=${tag#??} &&
> +    rm -f .git/objects/${tag%$thirtyeight}/$thirtyeight &&
> +    test_must_fail git index-pack --strict tag-test-${pack1}.pack 2> err &&

I had to drop "must fail" from this one (will amend the "SQUASH???"
again).

Perhaps you would want to add a real error, e.g. a tag with tagger
whose ident does not pass fsck-ident or something?

> +    grep "invalid .tag. name" err
> +'
> +
>  test_done
