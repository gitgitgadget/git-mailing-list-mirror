From: Junio C Hamano <gitster@pobox.com>
Subject: Re: optimising a push by fetching objects from nearby repos
Date: Sun, 11 May 2014 11:04:38 -0700
Message-ID: <xmqqbnv4ur7t.fsf@gitster.dls.corp.google.com>
References: <536E2C19.3000202@gmail.com>
	<xmqqtx8xuz3b.fsf@gitster.dls.corp.google.com>
	<536ECC93.1070102@gmail.com> <1399772049733.13154@student.bi.no>
	<536EDC1C.5040101@gmail.com> <1399777917522.41294@student.bi.no>
	<536F08C5.3010705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Storm-Olsen\, Marius" <Marius.Storm-Olsen@student.bi.no>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	milki <milki@rescomp.berkeley.edu>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 20:04:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjY7K-0005kF-Gc
	for gcvg-git-2@plane.gmane.org; Sun, 11 May 2014 20:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbaEKSEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2014 14:04:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64051 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663AbaEKSEn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2014 14:04:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E40931445E;
	Sun, 11 May 2014 14:04:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LPKj2ycrQLcwcMXH9E+Qwwgg+UM=; b=OVPFyv
	ng5mkQGSWgH5qf6ZP6tgOd6aqzK/EG7N0zoZkLvdVkO5V0BymnxG0fgx5Jwinapj
	EenmVpksf53RgQwAHoLGzG2UvlLBXm8m8Bo7qdDuSkRcLNn0V4Lb9IMI/urAYEN/
	9JRs8Bw1CFlvjSCypmwhwVC7aVPXAjSLIGM+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iHrMMRs4/kBAkSMXzQWBS1pXUzmlGZ1C
	ATIn4WWgS3/O2JqDOW6OcJpDxu3cAy5/AKbt2ATZDut86mj4B4r3gl88o4TlJRfk
	8gSNS1USr2iDhEND2IZB+QavxSBzY5xnKKb3i4MInj3aF6xx2+upk7u4Ij5pOMJx
	dJvW/KM++nk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DAEAD1445C;
	Sun, 11 May 2014 14:04:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3721014459;
	Sun, 11 May 2014 14:04:40 -0400 (EDT)
In-Reply-To: <536F08C5.3010705@gmail.com> (Sitaram Chamarty's message of "Sun,
	11 May 2014 10:51:09 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B8C10680-D936-11E3-A1E6-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248678>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> But what I was looking for was validation from git.git folks of the idea
> of replicating what "git clone -l" does, for an *existing* repo.
>
> For example, I'm assuming that bringing in only the objects -- without
> any of the refs pointing to them, making them all dangling objects --
> will still allow the optimisation to occur (i.e., git will still say "oh
> yeah I have these objects, even if they're dangling so I won't ask for
> them from the pusher" and not "oh these are dangling objects; so I don't
> recognise them from this perspective -- you'll have to send me those
> again").

So here is an educated guess by a git.git folk.  I haven't read the
codepath for some time, so I may be missing some details:

 - The set of objects sent over the wire in "push" direction is
   determined by the receiving end listing what it has to the
   sending end, and then the sending end excluding what the
   receiving end told that it already has.

 - The receiving end tells the sending end what it has by showing
   the names of its refs and their values.

Having otherwise dangling objects in your object store alone will
not make them reachable from the refs shown to the sending end.  But
there is another trick the receiving end employes.

 - The receiving end also includes the refs and their values that
   appear in the repository it borrows objects from its alternate
   repositories, when it tells what objects it already has to the
   sending end.

So what you "assumed" is not entirely correct---bringing in only the
objects will not give you any optimization.

But because we infer from the location of the object store
(i.e. "objects" directory) where the refs that point at these
borrowed objects exist (i.e. in "../refs" relative to that "objects"
directory) in order to make sure that we do not have to say "oh
these are dangling but we know their history is not broken", we
still get the same optimisation.

At least, that is the theory ;-)
