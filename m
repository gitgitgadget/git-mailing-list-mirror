From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 06:23:11 +0200
Message-ID: <e5bfff550609092123t1d8b6c70s5750fbb787534812@mail.gmail.com>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	 <Pine.LNX.4.64.0609081944060.27779@g5.osdl.org>
	 <17666.13716.401727.601933@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0609082054560.27779@g5.osdl.org>
	 <e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com>
	 <Pine.LNX.4.64.0609091022360.27779@g5.osdl.org>
	 <e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com>
	 <Pine.LNX.4.64.0609091256110.27779@g5.osdl.org>
	 <e5bfff550609092049t5e016cacr2502ce81bbb6489e@mail.gmail.com>
	 <7vpse4uzos.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Jon Smirl" <jonsmirl@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 10 06:23:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMGqp-0007MM-Us
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 06:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241AbWIJEXP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 00:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbWIJEXO
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 00:23:14 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:13617 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965241AbWIJEXM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 00:23:12 -0400
Received: by py-out-1112.google.com with SMTP id n25so1571463pyg
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 21:23:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tGKmZpKm/RnrrQ7BwXB8ayDah3olM2C/bHfjX2HYpt/PBYx+rpuPNfGR25L1A6bevO4feGs33P7ONPz6N25cqBPFzutKK66rzSoTLdFydUnXXKBXD+UaSJMITuJuomm6qqB2d8vUZhYIatduzVduDeQrxfpNDnx60+g4k/NY84Y=
Received: by 10.35.15.11 with SMTP id s11mr6091881pyi;
        Sat, 09 Sep 2006 21:23:11 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sat, 9 Sep 2006 21:23:11 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vpse4uzos.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26781>

On 9/10/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > On 9/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >>
> >> The example is
> >>
> >>                     A           <--- tip of branch
> >>                    / \
> >>                   B   E
> >>                   |   |
> >>                   |   F
> >>                   | /
> >>                   C
> >>                   |
> >>                   D
> >>                 ...
> >>
> >
> > Ok now it' clear, thanks. But anyhow I think that it should be
> > possible to avoid the check and reordering on the receiver side.
> >
> > Suppose for a moment to split the graph drawing from the sequence
> > reordering problem, suppose for a moment that receiver does do not
> > draw the graph immediately.
> >
> > As you described, in our case git-rev-list sends the following sequence:
> > A, B, C, D, E, F
> >
> > instead git-rev-list --topo-order would have sent something like
> > A, E, F, B, C, D
> >
> > Now I ask, is it possible to have a sequence (without latency) like
> > A, B, C, D, (-3)E, (-3)F
> >
> > where, in case of not topological correct revisions, git-rev-list
> > gives the hint on the correct position in sequence (3 revs before in
> > our case) where the revision would have been if the sequence would
> > have been --topo-order ?
>
> When rev-list is writing E out, it does not know it is a
> descendant of something it already emitted (i.e. C) because it
> hasn't looked at F nor checked its parent yet.  So asking for
> (-3)F may be fine but I think (-3)E is just a fantasy.
>
Ok. What about something like this?
A, B, C, D, E, (-3, 1)F

where -3 is the correct position in sequence and 1 is the number of
revisions before F to whom apply the -3 rule.


>
