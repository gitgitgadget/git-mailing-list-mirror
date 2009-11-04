From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: fix too generous RFC-2822 footer handling
Date: Tue, 03 Nov 2009 22:11:21 -0800
Message-ID: <7vljimlsza.fsf@alter.siamese.dyndns.org>
References: <20091103165951.GA2241@neumann>
 <1257304146-15543-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Brown <davidb@codeaurora.org>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Nov 04 07:11:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Z5m-0001Rc-7V
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 07:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbZKDGL1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 01:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbZKDGL1
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 01:11:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37754 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbZKDGL0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 01:11:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 40D7D91965;
	Wed,  4 Nov 2009 01:11:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=N41beqikY8PV
	4Iv/5DpmisqOJxk=; b=YeIAJah/8xotD4Q9bKAkuXUa/azc1eAftGkUB2Pj5AQ+
	FdCBTmg9BYvKmzos/2sM+esRF6siNheLCx6SJUyOCjGZNV2zhQZkjxZ+jT6dpHuu
	KXXz8EsxeAoBVLEtN++5ElopLIidinGH6IZKL1J9F9ViXb60BROau2Yy5Z5vjZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MSiWzS
	3HrX8jkdbJLVUwrKzGQhH/N6YkSTdrX6I11Lod6cYEM4cdsCIBHV3+lCzetvC9C3
	b4CjznDUwsMF2d+Qg2v1mcI1A6IwAWqqIAjMVpCxoJlsmMraKRVCvjueAsGe9Xcl
	VzSYdqKmiefb/vjeTeOMODBWfT3w37GRksLbM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 13F3691962;
	Wed,  4 Nov 2009 01:11:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6FC059195D; Wed,  4 Nov 2009
 01:11:23 -0500 (EST)
In-Reply-To: <1257304146-15543-1-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Wed\,  4 Nov 2009 04\:09\:06 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E3702F84-C908-11DE-B49C-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132041>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

>  builtin-commit.c  |    8 ++++++++
>  t/t7501-commit.sh |    4 ++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/builtin-commit.c b/builtin-commit.c
> index beddf01..4971156 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -429,6 +429,14 @@ static int ends_rfc2822_footer(struct strbuf *sb=
)
>  		hit =3D (buf[i] =3D=3D '\n');
>  	}
> =20
> +	for (j =3D i-1; j > 0; j--)
> +		if (buf[j] =3D=3D '\n') {
> +			hit =3D 1;
> +			break;
> +		}
> +	if (!hit)	/* one-line message */
> +		return 0;
> +

That looks overly convoluted.  Why isn't the attached patch enough?

 - We inspected the last line of the message buffer, and 'i' is at the
   beginning of that last line;

 - At the line that begins at 'i', we found something that does not mat=
ch
   the sob we are going to add;

 - We want a newline if it is a single liner (i.e. i =3D=3D 0), or if t=
hat
   last one is not sob/acked-by and friends.

If you are anal and want to allow an author with a funny name "is allow=
ed
as the first word", we _could_ encounter a single-liner commit like thi=
s:

        From: is allowed as the first word <author@example.xz>
	Subject: Signed-off-by: is allowed as the first word <author@example.x=
z>

        Signed-off-by: is allowed as the first word <author@example.xz>

and you may want to add "!i ||" in front of prefixcmp(), but I do not
think that is worth it.

 builtin-commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index c395cbf..cfa6b06 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -530,7 +530,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 		for (i =3D sb.len - 1; i > 0 && sb.buf[i - 1] !=3D '\n'; i--)
 			; /* do nothing */
 		if (prefixcmp(sb.buf + i, sob.buf)) {
-			if (!ends_rfc2822_footer(&sb))
+			if (!i || !ends_rfc2822_footer(&sb))
 				strbuf_addch(&sb, '\n');
 			strbuf_addbuf(&sb, &sob);
 		}
