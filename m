From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/6] patch-id: make it stable against hunk reordering
Date: Wed, 23 Apr 2014 15:05:42 -0700
Message-ID: <xmqqzjjbwvk9.fsf@gitster.dls.corp.google.com>
References: <1398255277-26303-1-git-send-email-mst@redhat.com>
	<1398255277-26303-4-git-send-email-mst@redhat.com>
	<xmqq4n1k0wtw.fsf@gitster.dls.corp.google.com>
	<20140423175717.GB28308@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 00:05:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd5Ik-0005m0-Ue
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 00:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbaDWWFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 18:05:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51947 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbaDWWFr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 18:05:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C36C7F550;
	Wed, 23 Apr 2014 18:05:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nbzTaMqvDR5RaKqxJ1OuY6p5nls=; b=B6JgeO
	JibAcyhvsjtIIlfBhQ/5qJ5r6/keM805GKT2f9tUzN0KKEnjgaXS945nJv3fuM50
	AW8H7dagT1sdLiGD6vRAZTV9gnt4aTzqGqIBJeaQjg1LoLuF/zIu8lNfXft3332L
	IfJzAI6OAeVPODg0sdKyRV1gRfSTBXRDPDepI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YA3wVmg0JKqWfG3FL447Gl5ygWEuAb/C
	FmA4LNZpNtvrNGNf8iIAaCNV/Tmv9eVoTzZbgPnwrR50hdqprXMsf5+tlSZm7JSd
	vQvbRqvTMT7/uFG/fdWL8j+G9+SqqcDl2kTOrjOWsezuuaibt5txdrt1P1a6tisx
	G8SPvgv2kfk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 420E17F54F;
	Wed, 23 Apr 2014 18:05:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 474977F54D;
	Wed, 23 Apr 2014 18:05:44 -0400 (EDT)
In-Reply-To: <20140423175717.GB28308@redhat.com> (Michael S. Tsirkin's message
	of "Wed, 23 Apr 2014 20:57:17 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6A957E70-CB33-11E3-8989-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246906>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Apr 23, 2014 at 10:39:23AM -0700, Junio C Hamano wrote:
>> Are these three patches the same as what has been queued on
>> mt/patch-id-stable topic and cooking in 'next' for a few weeks?
>
> Not exactly - at your request I implemented git config
> options to control patch id behaviour.
> Documentation and tests updated to match.

After comparing the patches 4-6 and the one that has been in 'next'
for a few weeks, I tried to like the new one, but I couldn't.

The new one, if I am reading the patch correctly, makes the stable
variant the default if

 - the configuration explicitly asks to use it; or

 - diff.orderfile, which is a new configuration that did not exist,
   is used.

At the first glance, the latter makes it look as if that will not
hurt any existing users/repositories, but the thing is, the producer
of the patches is different from the consumer of the patches.  There
needs to be a way for a consumer to say "I need stable variant" on
the patches when computing "patch-id" on a patch that arrived.  As
long as two different producers use two different orders, the
consumer of the patches from these two sources is forced to use the
stable variant if some sort of cache is kept keyed with the
patch-ids.

But "diff.orderfile" configuration is all and only about the
producer, and does not help the case at all.

Compared to it, the previous version forced people who do not have a
particular reason to choose between the variants to use the new
"stable" variant, which was a lot simpler solution.

The reason why I merged the previous one to 'next' was because I
wanted to see if the behaviour change is as grave as I thought, or I
was just being unnecessary cautious.  If there is no third-party
script that precomputes something and stores them under these hashes
that breaks with this change, I do not see any reason not to make
the new "stable" one the default.

I however suspect that the ideal "stable" implementation may be
different from what you implemented.  What if we compute a patch-id
on a reordered patch as if the files came in the "usual" order?
That would be another way to achieve the stable-ness for sane cases
(i.e. no funny "you could split one patch with two hunks into two
patches with one hunk each twice mentioning the same path" which is
totally an uninteresting use case---diff.orderfile would not even
produce such a patch) and a huge difference would be that it would
produce the same patch-id as existing versions of Git, if the patch
is not reordered.  Is that asking for a moon (I admit that I haven't
looked at the code involved too deeply)?
