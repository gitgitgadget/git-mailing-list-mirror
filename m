From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I don't want the .git directory next to my code.
Date: Thu, 17 Jan 2008 17:49:26 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801171748520.5731@racer.site>
References: <478D79BD.7060006@talkingspider.com> <86hcheig3n.fsf@blue.stonehenge.com> <478D82FA.2030404@talkingspider.com> <478D95D8.5040806@theory.org> <478E3D8E.1090300@talkingspider.com> <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org>
 <alpine.LFD.1.00.0801161019250.2806@woody.linux-foundation.org> <478EEAC4.2010006@talkingspider.com> <20080117151725.GC2816@coredump.intra.peff.net> <alpine.LFD.1.00.0801170849070.14959@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Mike <fromlists@talkingspider.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 18:50:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFYsL-00075L-FE
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 18:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbYAQRtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 12:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbYAQRtd
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 12:49:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:53393 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751246AbYAQRtc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 12:49:32 -0500
Received: (qmail invoked by alias); 17 Jan 2008 17:49:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 17 Jan 2008 18:49:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VPhgBkXaVhgKgw24KHAhS6mLzhTUax4zJid2PeQ
	mUrnUDPuF6NgRK
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0801170849070.14959@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70881>

Hi,

On Thu, 17 Jan 2008, Linus Torvalds wrote:

> Ok, here's the ugliest idea *ever*:

Okay, you won.

> diff --git a/setup.c b/setup.c
> index adede16..97865f4 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "dir.h"
> +#include <attr/xattr.h>
>  
>  static int inside_git_dir = -1;
>  static int inside_work_tree = -1;
> @@ -302,6 +303,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  	 */
>  	offset = len = strlen(cwd);
>  	for (;;) {
> +		int attr_len;
> +		static char git_dir[PATH_MAX];
> +
>  		if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
>  			break;
>  		if (is_git_directory(".")) {
> @@ -312,6 +316,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  			check_repository_format_gently(nongit_ok);
>  			return NULL;
>  		}
> +		attr_len = getxattr(".", "user.git-dir", git_dir, sizeof(git_dir)-1);
> +		if (attr_len > 0) {
> +			git_dir[attr_len] = 0;
> +			if (is_git_directory(git_dir)) {
> +				setenv(GIT_DIR_ENVIRONMENT, git_dir, 1);
> +				break;

What's this break all about?

> +			}
> +		}
>  		chdir("..");
>  		do {
>  			if (!offset) {

Ciao,
Dscho
