From: Junio C Hamano <gitster@pobox.com>
Subject: Re: directory permissions on AFS
Date: Wed, 12 Dec 2012 16:17:28 -0800
Message-ID: <7vd2ye24br.fsf@alter.siamese.dyndns.org>
References: <0A6FA42F-986D-4C3C-BC50-9A7C0494C703@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jaime Frey <jfrey@cs.wisc.edu>
X-From: git-owner@vger.kernel.org Thu Dec 13 01:17:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiwUm-0002Ua-Pt
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 01:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065Ab2LMARc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 19:17:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754962Ab2LMARb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 19:17:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59B55AB3A;
	Wed, 12 Dec 2012 19:17:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aJEcu4yxd4hjj4L6y87geLVxWLg=; b=PbvGss
	0kAJejL/ZcRCBu40F0R6so60T8GzLTG2cHVoHqEI7K3kPOcfEN1iFG1oDvvw2DcP
	aJ6ng49Y1UXgcSDN0iVsPodC2YRJdmJRfe4ryAU5UOBdLBUHv242r2rRiM5Vd+zt
	vk2Lcp2+A/llWAz+aUyOhFNEnNy5iyDoZSE7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SSEuD+zcIoVu7P+LhvsI59W1MWDBExOG
	REb9lGhXD1NACnMGQTmAQ+Uz33+YG2PDKs0mfB5czmLQl3RnqoIWLZXi6Wzw8C/W
	Cgc/mxxDdlAcTTfTNfGhP5oUIIT04jPj5xgUSxoTfPIU70TBytfsR4PN8XYqaRuD
	X22xdoAVQOo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47365AB39;
	Wed, 12 Dec 2012 19:17:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A04F0AB37; Wed, 12 Dec 2012
 19:17:29 -0500 (EST)
In-Reply-To: <0A6FA42F-986D-4C3C-BC50-9A7C0494C703@cs.wisc.edu> (Jaime Frey's
 message of "Wed, 12 Dec 2012 17:39:30 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B3B7F32-44BA-11E2-8373-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211426>

Jaime Frey <jfrey@cs.wisc.edu> writes:

> Stracing git revealed that it successfully recreated the ./objects/fb 
> and then failed to chmod() it. It failed because it tried to set the
> S_ISGID bit, which mere mortals cannot do on AFS. Manually recreating 
> all of these directories solves the problem. 

We fix directory permissions after creating any directory under .git
with the same code, so that in a repository shared by group, new
subdirectories created by a random somebody who belongs to that
group will belong to that group (we also chmod to g+wx in case such
a random somebody has overly strict umask).  Instead of running
chown(2) on every new file created by us, we let the filesystem to
take care of it by telling the directories we create that new files
in them should inherit their group ownership.

What we were worried about back when we decided to use S_ISGID was a
scenario like this:

 * A repository is shared by group "src".

 * A user belongs to the group "src".  That group may or may not be
   his primary group (i.e. "mkdir foo" done at random place by him
   may not belong to the "src" group).

 * The user attempts to create a new branch "foo/bar" by pushing
   from outside.  There is no other branch whose name is
   "foo/anything" when this happens.

 * An equivalent of "mkdir -p .git/refs/heads/foo" needs to be done
   before an equivalent of "echo $sha >.git/refs/heads/foo/bar"
   happens to accept this push.  We want "foo" and "bar" to belong
   to "src" group and they get appropriate permission bits suitable
   to be accessed by the members of the "src" group.

The story is the same for loose objects and their fan-out directory.
Storing a commit object fb/012345... may need to create the leading
fan-out ".git/objects/fb" and we want that directory and any future
files created in it to belong to the "src" group.

Any alternative implementation that achieves the same result that
works on AFS can be substituted with the current code, or made
conditionally activated on AFS.
