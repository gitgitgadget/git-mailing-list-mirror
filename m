From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: add ignore non-existent files option.
Date: Mon, 1 Sep 2008 15:38:03 -0700
Message-ID: <20080901223802.GK7482@spearce.org>
References: <94a0d4530809011501n651c42c8xebb5cc39a93aac4c@mail.gmail.com> <1220308173-20392-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 00:39:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaI3D-0000yd-D8
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 00:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbYIAWiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 18:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbYIAWiF
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 18:38:05 -0400
Received: from george.spearce.org ([209.20.77.23]:60696 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbYIAWiF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 18:38:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1007F38375; Mon,  1 Sep 2008 22:38:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1220308173-20392-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94619>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
> This is useful for SCMs that don't have proper changesets in each
> revision (monotone).
 
> +--tolerant::
> +	Avoid fatal exceptions when actions are executed in non-existent
> +	files.  For example removing a file that is not there.
> +

Yea.  But I'm not sure --tolerant is the best name.  --ignore-errors
or --treat-errors-as-warnings sounds better to me.
  
> diff --git a/fast-import.c b/fast-import.c
> index 7089e6f..01be3fa 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -345,6 +345,7 @@ static struct recent_command *rc_free;
>  static unsigned int cmd_save = 100;
>  static uintmax_t next_mark;
>  static struct strbuf new_data = STRBUF_INIT;
> +static int tolerant;
>  
>  static void write_branch_report(FILE *rpt, struct branch *b)
>  {
> @@ -1993,8 +1994,15 @@ static void file_change_cr(struct branch *b, int rename)
>  		tree_content_remove(&b->branch_tree, s, &leaf);
>  	else
>  		tree_content_get(&b->branch_tree, s, &leaf);
> -	if (!leaf.versions[1].mode)
> -		die("Path %s not in branch", s);
> +	if (!leaf.versions[1].mode) {
> +		if (tolerant) {
> +			if (leaf.tree)
> +				release_tree_content_recursive(leaf.tree);
> +			warning("Path %s not in branch", s);
> +			return;
> +		} else
> +			die("Path %s not in branch", s);
> +	}
>  	tree_content_set(&b->branch_tree, d,
>  		leaf.versions[1].sha1,
>  		leaf.versions[1].mode,
> @@ -2447,6 +2455,8 @@ int main(int argc, const char **argv)
>  			show_stats = 0;
>  		else if (!strcmp(a, "--stats"))
>  			show_stats = 1;
> +		else if (!strcmp(a, "--tolerant"))
> +			tolerant = 1;
>  		else
>  			die("unknown option %s", a);
>  	}

-- 
Shawn.
