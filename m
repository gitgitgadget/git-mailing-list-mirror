From: Junio C Hamano <gitster@pobox.com>
Subject: Re: optimising a push by fetching objects from nearby repos
Date: Sat, 10 May 2014 14:02:16 -0700
Message-ID: <xmqqtx8xuz3b.fsf@gitster.dls.corp.google.com>
References: <536E2C19.3000202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	milki <milki@rescomp.berkeley.edu>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 10 23:02:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjEPZ-0000Oa-UT
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 23:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757823AbaEJVCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 17:02:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61459 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757817AbaEJVCV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2014 17:02:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C1AD315191;
	Sat, 10 May 2014 17:02:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PUxwZaiZ7LRon8zO/xypuqybKxg=; b=eneaqI
	p/cl1bjvr5lpg9iC+EhWZ9Z4cMt19O2M+fYPguxwnujQ0Nqy+3SajxSI4RS3OknV
	Qsb5Wt1t8HzYZzezKyNexN6Sl31XxiVOZVszpvCBCtdBAgEO/b63FYhwiT/uLEYI
	wdSQRJmVbrNYy/6lA49fRwDXMVHRDT50UHVI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FD/n7YhDvsXmnGasY2U1UY0xIWjN/Fi3
	h5m/Ch6ebHPVHeVIb0W8PimOzaLsBM0ynRVmARaLSvbUe2bS1YU3Cliz0WVj7Deo
	7hNYf0jqK3epI89KSLts1xl6+wcIV4QzMYw82ExY776RkTaD/ORDOb+oKPfBVkHo
	B/SNtzIVKoQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B869B1518F;
	Sat, 10 May 2014 17:02:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 28D0B15186;
	Sat, 10 May 2014 17:02:18 -0400 (EDT)
In-Reply-To: <536E2C19.3000202@gmail.com> (Sitaram Chamarty's message of "Sat,
	10 May 2014 19:09:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5EF82594-D886-11E3-B47B-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248666>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> Is there a trick to optimising a push by telling the receiver to pick up
> missing objects from some other repo on its own server, to cut down even
> more on network traffic?
>
> So, hypothetically,
>
>     git push user@host:repo1 --look-for-objects-in=repo2
>
> I'm aware of the alternates mechanism, but that makes the dependency on
> the other repo sort-of permanent.

In the direction of fetching, this may be give a good starting point.

    http://thread.gmane.org/gmane.comp.version-control.git/243918/focus=245397

In the direction of pushing, theoretically you could:

 - define a new capability "look-for-objects-in" to pass the name of
   the repository from "git push" to the "receive-pack";

 - have "receive-pack" temporarily borrow from the named repository
   (if the policy on the server side allows it), and accept the push;

 - repack in order to dissociate the receiving repository from the
   other repository it temporarily borrowed from.

which would be the natural inverse of the approach suggested in the
"Can I borrow just temporarily while cloning?" thread.

But I haven't thought things through with respect to what else need
to be modified to make sure this does not have adverse interaction
with simultaneous pushes into the same repository, which would make
it harder to solve for "receive-pack" than for "clone/fetch".
