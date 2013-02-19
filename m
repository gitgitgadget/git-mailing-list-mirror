From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] git-commit: only append a newline to -m mesg if
 necessary
Date: Mon, 18 Feb 2013 22:31:21 -0800
Message-ID: <20130219063121.GF19757@elie.Belkin>
References: <1361247427-438-1-git-send-email-drafnel@gmail.com>
 <1361247427-438-3-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 07:32:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7gkB-0007w9-KP
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 07:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757313Ab3BSGb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 01:31:28 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:43180 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757183Ab3BSGb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 01:31:27 -0500
Received: by mail-pa0-f44.google.com with SMTP id kp1so3266905pab.17
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 22:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OtHEUwgaTs+gnHpEEr4CtLFSfFm8mPcLfHc76bauqs0=;
        b=gbwDZKTE6xDgvz46Mbt4a05Orfn8wZS1V5C4wXUNrxgBnh21TD04Dek3FKFjuWs62z
         61tojF9AnR78ENBg6rmQq6rWgE8wz+QXLu6hdI1V2ab/PMS995JbmjTneri8ltXHZrMT
         jCm/6y+82yAOcA1u8jAHFYASk3WLdWT7zVT9hSUdRh+nIltq35qqe+u5mGoAiipAIydA
         uPeiJLi35aJSxuqdmhwHkKIIIlB+E7547NACEB5KvDb2ir6vHMojC/heZoegyStgbtzj
         k/07W19H0sFY7lF/OCxCpgFMSP8KzWqHQgGnWnkPmuFH4LoGBWtFNgSYTPgzbTcM/Roi
         UGFQ==
X-Received: by 10.68.63.194 with SMTP id i2mr37872600pbs.4.1361255487278;
        Mon, 18 Feb 2013 22:31:27 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id kl4sm2733299pbc.31.2013.02.18.22.31.24
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 22:31:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1361247427-438-3-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216565>

Brandon Casey wrote:

> Currently, git will append two newlines to every message supplied via
> the -m switch.  The purpose of this is to allow -m to be supplied
> multiple times and have each supplied string become a paragraph in the
> resulting commit message.
>
> Normally, this does not cause a problem since any trailing newlines will
> be removed by the cleanup operation.  If cleanup=verbatim for example,
> then the trailing newlines will not be removed and will survive into the
> resulting commit message.
>
> Instead, let's ensure that the string supplied to -m is newline terminated,
> but only append a second newline when appending additional messages.
[...]
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -124,8 +124,10 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
>  	if (unset)
>  		strbuf_setlen(buf, 0);
>  	else {
> +		if (buf->len)
> +			strbuf_addch(buf, '\n');
>  		strbuf_addstr(buf, arg);
> -		strbuf_addstr(buf, "\n\n");
> +		strbuf_complete_line(buf);

As long as 'message' always consists of complete lines, this will
append 'arg' as a new paragraph, as desired.  And no other code path
touches 'message', so it always consists of complete lines.

Thanks for a clear patch and explanation.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

(rest of patch kept unsnipped for reference)

>  	}
>  	return 0;
>  }
> diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
> index 39e55f8..292bc08 100755
> --- a/t/t7502-commit.sh
> +++ b/t/t7502-commit.sh
> @@ -204,7 +204,7 @@ test_expect_success 'cleanup commit messages (verbatim option,-F)' '
>  
>  '
>  
> -test_expect_failure 'cleanup commit messages (verbatim option,-m)' '
> +test_expect_success 'cleanup commit messages (verbatim option,-m)' '
>  
>  	echo >>negative &&
>  	git commit --cleanup=verbatim -m "$mesg_with_comment_and_newlines" -a &&
> -- 
