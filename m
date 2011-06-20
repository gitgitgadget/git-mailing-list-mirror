From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH svn-fe 5/7] Fix vcs-svn/fast_export reinit bugs
Date: Mon, 20 Jun 2011 05:12:55 -0500
Message-ID: <20110620101254.GG28282@elie>
References: <1308558173-29672-1-git-send-email-divanorama@gmail.com>
 <1308558173-29672-5-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 12:13:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYbTc-0002X2-Pa
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 12:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443Ab1FTKM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 06:12:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33526 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab1FTKM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 06:12:59 -0400
Received: by iwn6 with SMTP id 6so1048925iwn.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 03:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dXphqN5k5L1j6mnkl2B5zl8OvMeDgOjOVnb7hLeOfkI=;
        b=rccdpP2GdPk/Twqx83WyWI5FbCfrz3s7zNRsRhxz2d8Mfzi+ykkTkhJlOxtt5BPKol
         o0aKIPZNA4wGqTTNtKT3RMfmJB6wmtQAw2qx2NoB+Kcmnk+O5C71p2oFHUrlZTt2V194
         b9jvpeI+yV44aLoBieqUxS7Fnv/r1a+MDEVP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uhwUz5AUOdU8fALSHlJYMXG7MQrGx71Ih71XmQwejI63zTdRUjS0/+t/G0lHow0vs5
         EpJ8qhHro5Q/mbUyALsojZvR7n8/imvEXli64nLPU/1V4dwkWVWr1uo7J2nbSJTeul8P
         J0wBSO2EaBInG0hRTMfRDfmqJ6XH8jRJpGcW8=
Received: by 10.231.209.138 with SMTP id gg10mr4948735ibb.107.1308564778744;
        Mon, 20 Jun 2011 03:12:58 -0700 (PDT)
Received: from elie (adsl-69-209-50-158.dsl.chcgil.sbcglobal.net [69.209.50.158])
        by mx.google.com with ESMTPS id s2sm1727466ibe.35.2011.06.20.03.12.57
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Jun 2011 03:12:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308558173-29672-5-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176060>

Hi,

Dmitry Ivankov wrote:

> first_commit_done was not set in _init, but it
> is needed if fast_export_ is used/_init-ed twice.

Thanks, good catch.  I wonder if it's possible to detect this kind of
thing automatically --- maybe it would make sense for test-svn-fe to
learn to apply two dumps in sequence so this code could be exercised.

> Same thing for the branch_name.

This one should be squashed with the previous patch for easier review
imho.  New readers never have to know the details of early mistakes.

>
> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
> ---
>  vcs-svn/fast_export.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
> index 8b14b74..6a4360f 100644
> --- a/vcs-svn/fast_export.c
> +++ b/vcs-svn/fast_export.c
> @@ -32,6 +32,8 @@ static int init_postimage(void)
>  
>  void fast_export_init(int fd, const char* branch)
>  {
> +	first_commit_done = 0;
> +	strbuf_reset(&branch_name);
>  	strbuf_addstr(&branch_name, branch);
>  	if (buffer_fdinit(&report_buffer, fd))
>  		die_errno("cannot read from file descriptor %d", fd);
> @@ -45,7 +47,9 @@ void fast_export_deinit(void)
>  
>  void fast_export_reset(void)
>  {
> +	first_commit_done = 0;

I don't think this is needed --- fast_export_reset is called when we
are about to exit.  Maybe the vcs-svn::*_reset functions should be
renamed to foo_free or something similar to avoid confusion
(especially when comparing to strbuf_reset).

>  	buffer_reset(&report_buffer);
> +	strbuf_reset(&branch_name);
>  }
>  
>  void fast_export_delete(const char *path)
> -- 
> 1.7.3.4
> 
