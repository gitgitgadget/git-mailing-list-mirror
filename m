From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Automerge fix
Date: Tue, 19 Apr 2005 04:57:26 +0200
Message-ID: <20050419025726.GA5554@pasky.ji.cz>
References: <20050419010242.GS5554@pasky.ji.cz> <Pine.LNX.4.58.0504181945400.15725@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 04:53:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNirh-0007yr-L9
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 04:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVDSC5c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 22:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVDSC5c
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 22:57:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64436 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261290AbVDSC52 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 22:57:28 -0400
Received: (qmail 13094 invoked by uid 2001); 19 Apr 2005 02:57:26 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504181945400.15725@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 04:48:09AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> > git-merge-one-file-script: 7ebf5dac4c69043cd2ff89bf7ee552152802f8d1
> > --- a/git-merge-one-file-script
> > +++ b/git-merge-one-file-script
> > @@ -43,7 +43,7 @@ case "${1:-.}${2:-.}${3:-.}" in
> >  	orig=$(unpack-file $1)
> >  	src1=$(unpack-file $2)
> >  	src2=$(unpack-file $3)
> > -	merge "$src2" "$orig" "$src1" || echo Leaving conflict merge in $src2 && exit 1
> > +	merge "$src2" "$orig" "$src1" || (echo Leaving conflict merge in $src2 && exit 1)
> >  	cp "$src2" "$4" && update-cache --add -- "$4" && exit 0
> 
> What's the right way?
> 
> Maybe
> 
> 	if merge "$src2" "$orig" "$src1"
> 	then 
> 		cp "$src2" "$4" && update-cache --add -- "$4" && exit 0
> 	fi
> 	echo Leaving conflict merge in $src2
> 	exit 1
> 
> would work?

Possibly. Or changing () to {} as suggested by Edgar Toernig.

FWIW, my fragment of this code now looks like:

        ret=0
        if ! merge "$src2" "$orig" "$src1"; then
                echo Conflicting merge!
                cat "$src2" >"$4"
                ret=1

        elif ! cat "$src2" >"$4" && update-cache --add -- "$4"; then
                echo "Choosing $src2 -> $4 failed"
                ret=1
        fi
        rm "$orig" "$src1" "$src2"
        exit $ret

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
