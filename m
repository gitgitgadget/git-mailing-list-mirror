From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] refs.c: change read_ref_at to use the reflog iterators
Date: Fri, 30 May 2014 18:51:06 -0400
Message-ID: <CAPig+cTi5qzS0xOvZcu05SK9vihufPDOxYYEEyo9AqG6wsKxoQ@mail.gmail.com>
References: <1401479462-2329-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sat May 31 00:51:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqVdp-0001wX-I4
	for gcvg-git-2@plane.gmane.org; Sat, 31 May 2014 00:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbaE3WvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 18:51:08 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:40028 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964939AbaE3WvH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 18:51:07 -0400
Received: by mail-yh0-f50.google.com with SMTP id 29so2148991yhl.23
        for <git@vger.kernel.org>; Fri, 30 May 2014 15:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9whaFLi/TfuDRFpXe+8vk7mMRYlPDSQ2r1wTsGtC1SY=;
        b=gLYmd8qWjqLOMbxzXle/PWytuCORUh8uuGj/LnIKqDLfpJpzI1Hi9Il5XofbvTvptS
         RgListPXm8YcoCtpofLAY3idnjcYTv7qjMNQ7lil5K+X/sw4amcPPkz9DTlF+lSMp4v9
         BTewciD/ExHSKVPqppDYxqpKrLOEZA/xkiiGMmGVHkXYOO49UUDyVANEuwK+EMgTHtv0
         F5ffyhosmjrLvs5OKcQIyVzrJCh3xguL6BVwfLR/AAgUQCUxwdMnBwlEDO+JvbBJwsa4
         kLB6Z7Tr6A7Xgw2lLQwgKwXk4VYhj25dkSG84c+jnL4YYwg2+5gH+WkoXHvN3gVa97GH
         sG3Q==
X-Received: by 10.236.72.70 with SMTP id s46mr8043562yhd.145.1401490266711;
 Fri, 30 May 2014 15:51:06 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Fri, 30 May 2014 15:51:06 -0700 (PDT)
In-Reply-To: <1401479462-2329-1-git-send-email-sahlberg@google.com>
X-Google-Sender-Auth: y5ljlyYcMC7xsujL0_SpKTCIDvM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250493>

On Fri, May 30, 2014 at 3:51 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> read_ref_at has its own parsing of the reflog file for no really good reason
> so lets change this to use the existing reflog iterators. This removes one
> instance where we manually unmarshall the reflog file format.
>
> Log messages for errors are changed slightly. We no longer print the file
> name for the reflog, instead we refer to it as 'Log for ref <refname>'.
> This might be a minor useability regression, but I don't really think so, since
> experienced users would know where the log is anyway and inexperienced users
> would not know what to do about/how to repair 'Log ... has gap ...' anyway.
>
> Adapt the t1400 test to handle the cahnge in log messages.

s/cahnge/change/

More below.

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
> diff --git a/refs.c b/refs.c
> index 6898263..99d4832 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2936,109 +2936,132 @@ static char *ref_msg(const char *line, const char *endp)
>         return xmemdupz(line, ep - line);
>  }
>
> +static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
> +               const char *email, unsigned long timestamp, int tz,
> +               const char *message, void *cb_data)
> +{
> +       struct read_ref_at_cb *cb = cb_data;
> +
> +       cb->reccnt++;
> +       cb->tz = tz;
> +       cb->date = timestamp;
> +
> +       if (timestamp <= cb->at_time || cb->cnt == 0) {
> +               if (cb->msg)
> +                       *cb->msg = xstrdup(message);
> +               if (cb->cutoff_time)
> +                       *cb->cutoff_time = timestamp;
> +               if (cb->cutoff_tz)
> +                       *cb->cutoff_tz = tz;
> +               if (cb->cutoff_cnt)
> +                       *cb->cutoff_cnt = cb->reccnt - 1;
> +
> +               /*
> +                * we have not yet updated cb->[n|o]sha1 so they still
> +                * hold the values for the previous record.
> +                */
> +               if (!is_null_sha1(cb->osha1)) {
> +                       hashcpy(cb->sha1, nsha1);
> +                       if (hashcmp(cb->osha1, nsha1))
> +                               warning("Log for ref %s has gap after %s.",
> +                                       cb->refname, show_date(cb->date, cb->tz, DATE_RFC2822));
> +               }
> +               else if (cb->date == cb->at_time)
> +                       hashcpy(cb->sha1, nsha1);
> +               else
> +                       if (hashcmp(nsha1, cb->sha1))

This could be an 'else if', allowing you to drop one level of indentation.

> +                               warning("Log for ref %s unexpectedly ended on %s.",
> +                                       cb->refname, show_date(cb->date, cb->tz,
> +                                                          DATE_RFC2822));
> +
> +               /*
> +                * return 1. Not to signal an error but to break the loop
> +                * since we have found the entry we want.
> +                */
> +               hashcpy(cb->osha1, osha1);
> +               hashcpy(cb->nsha1, nsha1);
> +               cb->found_it = 1;
> +               return 1;
> +       }
> +
> +       hashcpy(cb->osha1, osha1);
> +       hashcpy(cb->nsha1, nsha1);
> +       if (cb->cnt > 0)
> +               cb->cnt--;
> +
> +       return 0;
> +}
