From: Junio C Hamano <gitster@pobox.com>
Subject: Funnies with "git fetch"
Date: Thu, 01 Sep 2011 10:53:12 -0700
Message-ID: <7vpqjkw3nb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 19:54:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzBT3-0000id-PN
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 19:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756924Ab1IARxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 13:53:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38863 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756663Ab1IARxP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 13:53:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2B3F55AC;
	Thu,  1 Sep 2011 13:53:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=w
	/2CRT8KxMq0x3BtxqLyWvzghWs=; b=h5Ix3WeWgPDbyzhTn8Lbpy8ZU38wTHLzt
	Q8K8t++DS9zD/cprZIaaLKI3YsJz1yO9IRz7jX6LL7kAZTEXESt2zKCzIAez52S6
	UzNkg0Kji4OXyxhFIzk8/ZCE0Orz6/SNDYEpESYeH73AcSvb4Il1bTa0E7Kpk/jT
	wkpV5G6Yaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=KEl
	4Q3sVpOlpXwAE704+7OVIj1wbmj10nTqf7LCGd925AjRhzmj1JuKuRJUGUViJovd
	xw0GvE+By5vbvxkWbwoxjXQ95U/HAZ76KBRdXMb7zabnOzeDYCvP+FDrYAp3KXaH
	Pn5LgwtnKi2WI0aaHxTKiQtoLm+FYFedDtFlYHo4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA8AD55AB;
	Thu,  1 Sep 2011 13:53:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4836955AA; Thu,  1 Sep 2011
 13:53:14 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43D80E74-D4C3-11E0-87E5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180557>

I just did this in an empty directory.

    $ git init src
    $ cd src
    $ echo hello >greetings ; git add . ; git commit -m greetings
    $ S=$(git rev-parse :greetings | sed -e 's|^..|&/|')
    $ X=$(echo bye | git hash-object -w --stdin | sed -e 's|^..|&/|')
    $ mv -f .git/objects/$X .git/objects/$S

The tip commit _thinks_ it has "greetings" that contains "hello", but
somebody replaced it with a corrupt "bye" that does not match self
integrity.

    $ git fsck
    error: sha1 mismatch ce013625030ba8dba906f756967f9e9ca394464a

    error: ce013625030ba8dba906f756967f9e9ca394464a: object corrupt or missing
    missing blob ce013625030ba8dba906f756967f9e9ca394464a

The "hello" blob is ce0136, and the tree contained in HEAD expects "hello"
in that loose object file, but notices the contents do not match the
filename.

So far, so good. Let's see what others see when they interact with this
repository.

cd ../
git init dst
cd dst
git config receive.fsckobjects true
git remote add origin ../src
git config branch.master.remote origin
git config branch.master.merge refs/heads/master
git fetch
    remote: Counting objects: 3, done.
    remote: Total 3 (delta 0), reused 0 (delta 0)
    Unpacking objects: 100% (3/3), done.
    From ../src
     * [new branch]      master     -> origin/master

Oops? If we run "fsck" at this point, we would notice the breakage:

    $ git fsck
    notice: HEAD points to an unborn branch (master)
    broken link from    tree 1c93b84c9756b083e5751db1f9ffa7f80ac667e2
                  to    blob ce013625030ba8dba906f756967f9e9ca394464a
    missing blob ce013625030ba8dba906f756967f9e9ca394464a
    dangling blob b023018cabc396e7692c70bbf5784a93d3f738ab

Here, b02301 is the true identity of the "bye" blob the src repository
crafted and tried to fool us into believing it is "hello".  We can see
that the object transfer gave three objects, and because we only propagate
the contents and have the receiving end compute the object names from the
data, we received b02301 but not ce0136.

    $ ls .git/objects/??/?*
    .git/objects/1c/93b84c9756b083e5751db1f9ffa7f80ac667e2
    .git/objects/61/5d8c76daef6744635c87fb312a76a5ec7462ea
    .git/objects/b0/23018cabc396e7692c70bbf5784a93d3f738ab

As a side note, if we did "git pull" instead of "git fetch", we would have
also noticed the breakage, like so:

    $ git pull
    remote: Counting objects: 3, done.
    remote: Total 3 (delta 0), reused 0 (delta 0)
    Unpacking objects: 100% (3/3), done.
    From ../src
     * [new branch]      master     -> origin/master
    error: unable to find ce013625030ba8dba906f756967f9e9ca394464a
    error: unable to read sha1 file of greetings (ce013625030ba...)

But the straight "fetch" did not notice anything fishy going on. Shouldn't
we have?  Even though we may be reasonably safe, unpack-objects should be
able to do better, especially under receive.fsckobjects option.

Also as a side note, if we set 

    $ git config fetch.unpacklimit 1

before we run this "git fetch", we end up storing a single pack, whose
contents are the same three objects above (as expected), and we do not get
any indication of an error from the command.

I think the breakages are:

 - The sending side does not give any indication that it _wanted_ to send
   ce0136 but couldn't, and ended up sending another object;

 - The pack data sent over the wire was self consistent (no breakage here)
   and sent three well-formed objects, but it was inconsistent with
   respect to what history was being transferred (breakage is here);

 - The receiving end did not notice the inconsistency.

The first one is of the lower priority, as the client side should be able
to notice an upstream with corruption in any case. Perhaps after asking
for objects between "have" and "want", "git fetch" should verify that it
can fully walk the subhistory that was supposed to be transferred down to
the blob level?
