From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t1450-fsck (sometimes/often) failes on Mac OS X
Date: Tue, 02 Oct 2012 14:01:08 -0700
Message-ID: <7v4nmc7fmz.fsf@alter.siamese.dyndns.org>
References: <5001644F.10901@web.de>
 <20120715090849.GB18385@sigill.intra.peff.net> <5059ED25.9090002@web.de>
 <7va9wlhnl3.fsf@alter.siamese.dyndns.org> <506B110B.2050802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 02 23:03:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ9bq-0003ml-GI
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 23:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185Ab2JBVBS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2012 17:01:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47960 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389Ab2JBVBM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2012 17:01:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CDA682CE;
	Tue,  2 Oct 2012 17:01:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kS7pY6vgIqtN
	npJsUT6ABBDIQck=; b=vuoWvPTL+DkcgBpi7p5gghm42gLMtKjcQPNFmTtK1cuB
	zVjlkP1iXHnx03wItxzGkxLJvXT06S1Dx4+lwgQiw+Krlcgjq0OwBJTFwFSkEVmC
	3JR5EPicjwigWjpY5YkI2dajx3R5HSw5yrw20LkUgVdozxK7tAe1n8QUpSlKEu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JGrKzj
	+IO5lbcsgFtnMXI2GiGsdlXDahtEKasgGLk7b4pBzVN7zhSmbc6xl6tlR25+ghdU
	k0sYOzw0JOR0afXNa+nak3WWul/8UGHUrsUXvsiYSPFOK1HN8/jFtAN0XI62dX9T
	qG/r79EkjeopmWAucB7hj56oS3tJls0GZloKc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ABEA82CD;
	Tue,  2 Oct 2012 17:01:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9225682CC; Tue,  2 Oct 2012
 17:01:10 -0400 (EDT)
In-Reply-To: <506B110B.2050802@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Tue, 02 Oct 2012 18:06:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B09BB9E-0CD4-11E2-8E3B-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206846>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> With help of Junio's comments I probably found the reason why the tes=
t
> behaves differently:
>
> The objects are checked in a certain order, based on the inode number=
=2E
>
> Which seems to be the same on most machines: when files are created
> in a certain order, then the inode numbers are in the same order.
>
> When the inode numbering changes for reasons known to the file system=
,
> the order changes and fsck takes a different code path.
>
> To provoke the error, the following helped at my Linux box:
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index a710227..bba8082 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -373,7 +373,7 @@ static struct {
>
>  static int ino_compare(const void *_a, const void *_b)
>  {
> -       const struct sha1_entry *a =3D _a, *b =3D _b;
> +       const struct sha1_entry *a =3D _b, *b =3D _a;
>         unsigned long ino1 =3D a->ino, ino2 =3D b->ino;
>         return ino1 < ino2 ? -1 : ino1 > ino2 ? 1 : 0;
>  }
>
> The bad news: I haven't found the time to prepare a fix.

Thanks for a reproduction. Yes, the test t1450.13 is expecting too
much.

If it finds the $sha blob first and then looks at $tag tag, then it
will notice that the tag is pointing at a blob but claims it must be
a commit.  If it finds the $tag tag first, it will remember that the
tag claimed $sha must be a commit, and when later it sees $sha, it
finds that it is not of the type it is expecting (namely, a commit),
and says "the object called $sha is broken".

So "test_must_fail git fsck --tags" is correct.  The fsck must find
the breakage either way.

The last piece to expect "error in tag.*broken links" in the output
is wrong.  Probably we should remove the misguided check and end
it with "test_must_fail git fsck --tags".
