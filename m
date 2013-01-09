From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v2 03/10] mailmap: remove email copy and length limitation
Date: Wed, 9 Jan 2013 18:35:21 +0100
Message-ID: <CALWbr2wp7rV7Vh0=gwmWaZE5hLHQNL+UciDsL+z-1GyhS9pTkQ@mail.gmail.com>
References: <1357603821-8647-1-git-send-email-gitster@pobox.com>
	<1357603821-8647-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 18:35:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TszZ0-0008UP-6d
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 18:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035Ab3AIRfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 12:35:22 -0500
Received: from mail-qa0-f52.google.com ([209.85.216.52]:62747 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183Ab3AIRfW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 12:35:22 -0500
Received: by mail-qa0-f52.google.com with SMTP id d13so875495qak.18
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 09:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ILxPklAAaNbzeb7fPzOf44wHGKSjCHWAuAbaW3b70MY=;
        b=Uw4eMskh+bxpD5AM2aCysMwVFzJ6Qv8erKlEs5hv8aEA+eY8i0KJkPhKTuGEWxw3ha
         PpY7AMBP1rOy321h3uCDi9ab6KEYpoQIC8Lyzklokn/crX8qznQZ8uDAo9ktdQ2/Z2Hx
         0FeVNODJwX7ABcqqe/NA/80aBOmYeWpd/emFz+K9HjNtItOx+elp6slrfWFCbwrWt2VM
         NBwO5c3EXoa2tbtrS5M7JWrZL77uaSG/iffsv6efgFsXgh4uBBcCYi8KKAVmSqgo0QCe
         oVlu63SJYYMRfUvEbbYLkNKkZuIN7GWRK356NMEyoDpcN1kM7gwGIRZez4rH2tfQIS+q
         9Dhg==
Received: by 10.49.108.9 with SMTP id hg9mr60628913qeb.34.1357752921231; Wed,
 09 Jan 2013 09:35:21 -0800 (PST)
Received: by 10.49.11.233 with HTTP; Wed, 9 Jan 2013 09:35:21 -0800 (PST)
In-Reply-To: <1357603821-8647-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213071>

> +static struct string_list_item *lookup_prefix(struct string_list *map,
> +                                             const char *string, size_t len)
> +{
> +       int i = string_list_find_insert_index(map, string, 1);
> +       if (i < 0) {
> +               /* exact match */
> +               i = -1 - i;
> +               /* does it match exactly? */
> +               if (!map->items[i].string[len])
> +                       return &map->items[i];

I'm not sure the condition above is necessary, as I don't see why an
exact match would not be an exact match.
We have to trust the cmp function (that mailmap sets itself) to not
return 0 when the lengths are different.

> +       }
> +
> +       /*
> +        * i is at the exact match to an overlong key, or
> +        * location the possibly overlong key would be inserted,
> +        * which must be after the real location of the key.
> +        */
> +       while (0 <= --i && i < map->nr) {
> +               int cmp = strncasecmp(map->items[i].string, string, len);
> +               if (cmp < 0)
> +                       /*
> +                        * "i" points at a key definitely below the prefix;
> +                        * the map does not have string[0:len] in it.
> +                        */
> +                       break;
> +               else if (!cmp && !map->items[i].string[len])
> +                       /* found it */
> +                       return &map->items[i];
> +               /*
> +                * otherwise, the string at "i" may be string[0:len]
> +                * followed by a string that sorts later than string[len:];
> +                * keep trying.
> +                */
> +       }
> +       return NULL;
> +}
> +

I've tried to think about nasty use cases but everything seems fine.
