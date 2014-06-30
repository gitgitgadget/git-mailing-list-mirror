From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] notes-util.c: replace git_config with git_config_get_string
Date: Mon, 30 Jun 2014 10:52:52 -0700
Message-ID: <xmqqioniz3m3.fsf@gitster.dls.corp.google.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
	<1403520105-23250-4-git-send-email-tanayabh@gmail.com>
	<CAPig+cRcbamkpeaoCMQ9yXtYeMEEL-ve--VWKg4MAWeS08Lqyg@mail.gmail.com>
	<53ABD78E.3050800@gmail.com>
	<CAPig+cSRBk5Q2amvFXyjH4dpoP83qbYUEUizE7v38Wh8Ofnfpw@mail.gmail.com>
	<53B16748.8080703@gmail.com> <53B17696.3060808@gmail.com>
	<53B1889D.3010506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 19:53:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1flJ-0004bJ-N8
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 19:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540AbaF3RxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 13:53:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52761 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753774AbaF3Rw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 13:52:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6CFAF22D6E;
	Mon, 30 Jun 2014 13:52:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tAtR0gKYOtepsbCa/Z31MWblSmo=; b=PS/PRV
	1PBpI7UiM8c0h4ru4T6E/+nvByf7/Z/GLV2Zyng0VNHuzeFCrdX8/MRqfuKjok55
	X8YUwI07aXz/TAkVuewB6ZDz0+C4RDx1dluS1wM4EkVSUG2lUTV6U0f+jbwJH0iu
	AFIvdE0jV1e1C8JTwGejX1nxZPUgr3/zUI4kw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=du2vju77VwX+EYaqMAgN/C2kTgofWsjt
	fpnMHui7FoNKeAkuPEDTmYWOmSCtqUpF4C3wKCPy6eBOoBagEYX5fGfg/1nhlBsu
	s1in0Ch43MedkMIsAwqpUJMOox9xb7860UYVOCFj4Sle9ke5qv0020Rm7AHidaxJ
	Gr1Gq7f8M2I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6028322D6B;
	Mon, 30 Jun 2014 13:52:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 47F0622D64;
	Mon, 30 Jun 2014 13:52:45 -0400 (EDT)
In-Reply-To: <53B1889D.3010506@gmail.com> (Karsten Blees's message of "Mon, 30
	Jun 2014 17:56:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5746EF26-007F-11E4-A304-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252695>

Karsten Blees <karsten.blees@gmail.com> writes:

> Which may not be too harmful in some cases, but if a user changes:
>
>  gc.pruneexpire=4.weeks.ago
>
> to
>
>  gc.pruneexpire=4.monhts.ago
>
> (note the typo), the next git-gc will warn the user and then happily throw
> away data that the user intended to keep (default is 2.weeks.ago).
>
> Thus I think git should die() if it encounters an invalid config setting.

Yes but not at the parsing time.  Only when we are about to _use_
the value for pruneexpire as a time duration we should die of the
error.  Diagnosing an error early is a separate matter, but if the
operation does not care about the typo we shouldn't die.
