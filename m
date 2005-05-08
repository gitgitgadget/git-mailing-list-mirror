From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 08 May 2005 22:26:55 +0200
Message-ID: <1115584015.8949.43.camel@pegasus>
References: <20050508152529.GU9495@pasky.ji.cz>
	 <1115566990.9031.108.camel@pegasus> <20050508155656.GV9495@pasky.ji.cz>
	 <1115568937.9031.129.camel@pegasus> <20050508171209.GX9495@pasky.ji.cz>
	 <1115572667.9031.139.camel@pegasus> <20050508173003.GY9495@pasky.ji.cz>
	 <1115574035.9031.145.camel@pegasus> <20050508175156.GA9495@pasky.ji.cz>
	 <1115578658.8949.9.camel@pegasus>  <20050508200334.GG9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 22:27:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUsMr-0002U3-S3
	for gcvg-git@gmane.org; Sun, 08 May 2005 22:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbVEHUcv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 16:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVEHUbe
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 16:31:34 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:1198 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262995AbVEHU0d
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 16:26:33 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j48KRnWX005368
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 8 May 2005 22:27:50 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050508200334.GG9495@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

> > look at the attached patch. We should use "fmt -s" to keep newlines that
> > are inside the commit message and there is one unneeded empty CG: line.
> 
> thanks, fixed and pushed out.

cool. Now I have everything I am used to from CVS, but ...

@@ -113,7 +113,9 @@
                # TODO: Prepend a letter describing whether it's addition,
                # removal or update. Or call git status on those files.
                echo "CG:    $file" >>$LOGMSG
-               [ "$msgs" ] && echo $file
+               if [ "$msgs" ] && ! [ "$forceeditor" ]; then
+                       echo $file
+               fi
        done
 fi

There is no need to print out the files if we start the editor anyway.

@@ -122,10 +124,10 @@
 if tty -s; then
        if ! [ "$msgs" ] || [ "$forceeditor" ]; then
                ${EDITOR:-vi} $LOGMSG2
-       fi
-       if ! [ "$msgs" ] && ! [ $LOGMSG2 -nt $LOGMSG ]; then
-               rm $LOGMSG $LOGMSG2
-               die 'Commit message not modified, commit aborted'
+               if ! [ $LOGMSG2 -nt $LOGMSG ]; then
+                       rm $LOGMSG $LOGMSG2
+                       die 'Commit message not modified, commit aborted'
+               fi
        fi
 else

If you provide a commit message via -m and then close the editor without
changing it, it will commit the message. I think that will not be the
intention of the user.

> > I also put back in the "mess", because if there is no commit message
> > provided via -m it gives us an initial empty line to start in. This is
> > the same that CVS does and it makes the life inside vi a lot more
> > easier.
> 
> Well, I use 'O' to start editing. ;-) (Actually, I use the -m arguments
> extensively; the way it is now is how I always dreamt of it since I
> started using SCMs. Possibly in conjuction with -e to add some fancy
> stuff.)
> 
> Your way might be cunning, fast, or even clever, but it was certainly
> not clear, therefore not maintainable well. I tried to implement it in a
> simpler and more clear way. Does it behave as you want now?

What should I say ;)

I will do a little bit more tests, but it looks very good. Besides the
stuff above.

> > > > If you want the extra newline(s) then it is a good idea to add something
> > > > that strips heading and trailing empty lines from the final commit
> > > > message, because otherwise it will be ugly if you don't enter extra text
> > > > for the merge.
> > > 
> > > Isn't that what I initially suggested? :-)
> > 
> > But this hasn't been done so far. And I don't know any shell tool for
> > this job, beside some crazy awk or sed stuff. However stripspace.c from
> > git-tools can do this job.
> 
> #/bin/sh
> 
> leading=1
> emptylines=0
> while read line; do
>         if ! [ "$line" ]; then
> 		[ "$leading" ] && continue
> 		emptylines=$(($emptylines + 1))
>         else
> 		leading=0
>                 while [ $emptylines -gt 0 ]; do
>                         echo ""
>                         emptylines=$(($emptylines - 1))
>                 done
>                 echo $line
>         fi
> done
> 
> or something? (Based on someone else's script since I was too lazy. ;-)

I am not that script expert anymore. I do most stuff in C now and I am
very happy with it. Maybe someone else comes up with a clever way to
handle the following case:

/*
 * Remove empty lines from the beginning and end.
 *
 * Turn multiple consecutive empty lines into just one
 * empty line.
 */

Regards

Marcel


