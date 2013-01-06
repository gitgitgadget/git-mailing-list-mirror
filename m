From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v3 11/19] dir.c: use a single struct exclude_list per
 source of excludes
Date: Sun, 6 Jan 2013 23:17:57 +0000
Message-ID: <20130106231757.GA19655@pacific.linksys.moosehall>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-12-git-send-email-git@adamspiers.org>
 <7v1ue0veww.fsf@alter.siamese.dyndns.org>
 <20130106152039.GA2396@pacific.linksys.moosehall>
 <7v7gnqnjn7.fsf@alter.siamese.dyndns.org>
 <20130106225311.GB6552@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 07 00:18:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrzTx-0004vQ-Gq
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 00:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282Ab3AFXSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 18:18:01 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:46100 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab3AFXSA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 18:18:00 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 940102E5D3
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 23:17:57 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130106225311.GB6552@pacific.linksys.moosehall>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212856>

On Sun, Jan 06, 2013 at 10:53:11PM +0000, Adam Spiers wrote:
> That's a valid point.  However, the ary[0] part which assumes external
> knowledge of the internal implementation can trivially be avoided by
> squashing this patch onto the commit we are discussing:

[snipped]

> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 0ca9d8e..0406adc 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -420,10 +420,11 @@ static int option_parse_z(const struct option *opt,
>  static int option_parse_exclude(const struct option *opt,
>  				const char *arg, int unset)
>  {
> -	struct exclude_list_group *group = opt->value;
> +	struct string_list *exclude_list = opt->value;
>  
>  	exc_given = 1;
> -	add_exclude(arg, "", 0, &group->el[0]);
> +	string_list_append(exclude_list, arg);
> +	fprintf(stderr, "append %s\n", arg);

Whoops :-)

[snipped]

> @@ -524,9 +527,13 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  	if (read_cache() < 0)
>  		die("index file corrupt");
>  
> -	add_exclude_list(&dir, EXC_CMDL);
>  	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
>  			ls_files_usage, 0);
> +	el = add_exclude_list(&dir, EXC_CMDL);
> +	for (i = 0; i < exclude_list.nr; i++) {
> +		fprintf(stderr, "adding exclude: %s\n", exclude_list.items[i].string);

Excluding those two fprintf() calls, of course :-)

I've removed them, and pushed to my github fork a new version of v4
with the fixed version of this patch inserted in the appropriate place
(and labelled with a "[SQUASH]" prefix):

    git://github.com/aspiers/git.git
    https://github.com/aspiers/git/commits/check-ignore

Since I sent v4 earlier today, to avoid spamming this list, I won't
resend the whole series yet - not until we have made some progress in
reviewing v4.
