From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 10/21] pack-bitmap: add support for bitmap indexes
Date: Mon, 02 Dec 2013 12:36:34 -0800
Message-ID: <xmqqk3fnq9bh.fsf@gitster.dls.corp.google.com>
References: <20131114124157.GA23784@sigill.intra.peff.net>
	<20131114124432.GJ10757@sigill.intra.peff.net>
	<87siuedhvj.fsf@thomasrast.ch>
	<20131202161208.GB24202@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <tr@thomasrast.ch>, git@vger.kernel.org,
	Vicent =?utf-8?Q?Mart=C3=AD?= <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 02 21:36:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnaEZ-0005zJ-F1
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 21:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122Ab3LBUgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 15:36:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50850 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754615Ab3LBUgh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 15:36:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED8A85796B;
	Mon,  2 Dec 2013 15:36:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ep4N0bJbDUB7jISiDqUfRYtOmeQ=; b=IWlyq1
	OgZQHl7n3ne58aid6YCV9TRpHF0cttB8hEBhTwgnS8IZR/JCOym5tI9llWLCXLX0
	TiePghmZ05SEswdKhcbJxFVbKDChcwx+rKNIogI8E08iJid62d26mNzUCFPg96nq
	/JO38vDpwMHT9vgacrfcQbt+rP08xXgCroZ4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AGOrBhzPggnVS4i0ioQUeeGG1wgGRJH7
	ZY3zqWl/Vbx6fxNfHYj9eOvnjuGM9nKT53h5nb6gUfqlFQCBmJrOMDk3/uqXXsJp
	z5lfskC+6NKsYnrJaZIi1BNM6nPWLdBmZQAmBVNKUVbd/tvNej3RfHA7FB+E85Rn
	FPl1995go4A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D12885796A;
	Mon,  2 Dec 2013 15:36:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1679357969;
	Mon,  2 Dec 2013 15:36:35 -0500 (EST)
In-Reply-To: <20131202161208.GB24202@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 2 Dec 2013 11:12:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7023B558-5B91-11E3-AE2F-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238651>

Jeff King <peff@peff.net> writes:

> I do wonder if at some point we should revisit our "do not use any
> C99-isms" philosophy. It was very good advice in 2005. I don't know how
> good it is over 8 years later (it seems like even ancient systems should
> be able to get gcc compiled as a last resort, but maybe there really are
> people for whom that is a burden).

Well, we are not kernel where being able to precisely control
generated machine code matters and enforcement of acceptable
compiler versions to achieve that goal is warranted, so I'd prefer
to avoid anything that tells the users "go get a newer gcc".

There are certain things outside C89 that would make our code easier
to read and maintain (e.g. named member initialization of
struct/union, cf. ANSI C99 s6.7.9, just to name one) that I would
love to be able to use in our codebase, but being able to leave an
extra comma at the list of enums is very low on that list.  Other
than making a patch unnecessarily verbose when you introduce a new
enum and append it at the end, I do not think it hurts us much (I
may be missing other reasons why you may want to leave an extra
comma at the end, though).

Even that problem can easily be solved by having the "a value of
this enum has to be lower than this" at the end, e.g.

        enum object_type {
                OBJ_BAD = -1,
                OBJ_NONE = 0,
                OBJ_COMMIT = 1,
                OBJ_TREE = 2,
                OBJ_BLOB = 3,
                OBJ_TAG = 4,
                /* 5 for future expansion */
                OBJ_OFS_DELTA = 6,
                OBJ_REF_DELTA = 7,
                OBJ_ANY,
                OBJ_MAX
        };


which will never tempt anybody to append at the end, causing the
patch bloat.
