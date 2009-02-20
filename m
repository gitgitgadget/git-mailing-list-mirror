From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make git blame date output format configurable, a la
	git log
Date: Fri, 20 Feb 2009 09:27:30 -0500
Message-ID: <20090220142730.GA32751@coredump.intra.peff.net>
References: <1235136252-29649-1-git-send-email-eletuchy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, marius@trolltech.com,
	Eugene Letuchy <eugene@facebook.com>
To: eletuchy@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 20 15:29:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaWNf-0001DC-Uh
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 15:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbZBTO1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 09:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753758AbZBTO1f
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 09:27:35 -0500
Received: from peff.net ([208.65.91.99]:33271 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbZBTO1d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 09:27:33 -0500
Received: (qmail 2572 invoked by uid 107); 20 Feb 2009 14:27:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Feb 2009 09:27:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Feb 2009 09:27:30 -0500
Content-Disposition: inline
In-Reply-To: <1235136252-29649-1-git-send-email-eletuchy@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110847>

On Fri, Feb 20, 2009 at 05:24:12AM -0800, eletuchy@gmail.com wrote:

>  - git config value blame.date that expects one of the git log date
>    formats ({relative,local,default,iso,rfc,short})

OK. I was concerned that this might muck with scripts, but it looks like
the --porcelain and --incremental codepaths are properly unaffected.
Good.

>  - git blame command line option --date-format expects one of the git
>    log date formats ({relative,local,default,iso,rfc,short})

Why not --date= ?

It is currently accepted by the revision option parsing, but not used;
you would just need to pull the value from revs.date_mode instead of
adding a new option.

> The tests pass. The mailmap test needed to be modified to expect iso
> formatted blames rather than the new "default".

So there are actually two changes here:

  1. support specifying date format

  2. changing the default date format

I think (1) is a good change, but it should definitely not be lumped in
with (2), as people might like one and not the other (and I happen not
to like (2)).


All of that being said, I think there are two code issues to be dealt
with:

  1. There seems to be a bug. With your patch, running a simple test
     like:

       git blame --date-format=relative wt-status.c

     gives me relative output on some lines, and not on others. E.g.,
     the first 10 lines are:

85023577 (Junio C Hamano      Tue Dec 19 14:34:12 2006 -0800   1) #include "cache.h"
c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400   2) #include "wt-status.h"
c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400   3) #include "color.h"
c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400   4) #include "object.h"
c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400   5) #include "dir.h"
c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400   6) #include "commit.h"
c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400   7) #include "diff.h"
c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400   8) #include "revision.h"
c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400   9) #include "diffcore.h"
a734d0b1 (Dmitry Potapov      12 months ago  10) #include "quote.h"
ac8d5afc (Ping Yin            10 months ago  11) #include "run-command.h"
b6975ab5 (Junio C Hamano      8 months ago  12) #include "remote.h"
c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400  13)

  2. As you can see in the output above, there are potential alignment
     issues. The original date format had a fixed width, whereas
     arbitrary date formats can be variable. Obviously the mixture of
     relative and ISO dates makes it much worse, but even within an ISO
     date there are problems (e.g., "19" versus "8").

-Peff
