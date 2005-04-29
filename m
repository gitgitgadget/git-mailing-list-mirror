From: Klaus Robert Suetterlin <robert@mpe.mpg.de>
Subject: Re: [PATCH]: first take at cleanup of #include, xmalloc / xrealloc, git status report usage.
Date: Fri, 29 Apr 2005 19:07:43 +0200
Message-ID: <20050429170743.GD93323@xdt04.mpe-garching.mpg.de>
References: <bfbb1f23220e1918afe70d4cf3de24f5@mpe.mpg.de> <20050429182407.5f6afd15.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 19:04:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRYsy-0007Th-Lp
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 19:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbVD2RIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 13:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbVD2RIO
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 13:08:14 -0400
Received: from mpehp1.mpe-garching.mpg.de ([130.183.70.10]:53006 "EHLO
	mpehp1.mpe-garching.mpg.de") by vger.kernel.org with ESMTP
	id S262839AbVD2RHp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 13:07:45 -0400
Received: from xdt04.mpe-garching.mpg.de (xdt04.mpe-garching.mpg.de [130.183.136.164])
	by mpehp1.mpe-garching.mpg.de (8.9.3 (PHNE_25183+JAGae58098)/8.9.3) with ESMTP id TAA27087;
	Fri, 29 Apr 2005 19:07:44 +0200 (METDST)
Received: (from krs@localhost)
	by xdt04.mpe-garching.mpg.de (8.13.3/8.13.1/Submit) id j3TH7h7S094753;
	Fri, 29 Apr 2005 19:07:43 +0200 (CEST)
	(envelope-from krs)
To: Edgar Toernig <froese@gmx.de>
Content-Disposition: inline
In-Reply-To: <20050429182407.5f6afd15.froese@gmx.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Thanks for reviewing this lengthy patch!

On Fri, Apr 29, 2005 at 06:24:07PM +0200, Edgar Toernig wrote:
> Robert S?tterlin wrote:
> >[...]
> > +static int
> > +create_directories(const char *path)
> >   {
> > -	int len = strlen(path);
> > -	char *buf = xmalloc(len + 1);
> > -	const char *slash = path;
> > +	char *buf = (char *)path;
> > +	char *slash = buf;
> > 
> >   	while ((slash = strchr(slash+1, '/')) != NULL) {
> > -		len = slash - path;
> > -		memcpy(buf, path, len);
> > -		buf[len] = 0;
> > -		mkdir(buf, 0755);
> > +		*slash = '\0';
> > +		if (0 != mkdir(buf, 0755))
> > +			return error("Unable to mkdir(``%s'', 0755)", buf);
> > +		*slash = '/';
> 
> You need the temp buffer.  Simply casting the const away may
> shut up the compiler but it's not correct.

Ok, I see!  Someone will pass a const char * (e.g. static string,
readonly mmap, ...).  In that case I would rather change the signature
of the function ;).  My am I a smart ass, ain't I.

What I wanted to achieve was getting rid of xmalloc that would just
die("horribly") in case we cannot allocate the memory.  Or some
other hacked up malloc / realloc alternative.

Aside: I really do not like the current habit of die("if anything does
   not work out.") in git code all that much.  People seem to take
   the die() as cast in stone, and do not free resources in code
   pathes that lead to a die(), currently.  Of course this die()
   might change in the near future.  And we will have to examine
   every die() very carefully to make sure Joe Lazy Programmer
   didn't leave any garbage lying around.
   
   IMHO, the right thing for die() would be to dump core instead of just
   exiting.  As die() should be called in the ``can't happen'' or rather
   ``isn't resolved correctly'' cases only.  And programmers would be
   able to use the core to identify these cases quickly.

Unfortunately what You say is true and I cannot see a way around
some kind of working copy (except for forcing the caller to provide
a non-const char*).  Maybe I will put ``char scratchpath[MAXPATH + 1];''
and ``#include <sys/param.h>'' in cache.h :).

> 
> > -		if (errno != EEXIST)
> > +		if (EEXIST != errno)
> 
> Too much Star Wars?  Joda-speak?

No.  This is my prefered style for two reasons:

1) Putting the non-l-value on the left hand side protects against
   my most common typo: "=" instead of "==" or "!=".  No matter which
   compiler or warning level.

2) More often than not the variable part will be longer than
   ``errno''.  So putting EEXIST and the comparator front helps seeing
   the condition I test against.  Just compare:

while (-1 != (ch = getopt(argc, argv, "abcde:fg:h:ijkl:mnopq:r:stuvwx:y:z")))
while ((ch = getopt(argc, argv, "abcde:fg:h:ijkl:mnopq:r:stuvwx:y:z")) != -1)


> 
> Ciao, ET.
> 
> 
> PS: the mkdir mode should be 0777 ...
Thanks!  I did just a literal copy of what was there before.  I
added the check for the return value, to get the right diagnostic
output.

Kind regards,

--Robert Suetterlin (robert@mpe.mpg.de)
phone: (+49)89 / 30000-3546   fax: (+49)89 / 30000-3950
