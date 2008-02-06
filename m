From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: [PATCH 4/4] Add a --cover-letter option to format-patch
Date: Wed, 6 Feb 2008 19:21:58 +0100
Message-ID: <200802061921.58282.kumbayo84@arcor.de>
References: <alpine.LNX.1.00.0802061141410.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 19:23:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMovI-00029L-M8
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 19:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbYBFSWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 13:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbYBFSWb
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 13:22:31 -0500
Received: from mail-in-17.arcor-online.net ([151.189.21.57]:51318 "EHLO
	mail-in-17.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751505AbYBFSW3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2008 13:22:29 -0500
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mail-in-17.arcor-online.net (Postfix) with ESMTP id 687102BBB2B;
	Wed,  6 Feb 2008 19:22:28 +0100 (CET)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 4DA90100C2;
	Wed,  6 Feb 2008 19:22:28 +0100 (CET)
Received: from fnoheim52.netpark.at (fnoheim52.netpark.at [83.68.151.52])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id D9F2834A6BB;
	Wed,  6 Feb 2008 19:22:27 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LNX.1.00.0802061141410.13593@iabervon.org>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.92/5711/Wed Feb  6 12:22:58 2008 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72824>

On Mittwoch 06 Februar 2008, Daniel Barkalow wrote:
> If --cover-letter is provided, generate a cover letter message before
> the patches, numbered 0.
> 
> Original patch thanks to Johannes Schindelin
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> +static int reopen_stdout(const char *oneline, int nr, int total)
>  {
>  	char filename[PATH_MAX];
> -	char *sol;
>  	int len = 0;
>  	int suffix_len = strlen(fmt_patch_suffix) + 1;
>  
>  	if (output_directory) {
> -		if (strlen(output_directory) >=
> +		len = snprintf(filename, sizeof(filename), "%s",
> +				output_directory);
> +		if (len >=
>  		    sizeof(filename) - FORMAT_PATCH_NAME_MAX - suffix_len)
>  			return error("name of output directory is too long");
> -		strlcpy(filename, output_directory, sizeof(filename) - suffix_len);
> -		len = strlen(filename);
>  		if (filename[len - 1] != '/')
>  			filename[len++] = '/';
>  	}
>  
*snip*
> +	if (!filename)
> +		len += sprintf(filename + len, "%d", nr);
maybe this should be !oneline instead?
> +	else {
> +		len += sprintf(filename + len, "%04d-", nr);
> +		len += snprintf(filename + len, sizeof(filename) - len - 1
> +				- suffix_len, "%s", oneline);
>  		strcpy(filename + len, fmt_patch_suffix);
>  	}

> +static void make_cover_letter(struct rev_info *rev,
> +		int use_stdout, int numbered, int numbered_files,
> +			      struct commit *origin, struct commit *head)
> +{
> +	const char *committer;
> +	const char *origin_sha1, *head_sha1;
> +	const char *argv[7];
> +	const char *subject_start = NULL;
> +	const char *body = "*** SUBJECT HERE ***\n\n\n*** BLURB HERE ***\n";
I don't know git policy but maybe use
const char body[] = "*** SUBJECT HERE ***\n\n\n*** BLURB HERE ***\n";
since you don't change the pointer.
(or remove the variable)
> +	const char *msg;
> +	const char *extra_headers = rev->extra_headers;
> +	struct strbuf sb;
> +	const char *encoding = "utf-8";
same here
> +
> +	if (rev->commit_format != CMIT_FMT_EMAIL)
> +		die("Cover letter needs email format");

It might be useful to split the reopen_stdout/get_oneline_for_filename
into a separate patch.

When i tried to do this --cover-letter function i went the way to create a 
empty fake commit and let log_tree_commit do all the formating stuff for me.
But i don't know if which way is preferred...

Does you patch set up a reply to chain,
so patches are in reply to cover letter?
I remember battling a bit to set it up reasonably.

Greetings Peter
Who tried to create this --cover-letter function
but gave up silently when his patch mails never reached the ML :-(

I don't know if my patches are of any use (do not apply cleanly anymore, 
reading cover letter message from a file does not honor encoding in any way)
But i can send them to you if you want...
