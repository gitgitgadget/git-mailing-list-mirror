From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-cvsimport doesn't quite work, wrt branches
Date: Wed, 14 Jun 2006 13:56:13 +1200
Message-ID: <46a038f90606131856o77d58467le4d3dab8021b32@mail.gmail.com>
References: <87irn5ovn6.fsf@rho.meyering.net>
	 <Pine.LNX.4.64.0606131008470.5498@g5.osdl.org>
	 <1150224411.20536.79.camel@neko.keithp.com>
	 <46a038f90606131555m7b1fa744g9770140c87598b7b@mail.gmail.com>
	 <1150241459.20536.98.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Jim Meyering" <jim@meyering.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Urlichs" <smurf@smurf.noris.de>,
	"Yann Dirson" <ydirson@altern.org>, "Pavel Roskin" <proski@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 03:56:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqKcK-0003ie-Q8
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 03:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWFNB4P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 21:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWFNB4P
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 21:56:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:37028 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964784AbWFNB4O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 21:56:14 -0400
Received: by wr-out-0506.google.com with SMTP id 50so15965wri
        for <git@vger.kernel.org>; Tue, 13 Jun 2006 18:56:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jm+61jEwzppKwHpByEp8vuA2C8hFUo5BkAr86otXgTWNsTqbNwV94BII81/hmYBYqeqyX1h1x/K0Y+isnwr3hBpp5Cae0i5pZoNT5v+juLElThwsJSgngJ5c+kLtL7uBk/jA/uXvoTe5ub5w5vJghZGFNXbYEVensMYoK+JFVfo=
Received: by 10.54.89.9 with SMTP id m9mr158969wrb;
        Tue, 13 Jun 2006 18:56:13 -0700 (PDT)
Received: by 10.54.71.9 with HTTP; Tue, 13 Jun 2006 18:56:13 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>
In-Reply-To: <1150241459.20536.98.camel@neko.keithp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21820>

On 6/14/06, Keith Packard <keithp@keithp.com> wrote:
> On Wed, 2006-06-14 at 10:55 +1200, Martin Langhoff wrote:
>
> > In terms of history parsing, parsecvs and cvs2svn are similar. I like
> > cvs2svn "many passes" approach better, though the Python source is
> > really messy. A good thing about cvs2svn is that it is a lot more
> > conservative WRT memory use.
>
> I will try to fix parsecvs so it doesn't take so much memory. Of course,
> my goal was to import various X.org repositories which have horrible
> issues, but aren't all that huge. And, for them, it works just fine.

Would it be possible to have it parse the RCS histories from a remote repo?

I had forgotten, but that's something else that the cvsps +
git-cvsimport combo can do. In short, to replace cvsps+git-cvsimport
...

 + not memory bound -- or at least must be able to import large
(mozilla, gentoo) with a decent amount of memory

 + must work local and remote (of course local can be faster)

 + must do incrementals reasonably well

> I'd like some help figuring out how to do incremental imports with
> parsecvs. As parsecvs already constructs the project history from the
> present into the past, it should be possible to "notice" when it hits
> existing bits in the repository and stop automatically. I think this
> will just take saving a bit of state in the git repository to mark where
> in CVS the tips of each branch come from.

Ok. Before starting to read the RCS files, I would look at all the
branch tips in the git repo, and read some metadata of the last commit
of each head into memory (author, commitmsg, timestamp, diffstat).

When parsing RCS files and building changesets to import, compare them
with the 'head' data. The timestamp granularity is seconds which is
pretty coarse -- you can ask for history post those timestamps, but
there's the risk of missing commits (this affects git-cvsimport today,
and I'm thinking how to fix it there). So borderline changesets should
be compared against the metadata you have.

There is the chance that your earlier import caught a commit partway
through, so you may end up putting in the 'rest' of the commit. That's
why diffstat can be useful.

Is that useful?


cheers,



martin
