From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Mon, 06 May 2013 13:58:53 -0700
Message-ID: <7vppx3q0z6.fsf@alter.siamese.dyndns.org>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
	<1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
	<20130506123111.GB3809@sigill.intra.peff.net>
	<7v7gjctabm.fsf@alter.siamese.dyndns.org>
	<CAMP44s2rdkND40QDQA9T7MNGoKPtnr50nV98aExUe4bCOXZGyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 06 22:59:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZSUz-0006Oy-MY
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 22:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757851Ab3EFU65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 16:58:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36658 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757187Ab3EFU64 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 16:58:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A70041C02B;
	Mon,  6 May 2013 20:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DWmoIxcLcTR9u/aDzXfSw0FPHJc=; b=ovDxIV
	j6OnvOZZjby1vRv+GbE1DZ1KJdyu67susgdTcsmxJJRxC56QeypR84ItnbjzcVc7
	yq5mUdA7qG1UwRzBhdbk8cHtkl3bHFTbrqYwGkXLv0txH05yo15Ks1hcdkqHiCIc
	5nOS3U1xTETDYzvlMQ3ftL/WUXiZtqsEEB5bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n+dtFb4QrSU/0Hfsd9k0FkCDeQWpjj9g
	uHyYsgeiQCDUuQvu5chnQLmexy3yGn+1Nyesop+iMfeiM9njmbkxANDwzUH1bqis
	8USlUz/o9FMywSEzIFI75yIJ2U39C5cPFh5ht0JvhU3F/gErxzcjxNAD8jl2sifb
	vNoJjnm/dEk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DBB31C02A;
	Mon,  6 May 2013 20:58:55 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0680D1C029;
	Mon,  6 May 2013 20:58:54 +0000 (UTC)
In-Reply-To: <CAMP44s2rdkND40QDQA9T7MNGoKPtnr50nV98aExUe4bCOXZGyA@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 6 May 2013 14:09:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C375EDCC-B68F-11E2-B982-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223504>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> The story is different on the fast-import side, where we do say we
>> dump the full table and a later run can depend on these marks.
>
> Yes, and gaining nothing but increased disk-space.

I thought that the "gaining nothing" has already been refuted by the
discussion several hours ago...

cf. http://thread.gmane.org/gmane.comp.version-control.git/223275/focus=223440

Puzzled...

>> By discarding marks on blobs, we may be robbing some optimization
>> possibilities, and by discarding marks on tags, we may be robbing
>> some features, from users of fast-export; we might want to add an
>> option "--use-object-marks={blob,commit,tag}" or something to both
>> fast-export and fast-import, so that the former can optionally write
>> marks for non-commits out, and the latter can omit non commit marks
>> if the user do not need them. But that is a separate issue.
>
> How?

 * if we teach fast-import to optionally not write marks for blobs
   and trees out, your remote-bzr can take advantage of it, because
   it does not reuse marks for non-commits in later runs, right?
   Existing users like cvs2git that do not ask to skip marks for
   non-commits will not be hurt and keep referring to blobs an
   earlier run wrote out.

 * if we teach fast-export to optionally write marks for blobs and
   trees out, the users of fast-export could reuse marks for blobs
   and trees in later runs (perhaps they can drive fast-export from
   the output of "git log --raw", noticing blob object names they
   already saw).  Existing users that do not ask for such a feature
   will not be hurt.
