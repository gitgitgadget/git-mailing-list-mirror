From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 5/5] diff: parse U/u/unified options with an optional integer arg
Date: Sun, 14 May 2006 16:36:06 -0700
Message-ID: <20060514233606.GA10249@hand.yhbt.net>
References: <11476199631085-git-send-email-normalperson@yhbt.net> <Pine.LNX.4.64.0605140931410.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 01:36:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfQ8B-0007F9-88
	for gcvg-git@gmane.org; Mon, 15 May 2006 01:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWENXgI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 19:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWENXgI
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 19:36:08 -0400
Received: from hand.yhbt.net ([66.150.188.102]:32671 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751406AbWENXgH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 19:36:07 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id C9E967DC005; Sun, 14 May 2006 16:36:06 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605140931410.3866@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19994>

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Sun, 14 May 2006, Eric Wong wrote:
> > 
> > -u (lowercase) now accepts an optional arg, like -U (GNU diff
> > -u also has this behavior).
> 
> Actually, modern GNU "diff -u5" will say
> 
> 	diff: `-5' option is obsolete; use `-U 5'
> 	diff: Try `diff --help' for more information.
> 
> and exit.
> 
> I'm not entirely sure why, but I think it's because "u" can be mixed (ie 
> with something like "-urN"), while "U" cannot. The GNU diff rule seems to 
> be that simple arguments can be mixed together, but arguments with 
> parameters cannot. Which sounds sane.

Interesting.  With _POSIX2_VERSION < 200112, diff is happy to accept
-u5.  Setting _POSIX2_VERSION >= 200112 causes it to burp, however.

It turns out -u5 is actually short for -u -5, but I (and apparently some
other people) have always assumed -u5 worked like -U5.  POSIX doesn't
like -<num> switches, however, but we support it regardless in rev-list.

I prefer that it works the -u5 way, of course :)

Also, I find integer arguments being bundled with other parameters to be
pretty nice feature, but it's easy to disable if users don't like it:

diff --git a/gitopt.c b/gitopt.c
index 9e85247..139cd2d 100644
--- a/gitopt.c
+++ b/gitopt.c
@@ -270,17 +270,9 @@ static const char * parse_bundled(struct
        } else if (s->arg_fl) {
                if (*cur) {
                        /* no space between the arg and opt switch: */
-                       if (s->arg_fl & ARG_IS_INT) {
-                               /* we know to handle stuff like:
-                                * -h24w80 => -h=24 -w=80 */
-                               char *endptr = (char *)cur;
-                               strtol(cur, &endptr, 10);
-
-                               while (cur < endptr)
-                                       *c++ = *cur++;
-                       } else if (s->arg_fl & ARG_ONE) {
-                               /* unfortunately, other args are less
-                                * clear-cut */
+                       if (s->arg_fl & ARG_ONE) {
+                               /* don't attempt further unbundling, extra
+                                * chars are arguments */
                                while (*cur)
                                        *c++ = *cur++;
                        }

-- 
Eric Wong
