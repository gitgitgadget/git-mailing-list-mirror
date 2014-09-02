From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] imap-send: simplify v_issue_imap_cmd() and get_cmd_result() using starts_with()
Date: Tue, 02 Sep 2014 12:23:08 -0700
Message-ID: <xmqqoauxzv1f.fsf@gitster.dls.corp.google.com>
References: <5401F860.4030902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 02 21:23:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOtff-000608-Re
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 21:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042AbaIBTXL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Sep 2014 15:23:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64015 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754876AbaIBTXK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Sep 2014 15:23:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A04D37A10;
	Tue,  2 Sep 2014 15:23:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=w/CIFtJPM6Ic
	JL0a/h6A8Y6J974=; b=eEbTWrE/SXZg2mmJEMbLxf9R4zxnZnt1XZElecRxy8cg
	gTiwdX0XmlmmW+92VA7kVV0KSZDhp9NyC8p8r9kqph2L93KFKRBYE6oeLAtcqY1f
	f2OnuOePVTLPj3M9fgQ0lVjHw6imL5M5hDlfhfkOHv+C5dNvmtsZReFLY5po92A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DZb6IA
	h4MyRUMp0UyXNJJttZk381d0aX4+5OZtQHTznVSGmdZ1sv7uYb0t5TFJaPcAdTxf
	k4ZTGzO/vS2cWsVwcCwWBqv1+U7ceYSJ4SwHtymHPVyzYU77YSZk2JKD5gvKU7mK
	Uo3qEpbvm7o7ji/0C9SVNHMGF/SvrVM04+V54=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E6F137A0F;
	Tue,  2 Sep 2014 15:23:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E724B37A0D;
	Tue,  2 Sep 2014 15:23:09 -0400 (EDT)
In-Reply-To: <5401F860.4030902@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sat, 30
	Aug 2014 18:14:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 930E854E-32D6-11E4-96D2-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256341>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Use starts_with() instead of memcmp() to check if NUL-terminated
> strings match prefixes.  This gets rid of some magic string length
> constants.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  imap-send.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 524fbab..b079a0d 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -802,7 +802,10 @@ static int get_cmd_result(struct imap_store *ctx=
, struct imap_cmd *tcmd)
>  				resp =3D DRV_OK;
>  			else {
>  				if (!strcmp("NO", arg)) {
> -					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate || !memcmp(cm=
d, "[TRYCREATE]", 11))) { /* SELECT, APPEND or UID COPY */
> +					if (cmdp->cb.create && cmd &&
> +					    (cmdp->cb.trycreate ||
> +					     starts_with(cmd, "[TRYCREATE]"))) {
> +						/* SELECT, APPEND or UID COPY */
>  						p =3D strchr(cmdp->cmd, '"');
>  						if (!issue_imap_cmd(ctx, NULL, "CREATE \"%.*s\"", (int)(strchr=
(p + 1, '"') - p + 1), p)) {
>  							resp =3D RESP_BAD;

Do we want this hunk, given that it will disappear with the
tf/imap-send-create topic at e0d8e308 (imap-send: create target
mailbox if it is missing, 2014-08-01)?
