From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-pack: Filter unknown commits from alternates of the
 remote
Date: Tue, 27 Jan 2009 20:13:26 -0800
Message-ID: <7vljswxe3d.fsf@gitster.siamese.dyndns.org>
References: <7vk58gz04l.fsf@gitster.siamese.dyndns.org>
 <20090128013840.GA7224@atjola.homenet>
 <7vskn4xfyg.fsf@gitster.siamese.dyndns.org>
 <20090128035804.GC7503@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: PJ Hyett <pjhyett@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 28 05:15:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS1pQ-0000kn-OW
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 05:15:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbZA1ENj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jan 2009 23:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbZA1ENj
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 23:13:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbZA1ENi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2009 23:13:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8E04B94275;
	Tue, 27 Jan 2009 23:13:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7131594273; Tue,
 27 Jan 2009 23:13:29 -0500 (EST)
In-Reply-To: <20090128035804.GC7503@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Wed, 28 Jan 2009 04:58:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0971FA12-ECF2-11DD-AF2E-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107469>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> Uhm, it might be obvious, but what exactly could go wrong?

Between the refs and your object store, there is a contract that
guarantees that everything that is reachable from your refs are complet=
e
and you won't hit unreachable object while traversing the reachability
chain from them.  But your object store can contain other garbage
objects.  The contract is one of the things "git fsck" checks.

Imagine you have fetched from somewhere with a commit walker (e.g. fetc=
h
over http), that started fetching from the tip commit and its associate=
d
objects, and then got interrupted.  Such a transfer will leave the obje=
cts
in your local repository but it is safe because it won't update your re=
fs.

>> I'd prefer a small helper function to consolidate the duplicated cod=
e,
>> like the attached patch, though.  How about doing it like this?
>
> Yeah, that looks a lot nicer :-)

But it was broken.  The initial check feed_object() does with
has_sha1_file() and NEEDSWORK comment needs to be inside

	if (negative) {
		if (!has_sha1_file(theirs))
			return 1;
		/*
		 * NEEDSWORK: we should not be satisfied by simply having
		 * theirs, but should be making sure it is reachable from
		 * some of our refs.
		 */
	}

to make sure we won't trigger the availability or connectivity check fo=
r
positive refs.
