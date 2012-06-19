From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Makefile: split prefix flags from GIT-CFLAGS
Date: Tue, 19 Jun 2012 13:51:14 -0700
Message-ID: <7vmx3zyqil.fsf@alter.siamese.dyndns.org>
References: <20120619195229.GA14692@sigill.intra.peff.net>
 <20120619200354.GC14714@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 19 22:51:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh5Oo-0006xX-O0
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 22:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826Ab2FSUvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 16:51:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65461 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776Ab2FSUvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 16:51:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3568D940D;
	Tue, 19 Jun 2012 16:51:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZqcxSBtqqCfBV0QgcHrWTvHHw+0=; b=U+X8c7
	dpxRLG7tTKsqdaP5uBGNKEufm1s3/izAzPyKtItOzm+5HzjRdhoBjI39T50Egsy2
	Qw7zgfRXOZdqdKhYjKuhybsxdghhjs76cK8mmVpwISkE3EeChRbafz9VGZgFwtD3
	vQXl8NbFfnpHsUED0s1nRo5i8TC131BbhHT/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S1SdVDkj1fMyURz6WoJLxV/UJnuVHG6K
	sp0OBDucnpbSg86TdcT+/vTlsAxbV33YNNAyE9miV10gzyx4husjShPBwG09Twr2
	qKSZs4LGwBMDBVp5EXAQFkJMau1+7PHDpPN8NXeiahrs01JRwy7AsxtYfW2l489M
	eUlYxPDqoS0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D1B9940C;
	Tue, 19 Jun 2012 16:51:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6828940B; Tue, 19 Jun 2012
 16:51:15 -0400 (EDT)
In-Reply-To: <20120619200354.GC14714@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 19 Jun 2012 16:03:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 831B7EF4-BA50-11E1-B9F1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200243>

Jeff King <peff@peff.net> writes:

> Most of the build targets do not care about the setting of $prefix
> (or its derivative variables), but will be rebuilt if the prefix
> changes. For most setups this doesn't matter (they set prefix once
> and never change it), but for a setup which puts each branch or
> version in its own prefix, this unnecessarily causes a full
> rebuild whenever the branc is changed.

s/branc /branch /.

I have to wonder if is this something we care about that much.

The damage is not too bad from the point of view of linecount, but
this embeds the implicit knowledge of dependencies from $prefix to
various path variables to selected object files that embed these
paths variables by scattering dependencies on GIT-PREFIX in the
Makefile, which does not seem to scale very well.  I wonder if it
makes sense to have a single default-paths.o file that holds these
strings and recompile only that file when any of the paths change,
to localize the damage.

Of course, the current users of GIT_HTML_PATH that expect they can
do sizeof(GIT_HTML_PATH)-1 in place of strlen(GIT_HTML_PATH) may
need to be adjusted if we go that route.

Will queue, but we might want to rethink this a bit more.

Thanks.
