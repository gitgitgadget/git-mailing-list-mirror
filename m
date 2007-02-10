From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 20:08:53 +0100
Message-ID: <e5bfff550702101108k5dabd8d5o2487cc87bb1eafc7@mail.gmail.com>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	 <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
	 <Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0702101049480.1757@xanadu.home>
	 <7vr6syj7uw.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0702101131070.1757@xanadu.home>
	 <7vmz3mj6yo.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0702101154130.1757@xanadu.home>
	 <7v1wkxki4a.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0702101351430.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"GIT list" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Feb 10 20:08:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFxak-0007w0-GX
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 20:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbXBJTI4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 14:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbXBJTIz
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 14:08:55 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:39795 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbXBJTIz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 14:08:55 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1256103wri
        for <git@vger.kernel.org>; Sat, 10 Feb 2007 11:08:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l/0gcLJrP1GRjNxjRM8s9nIdU6c4sF/foJszJTSMPyh3zQPcYn4iPaD8O0zMgp5U6nMBSvjne+3JsKa0z4NNBvB9x+yKw+oq/JB2WKjlHrwXmOLi0XjBxvshgRAY0YJK5j6d6oPEp+FXbKt0s9eF4H6RlcuwahiMzIRmUauQYhQ=
Received: by 10.114.190.6 with SMTP id n6mr6500635waf.1171134533791;
        Sat, 10 Feb 2007 11:08:53 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sat, 10 Feb 2007 11:08:53 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0702101351430.1757@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39256>

On 2/10/07, Nicolas Pitre <nico@cam.org> wrote:
> On Sat, 10 Feb 2007, Junio C Hamano wrote:
>
> >  (0) Do nothing.
> >
> >  (1) We keep the current "git-status [-v] [-a] [[-i|-o] <paths...>]"
> >      command line and do the necessary index manipulation
> >      in-core without writing it out (see git-commit.sh for
> >      details of what it involves).
> >
> >  (2) We drop the support for any command line parameter from
> >      "git-status", apply my two patches for Marco to
> >      "git-runstatus", and rename "git-runstatus" to
> >      "git-status".
> >
> > If I have to pick between the two, I would probably pick (2).
> > While (1) would essentially mean doing "git-commit" entirely
> > in-core without writing the index out until we really make the
> > commit, which is a good thing in itself in the longer term, it
> > is out of the question this late in the game for 1.5.0.
>
> And don't get me wrong.  I think that for 1.5.0 you should really do (0).
>

I agree on doing (0) for 1.5.0 and the following Linus lines make me
wonder if is better doing (0) also after 1.5.0

> So the fact is, "git status" _needs_ to refresh the index. Because if it
> doesn't, you'll see every file that doesn't match the index as "dirty",
> and that is not just a "technical issue".
>
> And yes, doing an "internal" refresh, like Junio's patch does, hides the
> issue, but it hides it BY MAKING THE OPTIMIZATION POINTLESS!
>
> I suspect Marco is testing some reasonably small git archive. With
> something like git itself, with less than a thousand files (and most of
> them fairly small, so rehashing them all is quick), the optimization may
> _feel_ like just a small technical detail.

If current 'git runstatus' on a NTFS directory, Linux side, show as
dirty _all_ the repo files, then in case of big repos, as Linus
pointed out, a possible future 'git runstatus --refresh' will be
terribly slow because must filter out as false positives _all_ the
repo files. And worst, have to do it *any time* it is run.

So perhaps the two patches of Junio _seems_ to work to me just because
repo is small, is qgit4 indeed, but on a Linux tree would be veeery
slow, so slow that probably is better to avoid completely and report
quickly to user an empty set, being a corner case user will understand
;-)

Marco

P.S: I know I'm looking for flames but, if git-status HAVE to write
the index and if 'status', as Nicolas points out, is a word that
suggest a read only function, why don't change the name of the
command.....'git sync-index' as example.
