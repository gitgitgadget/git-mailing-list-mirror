From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Small rerere in rebase regression
Date: Mon, 23 May 2016 23:30:59 +0200
Message-ID: <57437693.3030106@kdbg.org>
References: <57434572.6030306@kdbg.org>
 <xmqqy4708ss0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 23:31:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4xRN-0005Ua-T0
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 23:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbcEWVbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 17:31:03 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:44083 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbcEWVbC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 17:31:02 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3rDBYH5Ll2z5tlL;
	Mon, 23 May 2016 23:30:59 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 418BC5291;
	Mon, 23 May 2016 23:30:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <xmqqy4708ss0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295397>

Am 23.05.2016 um 21:43 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> I'm not sure whether the new behavior is a defect in rerere.c or a
>> consequence of the extra rerere call in interactive rebase...
>
> Interesting.  When running an unnecessary "git rerere" (because it
> already was run and recorded the preimage), we used to be silent.
> With the updated code, we say something.
>
> At least it seems that we do not record the same preimage as a
> different variant, so the regression is hopefully merely cosmetic.
>
> I do not think it is a crime to say "git rerere" repeatedly without
> changing anything, so I do not think "rebase -i"'s call to rerere
> in die_with_patch is wrong, even though some calls to it seem to be
> made after seeing a "git merge" fail (which means we know 'rerere'
> has been run already).
>
> I think all plumbing that can turn an index into unmerged state has
> a call to git_rerere() at the end (the only obvious exception being
> "update-index" that lets you stuff higher stage entries to the
> index), so as long as "rebase -i" uses them correctly, I suspect
> that die_with_patch shouldn't have to have a call to "git rerere".

I also come to the conclusion that die_with_patch shouldn't have to have 
a call to "git rerere". die_with_patch can be called after "git 
cherry-pick", "git merge", "git commit", all of which have their own 
rerere() invocation.

However, calling "git rerere" after a failed "git commit" may be 
destructive: it would record a resolution even though the commit has not 
be completed. Think of an squash commit being aborted because the user 
notices an error in the last minute. If that error is in a conflict 
resolution, that wrong resolution would be recorded.

-- Hannes
