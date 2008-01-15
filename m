From: Junio C Hamano <gitster@pobox.com>
Subject: Re: performance problem: "git commit filename"
Date: Mon, 14 Jan 2008 17:13:52 -0800
Message-ID: <7vd4s3j3fz.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
	<7vtzliqh3u.fsf@gitster.siamese.dyndns.org>
	<7vd4s6qal0.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801130922030.2806@woody.linux-foundation.org>
	<7vr6glnrvp.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801141611560.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 15 02:14:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEaNz-0004Dj-UN
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 02:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbYAOBOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 20:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753161AbYAOBOL
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 20:14:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbYAOBOK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 20:14:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A32D74184;
	Mon, 14 Jan 2008 20:14:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DF81F4182;
	Mon, 14 Jan 2008 20:13:59 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801141611560.2806@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 14 Jan 2008 16:18:06 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70496>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 13 Jan 2008, Junio C Hamano wrote:
>> 
>> I've reworked the patch, and in the kernel repository, a
>> single-path commit after touching that path now calls 23k
>> lstat(2).  It used to call 46k lstat(2) after your fix.
>
> Hmm. This part of it looks incorrect:
>
>> diff --git a/diff.c b/diff.c
>> index b18c140..62d0c06 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -1510,6 +1510,10 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
>>  	if (pos < 0)
>>  		return 0;
>>  	ce = active_cache[pos];
>> +
>> +	if (ce_uptodate(ce))
>> +		return 1;
>> +
>>  	if ((lstat(name, &st) < 0) ||
>>  	    !S_ISREG(st.st_mode) || /* careful! */
>>  	    ce_match_stat(ce, &st, 0) ||
>
> Isn't this wrong?

You are right.  We call this with sha1 that may not necessarily
be the same as ce->sha1.

The code should probably be something like:

	ce = active_cache[pos];

	/*
         * Even if ce matches the work tree, it is not what we can
	 * reuse for sha1, if the hash is different or not a
         * regular blob.
         */
	if (hashcmp(sha1, ce->sha1) || !S_ISREG(ntohl(ce->st_mode))
		return 0;
	/*
         * Does ce actually match the work tree?  If so we can reuse.
         */
	if (ce_uptodate(ce) ||
	    (!lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
		return 1;
	return 0;

The expression inside the latter if () condition should probably
be the new abstraction at the level of ce_modified().

Currently ce_modified() assumes that lstat(2) is cheap and the
callers have called it on paths they are interested in already.
