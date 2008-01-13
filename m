From: Junio C Hamano <gitster@pobox.com>
Subject: Re: performance problem: "git commit filename"
Date: Sun, 13 Jan 2008 11:39:01 -0800
Message-ID: <7vsl11plbe.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
	<7vtzliqh3u.fsf@gitster.siamese.dyndns.org>
	<7vd4s6qal0.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801130922030.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 20:39:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE8gN-0000UA-L2
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 20:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbYAMTjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 14:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752667AbYAMTjO
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 14:39:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbYAMTjN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 14:39:13 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E73246FE;
	Sun, 13 Jan 2008 14:39:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A0FAB46F9;
	Sun, 13 Jan 2008 14:39:08 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801130922030.2806@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 13 Jan 2008 09:24:02 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70410>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 13 Jan 2008, Junio C Hamano wrote:
>> 
>> The attached is a quick and dirty hack which may or may not
>> help.  It all looks sane, this also is some core code, and meant
>> only for discussion and not application.
>
> I don't think this will help.
>
> You never set CE_UPTODATE, except in the "fill_stat_cache_info()" 
> function, but that one will never be called for an old file that already 
> matched the stat.
>
> So at a minimum, you should also make ie_match_stat() set CE_UPTODATE if 
> it matches. Or something.

Unfortunately ie_match_stat() is too late.  The caller is
supposed to have already called lstat(2) and give the result to
that function.

When refresh_cache_ent() finds the entry actually matched, we
could mark the path with CE_UPTODATE.  That would be a
relatively contained and safe optimization that might help
git-commit.

About the CE_NAMEMASK limitation (and currently we do not check
it, so I think we would be screwed when a pathname that is
longer than (CE_NAMEMASK+1) and still fits under PATH_MAX is
given), I think we do not have to limit the maximum pathname
length.  Instead we can teach create_ce_flags() and ce_namelen()
that a name longer than 2k (or 4k) has the NAMEMASK bits that
are all 1 and ce->name[] must be counted if so (with an obvious
optimization to start counting at byte position 2k or 4k in
ce_namelen()).
