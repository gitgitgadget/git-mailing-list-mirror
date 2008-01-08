From: Junio C Hamano <gitster@pobox.com>
Subject: Re: An interaction with ce_match_stat_basic() and autocrlf
Date: Tue, 08 Jan 2008 10:04:34 -0800
Message-ID: <7vr6gsry6l.fsf@gitster.siamese.dyndns.org>
References: <7vfxx8tt1z.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801080748080.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 19:06:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCIpB-0007vb-Q5
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 19:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbYAHSEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 13:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754108AbYAHSEu
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 13:04:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980AbYAHSEu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 13:04:50 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 49E39C56A;
	Tue,  8 Jan 2008 13:04:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A107AC567;
	Tue,  8 Jan 2008 13:04:41 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801080748080.3148@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 8 Jan 2008 08:10:11 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69900>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 8 Jan 2008, Junio C Hamano wrote:
>> 
>> This is caused partly by the breakage in size_only codepath of
>> diff.c::diff_populate_filespec().
>
> Only partially.

Agreed.  That's why it is "just a half of the story".

> The more fundamental behaviour (that of git update-index) is caused by 
> ie_modified() thinking that when DATA_CHANGED is true, it cannot possibly 
> need to call "ce_modified_check_fs()":
> ...
> Similarly, I think that the problem with "diff" not realizing they might 
> be the same comes from ie_match_stat(), which has a similar problem in not 
> realizing that DATA_CHANGED could possibly still mean that it's the same.

Yes, I think your patch to ie_modified() should take care of the
issue from the diff-files front-end side, which is the right
approach.  The optimization diffcore_populate_filespec() makes
when asked to do size_only, which predates the addition of
convert_to_git(), needs to be updated regardless, though.  The
size field in diffcore_filespec is never about on-filesystem
size.

> This patch should fix it, but I suspect we should think hard about that 
> change to ie_modified(), and see what the performance issues are (ie that 
> code has tried to avoid doing the more expensive ce_modified_check_fs() 
> for a reason).

I think the reason was I simply avoided doing any unnecessary
operation that goes to the filesystem.  We did not even have
that modified_check_fs() code before the racy-git safety, and
when I added it I do not think I benched it with a real-life
workload; the logic there was simply a valid optimization back
then.

It is not anymore.  Addition of convert_to_git() made cached
stat info essentially ineffective in the sense that:

 (1) if a user changes the work tree files in such a way that
     does not change convert_to_git() output, the index will say
     "file contents in external representation has definitely
     changed, the sizes no longer match".  We need to actually
     go to the data to find out that there is no change at the
     canonical level.

 (2) if a user changes the crlf setting (or .gitattributes)
     without touching the work tree files, the index will say
     "unchanged and do not have to compare".  We need to
     actually go to the data to find out that they do not match
     anymore.

The latter is an opposite issue of what I brought up in this
thread.  I personally do not want to "fix" it --- it means
destroying one of the most important optimizations.  The use
case is essentially a one-shot operation for a user to "fix" a
broken crlf setting, and having to re-checkout everything is a
small cost to pay to maintain it.

But the former is something we should be able to deal with
sanely.
