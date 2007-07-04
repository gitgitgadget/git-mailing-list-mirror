From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Finally implement "git log --follow"
Date: Wed, 4 Jul 2007 15:21:39 +0200
Message-ID: <e5bfff550707040621o1339de98o62f10fdfe4ff0650@mail.gmail.com>
References: <alpine.LFD.0.98.0706191358180.3593@woody.linux-foundation.org>
	 <alpine.LFD.0.98.0706191425240.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 04 15:21:48 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I64ng-0002VW-Az
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 15:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758188AbXGDNVl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 09:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758458AbXGDNVl
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 09:21:41 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:31213 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757831AbXGDNVk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 09:21:40 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1562326nze
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 06:21:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Anuozt3axLNGQgFXL4FfzpdcRSvvfBny4SxTqiJrDBrQGTRAoR//RdLulx0vWnfmslNm9+KTSzvxWCDBIydidC/BxFr2U+xOVAcApcH1FHs7lqvnQulYGaaziFYh0bx8P7/CdC+tUHbQom/dp4us/GqwfVpzS5I9c2DPKOVl2z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BHNcWCFnntRrWwJCA9LNiHY3JHZdLK2olkwy/HPzoJMuSYYdDs94KiH4ZVLrO06O4llhDOuLQxpNMfVvBlZhYJxf+iMdGBHW/lXrFIGQRrOPD3Cjjepw2g4ejRknH0wOOvzXKGULNUu1DO5PhmZ4S8sxr3SIKURY7z5yonNOJcs=
Received: by 10.115.108.1 with SMTP id k1mr7175369wam.1183555299671;
        Wed, 04 Jul 2007 06:21:39 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Wed, 4 Jul 2007 06:21:39 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0706191425240.3593@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51608>

On 6/19/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>  - the commit simplification isn't done. So you cannot do "--follow"
>    together with somethign that wants a contiguous history (like gitk) and
>    uses "--parents".
>
>    This is pretty fundamental. The commit simplification is a separate
>    phase over the (non-linear!) commit space, and the "git log --follow"
>    logic is really a *different* logic over the _linear_ space (namely the
>    streaming "log output" space).
>
>    Two totally different things, in other words. And not compatible.
>

Of course I need exactly that!

Really don't want to thrash away the nice qgit graph, also in file
histories, and at the same time I really like that '--follow' feature,
so....

I've just started to hit the wall against the scary revision.c and
friends, my goal is to find a solution (trick/hack) to get the renames
also with --parents.

First of all I have commented out:

		/* Can't prune commits with rename following: the paths change.. */
// 		if (!revs->diffopt.follow_renames)
			revs->prune_fn = try_to_simplify_commit;

So I've see that with --parents set try_to_simplify_commit() does his
job and when the processing arrives in diff_tree_sha1() it is already
pruned, so also if the check

if (opt->follow_renames && diff_might_be_rename())

is true and the following try_to_follow_renames() is called, no
alternative tree is found.

My idea, after have understood a little bit better how it works, is to
'resurrect' the pruned info  before calling try_to_follow_renames().
To do this I was thinking of saving a pointer to some pruned tree
information in try_to_simplify_commit() and in case use that pointer
after in diff_tree_sha1() when needed.

Nightmares??? Perhaps, I'm just starting with this difficult piece of
code and probably (90%) I will give up before the end and very
probably (99%) all said before is just brain dead, but...anyway I have
to start from somewhere.

Marco
