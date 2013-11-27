From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 20/24] introduce GIT_INDEX_VERSION environment variable
Date: Wed, 27 Nov 2013 16:57:38 -0500
Message-ID: <CAPig+cSHcL62EW5z5n68jQcS4BWW9cZ=GqRwZaoyYM69NE55+w@mail.gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
	<1385553659-9928-21-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Robin Rosenberg <robin.rosenberg@dewire.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 22:57:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vln7A-00062i-6J
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 22:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757890Ab3K0V5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 16:57:40 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:61759 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757299Ab3K0V5j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 16:57:39 -0500
Received: by mail-ie0-f176.google.com with SMTP id at1so13185574iec.35
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 13:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WHMLGuJpbRdn/xPGYJeKBxrvTjbEH/qX2XusEJBIcbY=;
        b=Px/Eq/nsF96UZLpQdiYeq0UmpWuiQ8pkG6rBOfJP/2u9q1qpPKpHTfn7/ksNJXNQ6r
         7eyisO2v4RDLAho21eypHGPd/FMVyefU076DuObWgq9ZDmsZ5RmgccCkqVxMjhHcZX0l
         qo8HgeSZusu7ez5aej/UVJFQ7bF2cTBmK+0lbMkC6grISMP+mOlrff30nZUU1IRlfNTN
         oTfFDMCdEqeOnXy2FICeVsbaoM4Dd3GSuQbz2iq4eiDJdyhcYSm2H4S8YO2CHg1lj7om
         hvX8zZDj0am5fYIvxbgX/VRsoomuPihxGQ0jG6qmQAGoW/8T4fIPj3cRTh8qsD/d9gBe
         SJYw==
X-Received: by 10.50.131.163 with SMTP id on3mr55174igb.46.1385589459014; Wed,
 27 Nov 2013 13:57:39 -0800 (PST)
Received: by 10.64.250.198 with HTTP; Wed, 27 Nov 2013 13:57:38 -0800 (PST)
In-Reply-To: <1385553659-9928-21-git-send-email-t.gummerer@gmail.com>
X-Google-Sender-Auth: 92qT2jmJBlZ4TLcqqFOj8Qut9JY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238467>

On Wed, Nov 27, 2013 at 7:00 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Respect a GIT_INDEX_VERSION environment variable, when a new index is
> initialized.  Setting the environment variable will not cause existing
> index files to be converted to another format for additional safety.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/read-cache.c b/read-cache.c
> index 46551af..04430e5 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1233,8 +1233,13 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
>  void initialize_index(struct index_state *istate, int version)
>  {
>         istate->initialized = 1;
> -       if (!version)
> -               version = INDEX_FORMAT_DEFAULT;
> +       if (!version) {
> +               char *envversion = getenv("GIT_INDEX_VERSION");
> +               if (!envversion)
> +                       version = INDEX_FORMAT_DEFAULT;
> +               else
> +                       version = atoi(envversion);

Do you want to check that atoi() returned a valid value and emit a
diagnostic if it did not?

> +       }
>         istate->version = version;
>         set_istate_ops(istate);
>  }
> --
> 1.8.4.2
