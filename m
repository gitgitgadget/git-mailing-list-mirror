From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 p2 1/9] transport-helper: update remote helper namespace
Date: Sat, 24 Nov 2012 04:28:39 +0100
Message-ID: <CAMP44s070w14K5ODv=5s2f0agV1aVn3FSBmXMmM6M2UqPd7Sdw@mail.gmail.com>
References: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
	<1353727520-26039-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:28:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6QJ-0000EL-HW
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756816Ab2KXD2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:28:40 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:45283 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049Ab2KXD2j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:28:39 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so9373323oag.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RuFb2Plc5djoQ/ONe6frJLc3r1lm9G3qj5WMk2XEz2E=;
        b=sID5guEkLyWxtdYonU6LaQJBlBD7uijuFydoBht8sIbUPHvqU9jm+qQDAJUAgMBcRC
         VFj7Ya8iVzr0FZyc/TJ+S1f6fJA9vi6EY14/H3YRC/N6A8kMDE3txKQ909vcaFrR894Y
         ccPmHQ5nAMB95xj38VZu9kCUVzIcWGuYBC2/oNr3Ah5Gd+b2s+3HmGJ4OhPOD0wb8uT/
         IeLjjKINsLTKENQET8Yd1OTNO5LpP3XewUZnflrShsY7F1YMY7tFjYqiUcBhyhj7oVQN
         0OOG1zislIaY+A0Gow2wuT9z+RsQg2T0Z6JG88025GwKnqXTHtTaRx6rTOjJuVs0yE0i
         tqOg==
Received: by 10.182.98.19 with SMTP id ee19mr4275660obb.90.1353727719073; Fri,
 23 Nov 2012 19:28:39 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Fri, 23 Nov 2012 19:28:39 -0800 (PST)
In-Reply-To: <1353727520-26039-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210310>

On Sat, Nov 24, 2012 at 4:25 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> @@ -673,11 +675,23 @@ static void push_update_refs_status(struct helper_data *data,
>         struct strbuf buf = STRBUF_INIT;
>         struct ref *ref = remote_refs;
>         for (;;) {
> +               char *private;
> +
>                 recvline(data, &buf);
>                 if (!buf.len)
>                         break;
>
> -               push_update_ref_status(&buf, &ref, remote_refs);
> +               if (push_update_ref_status(&buf, &ref, remote_refs))
> +                       continue;
> +
> +               if (!data->refspecs)
> +                       continue;
> +
> +               /* propagate back the update to the remote namespace */
> +               private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
> +               if (!private)
> +                       continue;
> +               update_ref("update by helper", private, ref->new_sha1, NULL, 0, 0);

free(private); I guess


-- 
Felipe Contreras
