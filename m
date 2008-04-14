From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git clean: Don't automatically remove directories when
 run within subdirectory
Date: Mon, 14 Apr 2008 00:18:13 -0700
Message-ID: <7v8wzgaoqy.fsf@gitster.siamese.dyndns.org>
References: <85fxtvj6y8.fsf_-_@lupus.strangled.net>
 <1208130578-24748-1-git-send-email-shawn.bohrer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jobh@broadpark.no, git@vger.kernel.org
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 09:19:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlIy5-0003Xz-8w
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 09:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbYDNHSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 03:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754837AbYDNHSY
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 03:18:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbYDNHSX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 03:18:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9304338B3;
	Mon, 14 Apr 2008 03:18:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B9F0838B1; Mon, 14 Apr 2008 03:18:16 -0400 (EDT)
In-Reply-To: <1208130578-24748-1-git-send-email-shawn.bohrer@gmail.com>
 (Shawn Bohrer's message of "Sun, 13 Apr 2008 18:49:37 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79476>

Shawn Bohrer <shawn.bohrer@gmail.com> writes:

> diff --git a/builtin-clean.c b/builtin-clean.c
> index fefec30..5c5ec98 100644
> --- a/builtin-clean.c
> +++ b/builtin-clean.c
> @@ -95,7 +95,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  
>  	for (i = 0; i < dir.nr; i++) {
>  		struct dir_entry *ent = dir.entries[i];
> -		int len, pos, matches;
> +		int len, pos;
> +		int matches = 0;
>  		struct cache_entry *ce;
>  		struct stat st;

Initialization of "matches" seems to be an independent clean-up.  Although
it forces the initialization in the codepath that do not need the value of
matches, that is not a big deal --- right?

> @@ -127,18 +128,16 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  
>  		if (pathspec) {
>  			memset(seen, 0, argc > 0 ? argc : 1);
> -			matches = match_pathspec(pathspec, ent->name, ent->len,
> +			matches = match_pathspec(pathspec, ent->name, len,
>  						 baselen, seen);
> -		} else {
> -			matches = 0;
>  		}

And the essential change (fix) is to send len which could be shorter than
ent->len because we have stripped '/' here, plus the one in match_one()
that now allows name[] that is not NUL terminated.

>  		if (S_ISDIR(st.st_mode)) {
>  			strbuf_addstr(&directory, ent->name);
>  			qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
> -			if (show_only && (remove_directories || matches)) {
> +			if (show_only && (remove_directories || (matches >= 2))) {
>  				printf("Would remove %s\n", qname);
> -			} else if (remove_directories || matches) {
> +			} else if (remove_directories || (matches >= 2)) {

These magic numbers are bad.  Please update it to use symbolic constants.

>  				if (!quiet)
>  					printf("Removing %s\n", qname);
>  				if (remove_dir_recursively(&directory, 0) != 0) {
> diff --git a/dir.c b/dir.c
> index b5bfbca..63715c9 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -80,7 +80,7 @@ static int match_one(const char *match, const char *name, int namelen)
>  	if (strncmp(match, name, matchlen))
>  		return !fnmatch(match, name, 0) ? MATCHED_FNMATCH : 0;
>  
> -	if (!name[matchlen])
> +	if (namelen == matchlen)
>  		return MATCHED_EXACTLY;
>  	if (match[matchlen-1] == '/' || name[matchlen] == '/')
>  		return MATCHED_RECURSIVELY;
