From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC] revision limiter in git-rev-list
Date: Tue, 6 Jun 2006 13:14:36 +0200
Message-ID: <e5bfff550606060414h37099bc1u770c204c269ebad6@mail.gmail.com>
References: <e5bfff550606060136l59143ef2mdb9dc68ab78e9ff1@mail.gmail.com>
	 <7v7j3uvapa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 13:14:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnZWF-0001st-PH
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 13:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWFFLOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 07:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWFFLOi
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 07:14:38 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:52529 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751226AbWFFLOh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 07:14:37 -0400
Received: by wr-out-0506.google.com with SMTP id 55so145049wri
        for <git@vger.kernel.org>; Tue, 06 Jun 2006 04:14:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JRVwvRbWW52ZrvGQ8E8WZBOG3IZoriCfG/ji87wci5lar0KWTRLfOg4Q5Ir2PhrCoCLxbdbswJaD+820wqmJXyYqA1Gk2oLxcF44V2UL8GIGcbRExPmaiOpbUPbqTN6MDCzgWG88fr4nZ5LeV3ZxN4Yo3NX/p4n2wBBFUdRambQ=
Received: by 10.64.150.20 with SMTP id x20mr2415825qbd;
        Tue, 06 Jun 2006 04:14:36 -0700 (PDT)
Received: by 10.65.210.20 with HTTP; Tue, 6 Jun 2006 04:14:36 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v7j3uvapa.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21373>

On 6/6/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > Of course I really ignore any implementation difficult/feasibility issues ;-)
>
> I do not think your problem is ignoring difficulty/feasibility.
> The bigger problem is ignoring to describe the semantics of what
> you are proposing.
>

Sadly I have to agree, sorry.

> For example:
>
> > As example, given the following revisions history:
> >
> > a
> > b-
> > | c
> > | d
> > e
> > f
> >
> > We could add a new option --filtered so that
> >
> > git-rev-list --topo-order --filtered HEAD -- a d e
> >
> > Gives the following
> >
> > a
> > b-
> > | d
> > e
>
> Why does it give that?  Where is the HEAD in the example,

HEAD is "a", just to try to be more clear that's the graph you would see running
gitk HEAD: HEAD is at top ("a") initial revision is at bottom ("e").

>
> > Note that the merge point b has been added implicitly as in
> > path limiter case.
>
> I do not think path limiter case adds anything.  A merge is
> shown if it touches the path in an nontrivial way, but otherwise
> it isn't.

Yes.

>Also b is not a merge unless time is flowing from
> bottom to top in your picture -- it is a fork point.
>

I meant a graph as shown by gitk HEAD, so I really meant
"b" is a merge.


> While I really do not think this belongs to rev-list, I suspect
> what you want is a command that takes a set of commits you are
> interested in and gives you an abbreviated topology across them.
> I think it might be a good thing to have in our toolset (didn't
> I say that already?).
>
> So your example would become:
>
>         Given this graph (and there may be other nodes before a or after
>         d or f):
>
>                   c---d
>                  /
>             a---b---e---f
>
>         the user is interested in A, D, and E.  Show an
>         abbreviated topology containing them.
>
> which would give you
>
>                   D
>                  /
>             A---B---E
>

Yes.

>
> Unfortunately, your description is a bit too fuzzy to me, so I
> am making guesses as to what you really want.  For example,
> although you said "b is included because it is a merge", I
> strongly suspect you have cases where you would want to and not
> want to include a fork point or a merge point in the result,
> depending on the commits you are interested in.  If you are
> reducing this graph for A, H, and J:
>
>                 f---g
>                /     \
>               c---d---e---h
>              /
>         a---b---i---j
>
> I think you would want to see this as the result of graph
> reduction:
>
>               H
>              /
>         A---B---J
>
> instead of:
>
>               C---E---H
>              /
>         A---B---J
>
> That is, although e is a merge and c is a fork point, they do
> not bring anything interesting in the bird's eye view picture,
> and are filtered out.  However, b is a point where lines of
> development leading to H and J (two of the commits the user is
> interested in) forks, and it is interesting.
>
> Is this kind of graph reduction what you are after?
>
>

Practically speaking it's the kind of reduction for whom examples I
gave _do_ work.


   Marco
