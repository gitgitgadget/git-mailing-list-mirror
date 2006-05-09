From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/6] gitopt: a new command-line option parser for git
Date: Tue, 9 May 2006 12:39:32 -0700
Message-ID: <20060509193932.GB3676@localdomain>
References: <1147151209168-git-send-email-normalperson@yhbt.net> <11471512103526-git-send-email-normalperson@yhbt.net> <20060509120809.4d9494b9.tihirvon@gmail.com> <7v8xpb73sq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 21:39:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdY3V-0007Lz-Vb
	for gcvg-git@gmane.org; Tue, 09 May 2006 21:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWEITjf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 15:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWEITjf
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 15:39:35 -0400
Received: from hand.yhbt.net ([66.150.188.102]:37604 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750709AbWEITje (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 15:39:34 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id AE1E32DC034;
	Tue,  9 May 2006 12:39:32 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue,  9 May 2006 12:39:32 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xpb73sq.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19844>

Junio C Hamano <junkio@cox.net> wrote:
> Timo Hirvonen <tihirvon@gmail.com> writes:
> 
> > Eric Wong <normalperson@yhbt.net> wrote:
> >
> >>  * unbundling of short options: -uC20n20z => -u -C20 -n20 -z
> >
> > Does anyone ever use this?  I think this makes sense only for flags that
> > don't have parameters but that would create an ugly special case. Is it
> > too hard to type "-u -C=20 -n=20 -z"?
> 
> I can already hear in my head that people would start talking
> about "git understands insane abbeviations of options".  It
> might be unambiguous, but that does not change it is a bit on
> the insane side.  People would probably expect -nuz can be split
> into -n -u -z, and the current handcrafted mess (although it is
> more obvious and easy to work with when reading and maintaining
> the existing code) is not abbreviation friendly, which we would
> want to do something about.  But I think squashing options with
> parameters together is going a bit too far.

I think numeric parameters are unambiguous when bundled.
I'm used to things like `diff -ru10p` working, *shrug*

Non-numeric parameters can only be used if the option is at the end of the
bundled string:

git commit -sam'this is my commit message'  would work

git commit -m'say hello' would also work

but git commit -mas'this is my commit message' would not work as intended
(where user wanted -a -s, too)

> > --with-r => --patch-with-raw works great
> 
> I personally think this also is too much.

There are (currently) two types of abbreviations, one is the prefix one used
commonly in shell scripts:  -e|--e|--ed|--edi|--edit.  I think this should
always be supported as most of our shell scripts already do.

The other one tokenizes on '-' first and looks for a prefix match after
each '-'.  I'd like to make that at least optional:

diff --git a/gitopt.c b/gitopt.c
index 056e163..9ca6025 100644
--- a/gitopt.c
+++ b/gitopt.c
gitopt.c
@@ -427,7 +427,7 @@ static void fallback_long(const struct o
        }
 
        /* ok, try harder, based on tokenization on '-' */
-       if (found < 0) {
+       if (found < 0 && getenv("GIT_ABBREV_HARDER")) {
                for (i = 0; ost[i].l || ost[i].s; i++) {
                        s = &(ost[i]);
                        if (s->l && opt_token_match(s,cur)) {

-- 
Eric Wong
