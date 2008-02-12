From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Tue, 12 Feb 2008 17:43:37 -0500
Message-ID: <9e4733910802121443g7b3f5977s1f7dfeb9ba6abaab@mail.gmail.com>
References: <200802081828.43849.kendy@suse.cz>
	 <200802091627.25913.kendy@suse.cz>
	 <alpine.LFD.1.00.0802092200350.2732@xanadu.home>
	 <alpine.LSU.1.00.0802101640570.11591@racer.site>
	 <alpine.LSU.1.00.0802101845320.11591@racer.site>
	 <alpine.LSU.1.00.0802122036150.3870@racer.site>
	 <alpine.LFD.1.00.0802121303450.2920@woody.linux-foundation.org>
	 <9e4733910802121336x42055baawf2b8f3714e2a1eb4@mail.gmail.com>
	 <alpine.LFD.1.00.0802121356330.2920@woody.linux-foundation.org>
	 <alpine.LFD.1.00.0802121412520.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Nicolas Pitre" <nico@cam.org>, "Jan Holesovsky" <kendy@suse.cz>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 23:44:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP3rN-00017W-Pd
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 23:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbYBLWnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 17:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753567AbYBLWnn
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 17:43:43 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:41882 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304AbYBLWnm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 17:43:42 -0500
Received: by wr-out-0506.google.com with SMTP id c48so4792126wra.23
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 14:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=l3HQ4f+LgUoyH/t2QOc6E0JywS6/epTaJlwDgBtoW8Q=;
        b=e40iGPe0T9bQ+mOOjoy+OO26/1gqJgjUDu2C8YE9fTtDNc3p83tPcbu3rL5OCFdQfOHxGGEUQdDE870owSHjGQkjZBmeARRm5PFy3gGRFs157bJHaaXIe/MMeoBQGPypsDkl07L6ZWB8i3peopbD26ivH6ONttGFiinSUjAmrXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bSCiMyNEg2ss4y8S37KwBUVLYKkEVmqveq3219OBo1857yDQpwf0nn6VocabpOrUjxBfhbqFq9C28VPMzRWhyQL6t/+IIX3UPjEmR1tSImjm7Nq53KBrRnKLEbjwzfIqqSLOBMpwRf5t9CHvWSPinEE88BQ6i4+IFjpvH0dYeDA=
Received: by 10.114.190.6 with SMTP id n6mr2132279waf.51.1202856218000;
        Tue, 12 Feb 2008 14:43:38 -0800 (PST)
Received: by 10.114.200.7 with HTTP; Tue, 12 Feb 2008 14:43:37 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802121412520.2920@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73706>

On 2/12/08, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Tue, 12 Feb 2008, Linus Torvalds wrote:
> >
> >  (b) we compare each object to the "window-1" preceding objects, which is
> >      how I got the O(windowsize^2)
>
> That's not really true, of course. But my (broken and inexact) logic is
> that we get one cost multiplier from the number of objects, and one from
> the size of the objects.
>
> So *if* we have the situation of not limiting the window size, we
> basically have a big slowdown from raising the window in number of
> objects: not only do we get a slowdown from comparing more objects, we
> spend relatively more time comparing the *large* ones to begin with and
> having more of them just makes it even more skewed - when we hit a series
> of big blocks, the window will also contain more big blocks, so it kind of
> a double whammy.
>
> But I don't think calling it O(windowsize^2) is really correct. It's still
> O(windowsize), it's just that the purely "number-of-object" thing doesn't
> account for big objects being much more expensive to diff. So you really
> want to make the *memory* limiter the big one, because that's the one that
> actually approximates how much time you end up spending.
>
> So ignore that O(n^2) blather. It's not correct. What _is_ correct is that
> we want to aggressively limit memory size, because CPU cost goes up
> linearly not just with number of objects, but also super-linearly with
> size of the object ("super-linear" due to bad cache behavior and in worst
> case due to paging).


In the gcc case I wasn't running out memory. I believe was CPU bound
for an hour processing a single object chain with 2000 entries. That
sure doesn't feel like O(windowsize).

Maybe someone playing the the OO repo can stick in an appropriate
printf and see how many diffs are really being done just to make sure
they match what we think the number should be.


>
>                         Linus
>


-- 
Jon Smirl
jonsmirl@gmail.com
