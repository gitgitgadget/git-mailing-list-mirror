From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH svn-fe 1/7] Remove redundant buffer_fdinit calls
Date: Mon, 20 Jun 2011 04:31:29 -0500
Message-ID: <20110620093129.GB28282@elie>
References: <1308558173-29672-1-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 11:31:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYapi-00005j-6X
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 11:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192Ab1FTJbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 05:31:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52811 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003Ab1FTJbe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 05:31:34 -0400
Received: by iwn6 with SMTP id 6so1024119iwn.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 02:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=M747U/dHNkLOZXTuByVnrbebz35hJxR+ZiNjiMc3ibQ=;
        b=ZQtLDr3Rp2wkkb4oKehOopPqtgbjNrzDVOmm7MKRkeQv8Ew0taab2x8FhvfEzayh3e
         NogqB3jiaKJ0KRw+XOUhbY/Q2DczCgIgWOK0/o7tUO9sSecGb1MhMcMlcDw085MW+VTC
         lnuVoeSSFaF4Rksmd1UsqcvLuxDITSoPl7ayA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RzTOL/7RxfvjOalHAOz+SKqfy5PVmG/1DkJRRAirUEgZpuagllPmaqY7u+gnwvayDj
         VF+ucJXABt4vOJIUbG8CwEAYt7PyKZxFvxk+DVw49zz1u+Ely/0PqiN8nLrNDqMjRy4A
         YzMb+tsAbhX73hbc17AYWsdeUA/heU4N55ANs=
Received: by 10.42.19.69 with SMTP id a5mr5538162icb.69.1308562293442;
        Mon, 20 Jun 2011 02:31:33 -0700 (PDT)
Received: from elie (adsl-69-209-50-158.dsl.chcgil.ameritech.net [69.209.50.158])
        by mx.google.com with ESMTPS id ly7sm5481461icb.12.2011.06.20.02.31.31
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Jun 2011 02:31:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308558173-29672-1-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176058>

Hi,

Dmitry Ivankov wrote:

> First of all fast_export_init called buffer_fdinit directly,
> and init_report buffer did fdopen once more - it is a FILE* leak.
> The second problem is that fast_export_init used fd passed while
> apply_delta used hardcoded REPORT_FILENO.
>
> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>

Good eyes.  As the patch "vcs-svn: implement text-delta handling"
bounced forward to a newer codebase it seems we let report_buffer be
initialized twice. :/

About the log message: it would be easier to read text that is (at
least mostly) wrapped to a consistent width.

Okay, okay, more substantive comments.  The ideal log message will
explain what the program currently does, why that's bad, and how the
patch will improve it.  In this example, that could mean something
vaguely like:

	When importing from a dump with deltas, svn-fe's fast-export module
	calls buffer_fdinit to initialize report_buffer twice: once in
	fast_export_init and once in init_report_buffer when processing the
	first delta.  The second initialization is redundant and leaks a
	FILE *.

	Fix it by relying on fast_export_init to initialize report_buffer.
	On one hand explicitly initializing like this is simpler than the
	on-demand initialization implemented by init_report_buffer, and on
	the other hand fast_export_init takes an fd as a parameter rather
	than hard-coding the requirement to read from fd 3.

Except as noted above:
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

By the way, I think it would make sense to initialize "postimage" in
fast_export_init (and deinitialize it in fast_export_deinit), too, for
a similar reason (simplification).

Thanks.  Patch left unsnipped in case others have thoughts.

> ---
>  I've added two more patches on top, they are less baked and so lack s-o-b.
>  
>  vcs-svn/fast_export.c |   12 ------------
>  1 files changed, 0 insertions(+), 12 deletions(-)
> 
> diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
> index 97f5fdf..3efde20 100644
> --- a/vcs-svn/fast_export.c
> +++ b/vcs-svn/fast_export.c
> @@ -14,7 +14,6 @@
>  #include "line_buffer.h"
>  
>  #define MAX_GITSVN_LINE_LEN 4096
> -#define REPORT_FILENO 3
>  
>  static uint32_t first_commit_done;
>  static struct line_buffer postimage = LINE_BUFFER_INIT;
> @@ -30,15 +29,6 @@ static int init_postimage(void)
>  	return buffer_tmpfile_init(&postimage);
>  }
>  
> -static int init_report_buffer(int fd)
> -{
> -	static int report_buffer_initialized;
> -	if (report_buffer_initialized)
> -		return 0;
> -	report_buffer_initialized = 1;
> -	return buffer_fdinit(&report_buffer, fd);
> -}
> -
>  void fast_export_init(int fd)
>  {
>  	if (buffer_fdinit(&report_buffer, fd))
> @@ -203,8 +193,6 @@ static long apply_delta(off_t len, struct line_buffer *input,
>  
>  	if (init_postimage() || !(out = buffer_tmpfile_rewind(&postimage)))
>  		die("cannot open temporary file for blob retrieval");
> -	if (init_report_buffer(REPORT_FILENO))
> -		die("cannot open fd 3 for feedback from fast-import");
>  	if (old_data) {
>  		const char *response;
>  		printf("cat-blob %s\n", old_data);
> -- 
> 1.7.3.4
> 
