From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: [RFC,PATCH] Make git prune remove temporary packs that look like write failures
Date: Mon, 4 Feb 2008 17:39:43 +0000
Message-ID: <e1dab3980802040939u1329ab6xa730f5ecc52c809a@mail.gmail.com>
References: <e1dab3980802040610s27a54a9due3b42db5f59c0cd5@mail.gmail.com>
	 <alpine.LSU.1.00.0802041512140.7372@racer.site>
	 <e1dab3980802040724l5ef12528y69f1d572b7ac8d54@mail.gmail.com>
	 <alpine.LSU.1.00.0802041714560.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "gi mailing list" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 18:46:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM5Oy-0005X8-Lp
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 18:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbYBDRqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 12:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752355AbYBDRqE
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 12:46:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:54348 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbYBDRqC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 12:46:02 -0500
Received: by ug-out-1314.google.com with SMTP id z38so46147ugc.16
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 09:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fi9nyhkAvJYGH4YIF437jFLoEJ4mgxyJGgDN2uc4bQk=;
        b=LTwOUSyIk6SQ6pGZ+QfF+CiE7hExw/64F02haIdU1kOXHykERl+oHJBabVlvmf0QqoOpyexR/Kxo+yxgFd8S2MlyUL5DYYV7G1VELW9PJQTjJIWxft0RTRRTlwMks8lyp6ykqR/Mh69BMVai15h2/etpXAW0edYVNEj1nG8dyjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vHz4gEpIgVBKSA5VXBhKr3haQxUrexHxlLhvwpEpujYyrdwPwxnSjGhr/n7fvhpjgbX5cOTgk5SCQHPR7eOejTp2AD7go87c2NKGPG2sQ5veXuUbPESutsX3dHWR228n7JHz1ukVCaCXbr3xf30F8gD5N+Sg+Swvz0A+gW4XIlk=
Received: by 10.151.82.3 with SMTP id j3mr3067223ybl.78.1202146783751;
        Mon, 04 Feb 2008 09:39:43 -0800 (PST)
Received: by 10.150.149.2 with HTTP; Mon, 4 Feb 2008 09:39:43 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802041714560.7372@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72534>

On Feb 4, 2008 5:21 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 4 Feb 2008, David Tweed wrote:

> > In response to this and to Nico's earlier mail, I _think_ the usage with
> > repack is completely safe.
>
> It would have been nicer of you to defend that, instead of sending me off
> to look for myself.  Having looked for myself, I am not convinced at all.

I probably ought to have put the underlines around the "I". I'm
convinced, but since this is deleting things I'm more cautious than I
would be, say, parsing options.

> And it would have been surprising: if your patch would play nicely with a
> repack in progress, then it would fail to remove the temporary packs left
> by a crashed repack.

I should been more careful what I said: I only use repack via "git gc"
which calls the repack as a subcommand. If the repack fails then the
whole process dies and you've got a dead tmp pack. The _next_ time you
call "git gc" it will do the repack, finish and then call "git prune"
(assuming --prune) and delete the temporary pack. Used in this way, I
have tried and I cannot see an execution path where this can go wrong.
You're right (and I didn't intend to suggest otherwise) that it would
be safe when running a "git prune" concurrently with a separate "git
repack".

However, I'm not familiar with what things like git-svn, cvs, etc, do.
Given that I've seen patches adding "git gc" periodically during
various imports, I wanted to someone who knows that area to confirm
the patch isn't violating any assumptions.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
