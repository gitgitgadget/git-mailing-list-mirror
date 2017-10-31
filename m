Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 011CB2055E
	for <e@80x24.org>; Tue, 31 Oct 2017 17:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753867AbdJaRL4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 13:11:56 -0400
Received: from ikke.info ([178.21.113.177]:35776 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752177AbdJaRL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 13:11:56 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id E4BDC44038E; Tue, 31 Oct 2017 18:11:54 +0100 (CET)
Date:   Tue, 31 Oct 2017 17:33:57 +0100
From:   Kevin Daudt <me@ikke.info>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/2] sequencer: factor out rewrite_file()
Message-ID: <20171031163357.GA19161@alpha.vpn.ikke.info>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 10:54:21AM +0100, René Scharfe wrote:
> Reduce code duplication by extracting a function for rewriting an
> existing file.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  sequencer.c | 46 +++++++++++++++++-----------------------------
>  1 file changed, 17 insertions(+), 29 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index f2a10cc4f2..17360eb38a 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2665,6 +2665,20 @@ int check_todo_list(void)
>  	return res;
>  }
>  
> +static int rewrite_file(const char *path, const char *buf, size_t len)
> +{
> +	int rc = 0;
> +	int fd = open(path, O_WRONLY);
> +	if (fd < 0)
> +		return error_errno(_("could not open '%s' for writing"), path);
> +	if (write_in_full(fd, buf, len) < 0)
> +		rc = error_errno(_("could not write to '%s'"), path);
> +	if (!rc && ftruncate(fd, len) < 0)
> +		rc = error_errno(_("could not truncate '%s'"), path);
> +	close(fd);
> +	return rc;
> +}
> +
>  /* skip picking commits whose parents are unchanged */
>  int skip_unnecessary_picks(void)
>  {
> @@ -2737,29 +2751,11 @@ int skip_unnecessary_picks(void)
>  		}
>  		close(fd);
>  
> -		fd = open(rebase_path_todo(), O_WRONLY, 0666);
> -		if (fd < 0) {
> -			error_errno(_("could not open '%s' for writing"),
> -				    rebase_path_todo());
> +		if (rewrite_file(rebase_path_todo(), todo_list.buf.buf + offset,
> +				 todo_list.buf.len - offset) < 0) {
>  			todo_list_release(&todo_list);
>  			return -1;
>  		}
> -		if (write_in_full(fd, todo_list.buf.buf + offset,
> -				todo_list.buf.len - offset) < 0) {
> -			error_errno(_("could not write to '%s'"),
> -				    rebase_path_todo());
> -			close(fd);
> -			todo_list_release(&todo_list);

Is this missing on purpose in the new situation?

> -			return -1;
> -		}
> -		if (ftruncate(fd, todo_list.buf.len - offset) < 0) {
> -			error_errno(_("could not truncate '%s'"),
> -				    rebase_path_todo());
> -			todo_list_release(&todo_list);
> -			close(fd);
> -			return -1;
> -		}
> -		close(fd);
>  
>  		todo_list.current = i;
>  		if (is_fixup(peek_command(&todo_list, 0)))
> @@ -2944,15 +2940,7 @@ int rearrange_squash(void)
>  			}
>  		}
>  
> -		fd = open(todo_file, O_WRONLY);
> -		if (fd < 0)
> -			res = error_errno(_("could not open '%s'"), todo_file);
> -		else if (write(fd, buf.buf, buf.len) < 0)
> -			res = error_errno(_("could not write to '%s'"), todo_file);
> -		else if (ftruncate(fd, buf.len) < 0)
> -			res = error_errno(_("could not truncate '%s'"),
> -					   todo_file);
> -		close(fd);
> +		res = rewrite_file(todo_file, buf.buf, buf.len);
>  		strbuf_release(&buf);
>  	}
>  
> -- 
> 2.15.0

Except for that question, it looks good to me (as a beginner), it makes
the code better readable.
