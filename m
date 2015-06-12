From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 01/12] for-each-ref: extract helper functions out of grab_single_ref()
Date: Fri, 12 Jun 2015 10:30:32 -0700
Message-ID: <xmqq616sesw7.fsf@gitster.dls.corp.google.com>
References: <5579B253.4020804@gmail.com>
	<1434039003-10928-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 19:30:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3Sn1-0003Yu-2y
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 19:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179AbbFLRam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 13:30:42 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37254 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbbFLRae (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 13:30:34 -0400
Received: by igbsb11 with SMTP id sb11so15327500igb.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 10:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OlNYlF+wXbDZHll0FjEaWNUovDnCdq+MB1yFFKrN6UI=;
        b=y0J4Gu35Xv494w7HJEW0SQuReoZeWZwtD0fyU2IWdNC8lEDuAJPESJvuYzTBT46OtU
         nLpe0MaPzDZXMOlVE3U+fhYxQYlSwfbFAVsPX/Gg8sfF9UkEYgKroQRr+AK8aaY6L96s
         FL9FG7+BX6yOwUnDbwZZvshN4jedcNiNs3ywU6Y613U+R5txTGDpaWWlbOfUOMNATu4m
         V2YvOibwJ+MB4+C9ubxf/m6Hu5w/1IjVW8zksQF0wQncwrUnxSZbaTtZ4ZT0n4jeC2aN
         +UvD+BwJfTVn/b0+zueA3LqlXe5MCP0CvGkzpzjWy4dDyS7AWL/YyjKqd8IukibKG37L
         7nqA==
X-Received: by 10.43.84.73 with SMTP id aj9mr17714447icc.69.1434130233987;
        Fri, 12 Jun 2015 10:30:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a12d:7c00:b954:bc66])
        by mx.google.com with ESMTPSA id g1sm2875116iog.4.2015.06.12.10.30.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 10:30:33 -0700 (PDT)
In-Reply-To: <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 11 Jun 2015 21:39:52 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271500>

Karthik Nayak <karthik.188@gmail.com> writes:

> Extract two helper functions out of grab_single_ref(). Firstly,
> new_refinfo() which is used to allocate memory for a new refinfo
> structure and copy the objectname, refname and flag to it.
> Secondly, match_name_as_path() which when given an array of patterns
> and the refname checks if the refname matches any of the patterns
> given while the pattern is a pathname, also supports wildcard
> characters.
>
> This is a preperatory patch for restructuring 'for-each-ref' and
> eventually moving most of it to 'ref-filter' to provide the
> functionality to similar commands via public API's.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/for-each-ref.c | 64 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 41 insertions(+), 23 deletions(-)
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index f7e51a7..67c8b62 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -851,6 +851,44 @@ struct grab_ref_cbdata {
>  };
>  
>  /*
> + * Return 1 if the refname matches with one of the patterns,

s/with //;

> + * otherwise 0.  The patterns can be literal prefix (e.g. a
> + * refname "refs/heads/master" matches a pattern "refs/heads/")
> + * or a wildcard (e.g. the same ref matches "refs/heads/m*",too).
> + */

I know this was my bad suggestion, but "refs/heads/m" can be thought
of as a "literal prefix" that may match "refs/heads/master"; we do
not want to make that match, so perhaps "literal" is a bad way to
say this.  "A pattern can be a path prefix or a worldcard"?
