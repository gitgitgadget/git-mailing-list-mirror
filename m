From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix git-svn for SVN 1.7
Date: Mon, 30 Jul 2012 23:53:30 -0700
Message-ID: <7v1ujsl8ut.fsf@alter.siamese.dyndns.org>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120730203844.GA23892@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael G. Schwern" <schwern@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jul 31 08:53:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw6Ks-0007l2-6o
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 08:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241Ab2GaGxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 02:53:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32874 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753545Ab2GaGxd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 02:53:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94AA258B8;
	Tue, 31 Jul 2012 02:53:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=up8rxXNVinuPrNfY22rmLXFeTt4=; b=bVrDtp
	xeMV0VVkoQRjzltGFH27DHW91t/ncF31yunXHvcdD2Ow52HHgRR48uL0PwGh6ocj
	OktsnnbJBKPC7WUe5RErH6WpoanQZaDfChxb0aZp1JWciDdJj3fTUaV39LtxRdhz
	KRkJX+FS/ScBkW+YyKrr0G9QqwLyKyDLoBEHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ky22SXF7FKikQgLvFe68dsgPsJ6sV3fu
	u7emXRTzDcy7VLEmxsa5NjN9mSulm4TWhswOLGXg+ixgmPKEl201RSjbjHnGh7sW
	9iOib8/cNEvc4L9CD3kwnnNTpBKtbsqe+uCjbO9WJnsrfAYk3RFTFg6h6FNOz181
	ITtTuBmTcnE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8232F58B7;
	Tue, 31 Jul 2012 02:53:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F102258B6; Tue, 31 Jul 2012
 02:53:31 -0400 (EDT)
In-Reply-To: <20120730203844.GA23892@dcvr.yhbt.net> (Eric Wong's message of
 "Mon, 30 Jul 2012 20:38:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70EF8EF8-DADC-11E1-ADDE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202631>

Eric Wong <normalperson@yhbt.net> writes:

> Perhaps we can depend on the URI.pm module?  It seems to be
> widely-available and not be a significant barrier to installation.  On
> the other hand, I don't know its history, either (especially since we're
> now dealing with SVN changes...).
>
> Anyways, I don't like relying on operator overloading, it makes code
> harder to read and review.

I think code that uses operator overloading, when printed in a
textbook, cast in stone and makes the reader aware that it is never
going to change, is indeed "easy" to read through.  But I suspect
that it may be merely giving a false illusion that it is easy to
readers.

The problem is that use of such obscure overloading tends to hurt
maintainability. If the initial version Michael produces converts
all the external strings into instances of CanonicalizedPath class,
according to the "convert as early as possible" principle, you can
be assured that all "eq" you see are about the normalized strings
the svn library wants to see, and that may allow us sleep safely.

But the real problem begins six months down the road, when somebody
wants to add a new codepath that reads a new string from an external
source (e.g. perhaps you add a new configuration variable that
specifies a path in the svn repository and does something special
when that path is touched by a revision; the exact nature of the new
feature does not matter in this discussion).  The new code can
forget to follow the "convert early" principle, and pass a bare
string read from the configuration around.

A comparison between such a new string and another variable that
holds path that comes from the existing codepath (i.e. Michael's
initial code that perfectly follows the "convert early" principle)
will still use the overloaded eq in "$new_str eq $old_path", thanks
to the language rule of Perl (namely, even though the new string is
a non object, the other side is still an instance of the class).

When the code needs to compare two or more such "new" strings (e.g.
perhaps it wants to remove duplicates from the set of paths it reads
from the configuration), however, "eq" silently turns back to a
simple string comparison, as "$new_1 eq $new_2" will not magically
turn into "Canonicalize($new_1)->cmp(Canonicalize($new_2))".

This kind of error is unnecessarily hard to catch mostly because the
previous "$new_str eq $old_path" does work; it masks the problem.
Overloading of "eq" is making it harder to spot new bugs.

If the code never uses "eq" to compare canonicalized paths, and all
the surrounding code compare paths using explicit method call on
objects, it makes it crystal clear to the readers that paths held in
a bare string is unwelcome in the codepath.  It makes it harder to
add new code that uses and passes around a bare string by mistake to
such a codepath, I would think.
