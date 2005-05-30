From: Alecs King <alecsk@gmail.com>
Subject: Re: [COGITO PATCH] Fix cg-log and cg-status for non-GNU sed/sort
Date: Tue, 31 May 2005 01:00:38 +0800
Message-ID: <20050530165655.GA1377@alc.bsd.st>
References: <20050529231652.GX1036@pasky.ji.cz> <20050529234326.12407.qmail@web41203.mail.yahoo.com> <20050529234911.GZ1036@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 30 18:56:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcnXX-0001JN-Fm
	for gcvg-git@gmane.org; Mon, 30 May 2005 18:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVE3Q5R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 12:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVE3Q5R
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 12:57:17 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:7707 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261565AbVE3Q4f (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 12:56:35 -0400
Received: by wproxy.gmail.com with SMTP id 69so2391471wri
        for <git@vger.kernel.org>; Mon, 30 May 2005 09:56:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ejhO7MKQgo+3VpozZpCboEQtRnGMVjGrdiInh+I5qVFl4k4YM/BjsQ+1Un+ydQSJ75zBnuG4ZFn4ci/oTLNJTdkFl+XhRlBJXqIJmUdtn+kzUPEtZk7zmxh+AeconMwVOXJUSkgauP7UKHEJZNbqf3SryoW2CobZkN47JbuIUTA=
Received: by 10.54.27.62 with SMTP id a62mr5701772wra;
        Mon, 30 May 2005 09:56:35 -0700 (PDT)
Received: from localhost ([210.77.2.13])
        by mx.gmail.com with ESMTP id 35sm302586wra.2005.05.30.09.56.33;
        Mon, 30 May 2005 09:56:35 -0700 (PDT)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050529234911.GZ1036@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 30, 2005 at 01:49:11AM +0200, Petr Baudis wrote:
> > > > -                               echo; sed -re '
> > > > -                                       /
> > > *Signed-off-by:.*/Is//'$colsignoff'&'$coldefault'/
> > > > -                                       /
> > > *Acked-by:.*/Is//'$colsignoff'&'$coldefault'/
> > > > -                                       s/./    &/
> > > > -                               '
> > > > +                               echo; sed -e "/
> > > > *Signed-off-by:.*/s/
> > > *Signed-off-by:.*/$colsignoff&$coldefault/" -e"/
> > > > +*Acked-by:.*/s/ *Acked-by:.*/$colsignoff&$coldefault/" -e "s/./
> > > > &/"
> > > > +
> > > 
> > > Is it necessary to take away the newlines? What is the real
> > > problem,
> > > actually? Just the I flag?
> > 
> > Is it strictly necessary to take away the newlines? I don't know. To
> > be honest, I didn't 
> > experiment too much with alternate implementations. But the I flag
> > in the sed script, 
> > yes that is not understood by non-GNU sed. And the "-r" to sed
> > itself is also
> > problematic.
> 
> I think we don't really need -r anyway. Could you please try with the
> 'i' flag instead of 'I'? (The manpage is somewhat unclear on the
> difference and portability.) Also, could you try if it works with the
> newlines?

-r here is for the 'I' (same as 'i') modifier, which means case
insensitive.  non-GNU sed might not have the '-r' option or the 'I'
('i') modifier.

I dunno about the strict rules of 'Signed-off-by' things but what i have
seen are all _exactly_ of this form.  I have never seen something like
'SIGNED-OFF-BY' or 'sIGneD-oFf-bY'.

If only the exact case sensitive form is allowed, then we can safely
remove the '-r' and 'I'.

Also, to Mark, as a quick alternative to work around these sed issues,
you can install the gsed port.  IIRC, opendarwin has this port.

Speaking of other portability issues, i made up a patch to make cogito
properly work under fbsd (without hurting others hopefully) weeks ago:

1) expr would regard a negative $dtz as an option (-xx).
2) coloring for both terminfo & termcap terminal.

Index: cg-Xlib
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-Xlib  (mode:100755)
+++ 4e3c899dfa4a74effdb4ae23528785b8f688561d/cg-Xlib  (mode:100755)
@@ -43,7 +43,7 @@
 	date="$1"
 	sec=${date[0]}; tz=${date[1]}
 	dtz=${tz/+/}
-	lsec=$(expr $dtz / 100 \* 3600 + $dtz % 100 \* 60 + $sec)
+	lsec=$(expr \( $dtz \) / 100 \* 3600 + \( $dtz \) % 100 \* 60 +
$sec)
 	pdate="$(date -Rud "1970-01-01 UTC + $lsec sec" 2>/dev/null)"
 
 	echo "${pdate/+0000/$tz}"
Index: cg-log
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-log  (mode:100755)
+++ 4e3c899dfa4a74effdb4ae23528785b8f688561d/cg-log  (mode:100755)
@@ -42,13 +42,14 @@
 	# TODO: Parse -r here too.
 	case "$1" in
 	-c)
-		# See terminfo(5), "Color Handling"
-		colheader="$(tput setaf 2)"    # Green
-		colauthor="$(tput setaf 6)"    # Cyan
-		colcommitter="$(tput setaf 5)" # Magenta
-		colfiles="$(tput setaf 4)"     # Blue
-		colsignoff="$(tput setaf 3)"   # Yellow
-		coldefault="$(tput op)"        # Restore default
+		# ANSI escape seq
+		esc=$(echo -e '\e')
+		colheader="${esc}[0;32m"    # Green
+		colauthor="${esc}[0;36m"    # Cyan
+		colcommitter="${esc}[0;35m" # Magenta
+		colfiles="${esc}[0;34m"     # Blue
+		colsignoff="${esc}[0;33m"   # Yellow
+		coldefault="${esc}[0m"      # Restore default
 		shift
 		;;
 	-f)

-- 
Alecs King
