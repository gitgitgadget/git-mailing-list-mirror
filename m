From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout creates strange '(null)'-branch
Date: Tue, 08 May 2012 09:22:25 -0700
Message-ID: <7vhavqy75q.fsf@alter.siamese.dyndns.org>
References: <CABPQNSZbgZsQBReSqOskNQ4oZokHSibVr=yHdn6oSFjtdRvVVA@mail.gmail.com>
 <7v62c6zon4.fsf@alter.siamese.dyndns.org>
 <CABPQNSYzxDoer_Xhf+8EEU4zz58PLRQiZAsg_CWzP3ps6f_4rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue May 08 18:22:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRnBJ-0001M3-Qc
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 18:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922Ab2EHQW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 12:22:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60801 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755675Ab2EHQW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 12:22:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48681636B;
	Tue,  8 May 2012 12:22:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2y6zUrgVgwwdrYhApe3cx/oO638=; b=rSCp6D
	zGILXrzJ1meh3Z4SEZJV9X4FHAeAEkN7SHtBfg45AvqbsH5xzNb7BEhEXZNGeqIh
	jIvANfVkpzN3ZuoITJNF6U+/xWDQM1AkxRC2p92Orj5H8qEnfdnZPKIxjOdJgas+
	2vTpDGXfV/rwenHeDI9QT2k5HGiNrxfwJx780=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aQR5pTV2h7Z1n7yr8bYRgV+/fyor65At
	cyVS/B42BkJkFZYpxYH6HT9PHQBUpzVEHxTm79ZWGp7wvJ7gWxFJIkMjfE8MLPka
	AMWi8s+oWtHGAE4j86oC0QTrK59J3ov/EIw80Idj1fqxcG4q/i9AVEzKtyXCSjkb
	RkE6xZwA/Nk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E02E636A;
	Tue,  8 May 2012 12:22:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C45E76369; Tue,  8 May 2012
 12:22:26 -0400 (EDT)
In-Reply-To: <CABPQNSYzxDoer_Xhf+8EEU4zz58PLRQiZAsg_CWzP3ps6f_4rw@mail.gmail.com> (Erik
 Faye-Lund's message of "Tue, 8 May 2012 18:04:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0028BED6-992A-11E1-88F9-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197382>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Yes, it does. Basically, it calls "git checkout -f -q" from cmd_add if
> $branch is empty. And it fails if the checkout-call fails.
>
> I'm not saying it's a sane thing to do. But to me, it kind of feels
> natural to initialize the shared (i.e bare) repos for both the
> superproject and the submodule, clone the superproject, add the
> submodule, and populate these from there.

I sense a bit of slipperly slope here.  After doing this, the superproject
would have its .gitmodules file set up to point at something, but what
does its first commit look like?  Other files and .gitmodules, but no
empty-submodule?  Can you commit the superproject _with_ empty-submodule
without having any commit in that empty-submodule?  I think "git add"
should fail when there is no commit there in the first place, so you won't
create such a superproject commit that does not have anything in the
submodule.  Is that OK for everybody?  Or would we add yet another funny
special case for such a setting, perhaps by contaminating the index and
the tree in the superproject with a stand-in value to represent a "does
not yet exist" commit that ought to be at the tip of submodule's history?

> But that won't work the way
> things currently are, because you can't "git submodule add" an empty
> project.
>
> To allow that,...

Yes, allowing that does not seem to make sense at all in the larger
picture. What benefit would we get from that slipperly slope?
