From: Junio C Hamano <gitster@pobox.com>
Subject: Mixing and matching multiple projects
Date: Fri, 17 Feb 2012 11:19:26 -0800
Message-ID: <7vhayptght.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 20:19:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyTLC-00063I-IR
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 20:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab2BQTTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 14:19:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40476 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006Ab2BQTT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 14:19:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8FD26B0F;
	Fri, 17 Feb 2012 14:19:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Q
	41hw/eZPdOgnO4HPkjRt2EbAOY=; b=NmOXriawEBCOeffbbHBndBEfRu5ms2EtB
	wpO2BENsQMgpsMQbXHaelH+LdL5rbT6ad4tkMtvBWXffKHRPRP9XNfVGEayMm5K7
	YTczvM/DES2WO2OdnSSYG4HBW83JvRgP7zI757x2hwtXWALTjQscDEhgxLEKHV5L
	YywLUcB/T4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Q9X
	zQR4Wv3KTNVZBgoI7ZJJUPSnxBR0AtWm0JLPlKHzF3355Ulw8xJK0M8oYKs2RH1j
	JGPhMPW0R5izYHmOW0AXxWuRoDmjdWwJN2sFAAZ9tW7wPYnVYBWeYXzGCNVgtSHB
	sQl6sgvns9CfPGXxbI6mhHcQwVLZWINK4/cTE7LI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE04B6B0E;
	Fri, 17 Feb 2012 14:19:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 159BC6B0D; Fri, 17 Feb 2012
 14:19:27 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F79FAD6-599C-11E1-8AEE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190974>

Imagine that there is an open source embedded appliance project "xyzzy"
that consists of two submodules and the top-level superproject that binds
them and serves as the scaffolding, perhaps organized like this:

    /s/xyzzy/.git       -- the superproject
    /s/xyzzy/os/.git    -- the "os" submodule
    /s/xyzzy/u/.git     -- the "userspace" submodule

The "os" submodule may contain various subdirectories, among which there
may be a device drivers directory.  Further imagine that the Makefile in
that directory, /s/xyzzy/os/drivers/Makefile, is written in such a way
that it can run make in any subdirectory of drivers/ and can link with
resulting *.o files in these subdirectories.

Now suppose somebody wanted to add an add-on device driver for frotz
device that does not appear in the open source tree.  Further suppose that
the open source folks do not want to accept support for "frotz" driver in
their tree for whatever reason.

At the working tree level, he can add /s/xyzzy/os/drivers/frotz/ directory
and populate its sources there. Everything else is already set up to build
and link to it properly. But how would he add that directory to git?

He could fork the /s/xyzzy/os/.git submodule and add "drivers/frotz/"
directory, and maintain his own fork of the submodule, which in turn means
that he has to fork the top-level superproject /s/xyzzy/.git because its
tree has to point at a commit in /s/xyzzy/os/.git repository that has the
"drivers/frotz" directory in it, which is different from the open source
version. A proprietary fork has to happen somewhere; that is a given.

But I wonder if we can do without forking the /s/xyzzy/os/.git submodule?

If we *could* do this:

	cd /s/xyzzy
        mkdir os/drivers/frotz && populate the directory with sources
        git add os/drivers/frotz ;# to the top-level superproject!!

to add the "frotz driver" submodule directly to the superproject, then we
could leave /s/xyzzy/os/.git intact, letting it follow the open source
world. Because the superproject must be forked in order to keep track of
what happens in the appliance that supports the "frotz" driver anyway,
this could result in the minimum amount of forking from the end user's
point of view.

People who know the Git data structure of course can immediately see that
this is not supported (and I strongly suspect unsupportable, but my
suspicion has a history of being wrong from time to time, and that is why
I am sending this message).  The index at /s/xyzzy/.git/index has to be
able to record "os" as a gitlink and "os/drivers/frotz/frotz.c" as a
regular blob at the same time, which is a D/F conflict.

Even if you modify the index D/F conflict check to allow this, you cannot
write the top-level tree object for the superproject, as "os" needs to be
recorded as a gitlink to bind the /s/xyzzy/os/.git submodule, while you
also have to have another "os" in the same top-level tree object as a tree
object that has a single entry "drivers" (which is a tree) in it, under
which all the "os/drivers/frotz" subdirectory hang.  All tree traversal
code would be very unhappy to see such a tree with "duplicate" entry,
including the unpack-trees machinery used for merging and switching
branches, connectivity machinery used for fsck, object enumeration, and
object transfer.  I imagine that it *could* be done, but it won't be a
mere two-weekend hack; it has to first destroy pretty much everything in
the current codebase and rebuild it to add such a support.

The "frotz" submodule could be added as /s/xyzzy/frotz/.git and the build
infrastructure at /s/xyzzy/.git (which we are going to fork anyway) could
be tweaked so that it creates a symbolic link in /s/xyzzy/os/drivers to
point there, pretending that there is a 'frotz' subdirectory. While that
would certainly be a workaround, I am wondering if people who have used
submodules and/or nested projects more than I have better solutions to
this puzzle.

Comments?
