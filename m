From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Git's static analysis
Date: Fri, 6 Feb 2009 07:11:36 +0100
Message-ID: <200902060711.37191.robin.rosenberg.lists@dewire.com>
References: <1233870004-63540-1-git-send-email-pdebie@ai.rug.nl> <7v63jo9xbg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 07:13:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVJxd-0008QE-4K
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 07:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbZBFGLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 01:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbZBFGLm
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 01:11:42 -0500
Received: from mail.dewire.com ([83.140.172.130]:4435 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440AbZBFGLl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 01:11:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9E580147E7FA;
	Fri,  6 Feb 2009 07:11:38 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CTi92VD3cKrB; Fri,  6 Feb 2009 07:11:37 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id C4DD3802666;
	Fri,  6 Feb 2009 07:11:37 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <7v63jo9xbg.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108661>

fredag 06 februari 2009 02:19:15 skrev Junio C Hamano:
> Pieter de Bie <pdebie@ai.rug.nl> writes:
> 
> > I played around a bit with the 'Clang' static analyser, and tried to run git's
> > source code through it. It comes up with a few possible errors, so I thought
> > you might find it interesting. I took a quick glance, and it also seems to
> > have a few false positives, but it might still be worth to take a look.
> >
> > The results can be found here:
> >
> > 	http://frim.frim.nl/git-analyse/
> 
> Hmm, I took a quick look at a few, and they looked nonsense, but perhaps I
> am misreading things.
> 
> For example:
> 
>     http://frim.frim.nl/git-analyse/report-uxXiUR.html#EndPath
> 
> I am assuming that we follow the control flow of the labelled comments, so
> I followed along from [1] to [7] and then saw these:
> 
>     [8] loop condition is false, execution continues on line 1492
>     1483:   for (i = 0; i < array->nr; i++) {
>                 ...
>             }
> 
>     [9] taking false branch
>     1492:   if (array->nr <= i)
>                 return NULL;
> 
>     [10] dereference of null pointer.
>     1495:   c->object.flags |= ...

> 
> The thing is, if [8] exits, "i < array->nr" is not true anymore, and there
> is no way you can take false branch of  "if (array->nr <= i)" in the
> immediately next step [9]. and reach point [10].

The code assumes can c become null in the loop [if (!c) continue]. If that
is the last iteration it comes out of the loop with c == NULL and array->nr >=i,
thus not returning. 

I have to dig through history until may 2008 to find this version of this code  so
the analysis seems a bit obsolete. The loop was rewritten in 4603ec0f960e.

-- robin
