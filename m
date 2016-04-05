From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Timestamp of zero in reflog considered invalid
Date: Tue, 05 Apr 2016 19:41:58 +0200
Message-ID: <87r3ek3qc9.fsf@linux-m68k.org>
References: <CAOTD34YpTXperaC0=Sy=21Q9_+0eGO1y-bP-WzrkxFvrDykRXg@mail.gmail.com>
	<xmqqbn5o2gv1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Erik Bray <erik.m.bray@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 19:42:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anUzU-00037D-0b
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 19:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759675AbcDERmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 13:42:06 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45755 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbcDERmE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 13:42:04 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3qfblC64kyz3hjP1;
	Tue,  5 Apr 2016 19:41:59 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3qfblC5Ywczvh1s;
	Tue,  5 Apr 2016 19:41:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id qt9-LgFWZnhS; Tue,  5 Apr 2016 19:41:58 +0200 (CEST)
X-Auth-Info: QbhtywWde50mfL9EarYmK+NJTpZiv0irMamQmidHPZQxZho39EibtsM1Z2j8Ehcs
Received: from igel.home (ppp-88-217-19-26.dynamic.mnet-online.de [88.217.19.26])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Tue,  5 Apr 2016 19:41:58 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 78AC72C1BB9; Tue,  5 Apr 2016 19:41:58 +0200 (CEST)
X-Yow: YOW!!  I'm in a very clever and adorable INSANE ASYLUM!!
In-Reply-To: <xmqqbn5o2gv1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 05 Apr 2016 08:52:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290801>

Junio C Hamano <gitster@pobox.com> writes:

> Checking the value against ULONG_MAX and errno==ERANGE would be an
> improvement.  It may be debatable if we should silently ignore an
> entry with an invalid timestamp, but that is a separate issue.
>
>  refs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 4e15f60..ff24184 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3701,7 +3701,8 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
>  	    get_sha1_hex(sb->buf + 41, nsha1) || sb->buf[81] != ' ' ||
>  	    !(email_end = strchr(sb->buf + 82, '>')) ||
>  	    email_end[1] != ' ' ||
> -	    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
> +	    ((timestamp = strtoul(email_end + 2, &message, 10)) == ULONG_MAX &&
> +	     errno == ERANGE) ||

You need to set errno = 0 before calling strtoul, to distinguish the
valid return of ULONG_MAX (which would keep errno intact) and a real
overflow.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
