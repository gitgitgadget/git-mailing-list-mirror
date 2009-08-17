From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] read-tree: Fix regression with creation of a new index
 file.
Date: Tue, 18 Aug 2009 00:19:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908180018020.8306@pacific.mpi-cbg.de>
References: <877hx25u7j.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 00:19:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdAXk-00018H-7z
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 00:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376AbZHQWS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 18:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753787AbZHQWS7
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 18:18:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:43375 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753403AbZHQWS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 18:18:58 -0400
Received: (qmail invoked by alias); 17 Aug 2009 22:18:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 18 Aug 2009 00:18:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jQ3972Zyjt02Iqeb6Svj9O+j7DNYWR3Us/rXBzR
	50xa76egqwB7CW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <877hx25u7j.fsf@wine.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126300>

Hi,

On Mon, 17 Aug 2009, Alexandre Julliard wrote:

> diff --git a/builtin-read-tree.c b/builtin-read-tree.c
> index 9c2d634..14c836b 100644
> --- a/builtin-read-tree.c
> +++ b/builtin-read-tree.c
> @@ -113,13 +113,15 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
>  	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
>  			     read_tree_usage, 0);
>  
> -	if (read_cache_unmerged() && (opts.prefix || opts.merge))
> -		die("You need to resolve your current index first");
> -
>  	prefix_set = opts.prefix ? 1 : 0;
>  	if (1 < opts.merge + opts.reset + prefix_set)
>  		die("Which one? -m, --reset, or --prefix?");
> -	stage = opts.merge = (opts.reset || opts.merge || prefix_set);
> +
> +	if (opts.reset || opts.merge || opts.prefix) {
> +		if (read_cache_unmerged() && (opts.prefix || opts.merge))
> +			die("You need to resolve your current index first");
> +		stage = opts.merge = 1;
> +	}

Actually, this should be enough:

-- snipsnap --
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 9c2d634..d649c56 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -113,14 +113,14 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
 			     read_tree_usage, 0);
 
-	if (read_cache_unmerged() && (opts.prefix || opts.merge))
-		die("You need to resolve your current index first");
-
 	prefix_set = opts.prefix ? 1 : 0;
 	if (1 < opts.merge + opts.reset + prefix_set)
 		die("Which one? -m, --reset, or --prefix?");
 	stage = opts.merge = (opts.reset || opts.merge || prefix_set);
 
+	if (opts.merge && (read_cache_unmerged() && !prefix_set && !opts.reset))
+		die("You need to resolve your current index first");
+
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 
-- 
1.6.4.313.g3d9e3
