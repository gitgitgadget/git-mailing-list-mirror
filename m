From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] init: plug tiny one-time memory leak
Date: Sun, 03 Oct 2010 16:46:18 -0700
Message-ID: <7vpqvqdelx.fsf@alter.siamese.dyndns.org>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org> <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino> <20101002083122.GB29638@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivan Kanis <expire-by-2010-08-14@kanis.fr>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 01:47:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2YHX-0000At-5G
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 01:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab0JCXqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 19:46:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab0JCXqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 19:46:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B617FDB384;
	Sun,  3 Oct 2010 19:46:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6ENrkio4h2anOOxzfPqmM+VHSEc=; b=d1nuda
	gmeiariasgX8z9ZZwbRhWVl3r8Mk0Pk376zWUk4G20Vkurkgo4I9FUj8J/hovBdb
	65omQ820pvd5tjtREOzEE5AFqgZiY7gbAXJG7F4jvffICBI3dQa8WGP7XE+TSsM0
	x5UeTpCwAPwAYBm+mn9lvNFzr8gpmT07KB8ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WthEq+hsi/CwnPKoXlPuk0KXcCAVRwv5
	LoMkE6BaevqrymQjKce6fsZQXl4Lwmr4KgTchoFtTCebX6H/r1LHGbVISvLFyY8E
	ZCgmTP/Rgibq9gz0lnEWLl0GDN9pySX2PQQmfLZUXzDnoeJiV+XYHybviR/4LSU5
	nR1EqQe/6o8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F458DB374;
	Sun,  3 Oct 2010 19:46:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4161DDB373; Sun,  3 Oct
 2010 19:46:20 -0400 (EDT)
In-Reply-To: <20101002083122.GB29638@burratino> (Jonathan Nieder's message of
 "Sat\, 2 Oct 2010 03\:31\:22 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6FA82DD0-CF48-11DF-8494-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157954>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The buffer used to construct paths like ".git/objects/info" and
> ".git/objects/pack" is allocated on the heap and never freed.

While at it it might be a good idea to rename its outdated name to
something saner, e.g. object_dir, perhaps?

In v0.99 days, it make some sense to call that sha1_dir because we
prepopulated 256 subdirectories 00-ff in it, and as an afterthought we
reused the buffer to create an extra subdirectory "/pack" there.  But we
do not create the fan-out in advance since 9106c09 (Create object
subdirectories on demand (phase II), 2005-10-09); sha1_dir is not a very
good name for the buffer to hold the path to ".git/objects" anymore.
