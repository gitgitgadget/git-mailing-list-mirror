From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix new-workdir (again) to work on bare repositories
Date: Tue, 21 Aug 2007 20:38:14 -0700
Message-ID: <7vtzqsme6x.fsf@gitster.siamese.dyndns.org>
References: <20070822015012.GA11085@spearce.org>
	<7v1wdwntc6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 05:38:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INh30-0003pF-OW
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 05:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbXHVDiT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 23:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754537AbXHVDiT
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 23:38:19 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:36242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbXHVDiS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 23:38:18 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F9C4125EB9;
	Tue, 21 Aug 2007 23:38:38 -0400 (EDT)
In-Reply-To: <7v1wdwntc6.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 21 Aug 2007 20:25:45 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56346>

Junio C Hamano <gitster@pobox.com> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> My day-job workflow involves using multiple workdirs attached to a
>> bunch of bare repositories.
>
> Are you sure the patch would help?
>
> For one thing, I do not think we supported such a layout,
> officially or unofficially --- the thing is in contrib so it
> could not be official, but that is besides the point ;-).  Older
> git might have worked by accident, though.
>
> You may have made the part to create the new directory and make
> bunch of symbolic links to work with your patch, but as far as I
> know, new-workdir is designed to share the .git/config file with
> the borrowed repository, which means the configuration would say
> "core.bare = yes" for a bare repository.  So I suspect that the
> initial checkout after creating the new directory and populating
> its .git would barf, although I haven't tested it.

Having said that, I am not saying that we should forbid such a
layout that uses a work tree or more attached to a bare
repository.  We need to figure out what the best practice should
be.

 * Maybe using such a layout needs GIT_WORK_TREE environment to
   be set?

 * Maybe using such a layout needs "core.bare = false" even
   though the true repository is a bare repository?  This has an
   obvious drawback that git-fetch cannot update the branch
   pointed by HEAD even though it is a bare repository.

 * Maybe ignore "core.bare = true" if $GIT_DIR ends with
   "/.git"?  I do not like relying on names too much, though.

 * Maybe ignore "core.bare = true" if $GIT_DIR/index exists?
   This is almost right, except that there is a chicken and egg
   problem -- the index does not exist until the initial
   checkout, and checkout wants to make sure you are not in a
   bare repository.
