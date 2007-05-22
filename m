From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Cross-reference the manpages for git-name-rev and git-describe
Date: Mon, 21 May 2007 23:13:09 -0700
Message-ID: <7vhcq59yiy.fsf@assigned-by-dhcp.cox.net>
References: <20070519120933.GW17511@curie-int.orbis-terrarum.net>
	<20070519121154.GA10268@coredump.intra.peff.net>
	<pan.2007.05.19.15.45.46@progsoc.org> <vpq646opzio.fsf@bauges.imag.fr>
	<A04FB6C2-20B2-4263-9D58-6C281C04C6C4@silverinsanity.com>
	<vpq8xbkoir8.fsf@bauges.imag.fr>
	<839C7D1E-E1D0-4EA1-8221-789C418CB242@silverinsanity.com>
	<7vfy5sy91f.fsf@assigned-by-dhcp.cox.net>
	<vpq7ir3658t.fsf_-_@bauges.imag.fr>
	<7vsl9rmkm0.fsf@assigned-by-dhcp.cox.net>
	<20070521072025.GO3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 22 08:13:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqNcx-0002n9-83
	for gcvg-git@gmane.org; Tue, 22 May 2007 08:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759AbXEVGNN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 02:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760069AbXEVGNM
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 02:13:12 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:62032 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756759AbXEVGNL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 02:13:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070522061310.GUBA12190.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 22 May 2007 02:13:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 26D91X00C1kojtg0000000; Tue, 22 May 2007 02:13:10 -0400
In-Reply-To: <20070521072025.GO3141@spearce.org> (Shawn O. Pearce's message of
	"Mon, 21 May 2007 03:20:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48072>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Teach git-describe how to run name-rev
>
> Often users want to know not which tagged version a commit came
> after, but which tagged version a commit is contained within.
> This latter task is the job of git-name-rev, but most users are
> looking to git-describe to do the job.
>
> Junio suggested we make `git describe --contains` run the correct
> tool, `git name-rev`, and that's exactly what we do here.  The output
> of name-rev was adjusted slightly through the new --name-only option,
> allowing describe to execv into name-rev and maintain its current
> output format.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ...
> diff --git a/builtin-describe.c b/builtin-describe.c
> index 165917e..efbd43f 100644
> --- a/builtin-describe.c
> +++ b/builtin-describe.c
> ...
> @@ -272,6 +276,17 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  
>  	save_commit_buffer = 0;
>  
> +	if (contains) {
> +		const char **nr = xmalloc((4 + argc - i) * sizeof(char*));
> +		nr[0] = "name-rev";
> +		nr[1] = "--name-only";
> +		nr[2] = "--tags";
> +		memcpy(nr + 3, argv + i, (argc - i) * sizeof(char*));
> +		nr[3 + argc - i] = NULL;
> +		execv_git_cmd(nr);
> +		die("unable to start %s", nr[0]);
> +	}
> +
>  	if (argc <= i)
>  		describe("HEAD", 1);
>  	else

Sorry for a belated question, but is there a reason not to do
this (on top)?

diff --git a/builtin-describe.c b/builtin-describe.c
index efbd43f..2a32af6 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -283,8 +283,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		nr[2] = "--tags";
 		memcpy(nr + 3, argv + i, (argc - i) * sizeof(char*));
 		nr[3 + argc - i] = NULL;
-		execv_git_cmd(nr);
-		die("unable to start %s", nr[0]);
+		return cmd_name_rev(3 + argc - i, nr, prefix);
 	}
 
 	if (argc <= i)
