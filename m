From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v17 13/14] tag.c: implement '--format' option
Date: Thu, 10 Sep 2015 10:59:37 -0700
Message-ID: <xmqq8u8e40l2.fsf@gitster.mtv.corp.google.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<1441902169-9891-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:00:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za68P-0006tH-I1
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 19:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbbIJR7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 13:59:42 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34592 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbbIJR7k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 13:59:40 -0400
Received: by padhy16 with SMTP id hy16so49345985pad.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=KwIdE97upc6gNZlM7/rOpOQewadk2GPP53SN0PvvMSQ=;
        b=c7CCvfO5Jg0vOx64dlDyL+32L911wJ3b9Kdu5I5t4QFgp4vXvoRALFrBPW+oRl9U1l
         5GWJakAUnwz9zxgvZXcvsCp4yszT6G4SKESbwdDEKcAknE8orQJUvnNbId6dOeGuYFaT
         qlX/h2yKdhmHqtHFi8GJfLlXnNK7peplLNeMcWdu/1kmSwxIcKDQFEqoAJvwK94Tk3Pd
         CSRsBPFsexRXd9GomJ6dDdS0efs1r+Tn1TvSaNKJt58ZLh9ZFO94QtvF1cMr5kXC+4Bj
         o8ogKnFD27CJ5qQiCtsT+AVbsJhlDPvCP3zItTeFdzbFxzII7qwpVU/UjIYYQeWyKR+M
         n/bg==
X-Received: by 10.68.204.232 with SMTP id lb8mr87596699pbc.146.1441907980121;
        Thu, 10 Sep 2015 10:59:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8419:5a5:3940:dfa0])
        by smtp.gmail.com with ESMTPSA id bz4sm13258736pbd.6.2015.09.10.10.59.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Sep 2015 10:59:38 -0700 (PDT)
In-Reply-To: <1441902169-9891-2-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 10 Sep 2015 21:52:48 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277617>

Karthik Nayak <karthik.188@gmail.com> writes:

> -static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting)
> +static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
>  {
>  	struct ref_array array;
> -	char *format, *to_free = NULL;
> +	char *to_free = NULL;
>  	int i;

format is const char * while to_free is non-const char * here.

> @@ -41,12 +41,14 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting)
>  	if (filter->lines == -1)
>  		filter->lines = 0;
>  
> +	if (!format) {
> +		if (filter->lines) {
> +			format = xstrfmt("%s %%(contents:lines=%d)",
> +					 "%(align:15)%%(refname:short)%%(end)", filter->lines);

Hmmm, did this even pass tests and if so how?  What are these double
%% doing before refname and end?  Perhaps we do not have enough test
coverage?

> +			to_free = format;

This assignment discards constness.

Take the result of xstrfmt() to to_free (which is a non-const
pointer) and then assigning it to format (which is a const pointer)
would work it around.
