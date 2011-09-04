From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Funnies with "git fetch"
Date: Sun, 04 Sep 2011 12:15:27 -0700
Message-ID: <7vliu4yv8w.fsf@alter.siamese.dyndns.org>
References: <7vpqjkw3nb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 04 21:15:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0IAJ-0001M0-Qd
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 21:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043Ab1IDTPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 15:15:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40655 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998Ab1IDTPa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 15:15:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAB3031E1;
	Sun,  4 Sep 2011 15:15:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e9cbdSqKkC8S5+45ikuYGIKhBLw=; b=D+3MYA
	1ETCNI8l42+bCsZsMB7krJn/pwMV3ew5vj7VevuuKrQU8QoYVhAhDjujQdmuSwDk
	HQuqdphOf4GTjOMVVYFmpPzpaR8Zp6b+UU1fuufKol94866Tm3ANhi52bK/txH+H
	uzUZ7gPrL2uCKSsnDeGlDh5NhDPsyKXX9HJgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OVRFNcl4xcdYxsFRX7hipQzFDcDCrZ+Z
	Levh7/3WBPDuseBct6MGL/Z+iQ2MjHytPl+EaxKcWM34+TCL4XL1uJgWYbCsb+U0
	SZdhm/fGMPZNYguYp14iNP3InmJ7fer3S8+JVVCJdV7+gEbiPzVq4XNQsImhJqOG
	3EMdJC9azx4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C317531E0;
	Sun,  4 Sep 2011 15:15:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FD0031DF; Sun,  4 Sep 2011
 15:15:29 -0400 (EDT)
In-Reply-To: <7vpqjkw3nb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 01 Sep 2011 10:53:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40834D24-D72A-11E0-A270-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180697>

Junio C Hamano <gitster@pobox.com> writes:

> I just did this in an empty directory.
>
>     $ git init src
>     $ cd src
>     $ echo hello >greetings ; git add . ; git commit -m greetings
>     $ S=$(git rev-parse :greetings | sed -e 's|^..|&/|')
>     $ X=$(echo bye | git hash-object -w --stdin | sed -e 's|^..|&/|')
>     $ mv -f .git/objects/$X .git/objects/$S
>
> The tip commit _thinks_ it has "greetings" that contains "hello", but
> somebody replaced it with a corrupt "bye" that does not match self
> integrity.
>
>     $ git fsck
>     error: sha1 mismatch ce013625030ba8dba906f756967f9e9ca394464a
>
>     error: ce013625030ba8dba906f756967f9e9ca394464a: object corrupt or missing
>     missing blob ce013625030ba8dba906f756967f9e9ca394464a
>
> The "hello" blob is ce0136, and the tree contained in HEAD expects "hello"
> in that loose object file, but notices the contents do not match the
> filename.
>
> So far, so good. Let's see what others see when they interact with this
> repository.
>
> cd ../
> git init dst
> cd dst
> git config receive.fsckobjects true
> git remote add origin ../src
> git config branch.master.remote origin
> git config branch.master.merge refs/heads/master
> git fetch
>     remote: Counting objects: 3, done.
>     remote: Total 3 (delta 0), reused 0 (delta 0)
>     Unpacking objects: 100% (3/3), done.
>     From ../src
>      * [new branch]      master     -> origin/master
>
> Oops? If we run "fsck" at this point, we would notice the breakage:
> ...
> But the straight "fetch" did not notice anything fishy going on. Shouldn't
> we have?  Even though we may be reasonably safe, unpack-objects should be
> able to do better, especially under receive.fsckobjects option.

We do not have fetch.fsckobjects, and here is a quick patch to add it. I
would also add transfer.fsckobjects to cover both with a single variable
in a follow-up patch, but with this, it fails as expected:

    $ git config fetch.fsckobjects true
    $ git fetch
    remote: Counting objects: 3, done.
    remote: Total 3 (delta 0), reused 0 (delta 0)
    Unpacking objects: 100% (3/3), done.
    error: unable to find ce013625030ba8dba906f756967f9e9ca394464a
    fatal: object of unexpected type
    fatal: unpack-objects failed

during the transfer phase.  The "rev-list --verify-objects" addition is a
fix to a related but independent issue, so both are probably good to have,
but this makes it unnecessary to run fsck_object() during the update-ref
phase.

 builtin/fetch-pack.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 412bd32..bfed536 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -16,6 +16,7 @@ static int fetch_unpack_limit = -1;
 static int unpack_limit = 100;
 static int prefer_ofs_delta = 1;
 static int no_done = 0;
+static int fetch_fsck_objects;
 static struct fetch_pack_args args = {
 	/* .uploadpack = */ "git-upload-pack",
 };
@@ -734,6 +735,8 @@ static int get_pack(int xd[2], char **pack_lockfile)
 	}
 	if (*hdr_arg)
 		*av++ = hdr_arg;
+	if (fetch_fsck_objects)
+		*av++ = "--strict";
 	*av++ = NULL;
 
 	cmd.in = demux.out;
@@ -853,6 +856,11 @@ static int fetch_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "fetch.fsckobjects")) {
+		fetch_fsck_objects = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
