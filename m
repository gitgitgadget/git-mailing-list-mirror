From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Respecting core.autocrlf when showing objects
Date: Tue, 10 Jun 2008 15:25:32 -0700
Message-ID: <7vk5gxc4gz.fsf@gitster.siamese.dyndns.org>
References: <7vprqqdwh7.fsf@gitster.siamese.dyndns.org>
 <cover.1213084587.git.marius@trolltech.com>
 <alpine.DEB.1.00.0806101632570.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 11 00:26:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6CIc-0008Ma-Nh
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 00:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760186AbYFJWZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 18:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760179AbYFJWZn
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 18:25:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42452 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760137AbYFJWZl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 18:25:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 91D431C89;
	Tue, 10 Jun 2008 18:25:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C2BC61C87; Tue, 10 Jun 2008 18:25:34 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806101632570.1783@racer> (Johannes
 Schindelin's message of "Tue, 10 Jun 2008 16:34:15 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 27C61F96-373C-11DD-819E-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84554>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 10 Jun 2008, Marius Storm-Olsen wrote:
>
>> When you use 'git show <rev>:<file>' or 'git show :<stage>:<file>', the 
>> objects are shows as they are in the object store, ignoring the 
>> core.autocrlf configuration.
>
> I think this is the correct behaviour: inside the object repository, the 
> files are supposed to be LF clean.
>
> Likewise, things in the unmerged stages are in the index, which again is 
> not the working directory, so they should be LF clean.
>
> _Only_ when writing a file to the working directory, it should get 
> clobbered.

I'd agree with your argument on general principle, but it might make sense
to give an option to let you say "here is a blob contents, and use the
attribute for this path to munge it out to the filesystem."  I am not sure
if that belongs to "git show" Porcelain, though.  It _could_ be more like:

        git checkout-blob $blob_sha1 $path

that (1) reads the blob object specified by its object name, (2)
grabs attribute for the $path, and (3) applies convert_to_worktree()
filtering given that attribute and deposits the results to $path.

Alternatively, the interface could be:

        git cat-file blob $blob_sha1 |
        git filter-blob --use-attr-for=$path >$path.old

so that you can then do:

	git diff --no-index $path.old $path

I dunno.
