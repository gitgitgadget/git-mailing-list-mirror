From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: git-svn set-tree bug
Date: Tue, 12 Jun 2007 10:04:41 +0200
Message-ID: <8c5c35580706120104m7c3e2b2cifca513f2dda50d23@mail.gmail.com>
References: <466C8B35.3020207@midwinter.com>
	 <003401c7abba$c7574300$0e67a8c0@Jocke> <20070611042509.GA19866@muzzle>
	 <7vir9vox5l.fsf@assigned-by-dhcp.cox.net>
	 <20070612072035.GA29385@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Joakim Tjernlund" <joakim.tjernlund@transmode.se>,
	"Steven Grimm" <koreth@midwinter.com>, git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 10:04:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy1Ms-0006At-F9
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 10:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbXFLIEo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 04:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbXFLIEo
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 04:04:44 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:33939 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbXFLIEm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 04:04:42 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1557982nzf
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 01:04:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=foaAaObkNaB43xIsml5pi5IB4F7OztBOniI178N4DtATxnOLlPqouJbe+swaW41ywccdAnheqXQZ1T0Sk5z2EfnDtg56ElEFopgjkUpaqZ6mLWjfnl4JzN6LCXBE6mOfm3I7Nc3TOzQeQZntDcLWCBEcq6OlR9O0TamGaKMT2RM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ff7HYaogACnO0Gg6mA0g5/L3TsnWNp8TauSPzizDtNTSX0y7DwC2zuuQ4cP2MH3Ly1btsw/I0PCPbUq0jTA8gQZQt4ziRWgntLKfmk+HqM1KxTHfRw/AJU/+5+3ygNXWUofk7J3VLvgz4JMou9Q42IY3jk/IboyIHV2YN/qQcqY=
Received: by 10.115.108.1 with SMTP id k1mr6365850wam.1181635481657;
        Tue, 12 Jun 2007 01:04:41 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Tue, 12 Jun 2007 01:04:41 -0700 (PDT)
In-Reply-To: <20070612072035.GA29385@muzzle>
Content-Disposition: inline
X-Google-Sender-Auth: 496cf6de7d1b1aa6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49934>

On 6/12/07, Eric Wong <normalperson@yhbt.net> wrote:
> If dcommit detects a merge commit when doing rev-list When looking at
> commit objects, is it safe to assume that the first parent is always the
> "mainline" and that parents after it are the ones to merge from?
>
> So if I saw:
>
> commit $X
> parent $A
> parent $B
>
> I'd basically do:
>   reset --hard $A
>   merge --squash $B
>
> And resulting in $C which would have the same tree as $X,
> then, when dcommit-ting, $D would be created with two parents:
>   $D~1 (svn), $B (git), but not $A
>
> Rewritten history:
>   $A         =>  $D~1
>   $X         =>  $D (HEAD revision in SVN)
>
> $X and $A are now discarded and gc-able.
>
>
> Of course, since I already have the result of "merge --squash $B" in $X,
> I could just rewrite $X with a single parent (call it $X'), dcommit, and
> then give $D ($D~1 and $B) as parents.  Avoiding the nastiness of
> set-tree
>

Would it be possible to keep the 'local commit' $X and change the
mapping in .rev_db to point at $X instead of $D? This would of course
require a matching TREE-ID + noMetadata=1. I've been tempted to try to
implement this, but my perl-skills are sadly non-existent.

If this is possible it would make my day-job interaction with svn a
much more pleasant experience: push/pull between git repos would 'just
work' (without -f).

And if "follow left parent" also works out, I (and our
'releasemaster') can finally do all merging in git (without --squash)
and preserve the DAG. Ahh, that would be great...

--
larsh
