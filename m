From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] peel_onion(): teach $foo^{object} peeler
Date: Tue, 02 Apr 2013 08:45:55 -0700
Message-ID: <7vfvz9gclo.fsf@alter.siamese.dyndns.org>
References: <51543FDB.9010109@alum.mit.edu>
 <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com>
 <515462FB.9040605@alum.mit.edu> <20130328153808.GB3337@sigill.intra.peff.net>
 <7vli97v558.fsf@alter.siamese.dyndns.org> <51565F96.1020203@alum.mit.edu>
 <7vk3opr0ke.fsf@alter.siamese.dyndns.org> <51567844.7030503@alum.mit.edu>
 <7vboa1qtnb.fsf@alter.siamese.dyndns.org>
 <7vhajtpdtc.fsf@alter.siamese.dyndns.org>
 <7vy5d3nqik.fsf_-_@alter.siamese.dyndns.org> <515A94C7.3000406@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 02 17:46:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN3Po-000648-JZ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 17:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761060Ab3DBPp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 11:45:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57250 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760542Ab3DBPp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 11:45:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CA3212378;
	Tue,  2 Apr 2013 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dlyQpU3GT6t6LA5LPUczH0QONIQ=; b=Qfh9O4
	qjoVqo9wJC2wWvRHwDN/SIVryumNqA9xRL4G24xWGygxf49PZqsg3hxQ/TiPCJ3t
	PvQaTDIh1cl1yEUN0mFU5n1CYjAKP7z2Phj/cmoEGPECp3d/reVHetMxBVY9quPy
	6Q5b34zL7HmgzHI1qw/rMi9XAXP/V8CyWCzFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hh4ER20uvjwqQgWWlzBWAWww36cMMfLT
	aKUXo3PKMDLxtCnRAEX/YdMZYOtOaLhY6jtfVlGTiErjvaTpsYiTM8M+gNi/btCH
	+Pd2o6nbHkZLUGCxyTi26vFUljvaQRmdmYBpAaPHQoY2qw2FJGt5iXorEkdDiE5p
	wAdBNdFNuTA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DF3A12377;
	Tue,  2 Apr 2013 15:45:58 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 855FA12375; Tue,  2 Apr
 2013 15:45:57 +0000 (UTC)
In-Reply-To: <515A94C7.3000406@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 02 Apr 2013 10:20:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6929C0DA-9BAC-11E2-BD29-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219782>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Off topic: Your patch reminds me of something else that surprised me:
> there is no "$userstring^{tag}".  I suppose it would be a bit ambiguous,
> given that tags can point at tags, and it would also be less useful than
> the other suffixes.  But its absence irked the completionist in me :-)

Yes, unfortunately, foo^{type} means "start from foo, and until what
you are looking at it is of type, repeatedly peel to see if you can
get to an object of that type, or stop and report an error".  If a
tag A points at another tag B, which in turn points at an object C,
you will never see B by applying usual peeling operator.

Also, v1.8.2^{tag} would be give the tag itself, while master^{tag}
would not report the commit "master" but would error out, which
would be useless.  You are better off doing `git cat-file -t foo`
and seeing if it is a tag object at that point.
