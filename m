From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: add a test for creating a new branch with
 regexp as a starting point
Date: Mon, 02 Aug 2010 14:04:27 -0700
Message-ID: <7v1vaglo9w.fsf@alter.siamese.dyndns.org>
References: <20100729220111.GA28176@wo.int.altlinux.org>
 <AANLkTi=Qf1OUmjkpL-6e8gT8MU9G=m37sxrdAoyj5=R0@mail.gmail.com>
 <201007300136.13501.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	"Dmitry V. Levin" <ldv@altlinux.org>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 02 23:04:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og2Bh-0004yq-P0
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 23:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958Ab0HBVEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 17:04:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab0HBVEk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 17:04:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F2F3CAB07;
	Mon,  2 Aug 2010 17:04:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0yXEZb5TYhSiTOHN2bCMHcTP8uI=; b=P25bLv
	vU/Y0WRCPEwz4c1IZlxRxC64ZO/lLFhAL/1w4TCaqCUpfy+a9I0MCkSCcF3JgEXB
	H28l0EeinyFn+WszZlb02KtoVCrmtis5r4569RwUewiF3xoEGIZ7fO2+kw0B0CpJ
	bAaYqLC8LhnmvWPeCc9/+IMavqeqzyMH07J08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VqgLHTwjfFBVEiJTKGoc2znbl+U5oab2
	gGe+NyD9EyTGMABXmlz2P1hs+Y6o4ymobweDG0IVjREYKiscJtL52sMggyjrqOC9
	oDS2myoLr1WvWSWDxjIniRk2r8+QOgb2WfGoJIuJVu7AxHn8P5d3FWGofrx8ltZK
	H2eYmfp9OEw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BD01CAB05;
	Mon,  2 Aug 2010 17:04:34 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D6F8CAB04; Mon,  2 Aug
 2010 17:04:29 -0400 (EDT)
In-Reply-To: <201007300136.13501.trast@student.ethz.ch> (Thomas Rast's
 message of "Fri\, 30 Jul 2010 01\:36\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8D45AED0-9E79-11DF-BF05-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152460>

Thomas Rast <trast@student.ethz.ch> writes:

>> > +test_expect_success checkout '
>> > +       git checkout -b new_branch :/first
>> > +'
>> > +
>> > +test_done
>> 
>> ...it looks like this can just be added to the end of
>> t2018-checkout-branch.sh instead of creating a new test. Creating a
>> new file just for a single test for such a simple feature is a bit of
>> an overkill.
>
> It should also use test_expect_failure unless you expect to have a fix
> soon, otherwise it would stop the test suite from running through.

I think this is an ancient bug from the very beginning of the ":/"
notation.  Because it temporarily uses one bit in the object flags, but
the get_sha1_oneline() parser can be called multiple times, it tries to
clear the flag bits it smudged at the end, but fails.

The basic pattern for traversing the ancestry while avoiding duplication
is:

    prepare commits you traverse from in "list";
    while (list) {
        commit = pop_most_recent_commit(&list, MARK);
        try to use commit;
    }

pop_most_recent_commit() removes a commit from the list, pushes parents of
the commit that are _not_ marked with any of the bits in the MARK to the
given list, and returns that commit.

While introducing the feature ':/', however, 28a4d94 (object name:
introduce ':/<oneline prefix>' notation, 2007-02-24) wanted to avoid
leaving the mark used in the loop before leaving the function (which is a
right thing to do), by doing this:

    prepare commits you traverse from in "list";
+   keep a copy of "list" in "backup";
    while (list) {
        commit = pop_most_recent_commit(&list, MARK);
        try to use commit;
    }
+   for (commit in backup)
+       clear_commit_marks(commit, MARK);

which is wrong, as clear_commit_marks() will ignore if the starting commit
does not have the MARK.

I think the fix should be just as simple as this.  Essentially, X_SEEN
mark means "we have marked and placed this item on the list (so do not put
it again back on the list when it appears as a parent of some other item)"
so marking commits we initially put on the list with the bit should be the
right thing to do regardless of this clean-up business.

 sha1_name.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 4f2af8d..b935688 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -704,8 +704,10 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 		die("Invalid search pattern: %s", prefix);
 
 	for_each_ref(handle_one_ref, &list);
-	for (l = list; l; l = l->next)
+	for (l = list; l; l = l->next) {
 		commit_list_insert(l->item, &backup);
+		l->item->object.flags |= ONELINE_SEEN;
+	}
 	while (list) {
 		char *p;
 		struct commit *commit;
