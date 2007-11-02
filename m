From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: New features in gitk
Date: Fri, 2 Nov 2007 13:44:05 +0100
Message-ID: <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	 <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
	 <18212.13862.637991.30536@cargo.ozlabs.ibm.com>
	 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
	 <18217.41899.54812.227152@cargo.ozlabs.ibm.com>
	 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
	 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 13:46:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Invv7-0005bG-8e
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 13:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbXKBMoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 08:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbXKBMoH
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 08:44:07 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:39025 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbXKBMoG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 08:44:06 -0400
Received: by rv-out-0910.google.com with SMTP id k20so792717rvb
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gDAkcke31nORJIQA4RIY27qyfnxhBq7gc24XVsw7hQc=;
        b=iq+ZjS9gSvdF+X2gWA+Y6uM/hme4u2jALYPfvQkWI8YMqCPp/18tiHpU1+uG/JPsQSASHqQy/hcikLjmnX8sqlbcgbWiqWT+f5VhkqjKRwNeplmahp7KoRP6S0Q/8Ts0PupIrLOB5BocBog1zJl2rPFprdphGhWSlUoP5Fo00vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I27j1zZyI5Wm8mmFclpFI0mDnLtBU/j3zRNK7xgJCIQS4yMFQRB2Q0GpEdY0RJJ2IoI1x5BgF1UJHjCrU8kz/Hh49DdYIaJUnfFqDVe9q16sRQb953FdLmFw+8KBVTn6XhoqVVEv20cPlkHOlvQYRe9tKoyxf/3dUle2rg6qx2M=
Received: by 10.140.251.1 with SMTP id y1mr848751rvh.1194007445647;
        Fri, 02 Nov 2007 05:44:05 -0700 (PDT)
Received: by 10.141.203.3 with HTTP; Fri, 2 Nov 2007 05:44:05 -0700 (PDT)
In-Reply-To: <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63111>

On 11/2/07, Paul Mackerras <paulus@samba.org> wrote:
>
> In any case, no that's not the only reason.  The main reason is that
> it (i.e. --topo-order) spits out the commits in exactly the order that
> gitk wants to display them (of which the bit about parents coming
> after all their children is a part), and thus reduces the amount of
> processing I need to do in Tcl.
>

I have tried to overcome --topo-order in qgit but I found it very
difficult, too much for me.

Lazily drawing the layout it doesn't mean that you lazy load the data
from git, indeed you load all the git-log output as soon as it
arrives.

And if the revisions arrive "in order", i.e. if revision A arrive
before revision B it means that A is NOT an ancestor of B, this is of
great help.

When drawing the graph assuming that the vector/list of the arrived
sha is already ordered greatly simplify the whole thing, if we relax
this hypothesis then a lot of work should be done before to draw a
graph chunk, essentially the GUI tool needs to walk the _entire_  list
and reorder it by itself _before_ to draw any graph chunk also if very
small.

So at the end you end up transferring the complete revision walk from
git-log to the GUI tool, and (this is the important thing) to be sure
graph is always correct you need to perform the walk _before_ drawing
any stuff.

The only possible _trick_ I was able to find is to optimistically draw
the graph chunk _assuming_ that it is ordered.

Then reorder the list in the background and finally check if the graph
is correct, if not redraw with correct data.

If the out of order revisions are rare you end up mimic a fast correct
drawing. If are not user will see some flickering at the end of the
load.

IMHO the above scheme is very complicated and fragile.

Just my two cents.

Marco
