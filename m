From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Change set based shallow clone
Date: Sat, 9 Sep 2006 21:17:10 +0200
Message-ID: <e5bfff550609091217r7fc17438pc969b2b2ae080584@mail.gmail.com>
References: <e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com>
	 <20060909184441.23764.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, git@vger.kernel.org, jonsmirl@gmail.com,
	paulus@samba.org
X-From: git-owner@vger.kernel.org Sat Sep 09 21:17:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM8Ky-0000Aw-9J
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 21:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWIITRq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 15:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWIITRp
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 15:17:45 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:2967 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964810AbWIITRo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 15:17:44 -0400
Received: by py-out-1112.google.com with SMTP id n25so1413436pyg
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 12:17:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aGje6A/bDVTWB9Iglr7wgytnyzAUCTvLGRXc0N4l/8wWOIiWOYIXEWJq0bdEosn3vmrzrbUUyLjJt+lJFLPdlCmbNR8uBGYfHUne4z7qM9x8QuHTt7l1hlO4cn12oGR62XULt8HiKpdluYtZZ81oilfd4FadZ9iQWO3nqON7MJ4=
Received: by 10.35.46.11 with SMTP id y11mr5416987pyj;
        Sat, 09 Sep 2006 12:17:10 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sat, 9 Sep 2006 12:17:10 -0700 (PDT)
To: "linux@horizon.com" <linux@horizon.com>
In-Reply-To: <20060909184441.23764.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26761>

On 9 Sep 2006 14:44:41 -0400, linux@horizon.com <linux@horizon.com> wrote:
> > Anyhow the basic is:
> >
> > -git-rev-list starts outputting the data early (order is not guaranteed)
> >
> > -before to mark for output a revision check if it breaks --topo-order
> >
> > -if the above is true store the revision away and *do not send*
> >
> > - at the end you get an early started steram of topological corrects
> > revisions without
> > preordering, just because you filter away the (few?) revisions that
> > are not in order.
> > The list you get is guaranteed to be in topo order although my not be complete.
> >
> > - _then_  you send the missing revisions that where previously
> > filtered out. At this stage the receiver has already drwan the graph,
> > indeed it has start drwaing as soon as the first revisons arrived and
> > *very important* receiver used old and fast topo-order parsing code.
> >
> > - finally the fixup routine at receiver's end updates the graph with
> > the info from the small set of out of order revisions filtered out
> > before and sent at the end (only this small set is sent at the end).
>
> The problem is that the gitk display code doesn't *like* input like this;
> it's only designed to append to a list.  Handling insertions would be
> hard work for a rare corner case, and a perpetual source of bugs.
>
> Unless gitk does a complete second pass, or course, which would
> guarantee an annoying flicker a few seconds after startup.
> And Twice the work.
>

I think I need to add another argument here, I didn't mention before
for clarity (indeed I'm not very good at this it seems ;-)  )

I don't know for gitk, perhaps Paul can better explain, but the usual
optimization of a git  visualizer is simply to not draw any graph
until that part does became visibile on the screen.

So your arguments are true but the fact is that there is no graph
insertion handling at all in almost all cases, but only insertion in
loaded revs list ; when the user scrolls to the inserted commit only
_then_ the graph will be calculated and dispalyed (I'm not sure in
gitk, but in qgit it works that way). So there's no flickering too,
and not double work.

Indeed lazy/on demand graph drawing policy is very well supported by
the above schema, and the above schema is good also because of the
lazy graph drawing.

         Marco
