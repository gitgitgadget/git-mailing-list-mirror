From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Tue, 09 May 2006 21:41:06 -0700
Message-ID: <7vd5emze3h.fsf@assigned-by-dhcp.cox.net>
References: <7viroezi8s.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605092117240.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 06:41:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdgVb-0008Tt-Ir
	for gcvg-git@gmane.org; Wed, 10 May 2006 06:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWEJElI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 00:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWEJElI
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 00:41:08 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:21144 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964806AbWEJElH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 May 2006 00:41:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060510044106.ZAOP25692.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 10 May 2006 00:41:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605092117240.3718@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 9 May 2006 21:21:07 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19873>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 9 May 2006, Junio C Hamano wrote:
>> 
>> Junio C Hamano:
>>       binary patch.
>>       binary diff: further updates.
>
> Btw, am I just smoking stuff, or is this going to be fundamentally 
> problematic for "git-apply -R" if we ever want to support that?

It is problematic but not more than the current index + "Binary
files differ" output.  If you have both pre and postimage then
you do not need the binary data.

The forward application is done assuming you have the preimage
(but not necessarily postimage), and when you do not have
postimage the binary data is used.  When going reverse we should
assume you have the postimage (but not necessarily preimage),
but the pack-object format xdelta is not reversible so if you do
not have preimage that matches the index, with the current
output format you lose.

If we care enough, we could add a reverse delta from postimage
to preimage to the output, but I am not sure if it is worth it.

> But at least in theory we might well want to do "-R" eventually.

Yes, but even without binary, -R has a funny implication when
copy-edit patch is involved.  What if a patch copy-edits to
create a new file B based on old A, and also modifies A
in-place, and somehow the postimages of A and B you already have
are not consistent with what that patch does?  Application with
-R would produce two versions of A and you would get a conflict.
I guess showing a combined diff would be a helpful way to
resolve that ;-).
