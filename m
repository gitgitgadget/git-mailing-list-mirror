From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix update-index --refresh for submodules if stat(2)
 returns st_size 0
Date: Tue, 22 Jul 2008 10:28:46 -0700
Message-ID: <7vy73tltf5.fsf@gitster.siamese.dyndns.org>
References: <20080721173511.GB5387@steel.home>
 <4885897C.8010401@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 19:29:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLLgR-0000zF-2z
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 19:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbYGVR24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 13:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbYGVR2z
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 13:28:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbYGVR2z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 13:28:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E7CC540A4A;
	Tue, 22 Jul 2008 13:28:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2162340A49; Tue, 22 Jul 2008 13:28:48 -0400 (EDT)
In-Reply-To: <4885897C.8010401@viscovery.net> (Johannes Sixt's message of
 "Tue, 22 Jul 2008 09:17:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A7889B6C-5813-11DD-AD1B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89507>

Johannes Sixt <j.sixt@viscovery.net> writes:

>> +	if ((changed & DATA_CHANGED) && (ce->ce_size != 0 || S_ISGITLINK(ce->ce_mode)))
>
> Does this mean that ce->ce_size is non-zero for gitlinks, at least on
> Unix? Is this value useful in anyway? I don't think so. Then it shouldn't
> be a random value that lstat() happens to return.

These ce_xxx fields are the values we read from lstat(2) when the user
told us to stage that working tree entity, be it a regular file, a
symlink, or a directory that is a submodule.  The only thing required for
them is that they are stable (i.e. if you haven't touched the working tree
entity, the value stays the same), and changes across modification.  The
value itself does not have to "mean" anything.

When trying to see if the user has changes in the working tree entity
since the last such staging of the path, we compare that value with what
comes back from lstat(2), before actually comparing the contents.  If the
filesize changed, they cannot be the same and the code says you have
modified it without having to look at the contents.

	Side note.  This is why you need to be careful after modifying
	autocrlf related configuration and attributes.  If you had CRLF
	contents in the working tree that was incorrectly staged as-is,
	then switch autocrlf-on, and "git add" to fix the staged copy to
	be LF-terminated, we say "it's unchanged and we do not bother
	rehashing" by comparing the ce_xxx fields without looking at the
	contents (this is an absolutely necessary optimization to make
	"git add ."  usable), because ce_size records the size of CRLF
	version you have in the working tree, and you haven't changed the
	working tree file in this sequence above.

        Removing the file and checking things out would be the most
	straightforward solution in such a case.

We used to include ce_dev (taken from struct stat.st_dev) in the list of
fields to cache and compare to detect changes, but that is now excluded
because it is not stable (see comments in read-cache.c).  If the directory
size is unstable, perhaps it would be better to force it to some fixed
magic value so that it is not used by this "quick change detection" check.

If you network-mount the same directory from POSIX and windows, the former
may give "storage size of the directory" while the latter may give 0.
This would mean that you would need a "update-index --refresh" when you
switch between such machines.
