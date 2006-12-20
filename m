X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Wed, 20 Dec 2006 15:03:32 -0800
Message-ID: <7v1wmu6ugr.fsf@assigned-by-dhcp.cox.net>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	<86ejquyz4v.fsf@blue.stonehenge.com>
	<86ac1iyyla.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 23:03:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <86ac1iyyla.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "20 Dec 2006 14:46:57 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34980>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxATL-00037b-AA for gcvg-git@gmane.org; Thu, 21 Dec
 2006 00:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161005AbWLTXDg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 18:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbWLTXDg
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 18:03:36 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:41368 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1161005AbWLTXDf (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 18:03:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220230333.VAGF22053.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Wed, 20
 Dec 2006 18:03:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 1B2r1W00A1kojtg0000000; Wed, 20 Dec 2006
 18:02:51 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:
>
> Randal> running "git version 1.4.4.3.g5485" on my openbsd box, but I can't get
> Randal> there on my OSX box.
>
> According to my headers, "strncasecmp" is defined in <string.h>,
> "NI_MAXSERV" is defined in <netdb.h>, and "initgrps" is defined
> in "unistd.h".  So this patch works (just verified on OSX), but I
> don't know what damage it does elsehwere:
>
> diff --git a/daemon.c b/daemon.c
> index b129b83..5ce73ed 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1,3 +1,7 @@
> +#include <string.h>
> +#include <netdb.h>
> +#include <unistd.h>
> +
>  #include "cache.h"

This unfortunately violates the "all common system headers in
git-compat-util.h" rule, which is needed to define _XOPEN_SOURCE
and friends before including the system header files.

And string.h, netdb.h and unistd.h are already included there,
so there is something deeper going on on OSX.

Is the declaration of strncasecmp in <string.h> on OSX
conditional to some macro (and the same question about other
symbols you did not get)?  We need to find out what feature
macros are expected on that platform and define them as needed.

For example, on OpenBSD, <sys/types.h> does not expose u_int
without __BSD_VISIBLE, and its <netinet/tcp.h> header uses that
type.  The source files (user programs, that's us) are expected
to include sys/types.h before including netinet/tcp.h *AND*
expected to somehow cause __BSD_VISIBLE be defined before
including sys/types.h.  That's why we have _BSD_SOURCE in our
git-compat-util.h header file (_XOPEN_SOURCE and _GNU_SOURCE
serve similar purposes for various other systems).
