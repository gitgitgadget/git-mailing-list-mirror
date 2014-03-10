From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/WIP] Pluggable reference backends
Date: Mon, 10 Mar 2014 10:46:01 -0700
Message-ID: <xmqqwqg2q752.fsf@gitster.dls.corp.google.com>
References: <531D9B50.5030404@alum.mit.edu>
	<CAJo=hJtiPgByhk9M4ZKD98DARzgeU6z2mmw7fcLTEbBza-_h6A@mail.gmail.com>
	<20140310155230.GA29801@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Vicent Marti <tanoku@gmail.com>,
	Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 18:46:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN4HF-0004xU-5k
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 18:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935AbaCJRqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 13:46:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44990 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbaCJRqH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 13:46:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1AC673663;
	Mon, 10 Mar 2014 13:46:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aN9sn3d7l5vR6TISVvCgvbZICW0=; b=XOhX4i
	BqL3oezIENeOtOvC9fgb17ryEeV4DTt5Uzo/cy1wS9rieqCGV4HXoiAVXc72jWIZ
	ryKdEGagK2ot/WgzljwRqb5vulhrYFcS7tmh3h/HIhR6xFV41MVmduAtW9+dH0Ad
	4UMqJ2tAhdvkMOZoYlDSkOga8dojmLKZ5M7qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E6aF6bv+xhJfcryRUWz3NB0aGGDwBlte
	bnfe+wBw3007GM6VHzrIox4dlVSu0YyI28A3plBQ5I7GnJ+72NL6wX4knFOons8/
	sDNNhXThSCLolYE4KXXuV6ofiowj1O79MqvEhdOWtZHWuDva8JLxBCQig1ZQebCl
	BfMH2Y39U+E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A89D773662;
	Mon, 10 Mar 2014 13:46:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD67E73660;
	Mon, 10 Mar 2014 13:46:03 -0400 (EDT)
In-Reply-To: <20140310155230.GA29801@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Mar 2014 11:52:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D9BB805E-A87B-11E3-BF3A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243780>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 10, 2014 at 07:30:45AM -0700, Shawn Pearce wrote:
>
>> > * Store references in a SQLite database, to get correct transaction
>> >   handling.
>> 
>> No to SQLLite in git-core. Using it from JGit requires building
>> SQLLite and a JNI wrapper, which makes JGit significantly less
>> portable. I know SQLLite is pretty amazing, but implementing
>> compatibility with it from JGit will be a big nightmare for us.
>
> That seems like a poor reason not to implement a pluggable feature for
> git-core. If we implement it, then a site using only git-core can take
> advantage of it. Sites with JGit cannot, and would use a different
> pluggable storage mechanism that's supported by both. But if we don't
> implement, it hurts people using only git-core, and it does not help
> sites using JGit at all.

We would need to eventually have at least one backend that we know
will play well with different Git implementations that matter
(namely, git-core, Jgit and libgit2) before the feature can be
widely adopted.

The first backend that is used while the plugging-interface is in
development can be anything and does not have to be one that
eventual ubiquitous one, however; as long as it is something that we
do not mind carrying it forever, along with that final reference
backend.  I take the objection from Shawn only as against making the
sqlite that final one.
