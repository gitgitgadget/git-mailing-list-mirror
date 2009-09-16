From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] Speed up fetch with large number of tags
Date: Wed, 16 Sep 2009 02:44:00 -0700
Message-ID: <7vbplb2pi7.fsf@alter.siamese.dyndns.org>
References: <20090916074737.58044.42776.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Sep 16 11:44:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnr3j-0007Wx-9X
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 11:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbZIPJoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 05:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbZIPJoI
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 05:44:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbZIPJoG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 05:44:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E73734868;
	Wed, 16 Sep 2009 05:44:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3YdZOe4FHopiLgJ/gp4JR7yovHQ=; b=GCSU3H
	fbNrnDN5i9ACvrLuHf6Z45syFdqOlWPtzPKlDnDA+UzNGPHGkdedhW1HBiT9J1VF
	D+I3VaMY0yJhSQy/SXZUtdXewHXZVfNoUITdKPW+ZTujn9PYk8vWIMhT/ggAIwMa
	CbF4c6tJdBqKAhCFn93l0PO45n1x45YnyRf24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=grVMpdpTprWqrDtefY8URiRqrFdSdX2c
	ktehXeP+D0gJ5qFnHJykuPGCQMwJ6kRxke60lhKyEjNtljO5SBuFq1xwQJeaAdbO
	BOol3TaL8IgEQls7UVPVbgBJpf7m8YCKNZOa2USJNqFIg/UA0NgwWsj28wkesLBJ
	bVZ0SIrx+64=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F6FE34866;
	Wed, 16 Sep 2009 05:44:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7414B34865; Wed, 16 Sep
 2009 05:44:02 -0400 (EDT)
In-Reply-To: <20090916074737.58044.42776.julian@quantumfyre.co.uk> (Julian
 Phillips's message of "Wed\, 16 Sep 2009 08\:53\:01 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7931BEE6-A2A5-11DE-A433-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128634>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> I have a repository at $dayjob where fetch was taking ~30s to tell me
> that there were no updates.
>
> It turns out that I appear to have added a nasty linear search of all
> remote refs for every commit (i.e. tag^{}) tag ref way back in the
> original C implementation of fetch.  This doesn't scale well to large
> numbers of refs, so this replaces it with a hash table based lookup
> instead, which brings the time down to a few seconds even for very large
> ref counts.
>
> I haven't tested it with non-native transports, but there is no reason
> to believe that the code should be transport specific.

Very interesting.

A few questions (not criticisms).

 * 1m50s to 4.5s is quite impressive, even if it is only in a repository
   with unusual refs-vs-commits ratio, but I personally think 10 refs per
   every commit is already on the borderline of being insane, and the
   normal ratio would be more like 1 refs per every 10-20 commits.

   What are possible downsides with the new code in repositories with more
   reasonable refs-vs-commits ratio?  A hash table (with a sensible hash
   function) would almost always outperform linear search in an randomly
   ordered collection, so my gut tells me that there won't be performance
   downsides, but are there other potential issues we should worry about?

 * In an insanely large refs-vs-commits case, perhaps not 50000:1 but more
   like 100:1, but with a history with far more than one commit, what is
   the memory consumption?  Judging from a cursory view, I think the way
   ref-dict re-uses struct ref might be quite suboptimal, as you are using
   only next (for hash-bucket link), old_sha1[] and its name field, and
   also your ref_dict_add() calls alloc_ref() which calls one calloc() per
   requested ref, instead of attempting any bulk allocation.

 * The outer loop is walking the list of refs from a transport, and the
   inner loop is walking a copy of the same list of refs from the same
   transport, looking for each refs/tags/X^{} what record, if any, existed
   for refs/tags/X.

   Would it make sense to further specialize your optimization?  For
   example, something like...

        /* Your hash records this structure */
        struct tag_ref_record {
                const char *name;
                struct ref *self;
                struct ref *peeled;
        };

        static void add_to_tail(struct ref ***tail,
                                struct string_list *existing_refs,
                                struct string_list *new_refs,
                                const struct ref *ref,
                                const unsigned char sha1[]) {
                ... the "appending to *tail" thing as a helper function ...
        }

        for (ref in all refs from transport) {
                if (ref is of form "refs/tags/X^{}")
                        look up tag_ref_record for "refs/tags/X" and store
                        ref in its peeled member;
                else if (ref is of form "refs/tags/X")
                        look up tag_ref_record for "refs/tags/X" and store
                        ref in its self member;
        }

        for (trr in all tag_ref_record database) {
                add_to_tail(tail, &existing_refs, &new_refs,
                            trr->self, self->old_sha1);
                add_to_tail(tail, &existing_refs, &new_refs,
                            trr->peeled, self->old_sha1);
        }

 * It is tempting to use a hash table when you have to deal with an
   unordered collection, but in this case, wouldn't the refs obtained from
   the transport (it's essentially a ls-remote output, isn't it?) be
   sorted?  Can't you take advantage of that fact to optimize the loop,
   without adding a specialized hash table implementation?

   We find refs/tags/v0.99 immediately followed by refs/tags/v0.99^{} in
   the ls-remote output.  And the inefficient loop is about finding
   refs/tags/v0.99 when we see refs/tags/v0.99^{}, so if we remember the
   tag ref we saw in the previous round, we can check with that first to
   make sure our "sorted" assumption holds true, and optimize the loop out
   that way, no?

diff --git a/builtin-fetch.c b/builtin-fetch.c
index cb48c57..3f12e28 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -516,6 +516,7 @@ static void find_non_local_tags(struct transport *transport,
 	const struct ref *tag_ref;
 	struct ref *rm = NULL;
 	const struct ref *ref;
+	const struct ref *last_tag_seen = NULL;
 
 	for_each_ref(add_existing, &existing_refs);
 	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
@@ -528,6 +529,11 @@ static void find_non_local_tags(struct transport *transport,
 
 		if (!strcmp(ref_name + ref_name_len - 3, "^{}")) {
 			ref_name[ref_name_len - 3] = 0;
+			if (last_tag_seen &&
+			    !strcmp(last_tag_seen->name, ref_name)) {
+				ref_sha1 = last_tag_seen->old_sha1;
+				goto quick;
+			}
 			tag_ref = transport_get_remote_refs(transport);
 			while (tag_ref) {
 				if (!strcmp(tag_ref->name, ref_name)) {
@@ -536,8 +542,11 @@ static void find_non_local_tags(struct transport *transport,
 				}
 				tag_ref = tag_ref->next;
 			}
+		} else {
+			last_tag_seen = ref;
 		}
 
+	quick:
 		if (!string_list_has_string(&existing_refs, ref_name) &&
 		    !string_list_has_string(&new_refs, ref_name) &&
 		    (has_sha1_file(ref->old_sha1) ||
