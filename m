From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Allow alternate "low-level" emit function from
 xdl_diff
Date: Sat, 23 Aug 2008 02:03:07 -0700
Message-ID: <7vy72o14tw.fsf@gitster.siamese.dyndns.org>
References: <1219360921-28529-1-git-send-email-bdowning@lavos.net>
 <1219360921-28529-2-git-send-email-bdowning@lavos.net>
 <48AFC73F.2010100@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Downing <bdowning@lavos.net>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Aug 23 11:04:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWp2h-0003Ro-Tt
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 11:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbYHWJDQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Aug 2008 05:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbYHWJDQ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 05:03:16 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbYHWJDP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Aug 2008 05:03:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C2ED26400F;
	Sat, 23 Aug 2008 05:03:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 775C26400E; Sat, 23 Aug 2008 05:03:10 -0400 (EDT)
In-Reply-To: <48AFC73F.2010100@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Sat, 23 Aug 2008 10:15:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 51CA8648-70F2-11DD-AA19-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93446>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Could we move more code into the library code to avoid that ugliness?
>
> AFAICS, compare_buffer() builds a struct patch with an array of
> struct chunks, whose members are then fed one by one into either
> blame_chunk() or handle_split().  Could we avoid the allocation
> altogether by using a different interface?
>
> E.g. have a callback like this:
>
> 	static void handle_split_cb(long same, long p_next, long t_next,
> 			void *data)
> 	{
> 		struct chunk_cb_data *d =3D data;
> 		handle_split(d->sb, d->ent, d->tlno, d->plno, same,
> 				d->parent, d->split);
> 		d->plno =3D p_next;
> 		d->tlno =3D t_next;
> 	}
>
> And use it like this:
>
> 	struct chunk_cb_data d =3D {sb, ent, 0, 0, parent, split};
>         xpparam_t xpp;
>         xdemitconf_t xecfg;
>
>         xpp.flags =3D xdl_opts;
>         memset(&xecfg, 0, sizeof(xecfg));
>         xecfg.ctxlen =3D context;
> 	xdi_diff_chunks(file_p, file_o, &xpp, &xecfg, handle_split_cb, &d);
>         handle_split(sb, ent, d.tlno, d.plno, ent->num_lines,
> 			parent, split);
>
> Makes sense?

Absolutely; very well formulated.  Thanks.
