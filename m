From: Junio C Hamano <gitster@pobox.com>
Subject: Re: breakage in revision traversal with pathspec
Date: Thu, 19 Sep 2013 21:58:23 -0700
Message-ID: <xmqqioxwqec0.fsf@gitster.dls.corp.google.com>
References: <xmqqy574y4pz.fsf@gitster.dls.corp.google.com>
	<522F8ED2.9000408@bracey.fi>
	<xmqq38pcwc21.fsf@gitster.dls.corp.google.com>
	<5230AD23.2050009@bracey.fi> <20130911182444.GD4326@google.com>
	<5230C6E3.3080406@bracey.fi>
	<xmqqa9jjrrfb.fsf@gitster.dls.corp.google.com>
	<xmqq38p0sdeb.fsf@gitster.dls.corp.google.com>
	<20130920033541.GC15101@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Bracey <kevin@bracey.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 20 06:58:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMsnX-0005j4-BZ
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 06:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472Ab3ITE61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 00:58:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63191 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808Ab3ITE60 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 00:58:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B93613BD1F;
	Fri, 20 Sep 2013 04:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i30KeUKBldYLGFgKxe/1zOpTq2E=; b=S5t55K
	A/71iEjm9AeF2yCQIjoNnF2BSH9V2F+A7LjsybynylJCAyATbmrNF88RlsmFSvAh
	II+4Sjc3ky2P1DZZJc0d1WvczQ7hjYMusOgB796vIYX5ImN4oLs01CsQcAUekeJ6
	yeDqCAwvYUipVWCnJ16LeSrPsomPTjIAYdwy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aFJqhjM0BtWSHWvRzo235OQaqFyj3ai1
	hwPRw8tTbeuzzIdhV6HRusJ0TETlHo/n3zijewCpt16JtUMmQzdDFyQUoTSxZMdQ
	zhFc97la9G9WcL8ZtrgJx0fOkrD3pj8/6PHcgxR8kqKMZbmc8OyuVAyla8kD+pru
	MT3WIya6jqo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABA903BD1E;
	Fri, 20 Sep 2013 04:58:25 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C83E3BD18;
	Fri, 20 Sep 2013 04:58:25 +0000 (UTC)
In-Reply-To: <20130920033541.GC15101@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 19 Sep 2013 23:35:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 47F31A3E-21B1-11E3-A5C5-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235057>

Jeff King <peff@peff.net> writes:

> One question, though. With your patch, if I do "tag1..tag2", I get both
> the tags and the peeled commits in the pending object list. Whereas with
> "^tag1 tag2", we put only the tags into the list, and we expect the
> traversal machinery to peel them later. I cannot off-hand think of a
> reason this difference should be a problem, but I am wondering if there
> is some code path that does not traverse, but just looks at pending
> objects, that might care.

Did I really do that?

I thought that the original was pushing peeled tag1^0 and tag2^0
(and nothing else) for "tag1..tag2", and the intent of the patch was
to see if "a" (which is "tag1^0" in this case) has the same object
name as the object originally given on the side of the dots
(i.e. "tag1").  If they differ, that means "a" is the peeled object,
and instead use the original "tag1" for "a_obj" that is pushed into
the pending (and if they are the same, "a_obj" is just "&a->object",
the object itself).  The same for "b", "tag2" and "b_obj".  So at
least I didn't mean to push four objects into the pending list
before prepare_revision_walk() kicks in.

Perhaps I missed something?

Now, when prepare_revision_walk() picks up objects from the pending
list, they are fed to handle_commit(), and these two tags will be
peeled and their commits are returned to be queued in revs->commits
linked list, while the tags themselves are sent to the pending list
to be emitted in "--objects" output. But that should be the same
between "tag1..tag2" and "^tag1 tag2".

A possible difference in behaviour is that with "^tag1 tag2", we do
not instantiate the commit objects pointed at by these tags until
prepare_revision_walk() sends these tags to handle_commit(), while
with "tag1..tag2", these tags and the commit objects would already
be parsed when setup_revisions() returns (and the updated code does
rely on this behaviour by saying "if a->object.sha1 and from_sha1
are different, we know the tag whose name is from_sha1 is already
parsed, so we can just call lookup_object() on from_sha1 to grab
it").  But I do not think any code just tries to grab an object
using a random object name outside the revision traversal and decide
to do things that results in semantically different behaviour if the
resulting object has (or has not) already been parsed.
