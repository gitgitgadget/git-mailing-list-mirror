From: Junio C Hamano <gitster@pobox.com>
Subject: Re: warning: no common commits - slow pull
Date: Wed, 27 Feb 2008 12:53:14 -0800
Message-ID: <7vskzeruit.fsf@gitster.siamese.dyndns.org>
References: <200802102007.38838.lenb@kernel.org>
 <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org>
 <200802261438.17014.lenb@kernel.org>
 <7vir0byoc2.fsf@gitster.siamese.dyndns.org>
 <7voda2yksf.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802271411280.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Len Brown <lenb@kernel.org>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 21:54:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUTI4-0006RW-HH
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 21:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbYB0Uxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 15:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbYB0Uxf
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 15:53:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbYB0Uxe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 15:53:34 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D57702674;
	Wed, 27 Feb 2008 15:53:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B8A1A266F; Wed, 27 Feb 2008 15:53:21 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802271411280.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 27 Feb 2008 14:28:15 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75303>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Correcting the transport code is important (and should probably be done in 
> transport.c, if possible), but I think we're being a bit silly in 
> autofollowing tags anyway. If we decide to fetch T due to having T^{}, we 
> should tell the remote up front that we have T^{}, before we mention 
> anything else, because it's obviously true and it's also absolutely 
> certain to make the remote immediately do the right thing.

That's correct, and the autofollowing code does so.  You will
not know if you have T^{} until your primary transfer finishes,
so you cannot roll autofollow into it.

I think we can teach the upload-pack side to be more helpful and
with a protocol extension to send tag objects that are pointing
at commits that will be included in the result, or something
like that, though.  But that is outside the scope of 1.5.5; it
would be a moderate to large protocol surgery, and I suspect it
might even have to affect pack-objects.

> It's silly to 
> decide to fetch T because we will only need that one object, and then not 
> instantly tell the server we only need that one object. (And, as luck 
> would have it, yesterday I wrote code to cause for_each_ref return some
> specific values in addition to and before the actual stored refs.)

You won't know if you need only one object, so seeing that you
have T^{} and asking _only_ for T is _wrong_.  Think of a tag
that points at another tag that points at the commit.  You need
to tell the other end "I have T^{}, please give me T", and that
is exactly what the autofollowing does.
