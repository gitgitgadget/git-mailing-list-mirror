From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 01/11] ref-filter: add "%(objectname:size=X)" option
Date: Tue, 28 Jul 2015 09:19:23 -0700
Message-ID: <xmqqvbd4fe5w.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 18:19:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK7bH-0006Pl-Iz
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 18:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbbG1QT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 12:19:27 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34339 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbbG1QT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 12:19:26 -0400
Received: by pacan13 with SMTP id an13so73586614pac.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=CMkQkBp6bkj5P+rl++v/e5C7iQ9TqWEQr4s85yTJrc0=;
        b=vAwc1IBw+RI2Cls/+55wAjPLFb4qLsKrOf3F0wkUR1N2PtiA+X9ZFNloN+FTzkBsrG
         nC1uFgL3UMLAn+5CqsG+FXJnMcJqkY4phYOn31EzPBMTsOEwx2k1b5Hhc7T2/z0z+71S
         zsquCiXBiVRC2lnX99CvLHcwpNCZJfJnsgidYcAuW6+RfeN6P4i3KTkUjUE9Bx7IsHc6
         KMe4nOUOjd5ZFkRJjiySp8T76nO/1fV19Uyk+eLRl45Tl0ekUW0/21Wdadzjo0/2ZOik
         vgT+QcPrChGi04fHn+8r5YsBCn0HS/oRucDar0EXKpy+iFAEV3ZZop9NmNbMsjYlN5yf
         hJXw==
X-Received: by 10.66.63.99 with SMTP id f3mr83821178pas.6.1438100366457;
        Tue, 28 Jul 2015 09:19:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id qo6sm36241070pab.23.2015.07.28.09.19.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 09:19:24 -0700 (PDT)
In-Reply-To: <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Tue, 28 Jul 2015 12:26:26 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274783>

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> Add support for %(objectname:size=X) where X is a number.
> This will print the first X characters of an objectname.
> The minimum value for X is 5. Hence any value lesser than
> 5 will default to 5 characters.

Where does this hardcoded 5 come from?

I'd agree that we would want some minimum for sanity (not safety),
but I do not think we want random callers of find-unique-abbrev
arbitrarily imposing their own minimum, making different codepaths
behave inconsistently without a good reason.

It seems that the minimum we use for sanity at the core level is
MINIMUM_ABBREV.  Is there a reason why that value is inappropriate
for this codepath?

>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  ref-filter.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 0a34924..4c5e3f8 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -196,6 +196,8 @@ static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned lo
>  static int grab_objectname(const char *name, const unsigned char *sha1,
>  			    struct atom_value *v)
>  {
> +	const char *p;
> +
>  	if (!strcmp(name, "objectname")) {
>  		char *s = xmalloc(41);
>  		strcpy(s, sha1_to_hex(sha1));
> @@ -206,6 +208,13 @@ static int grab_objectname(const char *name, const unsigned char *sha1,
>  		v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
>  		return 1;
>  	}
> +	if (skip_prefix(name, "objectname:size=", &p)) {
> +		unsigned int size = atoi(p);
> +		if (size < 5)
> +			size = 5;
> +		v->s = xstrdup(find_unique_abbrev(sha1, size));
> +		return 1;
> +	}
>  	return 0;
>  }
