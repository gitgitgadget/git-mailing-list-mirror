From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Be more careful about updating refs
Date: Thu, 17 Jan 2008 17:43:07 -0800
Message-ID: <7vbq7jkixg.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801151600140.2806@woody.linux-foundation.org>
	<7vodblpmyc.fsf@gitster.siamese.dyndns.org>
	<20080117091558.GA8341@hashpling.org> <478F3367.8050307@viscovery.net>
	<20080117110132.GB12285@hashpling.org>
	<478F4CDC.2090703@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <charles@hashpling.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 02:44:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFgHE-0005ZQ-Qt
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 02:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760941AbYARBng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 20:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbYARBng
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 20:43:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760887AbYARBne (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 20:43:34 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C487A6E97;
	Thu, 17 Jan 2008 20:43:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 01F746E93;
	Thu, 17 Jan 2008 20:43:23 -0500 (EST)
In-Reply-To: <478F4CDC.2090703@viscovery.net> (Johannes Sixt's message of
	"Thu, 17 Jan 2008 13:41:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70947>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Charles Bailey schrieb:
>> On Thu, Jan 17, 2008 at 11:52:23AM +0100, Johannes Sixt wrote:
>>> I observed the same (on Windows). The reason is that above-mentioned
>>> commit introduces a call to parse_objects(). But by the time that
>>> fast-import calls write_ref_sha1() (and, hence, this new parse_objects())
>>> it has not yet written a pack file, and parse_objects() fails. I don't
>>> have a clue how to fix this short of reverting the commit.
>>>
>> 
>> OK, so it's not just Mac OS X, then.  From your description and my
>> initial poke at the code,  I can't immediately see a good reason why
>> the test should succeed on Linux, though.
>
> My analysis is not correct. The pack file is present, but it seems to be
> incomplete.
>
> The reason is the NO_MMAP build flag. If you compile with
> NO_MMAP=YesPlease on Linux, t9301 fails as well. Does this ring a bell?

I ran strace and found that fast-import retains three windows to
the same data that was opened while the pack was still being
built (i.e. the filename is still tmp_pack_XXXXXX) when it dies:

    {next = 0x6f6d20, base = 0x6f77a0 "PACK", offset = 0, len = 907,
     last_used = 9, inuse_cnt = 0}
    {next = 0x728630, base = 0x6f7160 "PACK", offset = 0, len = 500, 
      last_used = 5, inuse_cnt = 0}
    {next = 0x0, base = 0x6f6d50 "PACK", offset = 0, len = 261, 
      last_used = 1, inuse_cnt = 0}

When it hits end_packfile() to install the built-pack to its
final destination and makes it available to the rest of git,
however, it has this clever code to reuse the still open window.

The object offset asked when it dies is at offset 887.  However,
tmp_pack was written after that last window with length 907 has
been (re)opened, and reusing the window results in reading a
stale data.

The following patch seems to fix the issue for me, but this is
primarily meant for discussion, as I do not quite understand why
the same issue does not manifest itself when NO_MMAP is not
used.

diff --git a/fast-import.c b/fast-import.c
index 3609c24..bd0ddb1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -926,7 +926,13 @@ static void end_packfile(void)
 		new_p = add_packed_git(idx_name, strlen(idx_name), 1);
 		if (!new_p)
 			die("core git rejected index %s", idx_name);
-		new_p->windows = old_p->windows;
+		while (old_p->windows) {
+			struct pack_window *w = old_p->windows;
+			munmap(w->base, w->len);
+			old_p->windows = w->next;
+			free(w);
+		}
+		new_p->windows = NULL;
 		all_packs[pack_id] = new_p;
 		install_packed_git(new_p);
 
