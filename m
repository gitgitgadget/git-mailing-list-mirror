From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] t4205: don't rely on en_US.UTF-8 locale existing
Date: Wed, 3 Jul 2013 22:53:03 +0100
Message-ID: <20130703215303.GG9161@serenity.lan>
References: <f607decdc65b86b1759438e375ddf77fd5b91042.1372882590.git.john@keeping.me.uk>
 <7vr4ffcoel.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexey Shumkin <Alex.Crezoff@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 23:53:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuUzE-0003jm-IW
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 23:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521Ab3GCVxM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jul 2013 17:53:12 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:48168 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221Ab3GCVxM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 17:53:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 8B9D6CDA603;
	Wed,  3 Jul 2013 22:53:11 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iypPAgqvxKpm; Wed,  3 Jul 2013 22:53:10 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 68BD6CDA606;
	Wed,  3 Jul 2013 22:53:04 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vr4ffcoel.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229537>

On Wed, Jul 03, 2013 at 02:41:06PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
>=20
> > My system doesn't have the en_US.UTF-8 locale (or plain en_US), whi=
ch
> > causes t4205 to fail by counting bytes instead of UTF-8 codepoints.
> >
> > Instead of using sed for this, use Perl which behaves predictably
> > whatever locale is in use.
> >
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> > This patch is on top of 'as/log-output-encoding-in-user-format'.
>=20
> Thanks.  I think Alexey is going to send incremental updates to the
> topic so I won't interfere by applying this patch on top of the
> version I have in my tree.
>=20
> But I do agree that using Perl may be a workable solution.
>=20
> An alternative might be not to use this cryptic 3-arg form of
> commit_msg at all.  They are used only for these three:
>=20
> 	$(commit_msg "" "8" "..*$")
> 	$(commit_msg "" "0" ".\{11\}")
> 	$(commit_msg "" "4" ".\{11\}")
>=20
> I somehow find them simply not readable, in order to figure out what
> is going on.
>=20
> Just using three variables to hold what are expected would be far
> more portable and readable.
>=20
> # "anf=E4nglich" whatever it means.
> sample_utf8_part=3D$(printf "anf\303\244ng")
>=20
> commit_msg () {
> 	msg=3D"initial. ${sample_utf8_part}lich";
> 	if test -n "$1"
> 	then
> 		echo "$msg" | iconv -f utf-8 -t "$1"
> 	else
> 		echo "$msg"
>         fi
> }
>=20
> And then instead of writing in the expected test output.
>=20
> 	$(commit_msg "" "8" "..*$")
> 	$(commit_msg "" "0" ".\{11\}")
> 	$(commit_msg "" "4" ".\{11\}")
>=20
> we can just say
>=20
> 	initial...
>         ..an${sample_utf8_part}lich
> 	init..lich
>=20
> It is no worse than those cryptic 0, 4, 8 and 11 magic numbers we
> see in the test, no?

That's probably better since we don't need to rely on some other tool
getting it right.

Alexey, will you incorporate this change in your incremental updates?
