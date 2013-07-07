From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] name-rev: strip trailing ^0 in when --name-only
Date: Sun, 07 Jul 2013 15:03:27 -0700
Message-ID: <7vtxk62fkg.fsf@alter.siamese.dyndns.org>
References: <1373200996-9753-1-git-send-email-artagnon@gmail.com>
	<1373200996-9753-3-git-send-email-artagnon@gmail.com>
	<7vd2qu44mm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 00:03:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvx3P-0006or-P5
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 00:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234Ab3GGWDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 18:03:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33752 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753171Ab3GGWDa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 18:03:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EB502F712;
	Sun,  7 Jul 2013 22:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z/ZgFR1t7S8ty6q4NVPFObXM5kQ=; b=W8EwNw
	0BgDgrHU5QOQbZq5yEGlXIQ6IYGqagE8wHM3s3FefTYYzQfu2mrwKxT3a0sk81Ed
	+cYo9st4PVzmvhMPHrxCjcDYlO9ERiK1bLJH4gkldJA5cnaDGtgDm6I8KimEKzcO
	ivTG5CV3acjZIot5PaepkOS3++hKWrEZ+jOUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UKlODikpXT1+bToE3Cu5dyn/NCFldxDG
	KzptD6IsR5ylrxpebWYiCsZQGnX+j3IEEG3ohYdVdGjqq+uqPDNXunDaXFYZROil
	ydgvbNK78XshW0ptb73Ox8hzcISMyn1F273pQS4viEyYJhFVN/0jMTQrPvltnOtX
	cgjI9yR4eU0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 652CA2F711;
	Sun,  7 Jul 2013 22:03:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C298A2F70F;
	Sun,  7 Jul 2013 22:03:28 +0000 (UTC)
In-Reply-To: <7vd2qu44mm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 07 Jul 2013 11:16:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E045544-E751-11E2-9E0B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229807>

Junio C Hamano <gitster@pobox.com> writes:

> WRT "describe --contains", I do agree that both of these
>
>     $ git describe $(git rev-parse v1.8.3^0)
>     $ git describe --contains $(git rev-parse v1.8.3^0)
>         
> should just say "v1.8.3" without ~0/^0/~0~0~0 etc. and the last
> example you showed will be improved by dropping ^0 at the end.
>
> However.
>
> I was a bit bothered by the description talking _only_ about
> describe, but the actual change is to modify what name-rev gives its
> direct users as well.  And that made me realize that the patch
> itself has an undesirable side effect.
>
> "describe" is _only_ about commit history graph, so in its context
> v1.8.3 means the same thing as v1.8.3^0 (we never want to get a tag;
> we always want a commit).  But I do not think "name-rev" is limited
> to commits, in the sense that you would see this:
>
>     $ git rev-parse v1.8.3 v1.8.3^0 | git name-rev --stdin
>     8af06057d0c31a24e8737ae846ac2e116e8bafb9
>     edca4152560522a431a51fc0a06147fc680b5b18 (tags/v1.8.3^0)
>
> The second object is _not_ v1.8.3 but is v1.8.3^0 in the context of
> name-rev, whose purpose is to give you a string you can feed
> "rev-parse" and get the object name back.  "rev-parse v1.8.3" will
> not give you the commit object name, so you need to keep "^0".

Well, the code in "name-rev" other than --stdin mode is already
broken (and the documentation half-describes this breakage) in that
it describes the peeled commit and rejects anything other than
commit objects.  The reason I say "half-describes" is that it only
says that the command takes "commit-ish" and leaves it unclear if it
comes up with a name for the tag itself that happens to be
commit-ish, or it does so for the commit that is referred by the
tag.

I'll send out a WIP to fix that, and also help the topic to strip
unnecessary "^0" suffix when name-rev is run as an implementation
detail of "describe" shortly.
