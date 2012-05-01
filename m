From: Junio C Hamano <gitster@pobox.com>
Subject: [BUG] "fetch $there +refs/*:refs/*" fails if there is a stash
Date: Tue, 01 May 2012 15:19:07 -0700
Message-ID: <7vsjfj7des.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 00:19:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPLPr-0003Xe-DC
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 00:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756322Ab2EAWTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 18:19:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63438 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755790Ab2EAWTK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 18:19:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AD186043;
	Tue,  1 May 2012 18:19:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=b
	zKmuq8GoKaGkrhzJUT90OnmCFw=; b=U41NbdOwOT7DS9u5z5sCu7I5ItvAbCEad
	lujhBmmVe2em3xD+hZT3P7HIPN2A5xZAQm4fmolBxkjIoBw+ne1CrLU6rwRTjlEX
	Zm9SMQDa4w6O2FasA8hnH2MEYi/OPlb4z82ldcDOAf/lR1bVxok/sog3cYxYyL5o
	VNLj0wgdgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=ntzJ26CjAD4GI9hOhKTdCxjVrb4VH6TjxMmVZpJe1xbr51RHP6rh54fy
	oTsBD4zZyf/DcwQq9mPwJ/T59KQAmyKUlseE/HTEekpEgJ+LW60qevEryYzDYLpR
	o82pCTFE6MyJURiWN/4ArYKas0MGkzqRZHz1yKAdAzFK4zh0rbA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FE696042;
	Tue,  1 May 2012 18:19:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C070D6041; Tue,  1 May 2012
 18:19:08 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ABD7A2B4-93DB-11E1-9F47-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196764>

This ought to work:

    $ git checkout HEAD^0 ;# make sure we are on detached HEAD
    $ git fetch $somewhere +refs/*:refs/*

if you want to pull down all the branches from somewhere, potentially
nuking the refs we currently have.

However, if $somewhere has a stash, i.e. refs/stash, even though our
"fetch" sees it in the "ls-remote $somewhere" output and tries to make
sure that the object comes over the wire, we never show "want" line for
refs/stash, because we silently drop it with check_ref_format().

I have run out concentration before digging this through, but the attached
single liner patch fixes it.  The thing is, this function is given a list
of refs and drops refs/stash (which is not what I want in the context of
the above +refs/*:refs/*), and modifies the caller's list of refs, and
then the caller (i.e. do_fetch_pack() that called everything_local()) then
uses updated list (i.e. without refs/stash) to run find_common() and
get_pack(), but the layer higher above (namely, do_fetch() that calls
fetch_refs() that in turn calls store_updated_refs(), all in
builtin/fetch.c) is _not_ aware of this filtering and expects that the
code at this layer *must* have asked for and obtained all the objects
reachable from what was listed in ls-remote output, leading to an
inconsistent state.

[Michael CC'ed as he seems to be dead set tightening check_ref_format()]

The specific failure of "refs/stash" is fixed with this patch, but I think
this call to check_ref_format() in the filter_refs() should be removed.
The function is trying to see what we _asked_ against what the remote side
said they have, and if we tried to recover objects from a broken remote by
doing:

	git fetch $somewhere refs/heads/a..b:refs/heads/a_dot_dot_b

and the remote side advertised that it has such a ref (note that a..b is
an illegal path component), we should be able to do so without a misguided
call to check_refname_format() getting in the way.

It is the same story if the name advertised by a broken remote were
"refs/head/../heads/master".  As long as the RHS of the refspec
(i.e. refs/heads/a_dot_dot_b) is kosher, we must allow such a request to
succeed, so that people can interoperate in less than perfect world.

 builtin/fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 7124c4b..34cd8a5 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -541,7 +541,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 	for (ref = *refs; ref; ref = next) {
 		next = ref->next;
 		if (!memcmp(ref->name, "refs/", 5) &&
-		    check_refname_format(ref->name + 5, 0))
+		    check_refname_format(ref->name, 0))
 			; /* trash */
 		else if (args.fetch_all &&
 			 (!args.depth || prefixcmp(ref->name, "refs/tags/") )) {
