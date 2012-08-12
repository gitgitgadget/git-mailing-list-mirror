From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git archive --format zip utf-8 issues
Date: Sat, 11 Aug 2012 21:27:42 -0700
Message-ID: <7vhas8hgzl.fsf@alter.siamese.dyndns.org>
References: <502583F4.8030308@tu-clausthal.de>
 <7vtxwagy9f.fsf@alter.siamese.dyndns.org> <5026C649.2090700@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Aug 12 06:28:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0Pmt-0000jT-Vx
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 06:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763Ab2HLE1p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Aug 2012 00:27:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44441 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715Ab2HLE1o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2012 00:27:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D8FB8F69;
	Sun, 12 Aug 2012 00:27:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=97Va/mkCfFJv
	BbuOJBaZ7Nyy79w=; b=kBY/FARBrV3rQHSYCsAo7ypqrKhw/sU2isIno20ilN9c
	kmFubhKP4h3wyUGQu2f+Fc7cbXozd0rNr1t27bXokn0iSzo05BKlcOptLyRA4Zd1
	mbnDkPKU1A0AYoGQ40DgQzeqIjl9yswVcR1auTYlInG83mAKS7hHJN4Jop/fKw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pq+2PI
	lGd2LJnBB2ckpIn6vaboppiw3nKJPiuHzEBLsrIArC9kXrL6em7CWKuYqbsmp0rE
	wYDSUNgpDCp6YF5z1l31Y0reS9hZThP6QjApfgzSk2sGxqVf2c4/NnOn/cR1ffGn
	T8WdC88cb74Woh2vFyx7ezN5RgVlTBCZmdq4w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 513738F68;
	Sun, 12 Aug 2012 00:27:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C9D38F67; Sun, 12 Aug 2012
 00:27:43 -0400 (EDT)
In-Reply-To: <5026C649.2090700@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat, 11 Aug 2012 22:53:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F749D7C-E436-11E1-A224-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203301>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> ... A more interesting question is: What's supported by
> which programs?

Yes, that is the most interesting question.

>> Of course, "git archive --format=3Dzip --path-reencode=3Dutf8-to-lat=
in1"
>> would be the most generic way to do this.
>
> I really hope we can make do without additional options.

We need to at least know the path encoding used in the tree objects,
and I'd be OK with a solution that assumes a single encoding is used
for the entire tree.

We would eventually need to also know the encoding used on the local
working tree (i.e. in what encoding paths are returned from
readdir() and the pathspec the user gives us from the command line),
and iconv it to the tree objects encoding for the project when
creating a cache_entry object to be fed to add_to_index(), and iconv
it back from the tree objects encoding to the working tree encoding
in write_entry(), but that is a longer term direction.  For now, in
order to address the immediate issue, we only need the tree object
encoding, which should default to UTF-8 for interoperability.

So "git archive --format=3Dzip --in-object-path-encoding=3Dbig5" for a
project whose tree object pathnames are in that encoding (and we
always record paths in UTF-8 when writing zipfiles) should be the
minimal that we need for now.

Optionally, with a configuration variable i18n.inObjectPathEncoding
(as opposed to the eventual i18n.worktreePathEncoding) set to big5,
users of such a project can say "git archive --format=3Dzip" without
the "--in-object-path-encoding" option.

Considering that zip is a format meant for exchange, I'd think we
would be fine to always write in UTF-8 and leaving the readers
responsible for converting the pathname while extracting.  If a
major zip extractor is incapable of handling UTF-8 (or even if
capable it is cumbersome, for that matter), we may end up having to
add "--in-archive-path-encoding=3DUTF-8" option to "git archive", with
associated "zip.archivePathEncoding" variable, though.
