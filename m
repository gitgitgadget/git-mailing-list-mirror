From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] commit: fix too generous RFC-2822 footer handling
Date: Wed, 4 Nov 2009 16:11:14 +0100
Message-ID: <20091104151114.GD6118@neumann>
References: <20091103165951.GA2241@neumann>
	<1257304146-15543-1-git-send-email-szeder@ira.uka.de>
	<7vljimlsza.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Brown <davidb@codeaurora.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 16:11:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5hW7-0003Lk-49
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 16:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888AbZKDPLM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 10:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755805AbZKDPLM
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 10:11:12 -0500
Received: from francis.fzi.de ([141.21.7.5]:17734 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755300AbZKDPLL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 10:11:11 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Nov 2009 16:11:14 +0100
Content-Disposition: inline
In-Reply-To: <7vljimlsza.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 04 Nov 2009 15:11:14.0838 (UTC) FILETIME=[0D36B360:01CA5D61]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132092>

Hi,


On Tue, Nov 03, 2009 at 10:11:21PM -0800, Junio C Hamano wrote:
> That looks overly convoluted.

I figured that the function ends_rfc2822_footer() should tell us
whether the message, well, ends with an rfc2822 _footer_.  But since
it may say so even if there is only a single line in the commit
message, I thought this function should be fixed in the first place.

But yeah, that solution was unnecessarily complicated, after a good
night's sleep I would do it this way:

diff --git a/builtin-commit.c b/builtin-commit.c
index beddf01..c7dcbd0 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -428,6 +428,8 @@ static int ends_rfc2822_footer(struct strbuf *sb)
                        break;
                hit =3D (buf[i] =3D=3D '\n');
        }
+       if (i =3D=3D 0)     /* one-line message */
+               return 0;
=20
        while (i < len - 1 && buf[i] =3D=3D '\n')
                i++;

> Why isn't the attached patch enough?
>=20
>  - We inspected the last line of the message buffer, and 'i' is at th=
e
>    beginning of that last line;
>=20
>  - At the line that begins at 'i', we found something that does not m=
atch
>    the sob we are going to add;
>=20
>  - We want a newline if it is a single liner (i.e. i =3D=3D 0), or if=
 that
>    last one is not sob/acked-by and friends.

You are right in that there is no need to look for an rfc-2822
formatted footer when the commit message has only a single line.  But
ends_rfc2822_footer() still not completely behaves as its name would
suggest (i.e. it might match even if there is no footer).  Perhaps it
could just be renamed to ends_rfc282().


Best,
G=E1bor
