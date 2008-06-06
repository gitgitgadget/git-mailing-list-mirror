From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin-fast-export: Add importing and exporting of
 revision marks
Date: Fri, 06 Jun 2008 16:09:42 -0700
Message-ID: <7v8wxirwi1.fsf@gitster.siamese.dyndns.org>
References: <BEF1F17D-6F0F-4F09-9CC4-B193B8907901@ai.rug.nl>
 <1212663163-43064-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sat Jun 07 01:10:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4l58-0006u0-8o
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 01:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136AbYFFXJ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jun 2008 19:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753426AbYFFXJ5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 19:09:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62682 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbYFFXJ4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2008 19:09:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1E9333875;
	Fri,  6 Jun 2008 19:09:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4C2A13874; Fri,  6 Jun 2008 19:09:48 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AC57F314-341D-11DD-8E45-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84134>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> +static void export_marks(char *file)
> +{
> +	unsigned int i;
> +	uint32_t mark;
> +	struct object_decoration *deco =3D idnums.hash;
> +	FILE *f;
> +
> +	f =3D fopen(file, "w");
> +	if (!f)
> +		error("Unable to open marks file %s for writing", file);
> +
> +	for (i =3D 0; i < idnums.size; ++i) {
> +		deco++;
> ...
> +			mark =3D (uint32_t *)deco->decoration - (uint32_t *)NULL;
> +			fprintf(f, ":%u %s\n", mark,
> +				sha1_to_hex(deco->base->sha1));
> ...
> +}
> +
> +static void import_marks(char * input_file)
> ...
> +		add_decoration(&idnums, object, ((uint32_t *)NULL) + mark);

I am confused.

The type of object_decoration.decorattion is a (void*).  Why isn't it
sufficient to do it in a na=C3=AFve and straightforward way?

	mark =3D (uint32_t)(deco->decoration);
        add_decoration(&idnums, object, (void*) mark);

Is this twisted pointer arithmetic done in order to avoid cast between =
int
and pointer of different size in the code?  Even if that is the case,
doesn't "(uint32_t *)deco->decoration - (uint32_t *)NULL" mean the valu=
e
range for deco->decoration is one-fourth of U32?  What are you gaining
from using "uint32_t *" instead of some other pointer types, say "char =
*"?
