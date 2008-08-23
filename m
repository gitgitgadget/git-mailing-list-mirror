From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/5] Allow alternate "low-level" emit function from xdl_diff
Date: Sat, 23 Aug 2008 10:15:59 +0200
Message-ID: <48AFC73F.2010100@lsrfire.ath.cx>
References: <1219360921-28529-1-git-send-email-bdowning@lavos.net> <1219360921-28529-2-git-send-email-bdowning@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Sat Aug 23 10:17:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWoJ4-0000nc-FX
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 10:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbYHWIQG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Aug 2008 04:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbYHWIQG
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 04:16:06 -0400
Received: from india601.server4you.de ([85.25.151.105]:41712 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbYHWIQE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 04:16:04 -0400
Received: from [10.0.1.200] (p57B7B8F9.dip.t-dialin.net [87.183.184.249])
	by india601.server4you.de (Postfix) with ESMTPSA id 4A9762F8048;
	Sat, 23 Aug 2008 10:16:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <1219360921-28529-2-git-send-email-bdowning@lavos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93431>

Brian Downing schrieb:
> For some users (e.g. git blame), getting textual patch output is just
> extra work, as they can get all the information they need from the lo=
w-
> level diff structures.  Allow for an alternate low-level emit functio=
n
> to be defined to allow bypassing the textual patch generation; set
> xemitconf_t's emit_func member to enable this.
>=20
> The (void (*)()) type is pretty ugly, but the alternative would be to
> include most of the private xdiff headers in xdiff.h to get the types
> required for the "proper" function prototype.  Also, a (void *) won't
> work, as ANSI C doesn't allow a function pointer to be cast to an
> object pointer.

Could we move more code into the library code to avoid that ugliness?

AFAICS, compare_buffer() builds a struct patch with an array of
struct chunks, whose members are then fed one by one into either
blame_chunk() or handle_split().  Could we avoid the allocation
altogether by using a different interface?

E.g. have a callback like this:

	static void handle_split_cb(long same, long p_next, long t_next,
			void *data)
	{
		struct chunk_cb_data *d =3D data;
		handle_split(d->sb, d->ent, d->tlno, d->plno, same,
				d->parent, d->split);
		d->plno =3D p_next;
		d->tlno =3D t_next;
	}

And use it like this:

	struct chunk_cb_data d =3D {sb, ent, 0, 0, parent, split};
        xpparam_t xpp;
        xdemitconf_t xecfg;

        xpp.flags =3D xdl_opts;
        memset(&xecfg, 0, sizeof(xecfg));
        xecfg.ctxlen =3D context;
	xdi_diff_chunks(file_p, file_o, &xpp, &xecfg, handle_split_cb, &d);
        handle_split(sb, ent, d.tlno, d.plno, ent->num_lines,
			parent, split);

Makes sense?

Ren=E9
