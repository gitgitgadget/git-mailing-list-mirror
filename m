From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-fetch: avoid local fetching from alternate (again)
Date: Tue, 06 Nov 2007 23:45:35 -0800
Message-ID: <7vd4umebxc.fsf@gitster.siamese.dyndns.org>
References: <20071107024118.GA11043@spearce.org>
	<7vsl3iefoj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 08:45:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipfbn-000257-Jj
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 08:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282AbXKGHpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 02:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755401AbXKGHpl
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 02:45:41 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:46703 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102AbXKGHpk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 02:45:40 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8AD2A2F0;
	Wed,  7 Nov 2007 02:46:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id BBD1491424;
	Wed,  7 Nov 2007 02:45:58 -0500 (EST)
In-Reply-To: <7vsl3iefoj.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 06 Nov 2007 22:24:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63778>

Junio C Hamano <gitster@pobox.com> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> Back in e3c6f240fd9c5bdeb33f2d47adc859f37935e2df Junio taught
>> git-fetch to avoid copying objects when we are fetching from
>> a repository that is already registered as an alternate object
>> database.  In such a case there is no reason to copy any objects
>> as we can already obtain them through the alternate.
>
> Well spotted.  It would be a good idea to commit the big comment
> from contrib/examples/git-fetch.sh to fetch_local_nocopy()
> function, which would have made us realize that the patch does
> not refrain from applying this optimization even when shallow
> is in effect.  But I think that is actually a good change.

Having thought about this further by writing that comment myself
(patch attached), I suspect that the test at the beginning of
the function to see if we are talking to another local
repository is not necessary.  Even if we are _not_ fetching from
the remote, we could have all the necessary objects connected,
albeit the chance of that is rather slim.  But that means the
rev-list test will error out rather quickly because objects near
the tips are more likely to be missing, and if we are talking
about a true remote connection, networking cost will most likely
outweigh the cost to do this checking.

---

 transport.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/transport.c b/transport.c
index 0604dc6..a887491 100644
--- a/transport.c
+++ b/transport.c
@@ -614,6 +614,20 @@ static struct ref *get_refs_via_connect(const struct transport *transport)
 	return refs;
 }
 
+/*
+ * We would want to bypass the object transfer altogether if
+ * everything we are going to fetch already exists and connected
+ * locally.
+ *
+ * The refs we are going to fetch are in to_fetch (nr_heads in
+ * total).  If running
+ *
+ *  $ git-rev-list --objects to_fetch[0] to_fetch[1] ... --not --all
+ *
+ * does not error out, that means everything reachable from the
+ * refs we are going to fetch exists and is connected to some of
+ * our existing refs.
+ */
 static int fetch_local_nocopy(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
