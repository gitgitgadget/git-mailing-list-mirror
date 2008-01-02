From: Junio C Hamano <gitster@pobox.com>
Subject: Re: input validation in receive-pack
Date: Tue, 01 Jan 2008 19:07:25 -0800
Message-ID: <7vzlvp3oya.fsf@gitster.siamese.dyndns.org>
References: <20080101213451.GA26772@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Wed Jan 02 04:08:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9ty6-0001Tv-TE
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 04:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766AbYABDHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 22:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753777AbYABDHp
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 22:07:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766AbYABDHo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 22:07:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D1B6AE77;
	Tue,  1 Jan 2008 22:07:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F31EAE6E;
	Tue,  1 Jan 2008 22:07:37 -0500 (EST)
In-Reply-To: <20080101213451.GA26772@auto.tuwien.ac.at> (Martin Koegler's
	message of "Tue, 1 Jan 2008 22:34:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69450>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> In the function "static const char *update(struct command *cmd)" in
> receive-pack.c:
>
> |        if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
> |            !is_null_sha1(old_sha1) &&
> |            !prefixcmp(name, "refs/heads/")) {
> |                struct commit *old_commit, *new_commit;
> |                struct commit_list *bases, *ent;
> |
> |                old_commit = (struct commit *)parse_object(old_sha1);
> |                new_commit = (struct commit *)parse_object(new_sha1);
> |                bases = get_merge_bases(old_commit, new_commit, 1);
> |                for (ent = bases; ent; ent = ent->next)
> |                        if (!hashcmp(old_sha1, ent->item->object.sha1))
> |                                break;
> |                free_commit_list(bases);
> |                if (!ent) {
> |                        error("denying non-fast forward %s"
> |                              " (you should pull first)", name);
> |                        return "non-fast forward";
> |                }
> |        }
>
> As far as I understand the code, it assumes, that sha1 values provided
> by the client really point to a commit. Shouldn't there be a check for
> the object type?

Yes, 11031d7e9f34f6a20ff4a4bd4fa3e5e3c0024a57 seems to have been
a bit sloppy.  The codepath to delete a ref may need to be lax
(see 28391a80a94d2b59d1d21f8264fe5dab91d77249) but there is no
excuse not to be strict when updating.

> Some lines above:
> |        if (!prefixcmp(name, "refs/") && check_ref_format(name + 5)) {
> |                error("refusing to create funny ref '%s' remotely", name);
> |                return "funny refname";
> |        }
>
> Is this code really correct?

Interesting.  Things have been this way forever, I think.  I do
not offhand see any reason not to refuse refs outside refs/, so
you can try 

	if (prefixcmp(name, "refs/") || check_ref_format(name +	5))

and see what happens.  Some people may however want to push to
HEAD (that is ".git/HEAD" which is outside ".git/refs"), though.

> In the update code path, the check is done in refs.c:
> | struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1, int flags)
> | {
> |         if (check_ref_format(ref) == -1)
> |                 return NULL;
> |         return lock_ref_sha1_basic(ref, old_sha1, flags, NULL);
> | }
>
> check_ref_format may also return -2 (less than two name levels) and -3
> (* at the end), which are ignored. Is it really intended, that
> receive-pack can create such refs.

Misconversion in 8558fd9ece4c8250a037a6d5482a8040d600ef47 that
changed check_ref_format() without looking at what its callers
are checking, I think.
