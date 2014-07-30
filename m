From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git p4 test: fix failure in 9814-git-p4-rename.sh Was: Re: Test failure in t9814-git-p4-rename.sh - my environment or bad test?
Date: Wed, 30 Jul 2014 12:09:48 -0700
Message-ID: <xmqq4mxyzmrm.fsf@gitster.dls.corp.google.com>
References: <CABUJjW8TFCw2wwAO83vMBPc7vQc+rvuPOAca-CNECEduUn19Ew@mail.gmail.com>
	<53D1543F.50508@kdbg.org>
	<xmqq4my68la5.fsf@gitster.dls.corp.google.com>
	<CABUJjW_tnf2SRCyjRw1n+UbzLzTbmqW6XAJSJnZ5qszdpJ3SYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Pete Wyckoff <pw@padd.com>,
	git@vger.kernel.org
To: Christoph Bonitz <ml.christophbonitz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 21:10:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCZGF-0001xM-Fc
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 21:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755705AbaG3TJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 15:09:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59621 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755500AbaG3TJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 15:09:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 62A0F2C2A1;
	Wed, 30 Jul 2014 15:09:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fhnG8nwg3+DKQFFugERZaSwEpdM=; b=KnQOgV
	byPYHGdx/gv+ieacC6aVE5n8EA9KKCUzI2gb3bT7EpUx3pkuQymE1I/Y0gbgDalT
	8u2vn7ooaDJ1PqH/7JYI1IktVBhI59nAYBteDGbIPuvldPAFKCdIx4xZWC3hV3Fo
	LkEgnXJl8ieURPZbCoqdteZ3k6XQyQ2+r100o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uwd+ityEmmknWVIksbNMyTI4imR+rtbY
	4rfXx1Q3EyiwEP6npRjto7nvRvM8ni63MoigDAsnqP3UMAASZsqLf0fAfZBMvadU
	6p0DiSVgww0zgOkwWvk9+5FzUUtZl2JLbYZADaHpgICGvADnaw7DrLiZ/qhV0aW1
	QR3AcoTMF/A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 567672C2A0;
	Wed, 30 Jul 2014 15:09:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A438B2C297;
	Wed, 30 Jul 2014 15:09:50 -0400 (EDT)
In-Reply-To: <CABUJjW_tnf2SRCyjRw1n+UbzLzTbmqW6XAJSJnZ5qszdpJ3SYA@mail.gmail.com>
	(Christoph Bonitz's message of "Wed, 30 Jul 2014 09:08:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 149C087C-181D-11E4-B646-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254510>

Christoph Bonitz <ml.christophbonitz@gmail.com> writes:

> Apart from your change and the word wrap adjustments suggested by
> Pete, would the following also make sense, to fix the other flaw
> Johannes pointed out? With regards to failing, git diff-tree should be
> idempotent. I think those are the two occurrences in this file:

As a band-aid, that might be OK, but I think these pipelines are
unnecessarily and overly wasteful in the first place.

All the "sed 1d" you see here is only because the upstream uses
the one-tree form "diff-tree <options> $commit"; by comparing two,
i.e. "diff-tree <options> $commit^ $commit", they can be dropped.

All the "cut -f2" is to grab the pathname; we have "--name-only"
these days.

I.e.

>  src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&

should become

    src=$(git diff-tree --name-only -r -C --find-copies-harder HEAD^ HEAD) &&

I would think.

Extracting C[0-9]* manually with sed is bad, and expecting that the
score is within certain range is even worse, because there is no
formal guarantee that the definition of similarity indices will not
improve in the future.  --diff-filter=C to limit the output to only
copied paths, without looking at the similarity index, would be more
appropriate, e.g. 

    git diff-tree --name-only --diff-filter=C -r -C HEAD^ HEAD

or something along those lines.

Otherwise, run them outside $(), keep the result in a temporary
file, and process the temporary file with the pipeline.  That has an
added benefit that lets you inspect the file when something goes
wrong.  I.e.

	git diff-tree ... >diff-tree-out &&
        level=$( sed 1d <diff-tree-out | cut -f1 | ... )
