From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] read_index_from(): catch out of order entries when
 reading an index file
Date: Thu, 28 Aug 2014 22:16:39 -0400
Message-ID: <CAPig+cS__Sw1gNj3Pz20OC51QBsuxBEXTzMStAerwfMuT2afQg@mail.gmail.com>
References: <xmqqy4ubi1ty.fsf@gitster.dls.corp.google.com>
	<1409168892-11345-1-git-send-email-jsorianopastor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 04:16:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNBk6-0003hU-EP
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 04:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbaH2CQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 22:16:41 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:34790 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbaH2CQk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 22:16:40 -0400
Received: by mail-yk0-f178.google.com with SMTP id q200so1055863ykb.9
        for <git@vger.kernel.org>; Thu, 28 Aug 2014 19:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=cpUFyqPahOqM37VhUipceC9srL0vHTkaueC8Tay9+MI=;
        b=WhMfpLd4iBF7LPpxNbc6e9eb+7hoCnAGILuE/9HRNtG6nBodqpRGPNTmE+rmzA6Hm5
         TI/rLWxYrluYuLHu76GIDKSYRX/GN5Vd+ZkeLfdkZ0VJPX7vki1kvQumiXnQcAhZhS3O
         JRkEhKpPM+6xlAYVaIf7E0/UT7U5HwZ7VIGEl91W2WwjgtBSVDemYdNTTVW/pHdH1cxw
         9zMj0ZkT0U1NeRcmdz3cFTh/gB9Obzpju+VsLj4Ro1X/QP0d3U8W9dSWEoJtEqpCviOI
         CehvMeVtqaPDbCfn0DycrKneSHmc5+inAx6PdV+nOrhUe1bB0+SbLK1+yhcfpTQaVYG/
         PnUw==
X-Received: by 10.236.26.101 with SMTP id b65mr8064234yha.75.1409278599765;
 Thu, 28 Aug 2014 19:16:39 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Thu, 28 Aug 2014 19:16:39 -0700 (PDT)
In-Reply-To: <1409168892-11345-1-git-send-email-jsorianopastor@gmail.com>
X-Google-Sender-Auth: Y0nmxO_-pWiuRfRS_SlS0kB4oVA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256136>

On Wed, Aug 27, 2014 at 3:48 PM, Jaime Soriano Pastor
<jsorianopastor@gmail.com> wrote:
> Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
> ---
>  read-cache.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/read-cache.c b/read-cache.c
> index 7f5645e..1cdb762 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1438,6 +1438,21 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
>         return ce;
>  }
>
> +static void check_ce_order(struct cache_entry *ce, struct cache_entry *next_ce)
> +{
> +       int name_compare = strcmp(ce->name, next_ce->name);
> +       if (0 < name_compare)
> +               die("Unordered stage entries in index");
> +       if (!name_compare) {
> +               if (!ce_stage(ce))
> +                       die("Multiple stage entries for merged file '%s'",
> +                               ce->name);
> +               if (ce_stage(ce) > ce_stage(next_ce))
> +                       die("Unordered stage entries for '%s'",
> +                               ce->name);

Perhaps consider dropping capitalization from error messages [1]
(despite existing code in read-cache.c having a mix of the two
styles). See "Error Messages" in Documentation/CodingGuidelines.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/251715/focus=253209

> +       }
> +}
> +
>  /* remember to discard_cache() before reading a different cache! */
>  int read_index_from(struct index_state *istate, const char *path)
>  {
> @@ -1499,6 +1514,9 @@ int read_index_from(struct index_state *istate, const char *path)
>                 ce = create_from_disk(disk_ce, &consumed, previous_name);
>                 set_index_entry(istate, i, ce);
>
> +               if (i > 0)
> +                       check_ce_order(istate->cache[i - 1], ce);
> +
>                 src_offset += consumed;
>         }
>         strbuf_release(&previous_name_buf);
> --
> 2.0.4.2.g7bc378e.dirty
