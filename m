From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Sat, 24 Nov 2012 04:12:15 +0100
Message-ID: <CAMP44s38qTcSk4PLMkjgyyNq3OJn9QhTV7MuzseB8jPM3GnmeA@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:12:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6AT-0007AH-6e
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842Ab2KXDMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:12:16 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:36749 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082Ab2KXDMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:12:16 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so9367647oag.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5sDlBV3oV2hbWaivtHJR56mG/mJlxmg0aE7ripk7bU4=;
        b=Ulqir7UkhLqwiTpWmYSPOqnV1/EaENXsmXtaALrOZYQ7Fo1YDpCd7hxnhwfc+E0qBh
         Q7Pb55H8jb5Mf5QYzDb/k9pfvHmqwyLlv0ynb2vdQd2Q9TiDIB+tRV7fbe+UZ0qCd+ad
         xinQ21N7k4Wge0qkKQ0eEViQWAEKoFZFQ3ze++SC9gy2jgRLGVcmFcK+/GbZaYuvbO16
         aK3Gr7Ur1Nq/Ku/UPie0YEPmKc6bzttCtGff9TwutD3oNsIpvHb3eg3pVWJDO/9B1it8
         3rIgGEubB79dNMsX946V5KrKv/69uPafk7qJJi252YZw35lVxxGX3WpJnhG8cr4JZFxt
         R52w==
Received: by 10.60.172.229 with SMTP id bf5mr4273718oec.81.1353726735321; Fri,
 23 Nov 2012 19:12:15 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Fri, 23 Nov 2012 19:12:15 -0800 (PST)
In-Reply-To: <1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210283>

On Sun, Nov 11, 2012 at 2:59 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -529,7 +529,9 @@ static void get_tags_and_duplicates(struct object_array *pending,
>                  * sure it gets properly upddated eventually.
>                  */
>                 if (commit->util || commit->object.flags & SHOWN)
> -                       string_list_append(extra_refs, full_name)->util = commit;
> +                       if (!(commit->object.flags & UNINTERESTING))
> +                               string_list_append(extra_refs, full_name)->util = commit;
> +
>                 if (!commit->util)
>                         commit->util = full_name;
>         }

There is one case where this can cause problems. I'm about to send
another patch series where I fix transport-helper to behave more
properly, and in doing so it sends things such as '^old-master master
new', and if new points to master, there's a problem. This means the
user would have to do 'git push new', instead of 'git push --all'. The
transport-helper could do the reset itself, but that would require
parsing the marks. A simpler solution for this is proposed in the next
patch series.

Cheers.

-- 
Felipe Contreras
