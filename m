From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now
 incompatible with Cygwin (and probably Windows)
Date: Wed, 28 May 2008 11:37:57 -0700
Message-ID: <7vskw2tgu2.fsf@gitster.siamese.dyndns.org>
References: <483AC2CE.7090801@gmail.com>
 <7vy75vvtxo.fsf@gitster.siamese.dyndns.org>
 <32541b130805280933r573d59d0mf9cdc09f5e5a6a17@mail.gmail.com>
 <7vfxs2uytm.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0805281326520.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 28 20:39:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1QYI-0006Zg-Qv
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 20:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbYE1SiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 14:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752429AbYE1SiJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 14:38:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbYE1SiH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 14:38:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2C3595661;
	Wed, 28 May 2008 14:38:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4050D5660; Wed, 28 May 2008 14:38:00 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0805281326520.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 28 May 2008 14:19:17 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 36556334-2CE5-11DD-B95E-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83125>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Report a non-fatal error, mark in the index that that entry is not 
> reflected in the working directory, and allow the user to manipulate it 
> with commands that don't really need the working directory content.
>
> $ git checkout origin/master
> Warning: couldn't create 't/t5100/nul' in your working directory; ignoring 
> working directory for this filename.
> $ git mv t/t5100/nul t/t5100/nul-plain
> $ ls t/t5100/nul-plain
> t/t5100/nul-plain
>
> The working directory doesn't really have to be absolutely vital to git's 
> functioning (of course, the project you've checked out is going to have 
> problems unless you fix things). In particular, it should be possible, on 
> a machine with a broken filesystem, to modify a project that triggers the 
> filesystem breakage to not trigger it,...

Now that is somebody who thinks before types.

Marking that the filesystem does not match what's in index is already
done, so you could argue that an alternative would be not to stop in the
middle of checkout_entry() loop and instead check out as much as we could,
write out the index perhaps, and signal error, _AFTER_ updating everything
else, including the HEAD.  We try to be atomic when able (e.g. on a broken
patch, "apply" does not apply early half the patch and fail but rejects
the whole thing), but checkout_entry() loop is not something you can
sanely make atomic (it needs to first remove existing files and even
directories before writing new files), so that alternative approach might
be easier to work with.

Care to follow it up with a patch?
