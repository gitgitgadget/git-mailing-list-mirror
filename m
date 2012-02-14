From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 2/5] do not override receive-pack errors
Date: Tue, 14 Feb 2012 09:33:24 +0100
Message-ID: <20120214083324.GA1762@ecki>
References: <7vhazobto3.fsf@alter.siamese.dyndns.org>
 <1329164235-29955-1-git-send-email-drizzd@aon.at>
 <1329164235-29955-3-git-send-email-drizzd@aon.at>
 <7v8vk6csx9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 09:41:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxDxQ-0005V2-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 09:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919Ab2BNIlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 03:41:47 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:40682 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751366Ab2BNIlq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 03:41:46 -0500
Received: from localhost (p5B22E1C5.dip.t-dialin.net [91.34.225.197])
	by bsmtp.bon.at (Postfix) with ESMTP id 1D9302C4002;
	Tue, 14 Feb 2012 09:43:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v8vk6csx9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190709>

On Mon, Feb 13, 2012 at 01:41:38PM -0800, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > Receive runs rev-list --verify-objects in order to detect missing
> > objects. However, such errors are ignored and overridden later.
> 
> This makes me worried (not about the patch, but about the current code).
> 
> Are there codepaths where an earlier pass of verify-objects mark a cmd as
> bad with a non-NULL error_string, and later code that checks other aspect
> of the push says the update does not violate its criteria, and flips the
> non-NULL error_string back to NULL?  Or is the only offence you found in
> such later code that it fills error_string with its own non-NULL string
> when it finds a violation (and otherwise does not touch error_string)?
> 
> In other words, is this really "ignored and overridden", not merely
> "overwritten"?

Yes, it really is. For example, in t5504 rev-list --verify-objects (it
was turned on for me if called from there) detects the corrupt object.
But the error string is later overwritten with the return value of
update, which is NULL in this case.

That is why I had to change the t5504 tests from a successful git push
to a test_must_fail git push with this fix. To keep the previous
behavior we would have to replace the corrupt blob with a more subtle
corruption that rev-list --verify-objects would not detect, but fsck
would (e.g., a malformed commit header).

> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index fa7448b..0afb8b2 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -642,8 +642,10 @@ static void check_aliased_updates(struct command *commands)
> >  	}
> >  	sort_string_list(&ref_list);
> >  
> > -	for (cmd = commands; cmd; cmd = cmd->next)
> > -		check_aliased_update(cmd, &ref_list);
> > +	for (cmd = commands; cmd; cmd = cmd->next) {
> > +		if (!cmd->error_string)
> > +			check_aliased_update(cmd, &ref_list);
> > +	}
> 
[...]
> If we have already decided the former cmd is deemed to fail and skip
> this check, we would not catch that the latter cmd is trying to make
> an inconsistent update request, and we would end up ignoring that
> case.

Actually, check_alias_update searches for aliases of cmd in ref_list,
which is a list of refs from all commands, irrespective of their error
status. So this change is correct.

However, after re-reading the code I now have the impression that the
alias detection is not entirely correct. It does find aliases between
symrefs and regular refs.  But it does not find aliases between two
symrefs, because ref_list will not contain the actual ref pointed to,
and therefore the code considers neither symref an alias.

But that is independent of the hunk above.
