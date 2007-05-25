From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Split packs from git-repack should have descending timestamps
Date: Thu, 24 May 2007 19:33:40 -0700
Message-ID: <56b7f5510705241933x67fd4ed9h6d0e24341c19a9d4@mail.gmail.com>
References: <465612CE.4080605@gmail.com> <20070525004610.GP28023@spearce.org>
	 <7vbqg9vhlf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 04:33:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrPcj-00058D-HV
	for gcvg-git@gmane.org; Fri, 25 May 2007 04:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbXEYCdm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 22:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753011AbXEYCdm
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 22:33:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:29914 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbXEYCdl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 22:33:41 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1014137ugf
        for <git@vger.kernel.org>; Thu, 24 May 2007 19:33:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AcMwPskjXUD1prLwBqpnqF/oO6mYQye7X4u0lAASsWzfDbIpTNbUOhkCdBOZtKzY+tHz0NStOkO5SYYwFKYsuVv3sPHDhTj7VSKUR7hWXNUH0vTwUx7g0aLcbz8+OtPdSdODHlcAIkC/+9Y6MU0bWJQTt0p2g6zHRbcly48E1Ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PYO4XKc3Mjq+xsHYFKRLlb+fVhZjm4emT3/HvYegY4Ezxj3G7t4u3AqyNwxSKICBs8AOsXxM/V2Lk8uBtSNXTNYFBiHR7Y//PiBGf0v6x6ilrWakXGtj43FP93joQzMbvsbrEE2NNI4Pay735X/pynidAEWle2uHg2A90Bs6Sps=
Received: by 10.78.171.13 with SMTP id t13mr722112hue.1180060420113;
        Thu, 24 May 2007 19:33:40 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Thu, 24 May 2007 19:33:40 -0700 (PDT)
In-Reply-To: <7vbqg9vhlf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48337>

On 5/24/07, Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Dana How <danahow@gmail.com> wrote:
> >>
> >> If git-repack produces multiple split packs because
> >> --max-pack-size was in effect,  the first pack written
> >> should have the latest timestamp because:
> >> (1) sha1_file.c:rearrange_packed_git() puts more recent
> >>     pack files at the beginning of the search list;  and
> >> (2) the most recent objects are written out first
> >>     while packing.
> >
> > Ack.  Given our mtime based sorting routine, even without your
> > recent patch to improve it, I think we definately want this type
> > of behavior built into git-repack.sh.  Good follow-on to your
> > --max-pack-size series.
>
> Gee, I do not want to touch this, unless we can do something
> about that sleep 2, even if you have & at the end (actually,
> especially because you have that -- it makes me worried).
>
> At the minimum, I think you do not have to restamp at all if the
> result is a single pack (i.e. the usual case), like so:
>
> case "$restamp" in
> ?*' '?*)
>         # we have more than one.
>         # for split packs,  the first created should have most recent timestamp
>         for file in $restamp ; do touch $file; sleep 2; done &
>         ;;
> esac
>
> Come to think of it, can't you do this "re-touching" business at
> the end of pack-objects without sleeping?  You could keep track
> of the names of the packs you produced, and if you have produced
> 5, like so:
>
>         1
>         2
>         3
>         4
>         5
>
> you would swap timestamp of #1 and #5, #2 and #4 using stat()
> and utime(), and you are done.  Each of these huge packs would
> take more than one second to write it out, but if that is not
> the case, you could even start with timestamp of #5, subtract 1
> and stamp #4, subtract 1 and stamp #3, ... You may end up using
> timestamp from the past, but that would not be a problem.
OK,  this triggered the following argument which convinces me:
git-pack-objects really should guarantee the correct timestamp
order,  otherwise some other caller will have to repeat the stuff
I tried to put in git-repack.sh .  So I will resubmit following Junio's
suggestions.  This won't be for a few days.

Also,  if there are rules on allowable bash constructs
(POSIX only, no &, etc),  perhaps they should go in
SubmittingPatches near the new C99 comments?

> And I am really hoping that the other "use object density in
> reordering" patch would make this irrelevant.  You would have
> commit and then the rest in the normal input object stream, and
> recenty ordering done by git-pack-objects should keep commits
> together early in the resulting split pack, and earlier parts
> that have the commits would be hopefully denser.
I understand your point,  but for a "normal" yet extremely
large repository this may not be the case.  The "object density"
patch is designed so that the density component of the sort
key is extremely weak -- I think the timestamp is very revealing,
and should be followed in the absence of large variations
in object density.  Correcting the timestamps makes sure
that the timestamp order corresponds sensibly to recency order
when packs are split.  A sequence of user commands producing
packfiles results in sensible and usable timestamps;
i"d just like to make sure this is also true when packs are
split.

Anyway,  I'm not going to submit anything more about
timestamps or object density until I see reactions to both patches,
since they interact.
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
