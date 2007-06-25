From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: round down similarity index
Date: Sun, 24 Jun 2007 23:18:33 -0700
Message-ID: <7vir9co8ue.fsf@assigned-by-dhcp.cox.net>
References: <467EEEE6.3090100@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jun 25 08:18:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2huX-0000Om-Uh
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 08:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbXFYGSg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 25 Jun 2007 02:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754714AbXFYGSg
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 02:18:36 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:41007 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbXFYGSf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2007 02:18:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070625061834.GKSY2558.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 Jun 2007 02:18:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FiJa1X0011kojtg0000000; Mon, 25 Jun 2007 02:18:34 -0400
In-Reply-To: <467EEEE6.3090100@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Mon, 25 Jun 2007 00:23:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50862>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> +static int similarity_index(struct diff_filepair *p)
> +{
> +	int result =3D p->score * 100.0 / MAX_SCORE;
> +
> +	/* Paranoia: guard against floating point rounding errors. */
> +	if (p->score =3D=3D MAX_SCORE)
> +		result =3D 100;
> +	else if (result =3D=3D 100)
> +		result =3D 99;
> +
> +	return result;
> +}

Why not simply do this?

        static int similarity_index(struct diff_filepair *p)
        {
                if (p->score =3D=3D MAX_SCORE)
                        return 100;
                return p->score * 100 / MAX_SCORE;
        }

MAX_SCORE and p->score run up to 60000 and we assume int is at
least 32-bit, so I do not think there is no risk of overflowing.
