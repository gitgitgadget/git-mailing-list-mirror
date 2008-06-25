From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack.indexversion config option now defaults to 2
Date: Tue, 24 Jun 2008 21:59:06 -0700
Message-ID: <7vd4m66rfp.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0806250025130.2979@xanadu.home>
 <alpine.LFD.1.10.0806242130450.22069@hp.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 07:00:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBN7d-00074V-Mg
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 07:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbYFYE7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 00:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbYFYE7W
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 00:59:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbYFYE7V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 00:59:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DF9AA17295;
	Wed, 25 Jun 2008 00:59:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CBD9917294; Wed, 25 Jun 2008 00:59:14 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0806242130450.22069@hp.linux-foundation.org>
 (Linus Torvalds's message of "Tue, 24 Jun 2008 21:32:49 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 785D3696-4273-11DD-9734-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86225>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 25 Jun 2008, Nicolas Pitre wrote:
>> 
>> Git older than version 1.5.2 (or any other git version with this option
>> set to 1) may revert to version 1 of the pack index by manually deleting
>> all .idx files and recreating them using 'git index-pack'.  Communication
>> over the git native protocol is unaffected since the pack index is never
>> transferred.
>
> Rather than talk about when it does _not_ matter, wouldn't it be better to 
> talk about when it _can_ matter?
>
> Namely when using dumb protocols, either http or rsync, with the other end 
> being some ancient git thing (and it is worth mentioning version of what 
> counts as 'ancient' too, I can't remember, probably means that pretty much 
> nobody else can either).

I agree with you that the description of the change (in the commit log)
and the instruction (in the documentation) could be more helpful and
explicit.

For the other "usedeltabaseoffset" change, I think the insn in the
documentation Nico added is reasonable:

+	By default, linkgit:git-repack[1] creates packs that use
+	delta-base offset. If you need to share your repository with
+	git older than version 1.4.4, either directly or via a dumb
+	protocol such as http, then you need to set this option to
+	"false" and repack. Access from old git versions over the
+	native protocol are unaffected by this option.

except perhaps that the "set false and repack" should be clarified
further, perhaps like:

	... then you need to set this option to "false" and repack using
	git that is newer than (and including) v1.5.0.

I am basing the above 1.5.0 on description of b6945f5 (git-repack:
repo.usedeltabaseoffset, 2006-10-13).

On the "indexVersion" change, the documentation reads:

pack.indexVersion::
	Specify the default pack index version.  Valid values are 1 for
 	legacy pack index used by Git versions prior to 1.5.2, and 2 for
 	the new pack index with capabilities for packs larger than 4 GB
 	as well as proper protection against the repacking of corrupted
+	packs.  Version 2 is the default.  Note that version 2 is enforced
+	and this config option ignored whenever the corresponding pack is
+	larger than 2 GB.

which lacks the recovery insn (and it is int strictly the fault of this
patch, but we should have done this when we introduced the v2 idx).  I
think a separate paragraph after the above would be necessary and
sufficient:

	If you have an ancient git that does not understand the version 2
	`*.idx` file, cloning or fetching over a non native protocol
	(e.g. "http" and "rsync") which will copy both `*.pack` file and
	corresponding `*.idx` file from the other side may give you a
	repository that cannot be accessed with your old git.  If the
	`*.pack` file is smaller than 2 GB, however, you can use
	`git-index-pack` on the `*.pack` to regenerate the `*.idx` file.
