From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Sun, 10 Feb 2008 23:53:39 +0100
Message-ID: <200802102353.40230.jnareb@gmail.com>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org> <m3myq8fwdx.fsf@localhost.localdomain> <alpine.LFD.1.00.0802101241590.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:54:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOL4O-0000pD-JT
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 23:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbYBJWxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 17:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbYBJWxw
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 17:53:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:14190 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbYBJWxv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 17:53:51 -0500
Received: by ug-out-1314.google.com with SMTP id z38so195027ugc.16
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 14:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=5j2s+6cbrX6JIwDWWpr11kYgHmTQQFOUqPBlXaVLicE=;
        b=UzjXT4WGKhXO5X9MW+EZm6b5dL1heDhJFeCwF2vqiG6RRAEw9T1SKnv4uBJo/apRRqJ98u5K8+K9SoCcYMXwrdgMx4xnB/Lf1WimqGn4F6OUlZIxYnPPb1YNKsblplq74dn4j65wecqOG1zWvBvzRPD59n3B6P+XplELcx1uiQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iuFuwDHUq7SOZMIk3NBioBMWjxvUilXoVR5tTUIZnpcXbltoP3EyU2eLwfBhqJ3tfRLu0KOvYnRKHCAlzyMkkezWm+ZzL/O5lcgiunmFny/+gH99yGneF+RPoP0p3J9ragVFS0QQhKuPyAgXrIaF5pVYQfAucIZZDCWMGFAP3fA=
Received: by 10.67.20.3 with SMTP id x3mr8346431ugi.3.1202684025768;
        Sun, 10 Feb 2008 14:53:45 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.220.19])
        by mx.google.com with ESMTPS id w40sm1584137ugc.45.2008.02.10.14.53.43
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Feb 2008 14:53:44 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.1.00.0802101241590.2896@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73431>

On Sat, 10 Feb 2008, Linus Torvalds wrote:
> 
> On Sun, 10 Feb 2008, Jakub Narebski wrote:
> > 
> > P.S. Would having generation + roots be enough?
>
> I'm wavering here. Maybe just "generation" works (the longest path from 
> any root), because what we are looking for is essentially "guarantee that 
> this commit cannot possibly be reached from that other commit", and I 
> guess a simple generation count actually does work for that (if the 
> generation of "x" is smaller than the generation of "y", we definitely 
> cannot reach y from x).

Well, "generation" number alone would work quote well as an exclusion
mechanism; generation + roots would work better, I think.

Lets take for an example the following revision graph:

roots: a    a    a    aA   aA
gen:   1    2    3    4    5

       a----b----c----d----e
                     /
            A----B--/

gen:        1    2
roots:      A    A

For example lone generation number is enough to decide that 'c'
(generation 3) cannot be reached from 'a' (generation 1 < 3), and
that 'c' (generation 3) cannot be reached from 'B' (generation 2 < 3).
Roots allow for easy check that 'B' (gen: 2, roots: A) cannot be
reached from 'c' (roots: a, and A \not\in a), but can be reached
from 'e' (gen: 5 > 2, roots: aA \ni a).

What I don't know if generation number would be enough to avoid
"going to root" or "going to common ancestor" costly case when
calculating excluded commits.

> At the same time, I'm still not really convinced we need to add the 
> redundant info. I do think I *should* have designed it that way to start 
> with (and I thought so two years ago - blaah), so the strongest reason for 
> "we should add generation numbers" at least for me is that I actually 
> think it's a GoodThing(tm) to have.

While this information can be calculated from revision graph it is
I think costly enough that it truly would be better to have it in
commit object.

Well, we could always start using core.repositoryFormatVersion ;-)

> But adding it is a pretty invasive thing, and would force people to 
> upgrade (it really isn't backwards compatible - old versions of git would 
> immediately refuse to touch archives with even just a single top commit 
> that has a generation number in it, unless we'd hide it at the end of the 
> buffer and just uglify things in general).

Well, we could always add it as a local (per repository) "cache".
With only generation numbers we could use pack-index-like format
to store a mapping "commit sha-1 => generation number", just like
now pack index stores mapping "object sha-1 => offset in pack".

If we want to store also roots, we could either map 
"commit sha-1 => generation number, roots set offset / id" (constant
length value)[*1*], or have gen-*.gen file with generation numbers
and roots, and gen-*.idx as index to that file.


[*1*] If I understand math correctly it would limit us in theory to
up to 64 roots (git.git has 8 roots IIRC).
-- 
Jakub Narebski
Poland
