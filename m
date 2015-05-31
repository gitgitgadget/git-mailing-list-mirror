From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP/PATCH v4 1/8] for-each-ref: extract helper functions out of grab_single_ref()
Date: Sun, 31 May 2015 10:34:53 -0700
Message-ID: <xmqqvbf8abwi.fsf@gitster.dls.corp.google.com>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 19:35:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz78m-0002z4-H9
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 19:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758153AbbEaRe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 13:34:59 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33172 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559AbbEaRe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 13:34:58 -0400
Received: by iebgx4 with SMTP id gx4so94399226ieb.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=LSPReZx3UpfH+Bv2U+Mp+RIfD92B8Cpm1zHAlOhEqWM=;
        b=MdUBUmqsC/CBkknAeNWk7VFuwsGV/9/ZQewhezQUx8xJuxKKqt3hI/jwaA8I/yn85m
         V+NbIjx1xe5+VBOYjJp+LHU4Kipg+GiMfhjjqp3FtbpxAQMPu+1TCuIUhoq02qAS44pZ
         XMGPPx5vh2pP465IVxjT1I7pvqcKFD65IdQP4TTgpsPd+4vKkcaNVb2HNgH29SBtetkl
         yqy7WJP64lzIgrMLmFQctU2gd9JbqX7QVohUuirMB7EAXRSPamyC2tQd3aMZW1IgSCr1
         NM/b6lpFCPZ61DtVI8sn8S1OyshpOp1PdjKphHQfxu0TYiO7Oo8QEm/WOEnfqUBNCiAl
         vQng==
X-Received: by 10.42.110.66 with SMTP id o2mr25657425icp.54.1433093697273;
        Sun, 31 May 2015 10:34:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3d1d:5ddf:1454:826b])
        by mx.google.com with ESMTPSA id rp7sm3337802igb.21.2015.05.31.10.34.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 31 May 2015 10:34:55 -0700 (PDT)
In-Reply-To: <1433008411-8550-1-git-send-email-karthik.188@gmail.com> (Karthik
	Nayak's message of "Sat, 30 May 2015 23:23:24 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270334>

Karthik Nayak <karthik.188@gmail.com> writes:

>  /*
> + * Given a refname, return 1 if the refname matches with one of the patterns
> + * while the pattern is a pathname like 'refs/tags' or 'refs/heads/master'
> + * and so on, else return 0. Supports use of wild characters.
> + */
> +static int match_name_as_path(const char **pattern, const char *refname)
> +{

I wonder why this is not "match_refname", in other words, what the
significance of "as path" part of the name?  If you later are going
to introuce match_name_as_something_else() and that name may not be
a refname, then this naming is perfectly sane.  If such a function
you will later introduce will still deal with names that are only
refnames, then match_refname_as_path() would be sensible.  Otherwise
this name seems overly long (i.e. "as_path" may not be adding value)
while not being desctiptive enough (i.e. is meant to be limited to
refnames but just says "name").

Just being curious.

> @@ -851,40 +888,16 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
>  		  return 0;
>  	}
>  
> -	if (*cb->grab_pattern) {
> -...
> -	}
> +	if (*cb->grab_pattern && !match_name_as_path(cb->grab_pattern, refname))
> +		return 0;
>  
> -	/*
> -	 * We do not open the object yet; sort may only need refname
> -	 * to do its job and the resulting list may yet to be pruned
> -	 * by maxcount logic.
> -	 */
> -	ref = xcalloc(1, sizeof(*ref));

The comment still is a good reminder for those who will later touch
this grab_single_ref() function to make them think twice.

Thanks.
