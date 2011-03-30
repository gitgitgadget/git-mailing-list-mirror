From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] remote: separate the concept of push and fetch
 mirrors
Date: Wed, 30 Mar 2011 13:45:59 -0700
Message-ID: <7vhbakmj5k.fsf@alter.siamese.dyndns.org>
References: <20110330195139.GA814@sigill.intra.peff.net>
 <20110330195318.GB30624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: chris <jugg@hotmail.com>, Jan Hudec <bulb@ucw.cz>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 22:46:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q52HT-0002z6-Qb
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 22:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331Ab1C3UqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 16:46:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389Ab1C3UqN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 16:46:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1F7674293;
	Wed, 30 Mar 2011 16:47:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6Cug2J4S+r1n0k1q/Cd0DsSxMXE=; b=HkfHJy
	SEvBXKLXjGJmKrVt3+qKyicuwfXZVFpnjtZsaB3zRfKUKKA2tptyN25hfkO2/ZBU
	Cif5WpZ49e+Je9zGhV0rY2CnT9xxsoJ91aRcySYdhcifQ7gSW2UdAQJ5X0Jn43W1
	n+Esq9vk1okgbA4MiMmQq7pb2zrxLrrQEg/yc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=we8wfzSwdOBPRzlvZ2i6RYRSvNh5rvFb
	nPTVMzxAnoA8nsiOLnyCIv+QIg00cVcTIrD3wYhbr6ENeWlHZNykjY5ogJTDkvmo
	sZseJ8d3o4bEMKY8YE2qRThDrlZoXwXF96ESZc94SuKw594u+LvBOOZf5FnHgdlD
	t6Vg5KqyoKY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CFC684292;
	Wed, 30 Mar 2011 16:47:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 481BA428E; Wed, 30 Mar 2011
 16:47:48 -0400 (EDT)
In-Reply-To: <20110330195318.GB30624@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 30 Mar 2011 15:53:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC0F7A56-5B0E-11E0-8EBB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170423>

Jeff King <peff@peff.net> writes:

> git-remote currently has one option, "--mirror", which sets
> up mirror configuration which can be used for either
> fetching or pushing. It looks like this:
>
>   [remote "mirror"]
>     url = wherever
>     fetch = +refs/*:refs/*
>     mirror = true
>
> However, a remote like this can be dangerous and confusing.

When --mirror was introduced at 3894439 (Teach "git remote" a mirror mode,
2007-09-02), it was only about fetching into a bare repository from
another repository and there wasn't any confusion.

I knew about this potential confusion when we applied 84bb2df (Add a
remote.*.mirror configuration option, 2008-04-17), but chose to be lazy
and ignored the issue, thinking that users are intelligent enough not to
mix these obviously incompatible modes of operation.  If a repository is a
mirror to fetch from somebody else, you wouldn't develop in it in the
first place, and you would definitely not push it back to where you are
mirroring from.  If a repository is mirrored into somewhere else to
publish your work in there, you wouldn't be fetching back from there to
obliterate your work.

Being explicit like your series does is much safer than relying on "common
sense".

I briefly wondered if this affects one use case where you want to
configure a bare repository at your firewall boundary as a relay that
mirrors an external public repository of somebody else by fetching and
then publishes that to a repository internal to your network by pushing,
but in that case you would have two remotes (the external --mirror=fetch
one, and the internal --mirror=push one) that are separate, so it is not
an issue.

Thanks for cleaning up the two-year old mess.
