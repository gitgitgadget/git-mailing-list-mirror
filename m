From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] alloc_ref(): allow for trailing NUL
Date: Fri, 28 Sep 2007 01:46:13 -0700
Message-ID: <7vhclfqisq.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709280356550.28395@racer.site>
	<Pine.LNX.4.64.0709280046241.5926@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 10:46:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbBUT-0005PF-O8
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 10:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbXI1IqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 04:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754485AbXI1IqX
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 04:46:23 -0400
Received: from rune.pobox.com ([208.210.124.79]:49452 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753147AbXI1IqW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 04:46:22 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id AEEFF13D4B7;
	Fri, 28 Sep 2007 04:46:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C8EBA13D79C;
	Fri, 28 Sep 2007 04:46:37 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709280046241.5926@iabervon.org> (Daniel
	Barkalow's message of "Fri, 28 Sep 2007 01:03:46 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59377>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Fri, 28 Sep 2007, Johannes Schindelin wrote:
>
>> The parameter name "namelen" suggests that you pass the equivalent of
>> strlen() to the function alloc_ref().  However, this function did not
>> allocate enough space to put a NUL after the name.
>> 
>> Since struct ref does not have any member to describe the length of the
>> string, this just does not make sense.
>> 
>> So make space for the NUL.
>
> Good point, but shouldn't you then fix call sites that use strlen(name) + 
> 1?

Good point.

I audited "git grep -A2 -B4 -e alloc_ref next master" output,
and it appears almost everybody knows alloc_ref() wants the
caller to count the terminating NUL.

There however are a few gotchas.

 * There is one overallocation in connect.c, which would not
   hurt but is wasteful;

 * next:transport.c has alloc_ref(strlen(e->name)) which is a
   no-no;

Discarding Johannes's patch, the following would fix it.

---

 connect.c   |    4 ++--
 transport.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/connect.c b/connect.c
index 06d279e..3d5c4ab 100644
--- a/connect.c
+++ b/connect.c
@@ -72,9 +72,9 @@ struct ref **get_remote_heads(int in, struct ref **list,
 			continue;
 		if (nr_match && !path_match(name, nr_match, match))
 			continue;
-		ref = alloc_ref(len - 40);
+		ref = alloc_ref(name_len + 1);
 		hashcpy(ref->old_sha1, old_sha1);
-		memcpy(ref->name, buffer + 41, len - 40);
+		memcpy(ref->name, buffer + 41, name_len + 1);
 		*list = ref;
 		list = &ref->next;
 	}
diff --git a/transport.c b/transport.c
index 4f9cddc..3475cca 100644
--- a/transport.c
+++ b/transport.c
@@ -215,7 +215,7 @@ static struct ref *get_refs_from_bundle(const struct transport *transport)
 		die ("Could not read bundle '%s'.", transport->url);
 	for (i = 0; i < data->header.references.nr; i++) {
 		struct ref_list_entry *e = data->header.references.list + i;
-		struct ref *ref = alloc_ref(strlen(e->name));
+		struct ref *ref = alloc_ref(strlen(e->name) + 1);
 		hashcpy(ref->old_sha1, e->sha1);
 		strcpy(ref->name, e->name);
 		ref->next = result;
