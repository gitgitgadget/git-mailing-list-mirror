From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 06:46:44 +0200
Message-ID: <e5bfff550609092146x624353daqc6e649c0d32d315f@mail.gmail.com>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	 <17666.13716.401727.601933@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0609082054560.27779@g5.osdl.org>
	 <e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com>
	 <Pine.LNX.4.64.0609091022360.27779@g5.osdl.org>
	 <e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com>
	 <Pine.LNX.4.64.0609091256110.27779@g5.osdl.org>
	 <e5bfff550609092049t5e016cacr2502ce81bbb6489e@mail.gmail.com>
	 <7vpse4uzos.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550609092123t1d8b6c70s5750fbb787534812@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Jon Smirl" <jonsmirl@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 10 06:46:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMHDV-0001dS-Cs
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 06:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbWIJEqq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 00:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965252AbWIJEqq
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 00:46:46 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:50276 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965248AbWIJEqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 00:46:45 -0400
Received: by py-out-1112.google.com with SMTP id n25so1577708pyg
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 21:46:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BElguhzy8aqmXUbui7GWYhyYAQDargDO9zUw7ix3SWZQw3NRXAI7nYDyf6Sl/Rx8HdyAwfB6HcZ80fxF0u7FP8yY7CphFliCQ6PDk3chATRTjxy1tlsl29upG9JNZBjoYe5MPQw5nxDOIDvcbl+ESkW64eVQLq0+Pm1Yke0/bHI=
Received: by 10.35.91.15 with SMTP id t15mr6121053pyl;
        Sat, 09 Sep 2006 21:46:45 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sat, 9 Sep 2006 21:46:44 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <e5bfff550609092123t1d8b6c70s5750fbb787534812@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26782>

On 9/10/06, Marco Costalba <mcostalba@gmail.com> wrote:
> On 9/10/06, Junio C Hamano <junkio@cox.net> wrote:
> > "Marco Costalba" <mcostalba@gmail.com> writes:
> >
> > > On 9/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > >>
> > >> The example is
> > >>
> > >>                     A           <--- tip of branch
> > >>                    / \
> > >>                   B   E
> > >>                   |   |
> > >>                   |   F
> > >>                   | /
> > >>                   C
> > >>                   |
> > >>                   D
> > >>                 ...
> > >>
> > >
> > > Ok now it' clear, thanks. But anyhow I think that it should be
> > > possible to avoid the check and reordering on the receiver side.
> > >
> > > Suppose for a moment to split the graph drawing from the sequence
> > > reordering problem, suppose for a moment that receiver does do not
> > > draw the graph immediately.
> > >
> > > As you described, in our case git-rev-list sends the following sequence:
> > > A, B, C, D, E, F
> > >
> > > instead git-rev-list --topo-order would have sent something like
> > > A, E, F, B, C, D
> > >
> > > Now I ask, is it possible to have a sequence (without latency) like
> > > A, B, C, D, (-3)E, (-3)F
> > >
> > > where, in case of not topological correct revisions, git-rev-list
> > > gives the hint on the correct position in sequence (3 revs before in
> > > our case) where the revision would have been if the sequence would
> > > have been --topo-order ?
> >
> > When rev-list is writing E out, it does not know it is a
> > descendant of something it already emitted (i.e. C) because it
> > hasn't looked at F nor checked its parent yet.  So asking for
> > (-3)F may be fine but I think (-3)E is just a fantasy.
> >
> Ok. What about something like this?
> A, B, C, D, E, (-3, 1)F
>
> where -3 is the correct position in sequence and 1 is the number of
> revisions before F to whom apply the -3 rule.
>

Suppose git-rev-list gives:

A, B, H, C, D, E, F, G, I, L, M, N

Suppose git-rev-list --topo-order would have sent

A, B, C, D, E, F, G, H,  I,  L, M, N

Perhaps a more general fixup syntax could be:

A,B, H, C, D, E, F, G, I(6, C, D, E, F, G, H), L, M, N

Where 6 is the number of previous revisions to rearrange with the
corresponding correct sequence(C, D, E, F, G, H).

Note that the same subset could be rearranged multiple times if it
helps git-rev-list parsing, as example it should be possible to have
something like:

A,B, H, C, D, E, F, G, I(6, C, D, E, F, G, H), L, M(3, L, G, H), N


Marco
