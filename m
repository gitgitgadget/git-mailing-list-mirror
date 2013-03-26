From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Composing git repositories
Date: Tue, 26 Mar 2013 09:39:51 -0700
Message-ID: <7vmwtqt8rs.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 17:40:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKWv7-00042j-H2
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 17:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965745Ab3CZQjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 12:39:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32809 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965531Ab3CZQjx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 12:39:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3875DA2F3;
	Tue, 26 Mar 2013 12:39:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6CJU/ZAg8yZJZwI45emJpEGCLR0=; b=kON/Qa
	ZG1VukpKKFfvB4kH7Q5PMjzpQTsBKs9/QiM7XI5qk4ZSdVjwkwZEo5786p/PTHsz
	PUcrS/WVC9Kv4LgU4AeFWPnw+/A8yw8G4D36KBnqwlro8NjAoitf6Tt/sJ83KG5O
	5wQoljsN9ppK6rjmZ9574bLq3OCrXJyMRM6F8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=glJueMhMvbl5TDNUqlHN6evayoCoPvs+
	FLl8CWPk3f/HDMS+KkntCOg/kUJDB3g9738IMPzR4Fgl0db/21OWiH2++GTKG9n3
	8+hrseQP0kvKVAWwETg8n3Op//fdih3Rf3hSFcZf9j8V4wwUC78vK0vmKWQRTQGU
	idcGdxw34pA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D6B0A2F2;
	Tue, 26 Mar 2013 12:39:53 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A52C6A2F1; Tue, 26 Mar 2013
 12:39:52 -0400 (EDT)
In-Reply-To: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 26 Mar 2013 13:26:33 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C88F0072-9633-11E2-B027-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219167>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Apart from the implementation glitches, I don't like the design;
> submodules don't compose well:
>
> 1. There's an inherent asymmetry between the superproject and each of
> the subprojects, because the superproject owns all the object stores.
> Why is it absolutely necessary to relocate the object stores?

Imagine doing "git checkout oldbranch" in the superproject when your
current branch has a submodule A bound to it, but the oldbranch that
is an old version of the superproject did not (yet) have it.

You obviously want the directory A disappear, but you would be
unhappy if you have to lose A/.git and everything in it while doing
so.  If you are lucky, you can re-clone, but you may have your own
changes.

So you have to stash it somewhere.  We could have made it to move
them to $HOME/.safeplace or somewhere totally unrelated to the
superproject.  So in that sense, the repositories are *not* owned by
the superproject in any way.  However, you are working within the
context of the superproject on the submodule after all, and
somewhere under $GIT_DIR/ of the superorject is not too wrong a
place to use as such a safe place.

> 3. The current implementation only allows me to compose with commit
> objects, but what if I want to compose with refs?  ie. What if I want
> to track the tip of the 'master' of a submodule in a superproject?

Look for floating submodules in the list archive.
