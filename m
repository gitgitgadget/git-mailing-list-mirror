From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: preserving mtime
Date: Mon, 19 Nov 2007 09:36:52 +1300
Message-ID: <46a038f90711181236o1acd00d4id9c5aeffd3065b80@mail.gmail.com>
References: <473D63F9.4010201@inrim.it> <473D6DC6.8040804@op5.se>
	 <20071117182236.GD23659@blorf.net>
	 <20071118084511.GC16863@glandium.org>
	 <46a038f90711180134j411bb9c9uf2476f564f9abb6@mail.gmail.com>
	 <20071118184724.GA494@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Mike Hommey" <mh@glandium.org>,
	"Wayne Davison" <wayne@opencoder.net>,
	"Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 21:37:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItqtF-0006mZ-Bt
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 21:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbXKRUgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 15:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbXKRUgz
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 15:36:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:55456 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbXKRUgy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 15:36:54 -0500
Received: by ug-out-1314.google.com with SMTP id z38so864829ugc
        for <git@vger.kernel.org>; Sun, 18 Nov 2007 12:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yZmbb9GieacwBxqso+sirm4jUT6QsxxCpL+HiOElTuY=;
        b=tdOs0gnum1h8ozznsexGq6VljmWXHkyLXbtGLsp7umPWu2uGE3Cstss5/jlgrOYakfwOM/PL+arYSeCx8oHPq/wrW0UrLmLN7rziew0Y16IIOkVVLHiVnu4X+95/q/NVk8tgxZNys/JESAokwoFGSPmup67Hl2Iz/Blji8DuWPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jcdefv7fGC/cHgQ0DFqOKPnmnL+EOx9PIXSHTJGATJfBVszVZRgQcuylged8SIhKPeKWpLn4jHbQu9sqRfZwLG0fWNBj/qyIR3WPcbDtzVLeYSJ/4TLDBE8QHuxamrzeof0kPeJvTcdwCmm3oSrzhi1LyG7v5O9eXcJzBB2ApxQ=
Received: by 10.66.221.6 with SMTP id t6mr190540ugg.1195418212984;
        Sun, 18 Nov 2007 12:36:52 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Sun, 18 Nov 2007 12:36:52 -0800 (PST)
In-Reply-To: <20071118184724.GA494@old.davidb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65390>

On Nov 19, 2007 7:47 AM, David Brown <git@davidb.org> wrote:
> On Sun, Nov 18, 2007 at 10:34:55PM +1300, Martin Langhoff wrote:
>
> >I do hope anyone doing those things is _very_ aware that the mtime
> >metadata has a specific meaning -- when did this specific file in this
> >filesystem last change -- and is used by many tools in that sense. You
> >are trying to use it for something else. Lots of things will break.
> >
> >Like incremental backups, for example.
>
> 'mtime' does _not_ have the specific meaning of 'when did this specific
> file last change'.  That is the 'ctime' field.  'mtime' is also updated
> when a file is modified, but can be changed by the user.  Many utilities
> restore mtime to older values, including tar.

Hmmm. After a bit of googling I've found conflicting descriptions of
the mtime/ctime semantics (I thought - for 10 years now - that ctime
was "creation time", it is "changed time"). Some people think that
anything that updates mtime also updates ctime, and others say the
opposite.

Wikipedia says (at http://en.wikipedia.org/wiki/MAC_times and
http://en.wikipedia.org/wiki/Stat_%28Unix%29 ) that mtime is about the
content, and ctime about metadata (owner, permissions, moved inode,
etc). Changes in content "touch" mtime + ctime.

With that in mind, I think it makes sense for things like make and
amanda to read mtime as referring to a real change of that concrete
file. The abstract notion of the file having changed in the big DSCM
in the sky is useful, but putting that data in mtime messes things up.

> However, it will make 'make' very confusing, since it uses the mtime to
> determine if files are out of date.  If moving to an older version of a
> file causes the file to become older, make won't recompile.  This is
> arguably a defect in make, but that is how it works.

It's not a bug in make. mtime has a definite meaning, and make is
using that meaning. Same with amanda.

cheers,


m
