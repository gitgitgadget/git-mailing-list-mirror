From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file.c:create_tmpfile(): Fix race when creating loose object dirs
Date: Tue, 22 Oct 2013 11:09:47 -0700
Message-ID: <xmqqhac9tbx0.fsf@gitster.dls.corp.google.com>
References: <1382102267-18151-1-git-send-email-johan@herland.net>
	<CACsJy8C=kaa2OgdxOrefP+Ck_sSA00tHs9UqMXwkh9v4K3Mdvg@mail.gmail.com>
	<CACsJy8ChkKQJJfV1G6DUQgq1Pwy7Hki1qkD8V4FsLC0bN362PA@mail.gmail.com>
	<CALKQrgcc6gXcthgZgrGS6YA0b8KmnaG=WO=Eu_YQc9pgjRRj6Q@mail.gmail.com>
	<20131018190537.GB11040@sigill.intra.peff.net>
	<xmqq7gdawfeg.fsf@gitster.dls.corp.google.com>
	<CALKQrgdAhLZStLUquizkW_t6wVQsWs0hpGauEm8NjB6tZ67JFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Oct 22 20:09:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYgOx-0004WD-JE
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 20:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875Ab3JVSJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 14:09:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52301 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753768Ab3JVSJu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 14:09:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC4B24C2F7;
	Tue, 22 Oct 2013 18:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=vbrq2g5MDttpK1nVZzvLtHC6NJI=; b=QlOswM5aLs22xHcrXDRa
	inH6F+tXCVfh4iAnpt0LoZsoTeKItSBbGPqttwtzw0rbpjzSwhBtWRP8DqtzsGfC
	63w/zY1YkMC5nXy6Tk3Xg/nuBRFqBSRNxAU3HE2TCbwxmNYC8YjdaeXz1BSWpiyG
	zOH3rMgb0VtGO0rGXk/fMlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=NJdbXnOw3btLPnfrcyS9Mm6XLaTZ4lmSxOExii81qZHtHT
	AYhzIQs3c5W8oa1Yiy+KmX+P3bF2kXoBVHlZjDHBh8Yn5xZ5DjxvwQYg6Kzpkze/
	jSTbvdPofIteATT3CcYfSmUJyWNyg1LdNjnktGZl/ndy6n5DE/iFMQDs4vxIg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E37D4C2F6;
	Tue, 22 Oct 2013 18:09:49 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBB624C2EE;
	Tue, 22 Oct 2013 18:09:48 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 23BFB4B2-3B45-11E3-8207-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236481>

Johan Herland <johan@herland.net> writes:

>> Agreed.  We may notice the failure to correct the permissions in the
>> new code, where the old code left existing directories incorrect
>> permissions as they were.
>
> I'm trying to mentally construct a scenario where two writers with
> different configuration contexts ...
> This case is unfortunate, but no different than if steps 3 and 4 are
> swapped, i.e. the case where fetch B fails because the repo is not yet
> group-writable. Also, remember that as part of changing
> core.sharedRepository like this (step 3), we also require the admin to
> manually alter the permission bits of existing object dirs, to make
> sure they are group-writable (call this step 3.5). All of this has to
> happen _while_ fetch A is running.
>
> Trying to code around this (frankly insane) case in the
> create_tmpfile()/adjust_shared_perm() code is IMHO silly.

I agree.  Note that "We may notice" above were not meant as "we
would fail unnecessarily in some cases where we did not, which is a
regression".  Both the old and the new code will have problems when
two different users race with each other while having umask that is
unsuitable for working together.
