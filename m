From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] builtin/log.c: fix minor memory leak
Date: Thu, 7 Aug 2014 11:04:35 -0700
Message-ID: <20140807180435.GD12427@google.com>
References: <1407431617-4156-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 07 20:04:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFS3O-0008Vs-Sr
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 20:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbaHGSEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 14:04:39 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:41558 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbaHGSEi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 14:04:38 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so5731594pab.26
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 11:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zJjEzT69pmRqDCtqgOHJDhYBzDhnvegxP3mxc0qnTzM=;
        b=vlc4IFfUzSlHTVDHVR6koVrF+TsDOIRET4x/nnsldSZm+HhZdDnbvZheD5fcWk6RMI
         RaFV/4SF8OxeXcDvN6Ru09T00A+xcqeu+s8BdHJ/l4q3eQk91RwrPFfAuvmAAcr3EqIS
         ZNW0PS7uDOia3BDXOnkmgPIBMqNi1v/e6hvSk+oxVnKuoOKpMtrmSIORab/lKYQW9Gy4
         rR4vNGcgiiWALQ5R+xuqHkyBtmn4UHoljidmaF4KFwoLLnS39HAHhZWwW6aVMbNWk20/
         JOy/rdk3hkvPKmcjjXzxJtr5sduLRpMc0enHevsFCL6kblMzXSkdp4qTotMLNm+Xisgq
         DdrQ==
X-Received: by 10.70.129.162 with SMTP id nx2mr11371244pdb.73.1407434678247;
        Thu, 07 Aug 2014 11:04:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:9932:b877:7123:e96a])
        by mx.google.com with ESMTPSA id io7sm531046pbd.11.2014.08.07.11.04.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 11:04:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1407431617-4156-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254984>

Matthieu Moy wrote:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Valgrind confirms, one less unreachable block ;-).

This belongs in the commit message.

[...]
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -857,20 +857,21 @@ static void add_branch_description(struct strbuf *buf, const char *branch_name)
>  {
>  	struct strbuf desc = STRBUF_INIT;
>  	if (!branch_name || !*branch_name)
>  		return;
>  	read_branch_desc(&desc, branch_name);
>  	if (desc.len) {
>  		strbuf_addch(buf, '\n');
>  		strbuf_addbuf(buf, &desc);
>  		strbuf_addch(buf, '\n');
>  	}
> +	strbuf_release(&desc);

This is an old one.  The leak was introduced by v1.7.9-rc1~1^2~12
(format-patch: use branch description in cover letter, 2011-09-21).

I was a little scared to see a leak in 'git log' code, since most of
what log does involves looping over many commits.  Luckily this one is
only used in make_cover_letter to create a cover letter describing the
single branch on the command line, making it is a small, one-time
leak.

Less noise from static and dynamic analysis tools is still worthwhile,
so for what it's worth,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
