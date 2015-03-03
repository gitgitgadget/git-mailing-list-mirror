From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] xmerge.c: fix xdl_merge to conform with the manual
Date: Tue, 03 Mar 2015 12:32:19 -0800
Message-ID: <xmqqzj7takks.fsf@gitster.dls.corp.google.com>
References: <1425404233-89907-1-git-send-email-anton.a.trunov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, charles@hashpling.org,
	Johannes.Schindelin@gmx.de
To: Anton Trunov <anton.a.trunov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 21:32:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YStUX-0004aN-CD
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 21:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820AbbCCUc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 15:32:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751441AbbCCUc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 15:32:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 582FD3DBCD;
	Tue,  3 Mar 2015 15:32:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rNXTFAsVpSSSh51vsx2R7fBk/Y0=; b=nZEUGi
	NEmutTkz7zxmoIyempl42RyMB9pgiMZYbCi55IauBCPt0QWlITooL0seTTbVGxxc
	+ViBtd/r115ejkTwVqySq6oHDiCKUVPYRGgwsjpkqIIL0FlFW7hIFJ0MOiFOhUCe
	d2jWCwliYft7c7GTcGZp8uOGQg9R+iusVBsNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ol5zVQBqLEdKrvDseWBq+B0+y4S6wtkw
	xVBB+80kTg5eo/lMgXY7ol5z1xUQJP+ucdaKixYZtUIdaTyZymYoutH0JMw9Mz1L
	F/A2AmvwcqtPRWoUnXVwDjnOTarkTmzCIjqd0uUy+fi2bT9fDSOlD8vJX3eToI3o
	vA2LG2DmpzM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F9D03DBCC;
	Tue,  3 Mar 2015 15:32:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58F623DBBF;
	Tue,  3 Mar 2015 15:32:21 -0500 (EST)
In-Reply-To: <1425404233-89907-1-git-send-email-anton.a.trunov@gmail.com>
	(Anton Trunov's message of "Tue, 3 Mar 2015 20:37:00 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 64AFC90E-C1E4-11E4-8B0B-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264685>

Anton Trunov <anton.a.trunov@gmail.com> writes:

> The git-merge manual says that the ignore-space-change,
> ignore-all-space, ignore-space-at-eol options preserve our version
> if their version only introduces whitespace changes to a line.
>
> So far if there is whitespace-only changes to both sides
> in *all* lines their version will be used.

I am having hard time understanding the last sentence, especially
the "So far" part.  Do you mean "With the current code, if ours and
theirs change whitespaces on all lines, we take theirs"?

I find the description in the documentation is a bit hard to read.

  * If 'their' version only introduces whitespace changes to a line,
    'our' version is used;

  * If 'our' version introduces whitespace changes but 'their'
    version includes a substantial change, 'their' version is used;

  * Otherwise, the merge proceeds in the usual way.

And it is unclear if your reading is correct to me.  In your "So
far" scenario, 'our' version does introduce whitespace changes and
'their' version does quite a bit of damage to the file (after all,
they both change *all* lines, right?).  It does not seem too wrong
to invoke the second clause above and take 'theirs', at least to me.

It is an entirely different matter if the behaviour the document
describes is sane, and I didn't ask "git log" what the reasoning
behind that second point is, but my guess is that a change made by
them being "substantial" is a sign that it is a whitespace cleanup
change and we should take the cleanup in such a case, perhaps?
