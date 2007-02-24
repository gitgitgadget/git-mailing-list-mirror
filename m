From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Limit filename for format-patch
Date: Sat, 24 Feb 2007 00:51:34 -0800
Message-ID: <7vtzxcym3t.fsf@assigned-by-dhcp.cox.net>
References: <200702232239.19504.robin.rosenberg@dewire.com>
	<20070223222606.28660.46208.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Feb 24 09:51:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKsdA-0002oB-84
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 09:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933439AbXBXIvg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 03:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933441AbXBXIvg
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 03:51:36 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:48624 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933439AbXBXIvf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 03:51:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070224085134.UWSA2670.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 24 Feb 2007 03:51:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TLra1W0021kojtg0000000; Sat, 24 Feb 2007 03:51:34 -0500
In-Reply-To: <20070223222606.28660.46208.stgit@lathund.dewire.com> (Robin
	Rosenberg's message of "Fri, 23 Feb 2007 23:27:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40506>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> -static void reopen_stdout(struct commit *commit, int nr, int keep_subject)
> +static int reopen_stdout(struct commit *commit, int nr, int keep_subject)
>  {
> -	char filename[1024];
> +	char filename[PATH_MAX];
>  	char *sol;
>  	int len = 0;
> -	int suffix_len = strlen(fmt_patch_suffix) + 10; /* ., NUL and slop */
> +	int suffix_len = strlen(fmt_patch_suffix) + 1;
>  
>  	if (output_directory) {
> -		strlcpy(filename, output_directory, 1000);
> +		if (strlen(output_directory) >= sizeof(filename) - 64 - suffix_len)
> +			return error("name of output directory is too long");
> +		strlcpy(filename, output_directory, sizeof(filename) - suffix_len);

Sorry for a late doubt, but I started wondering if we should use
NAME_MAX instead of hardcoded 64.  Purists might argue for using
pathconf() but I think it is an overkill.

NAME_MAX is 255 on Linux, POSIX says it should be 14 at least
(and further says if the platform supports only smaller max,
NAME_MAX should not be defined -- heh).  I do not know how
universal NAME_MAX is defined, and I hate dealing with header
incompatibility across different systems, so I am tempted to
just do something like:

#define FORMAT_PATCH_NAME_MAX 64

locally, and use that instead.
