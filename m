From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH 3/3] builtin-add: simplify (and increase accuracy of) exclude handling
Date: Mon, 11 Jun 2007 17:01:23 +0200
Message-ID: <20070611150122.GA11020@diku.dk>
References: <20070611123045.GA28814@coredump.intra.peff.net> <20070611133956.GC7008@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 17:02:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxlPX-00013V-Ps
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 17:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbXFKPBw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 11:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754683AbXFKPBv
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 11:01:51 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:39011 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754041AbXFKPBt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 11:01:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 07822F00A1;
	Mon, 11 Jun 2007 17:01:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wQNEfkrTCNva; Mon, 11 Jun 2007 17:01:37 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 52738F009D;
	Mon, 11 Jun 2007 17:01:23 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A68376DFB5B; Mon, 11 Jun 2007 16:59:03 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 3801C62A5D; Mon, 11 Jun 2007 17:01:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070611133956.GC7008@coredump.intra.peff.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49857>

Hej Jeff,

Thanks for looking into this and making these patches. :)

Jeff King <peff@peff.net> wrote Mon, Jun 11, 2007:
>  builtin-add.c |   89 ++++++++++++++++++++++++++++++--------------------------
>  dir.c         |    1 -
>  dir.h         |    4 +--
>  3 files changed, 49 insertions(+), 45 deletions(-)
> 
> diff --git a/builtin-add.c b/builtin-add.c
> index 1591171..8988930 100644
> --- a/builtin-add.c
> +++ b/builtin-add.c
> @@ -160,6 +166,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  	const char **pathspec;
>  	struct dir_struct dir;
>  	int add_interactive = 0;
> +	int has_ignored;
>  
>  	for (i = 1; i < argc; i++) {
>  		if (!strcmp("--interactive", argv[i]) ||
> @@ -237,25 +242,19 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  	if (read_cache() < 0)
>  		die("index file corrupt");
>  
> -	if (!ignored_too) {
> -		int has_ignored = 0;
> -		for (i = 0; i < dir.nr; i++)
> -			if (dir.entries[i]->ignored)
> -				has_ignored = 1;
> -		if (has_ignored) {
> -			fprintf(stderr, ignore_warning);
> -			for (i = 0; i < dir.nr; i++) {
> -				if (!dir.entries[i]->ignored)
> -					continue;
> -				fprintf(stderr, "%s", dir.entries[i]->name);
> -				if (dir.entries[i]->ignored_dir)
> -					fprintf(stderr, " (directory)");
> -				fputc('\n', stderr);
> -			}
> -			fprintf(stderr,
> -				"Use -f if you really want to add them.\n");
> -			exit(1);
> +	has_ignored = 0;
> +	for (i = 0; i < dir.ignored_nr; i++) {
> +		if (dir.ignored[i])
> +			has_ignored = 1;
> +	}
> +	if (has_ignored) {
> +		fprintf(stderr, ignore_warning);
> +		for (i = 0; i < dir.ignored_nr; i++) {
> +			if (dir.ignored[i])
> +				fprintf(stderr, "%s\n", dir.ignored[i]->name);
>  		}
> +		fprintf(stderr, "Use -f if you really want to add them.\n");
> +		exit(1);
>  	}
>  
>  	for (i = 0; i < dir.nr; i++)

I think you could even get rid of has_ignored with something like this.

diff --git a/builtin-add.c b/builtin-add.c
index 8988930..da6ab11 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -166,7 +166,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	const char **pathspec;
 	struct dir_struct dir;
 	int add_interactive = 0;
-	int has_ignored;
 
 	for (i = 1; i < argc; i++) {
 		if (!strcmp("--interactive", argv[i]) ||
@@ -242,12 +241,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die("index file corrupt");
 
-	has_ignored = 0;
-	for (i = 0; i < dir.ignored_nr; i++) {
-		if (dir.ignored[i])
-			has_ignored = 1;
-	}
-	if (has_ignored) {
+	if (dir.ignored_nr) {
 		fprintf(stderr, ignore_warning);
 		for (i = 0; i < dir.ignored_nr; i++) {
 			if (dir.ignored[i])

-- 
Jonas Fonseca
