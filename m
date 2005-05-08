From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 08 May 2005 18:15:36 +0200
Message-ID: <1115568937.9031.129.camel@pegasus>
References: <1115564550.9031.96.camel@pegasus>
	 <20050508152529.GU9495@pasky.ji.cz> <1115566990.9031.108.camel@pegasus>
	 <20050508155656.GV9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 18:08:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUoKW-0000E3-IV
	for gcvg-git@gmane.org; Sun, 08 May 2005 18:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbVEHQPb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 12:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbVEHQPb
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 12:15:31 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:54701 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262891AbVEHQPP
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 12:15:15 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j48GGWWX003870
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 8 May 2005 18:16:33 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050508155656.GV9495@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

> > > What is so special about 74 columns? Why not 75 (fmt default), or 72
> > > (emails)?
> > 
> > I ended up with 74, because "CG" has only two letters instead of "CVS"
> > which has three. And cg-log uses a prefix of four whitespaces. This
> > leaves two free characters at the end of a line if your terminal uses a
> > width of 80 characters. The decision was of cosmetic nature.
> 
> Isn't one free character enough?  I'll just stay with 75. :-)

I think it looks a little bit squeezed, but I don't mind at all. Maybe
using 72 is a good idea. However it is only cosmetic and I can change it
to use the fmt default.

> > > Also, I'd prefer the empty line to be always there in front of the CG:
> > > stuff (two empty lines in case of merge - I want to encourage people to
> > > keep possible details w.r.t. the merge separated by an empty line from
> > > the merge information), and when reading it back cg-commit should strip
> > > any trailing empty lines.
> > 
> > I think we should differentiate between the merges. There is no need for
> > additional information if it is an automatic merge (no conflicts) and in
> > general it makes no sense to open the editor (until forced). I wanted to
> > address this later. And yes in case of a manual merge it is a good idea
> > to add two extra empty lines at the top.
> 
> Not so. I frequently write a brief summary of what I'm actually merging.
> I'm not forcing you to do so too, but I personally think it's a good
> idea, and want to do it in the future too. :-)

What do you think about a special flag for automatic merging (which
makes the commit message say "Automatic merge") and a .cogitorc file
like .cvsrc where you can choose the default method.

I am using a lot of temporary trees where I pull a lot of kernel
subsystems together and I don't need that "feature" there.

> > This is only cosmetic. Using vim it displays the name of the temporary
> > file and confusing the user with gitci2.XXXX instead of gitci.XXX is
> > weird. Even using gitci as basename looks not good to me, but I left it
> > for now.
> 
> It boosts the patch size unnecessarily. It shouldn't be called gitci2
> anyway... :-) Feel free to change the mktemp templates instead.

I will check what I can do, but I don't really care that much about the
patch size ;)

> The gitci name comes all the way from the times where this command was
> usually triggered by 'git ci'.

I thought so. Is using cogito.XXXXXX and cogito.temp.XXXXX fine with
you?

> > Index: cg-commit
> > ===================================================================
> > --- f00d7589973e8ea65d2264f5fbac82e1b217dc8f/cg-commit  (mode:100755)
> > +++ cb61efa8a01400150162af9b0f3773f21d502fe9/cg-commit  (mode:100755)
> > @@ -94,30 +78,55 @@
> >  		echo "$uri" >>$LOGMSG
> >  		[ "$msgs" ] && echo "$uri"
> >  	done
> > -	echo >>$LOGMSG
> > +else
> > +	first=1
> >  fi
> > -first=1
> > +
> >  for msg in "${msgs[@]}"; do
> >  	if [ "$first" ]; then
> >  		first=
> >  	else
> >  		echo >>$LOGMSG
> >  	fi
> > -	echo $msg | fmt >>$LOGMSG
> > +	echo $msg | fmt -s -w 74 >>$LOGMSG
> >  done
> > +
> > +if [ "$first" ]; then
> > +	echo >>$LOGMSG
> > +fi
> 
> This mess is still here.

That is not mess. Think about it. If we have messages provided by -m we
want an empty line between the merge message and the the first commit
message. And we don't wanna have an extra empty line at the top if you
provide a commit messages via -m.

Regards

Marcel


