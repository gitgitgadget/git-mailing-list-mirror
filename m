From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Be more careful about updating refs
Date: Thu, 17 Jan 2008 18:01:50 -0800
Message-ID: <7v63xrki29.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801151600140.2806@woody.linux-foundation.org>
	<7vodblpmyc.fsf@gitster.siamese.dyndns.org>
	<20080117091558.GA8341@hashpling.org> <478F3367.8050307@viscovery.net>
	<20080117110132.GB12285@hashpling.org>
	<478F4CDC.2090703@viscovery.net>
	<7vbq7jkixg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <charles@hashpling.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 03:02:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFgZ6-0002QX-B4
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 03:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757047AbYARCCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 21:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755478AbYARCCJ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 21:02:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32821 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975AbYARCCH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 21:02:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B0B8B23C8;
	Thu, 17 Jan 2008 21:02:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B0D9F21FD;
	Thu, 17 Jan 2008 21:01:56 -0500 (EST)
In-Reply-To: <7vbq7jkixg.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 17 Jan 2008 17:43:07 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70948>

Junio C Hamano <gitster@pobox.com> writes:

> The following patch seems to fix the issue for me, but this is
> primarily meant for discussion, as I do not quite understand why
> the same issue does not manifest itself when NO_MMAP is not
> used.
> ...

BTW, the lookup of the object that dies is in update_branch().
The call to write_ref_sha1() at the last tries to verify b->sha1
is available and is a commit.

        static int update_branch(struct branch *b)
        {
                static const char *msg = "fast-import";
                struct ref_lock *lock;
                unsigned char old_sha1[20];

                if (read_ref(b->name, old_sha1))
                        hashclr(old_sha1);
                lock = lock_any_ref_for_update(b->name, old_sha1, 0);
                if (!lock)
                        return error("Unable to lock %s", b->name);
                if (!force_update && !is_null_sha1(old_sha1)) {
                        struct commit *old_cmit, *new_cmit;

                        old_cmit = lookup_commit_reference_gently(old_sha1, 0);
                        new_cmit = lookup_commit_reference_gently(b->sha1, 0);
                        if (!old_cmit || !new_cmit) {
                                unlock_ref(lock);
                                return error("Branch %s is missing commits.", b->name);
                        }

                        if (!in_merge_bases(old_cmit, &new_cmit, 1)) {
                                unlock_ref(lock);
                                warning("Not updating %s"
                                        " (new tip %s does not contain %s)",
                                        b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
                                return -1;
                        }
                }
                if (write_ref_sha1(lock, b->sha1, msg) < 0)
                        return error("Unable to update %s", b->name);
                return 0;
        }

The write_ref_sha1() function previously did not even check if
the object pointed at by b->sha1 actually existed, but now it
parses the object and makes sure it is a commit, if the updated
ref is under ref/heads/ hierarchy.

What I do not quite understand is how this can be a new issue.

The codepath to allow updating an existing branch shown above
(i.e. "if it is not force and old is not NULL") uses the usual
lookup_commit_reference_gently() interface to access b->sha1,
and does not use gfi-aware gfi_unpack_entry() or anything
magical, which means it would have passed the same codepath down
to trigger the same issue.  IOW, even before this tightening of
write_ref_sha1(), we already should have had the issue of not
being to able to grab the object b->sha1 refers to out of the
newly built packfile.

Is it just nobody seriously exercised the codepath yet, or is
there a difference between these two calls that is more subtle
than that?

Quite confused...
