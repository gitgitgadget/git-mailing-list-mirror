From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git cat-file: Fix memory leak in batch mode
Date: Sat, 28 Jun 2008 20:36:46 -0700
Message-ID: <7v1w2gkj3l.fsf@gitster.siamese.dyndns.org>
References: <20080629005858.GA2036@atjola.homenet>
 <20080629012125.GA1722@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Adam Roben <aroben@apple.com>,
	Samuel Bronson <naesten@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 29 05:38:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCnk0-00074W-LV
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 05:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758225AbYF2DhA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jun 2008 23:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758198AbYF2DhA
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 23:37:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33881 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbYF2Dg7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jun 2008 23:36:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B531C1515B;
	Sat, 28 Jun 2008 23:36:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0D66C1515A; Sat, 28 Jun 2008 23:36:50 -0400 (EDT)
In-Reply-To: <20080629012125.GA1722@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Sun, 29 Jun 2008 03:21:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A0406E8C-458C-11DD-AB94-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86757>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> When run in batch mode, git cat-file never frees the memory for the b=
lob
> contents it is printing. This quickly adds up and causes git-svn to b=
e
> hardly usable for imports of large svn repos, because it uses cat-fil=
e in
> batch mode and cat-file's memory usage easily reaches several hundred=
 MB
> without any good reason.
>
> Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
> ---
>  builtin-cat-file.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-cat-file.c b/builtin-cat-file.c
> index bd343ef..f966dcb 100644
> --- a/builtin-cat-file.c
> +++ b/builtin-cat-file.c
> @@ -183,6 +183,7 @@ static int batch_one_object(const char *obj_name,=
 int print_contents)
>  		fflush(stdout);
>  	}
> =20
> +	free(contents);
>  	return 0;
>  }

Thanks, except that it should go inside the "if (print_contents =3D=3D =
BATCH)"
block to avoid freeing an uninitialized pointer.
