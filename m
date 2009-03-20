From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git no longer reads attributes from the index properly
Date: Fri, 20 Mar 2009 03:16:45 -0700
Message-ID: <7v4oxojy7m.fsf@gitster.siamese.dyndns.org>
References: <20090320073527.GC1037@lavos.net>
 <7vab7gk39o.fsf@gitster.siamese.dyndns.org> <20090320084031.GD1037@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	msysgit@googlegroups.com
To: bdowning@lavos.net (Brian Downing)
X-From: git-owner@vger.kernel.org Fri Mar 20 11:20:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkboQ-0004sE-5l
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 11:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758045AbZCTKQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 06:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbZCTKQ5
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 06:16:57 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbZCTKQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 06:16:56 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 24E437DDD;
	Fri, 20 Mar 2009 06:16:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 51B207DDC; Fri,
 20 Mar 2009 06:16:47 -0400 (EDT)
In-Reply-To: <20090320084031.GD1037@lavos.net> (Brian Downing's message of
 "Fri, 20 Mar 2009 03:40:31 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3BAFAE98-1538-11DE-8E66-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113933>

bdowning@lavos.net (Brian Downing) writes:

> However, that commit looks like it's solving a different problem
> entirely (supporting changing between two branches where .gitattributes
> exists in both cases) and happens to fix the no .gitattributes -> read
> from index regression at the same time.  I don't know enough about the
> guts to tell, but does this also fix the core problem of the regression
> (I assume something about trying to read from the wrong index, given the
> commit that broke it), or does it just happen to work around it?

Actually the commit solves both.

Notice that the second hunk of the patch to unpack-trees passes o->result
to the new git_attr_set_direction() function to tell it to read from the
new index, instead of reading from the wrong one.  In addition, by setting
the direction to CHECKOUT, it favors to read the attribute data from the
index over from the work tree.

Note that this is merely a "good enough" approximation and arguing that we
should only read from the in-index attributes during checkout (and read
only from work tree attributes during checkin) is futile.  Look at other
thread with Kristian Amlie for details.

diff --git a/unpack-trees.c b/unpack-trees.c
index e547282..661218c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -105,6 +106,7 @@ static int check_updates(struct unpack_trees_options *o)
 		cnt = 0;
 	}
 
+	git_attr_set_direction(GIT_ATTR_CHECKOUT, &o->result);
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
