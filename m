From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Wed, 11 Feb 2009 22:42:27 -0800
Message-ID: <7v3aekqhpo.fsf@gitster.siamese.dyndns.org>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
 <20090129035138.GC11836@coredump.intra.peff.net>
 <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com>
 <20090129113735.GA6505@coredump.intra.peff.net>
 <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl>
 <bd6139dc0901290345u4962f747gbe93c945ab35c9cb@mail.gmail.com>
 <20090129115026.GB10792@coredump.intra.peff.net>
 <bd6139dc0901290420x1216a399w656e4d1622178a06@mail.gmail.com>
 <20090130045131.GB18655@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901301415260.3586@pacific.mpi-cbg.de>
 <7vr62j0wpc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Sverre Rabbelier <srabbelier@gmail.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 12 07:44:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXVIw-0001DY-6Y
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 07:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbZBLGml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 01:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbZBLGml
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 01:42:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39442 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbZBLGmk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 01:42:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F3D3B98EC2;
	Thu, 12 Feb 2009 01:42:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4EF8298EC1; Thu,
 12 Feb 2009 01:42:29 -0500 (EST)
In-Reply-To: <7vr62j0wpc.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 31 Jan 2009 17:31:27 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5689E654-F8D0-11DD-9C41-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109578>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> How about installing
>>
>> 	[branch "master"]
>> 		remote = origin
>> 		merge = refs/heads/master
>>
>> by default?  It is a safe bet that this will be the case for 99% of all 
>> users that want to clone an empty repository (especially if they are 
>> putting their public repositories on something like repo.or.cz, where you 
>> cannot change the default branch from "master" to something else).
>
> I think this is a reasonable thing to do.

So I've been sort of waiting for a trivial patch to materialize, and then
almost forgot about it like everybody else did.  Before all of us forget,
here is my attempt to do the above.

We seem to have acquired a bad habit of discussing and agreeing on a
potential improvement and then not following through, forgetting it
altogether.

Exciting new features we can count on original submitters to stick to them
and push them forward whether we go into a release freeze, but the more
boring kind of patches that we already know what we want to see by the
next release are actually the more important to the overall project;
sadly, they tend to get lost somewhere in the crack.  I wonder if we can
do anything about it.

And no, a bug tracker is not the answer, even though it could be a (small)
part of the solution.

-- >8 --
Subject: Install the default "master" branch configuration after cloning a void

After "cloning from an empty repository", we have a configuration to
describe the remote's URL and the default ref mappings, but we lack the
branch configuration for the default branch we create on our end,
"master".

It is likely that the empty repository we cloned from will point the
default "master" branch with its HEAD, so prepare the local configuration
to match.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-clone.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index f73029e..431c136 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -350,6 +350,18 @@ static struct ref *write_remote_refs(const struct ref *refs,
 	return local_refs;
 }
 
+static void install_branch_config(const char *origin, const char *local,
+				  const char *remote)
+{
+	struct strbuf key = STRBUF_INIT;
+	strbuf_addf(&key, "branch.%s.remote", local);
+	git_config_set(key.buf, origin);
+	strbuf_reset(&key);
+	strbuf_addf(&key, "branch.%s.merge", local);
+	git_config_set(key.buf, remote);
+	strbuf_release(&key);
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int use_local_hardlinks = 1;
@@ -539,6 +551,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		head_points_at = NULL;
 		remote_head = NULL;
 		option_no_checkout = 1;
+		if (!option_bare)
+			install_branch_config(option_origin, "master",
+					      "refs/heads/master");
 	}
 
 	if (head_points_at) {
@@ -567,11 +582,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 				      head_points_at->peer_ref->name,
 				      reflog_msg.buf);
 
-			strbuf_addf(&key, "branch.%s.remote", head);
-			git_config_set(key.buf, option_origin);
-			strbuf_reset(&key);
-			strbuf_addf(&key, "branch.%s.merge", head);
-			git_config_set(key.buf, head_points_at->name);
+			install_branch_config(option_origin, head,
+					      head_points_at->name);
 		}
 	} else if (remote_head) {
 		/* Source had detached HEAD pointing somewhere. */
