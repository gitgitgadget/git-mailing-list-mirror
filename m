From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/9] vcs-svn: pass paths through to fast-import
Date: Sat, 19 Mar 2011 02:50:28 -0500
Message-ID: <20110319075028.GB4063@elie>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300518231-20008-2-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:50:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qvq-00068F-7B
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891Ab1CSHuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:50:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36168 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab1CSHug (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:50:36 -0400
Received: by iwn34 with SMTP id 34so4754856iwn.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 00:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dwjx0ePROqKCQFI16KT7eSntX37RerFdM8DVj6azHoE=;
        b=Qj4TUc2aMU//SJvIoSk9DBvyawep7sv1Qo0+SMSkeHTCcqsvNPnGRdl0JzCFuPQCHS
         Q/wsK0GSxl6bTIWhJs3Mh2/fiLBStpuutwJefPMYpFALckLf1xrNafDfCQij1BQFgS3H
         kFNgyx9G2xVkZZE102IjHe9DWpRhNO2VoSFz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FZSr+PVmtbIERm1UK9YQn/YtKZD9RaXuwxHz4lt4YSB0+gglIA4c9Bf6OjRVuMaH95
         vRpDS+/2Dw8AoXtNUavHGT1ZZIGqVOKImpVetnGIuFd85XM0QEAw35IocezFpLXZXbP4
         GZ2AZj97Vehp0RoZhgodJQPr9TTmw2/auyWI4=
Received: by 10.42.132.198 with SMTP id e6mr2873899ict.328.1300521035443;
        Sat, 19 Mar 2011 00:50:35 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id s40sm2061976ibg.43.2011.03.19.00.50.32
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 00:50:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300518231-20008-2-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169413>

Hi,

David Barr wrote:

>  vcs-svn/fast_export.c |   47 ++++++++++++++++++------------------
>  vcs-svn/fast_export.h |    9 +++----
>  vcs-svn/repo_tree.c   |   20 +++++++-------
>  vcs-svn/repo_tree.h   |   13 ++++------
>  vcs-svn/svndump.c     |   63 +++++++++++++++++++++----------------------------
>  5 files changed, 70 insertions(+), 82 deletions(-)

Hoorah!  Simpler and more idiomatic.

> +++ b/vcs-svn/fast_export.c
> @@ -32,30 +34,30 @@ void fast_export_reset(void)
[...]
>  	buffer_reset(&report_buffer);
>  }
>  
> -void fast_export_delete(uint32_t depth, const uint32_t *path)
> +void fast_export_delete(const char *path)
>  {
> -	printf("D \"");
> -	pool_print_seq_q(depth, path, '/', stdout);
> -	printf("\"\n");
> +	putchar('D');
> +	putchar(' ');
> +	quote_c_style(path, NULL, stdout, 0);
> +	putchar('\n');
>  }

Functional change: if the path doesn't need quoting, this won't
surround it with quotation marks.  Luckily fast-import doesn't
mind.

[...]
> -	printf("M %06"PRIo32" %s \"", mode, dataref);
> -	pool_print_seq_q(depth, path, '/', stdout);
> -	printf("\"\n");
> +	printf("M %06"PRIo32" %s ", mode, dataref);
> +	quote_c_style(path, NULL, stdout, 0);
> +	putchar('\n');
[...]
> -	printf("ls :%"PRIu32" \"", rev);
> -	pool_print_seq_q(depth, path, '/', stdout);
> -	printf("\"\n");
> +	printf("ls :%"PRIu32" ", rev);
> +	quote_c_style(path, NULL, stdout, 0);
> +	putchar('\n');

Likewise.

[...]
> -static void ls_from_active_commit(uint32_t depth, const uint32_t *path)
> +static void ls_from_active_commit(const char *path)
>  {
>  	/* ls "path/to/file" */
>  	printf("ls \"");
> -	pool_print_seq_q(depth, path, '/', stdout);
> +	quote_c_style(path, NULL, stdout, 1);
>  	printf("\"\n");

Single-argument 'ls': quotes always present.  Phew.

[...]
> --- a/vcs-svn/repo_tree.h
> +++ b/vcs-svn/repo_tree.h
> @@ -8,15 +8,12 @@
>  #define REPO_MODE_EXE 0100755
>  #define REPO_MODE_LNK 0120000
>  
> -#define REPO_MAX_PATH_LEN 4096
> -#define REPO_MAX_PATH_DEPTH 1000

Yes.

> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -11,8 +11,8 @@
>  #include "repo_tree.h"
>  #include "fast_export.h"
>  #include "line_buffer.h"
> -#include "obj_pool.h"
>  #include "string_pool.h"
> +#include "strbuf.h"
>  
>  #define REPORT_FILENO 3
>  
> @@ -31,32 +31,20 @@
>  #define LENGTH_UNKNOWN (~0)
>  #define DATE_RFC2822_LEN 31
>  
> -/* Create memory pool for log messages */
> -obj_pool_gen(log, char, 4096)
> -

Not a path. :)  Snuck in from a separate patch?

>  static struct line_buffer input = LINE_BUFFER_INIT;
>  
>  #define REPORT_FILENO 3
>  
> -static char *log_copy(uint32_t length, const char *log)
> -{
[...]
> -}

Likewise.

[...]
>  static struct {
>  	uint32_t revision, author;
>  	unsigned long timestamp;
> -	char *log;
> +	struct strbuf log;
>  } rev_ctx;

Likewise.

[... etc ...]
> @@ -406,6 +395,9 @@ int svndump_init(const char *filename)
>  	if (buffer_init(&input, filename))
>  		return error("cannot open %s: %s", filename, strerror(errno));
>  	fast_export_init(REPORT_FILENO);
> +	strbuf_init(&rev_ctx.log, 4096);
> +	strbuf_init(&node_ctx.src, 4096);
> +	strbuf_init(&node_ctx.dst, 4096);

4096 because PATH_MAX or some other reason?

> @@ -415,11 +407,13 @@ int svndump_init(const char *filename)
>
>  void svndump_deinit(void)
>  {
> -	log_reset();
>  	fast_export_deinit();
>  	reset_dump_ctx(~0);
>  	reset_rev_ctx(0);
>  	reset_node_ctx(NULL);
> +	strbuf_release(&rev_ctx.log);
> +	strbuf_release(&node_ctx.src);
> +	strbuf_release(&node_ctx.dst);

Side note: it's often not clear what should go in the "prepare for next
user" routine and what should go in the "shutting down for good".  I
suppose these should use strbuf_reset and the memory would be finally
freed in svndump_reset?  Does it make sense to have two distinct
routines like this without a user to demonstrate the trade-offs?

Except as noted above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks; I like where this is going.
