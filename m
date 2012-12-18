From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Tue, 18 Dec 2012 12:00:58 +0100
Organization: Bertin Technologies
Message-ID: <20121218120058.0c558ba5@chalon.bertin.fr>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
 <7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
 <20121212094432.6e1e48c8@chalon.bertin.fr>
 <7v38zb3ux0.fsf@alter.siamese.dyndns.org> <877goht6eu.fsf@pctrast.inf.ethz.ch>
 <20121217114058.449cbc3c@chalon.bertin.fr>
 <CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com>
 <m21ueo78f8.fsf@igel.home> <7vwqwgjs8f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 12:01:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkuvR-0004h9-GQ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 12:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab2LRLBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 06:01:11 -0500
Received: from cabourg.bertin.fr ([195.68.26.10]:61111 "EHLO cabourg.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754532Ab2LRLBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 06:01:09 -0500
Received: from cabourg.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id D029CA0F84
	for <git@vger.kernel.org>; Tue, 18 Dec 2012 12:01:07 +0100 (CET)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by cabourg.bertin.fr (Postfix) with ESMTP id 10763A0F78
	for <git@vger.kernel.org>; Tue, 18 Dec 2012 12:01:07 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MF80068Q3XU0FA0@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Tue, 18 Dec 2012 12:01:06 +0100 (CET)
In-reply-to: <7vwqwgjs8f.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.8.0.1017-19458.006
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211743>

On Mon, 17 Dec 2012 13:14:56 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Andreas Schwab <schwab@linux-m68k.org> writes:
> 
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> >> Yeah, at one point I wanted to have a command that created to craft a
> >> new commit based on an existing one.
> >
> > This isn't hard to do, you only have to resort to plumbing:
> >
> > $ git cat-file commit fef11965da875c105c40f1a9550af1f5e34a6e62 | sed s/bfae342c973b0be3c9e99d3d86ed2e6b152b4a6b/790c83cda92f95f1b4b91e2ddc056a52a99a055d/ | git hash-object -t commit --stdin -w
> > bb45cc6356eac6c7fa432965090045306dab7026
> 
> Good.  I do not think an extra special-purpose command is welcome
> here.

Well, I'm not sure this is intuitive enough to be useful to the average user :)
Adding git-rev-parse calls for convenience, and calling git-replace, would make it
a more complete recipe, and we could suggest that as an alias in the collection that's
in the wiki (which is not even linked any more from git-scm.com btw), but imho that
would be hiding valuable information in a dark corner.

Anyway, in this form it will only replace a parent with another, whereas a full
graft replacement should allow to write a different number of new parents instead.
That is, instead of this simple sed, something like:

(NEWPARENTS='parent xxx\nparent yyy\nparent zzz\n; git cat-file commit master | perl -ne 'BEGIN { $state=0 }; if ($state eq 0) { if (/^parent/) { $state=1 } else { print } } elsif ($state eq 1) { if (/^author/) { print "'"$NEWPARENTS"'"; print; $state=2 } } else { print }')

Well, a short bash script should be more readable and possibly faster, but that's the
idea.  Such a script could be a candidate for contrib ?
-- 
Yann Dirson - Bertin Technologies
