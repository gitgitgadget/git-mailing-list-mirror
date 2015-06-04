From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] extract setting of wt_status.commitable flag out of wt_status_print_updated()
Date: Thu, 04 Jun 2015 14:34:23 -0700
Message-ID: <xmqq8ubzupi8.fsf@gitster.dls.corp.google.com>
References: <1433440591-30917-1-git-send-email-rctay89@gmail.com>
	<1433440591-30917-2-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 23:34:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0cmV-0005Sb-8Q
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 23:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbbFDVe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 17:34:27 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34771 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbbFDVe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 17:34:26 -0400
Received: by iebmu5 with SMTP id mu5so10358109ieb.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 14:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1QmTsKLPldNZP3eDWQQSqBHT8rBGquV++JZz7t3i4wA=;
        b=b6EOOYP3YJgQekK8VDE4wp2rcenl5xwpdrcwaOoAwg77o6/q3GmwP4dEDwTKNpEz2j
         Y1374p185cHiYu78G/2GcdLnROaugnbPSExSn2wJSTqjLZK7x5ynDB2BBiJvgaiPiLOT
         S9HHN/yEGFNNqQIbKFj6H7MUkLZdCVMyIIM1C+7geLFZfzMnI33hdUMSS1/BQFUWB3S0
         I+n6OLEcXt2KQDWtgfmEljYHWS+oMYxna7vIw5iqVjMHYPlYTwgf81tsQavKAJUEPtKs
         G458+s/+MJSDOh+h0rgeTqXWIxqWGAPY42FoiUxGI9IcwqlYhm+HMwRFwxal8XEUJ7zb
         6lDw==
X-Received: by 10.42.48.9 with SMTP id q9mr6947541icf.21.1433453665813;
        Thu, 04 Jun 2015 14:34:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8c50:e66f:fc40:1825])
        by mx.google.com with ESMTPSA id d8sm105203igl.19.2015.06.04.14.34.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jun 2015 14:34:25 -0700 (PDT)
In-Reply-To: <1433440591-30917-2-git-send-email-rctay89@gmail.com> (Tay Ray
	Chuan's message of "Fri, 5 Jun 2015 01:56:30 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270800>

Tay Ray Chuan <rctay89@gmail.com> writes:

> It may not be obvious from its name that wt_status_print_updated() that
> it also sets wt_status.commitable, which affects commit functionality.
> Extract this out into a separate function for improved clarity, though
> at the expense of executing another loop.

Makes sense.

> @@ -1360,6 +1374,7 @@ void wt_status_print(struct wt_status *s)
>  
>  	wt_status_print_updated(s);
>  	wt_status_print_unmerged(s);
> +	wt_status_mark_commitable(s);
>  	wt_status_print_changed(s);
>  	if (s->submodule_summary &&
>  	    (!s->ignore_submodule_arg ||

As this is the only callsite of _updated(), we can be assured that
the conversion would not change the behaviour.

But I am not sure the placement of the new call is sensible.  The
standard pattern used in the wt-status infrastructure is to first
collect the information and then make output based on what was
collected.  Because the value of this patch is to separte the "is it
committable?" information gathering step out of the output step,
shouldn't the call be made a lot earlier than these sequence of
wt_status_print_blah() calls?

I am wondering if the flipping of the "is it committable?" bit
belongs to wt_status_collect().  It could be that some other crufty
checks that wt_status_print() have accumulated over time might be
better moved to the "collect" phase, but that is a separate topic.
