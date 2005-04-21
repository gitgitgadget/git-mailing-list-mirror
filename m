From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] gittrack.sh accepts invalid branch names
Date: Wed, 20 Apr 2005 21:28:51 -0400
Message-ID: <1114046931.20044.11.camel@dv>
References: <1114026510.15186.15.camel@dv>
	 <20050420232110.GA12962@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 03:25:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOQR4-0000rA-BA
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 03:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVDUB3K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 21:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVDUB3K
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 21:29:10 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:4055 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261163AbVDUB2z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 21:28:55 -0400
Received: by localhost.localdomain (Postfix, from userid 500)
	id 487E1EFF27; Wed, 20 Apr 2005 21:28:51 -0400 (EDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050420232110.GA12962@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Petr!

On Thu, 2005-04-21 at 01:21 +0200, Petr Baudis wrote:
> Dear diary, on Wed, Apr 20, 2005 at 09:48:30PM CEST, I got a letter
> where Pavel Roskin <proski@gnu.org> told me that...
> > --- a/gittrack.sh
> > +++ b/gittrack.sh
> > @@ -35,7 +35,7 @@ die () {
> >  mkdir -p .git/heads
> >  
> >  if [ "$name" ]; then
> > -	grep -q $(echo -e "^$name\t" | sed 's/\./\\./g') .git/remotes || \
> > +	sed -ne "/^$name\t/p" .git/remotes | grep -q . || \
> >  		[ -s ".git/heads/$name" ] || \
> >  		die "unknown branch \"$name\""
> 
> This fixes the acceptance, but not the choice.
> 
> What does the grep -q . exactly do? Just sets error code based on
> whether the sed output is non-empty?

Yes.

>  What about [] instead?

You'll need another pair of quotes for that:

[ "$(sed -ne "/^$name\t/p" .git/remotes)" ]; echo $?

If I remember correctly from my Autoconf hacking experience, not all
shells like mixing quotes and command substitution, and even bash
treated this differently in different versions.  I can do more research,
but it seems just too fragile to me.

Another thing I remember is that "case" would not need quotes.  For some
historic reasons, the expression between "case" and "in" is subjected to
command substitution, but not word expansion.

So the patch becomes:

--- a/gittrack.sh
+++ b/gittrack.sh
@@ -35,9 +35,11 @@ die () {
 mkdir -p .git/heads
 
 if [ "$name" ]; then
-	grep -q $(echo -e "^$name\t" | sed 's/\./\\./g') .git/remotes || \
+	case x$(sed -ne "/^$name\t/p" .git/remotes) in
+	x)
 		[ -s ".git/heads/$name" ] || \
-		die "unknown branch \"$name\""
+		die "unknown branch \"$name\"" ;;
+	esac
 
 	echo $name >.git/tracking
 
Looks rather ugly for my taste, but just in case:
Signed-off-by: Pavel Roskin <proski@gnu.org>

By the way, please check all references to .git/remotes - this bug is
not specific to gittrack.sh.


-- 
Regards,
Pavel Roskin

