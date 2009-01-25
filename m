From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] archive.c: add support for
 --submodules[=(all|checkedout)]
Date: Sun, 25 Jan 2009 12:57:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901251247040.14855@racer>
References: <1232844726-14902-1-git-send-email-hjemli@gmail.com> <1232844726-14902-2-git-send-email-hjemli@gmail.com> <1232844726-14902-3-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 12:59:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR3du-0005Du-H4
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 12:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbZAYL4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 06:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbZAYL4y
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 06:56:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:37960 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752912AbZAYL4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 06:56:54 -0500
Received: (qmail invoked by alias); 25 Jan 2009 11:56:52 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp053) with SMTP; 25 Jan 2009 12:56:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0fJ53MyS0sDVmXE5yWtPG4QMldZTU3ryZmEUoKt
	+Nahg1oR3YsNZp
X-X-Sender: gene099@racer
In-Reply-To: <1232844726-14902-3-git-send-email-hjemli@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107052>

Hi,

On Sun, 25 Jan 2009, Lars Hjemli wrote:

> The --submodules option uses the enhanced read_tree_recursive() to
> enable inclusion of submodules in the generated archive.
> 
> When invoked with `--submodules=all` all gitlink entries will be
> traversed, and when invoked with --submodules=checkedout (the default
> option) only gitlink entries with a git repo (i.e. checked out sub-
> modules) will be traversed.

                               In bare repositories, this means: none.

My reasoning for "*" instead of "all" and "" instead for "checkedout" was 
that you could allow "<name1>,<name2>" at some stage, where <name> would 
first be interpreted as a submodule group, and if that fails, as submodule 
name.

Thinking about that more, "" seems illogical, that should rather mean 
"none", i.e. the same as --no-submodules.  The "checkedout" could be "." 
then, perhaps?  As in "what we have checked out in ./, the current 
directory"?

> When a gitlink has been selected for traversal, it is required that all
> objects necessary to perform this traversal are available in either the
> primary odb or through an alternate odb. To this end, git archive will
> insert the object database of the selected gitlink (when checked out)
> as an alternate odb, using the new function add_alt_odb().

> And since alternates now can be added after parsing of 
> objects/info/alternates, the error message in link_alt_odb_entry() has 
> been updated to not mention this file.

Could you split that part into its own patch again, please?

> @@ -91,6 +92,70 @@ static void setup_archive_check(struct git_attr_check *check)
>  	check[1].attr = attr_export_subst;
>  }
>  
> +static int include_repository(const char *path)
> +{
> +	struct stat st;
> +	const char *tmp;
> +
> +	/* Return early if the path does not exist since it is OK to not
> +	 * checkout submodules.
> +	 */
> +	if (stat(path, &st) && errno == ENOENT)
> +		return 1;
> +
> +	tmp = read_gitfile_gently(path);

This will leak memory, no?

> +	if (tmp) {
> +		path = tmp;
> +		if (stat(path, &st))
> +			die("Unable to stat submodule gitdir %s: %s (%d)",
> +			    path, strerror(errno), errno);
> +	}
> +
> +	if (!S_ISDIR(st.st_mode))
> +		die("Submodule gitdir %s is not a directory", path);
> +
> +	if (add_alt_odb(mkpath("%s/objects", path)))
> +		die("submodule odb %s could not be added as an alternate",
> +		    path);
> +
> +	return 0;
> +}

Ciao,
Dscho
