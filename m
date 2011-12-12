From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 08/51] is_dup_ref(): extract function from sort_ref_array()
Date: Mon, 12 Dec 2011 12:44:24 +0100
Message-ID: <4EE5E918.8090104@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu> <1323668338-1764-9-git-send-email-mhagger@alum.mit.edu> <20111212083345.GA16106@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 12:44:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra4JL-0001fh-53
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 12:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730Ab1LLLom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 06:44:42 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:38453 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab1LLLol (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 06:44:41 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBCBiOZo009281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 12 Dec 2011 12:44:25 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <20111212083345.GA16106@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186909>

On 12/12/2011 09:33 AM, Jeff King wrote:
> On Mon, Dec 12, 2011 at 06:38:15AM +0100, mhagger@alum.mit.edu wrote:
> 
>> +/*
>> + * Emit a warning and return true iff ref1 and ref2 have the same name
>> + * and the same sha1.  Die if they have the same name but different
>> + * sha1s.
>> + */
>> +static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2)
>> +{
>> +	if (!strcmp(ref1->name, ref2->name)) {
>> +		/* Duplicate name; make sure that the SHA1s match: */
>> +		if (hashcmp(ref1->sha1, ref2->sha1))
>> +			die("Duplicated ref, and SHA1s don't match: %s",
>> +			    ref1->name);
>> +		warning("Duplicated ref: %s", ref1->name);
>> +		return 1;
>> +	} else {
>> +		return 0;
>> +	}
>> +}
> 
> As a user, I'm not sure what this message means. If I understand the
> context right, this happens when you have duplicate entries in your
> packed-refs file?

It could be caused by dups in any of the three ref caches: packed refs,
loose refs, or extra refs.

Duplicates in the packed-refs file could be caused by any garden-variety
data corruption external to git.  Or they could be caused by a bug in
git that caused it to write duplicates.  But the code that writes packed
refs iterates over the refs right after they are sorted, and sorting
eliminates duplicates, so this would be an unlikely bug the way the code
is currently organized.  I suppose they could also be caused by the
simultaneous writing of the packed-refs file by another process that
doesn't respect git's lock file; perhaps an ill-timed rsync or something.

Normally there should be no duplicate loose refs, because their names
are taken directly from the filesystem and duplicate filenames are not
allowed.  (Though I don't know if readdir() guarantees an atomic
snapshot of a directory; if not, then a dup could perhaps be created by
having another process add and remove files while git is reading a loose
ref directory.)

Extra refs are created locally by other git code that I am not familiar
with, so duplicate extra refs could only be created by a bug in git.

So in summary, duplicates could be caused by a git bug, by a corrupt
packed-refs file, or conceivably by a race condition with another
process that is mutating the packed-refs file or the loose reference
directories.

> This would indicate a bug in git, so should this perhaps say "BUG:" in
> front, or maybe give some more context so that a user understands it is
> not their error, or even a random error on this run, but that git has
> accidentally corrupted the packed-refs file (and their best bet is
> probably to report the bug to us).
> 
> This is obviously not an issue introduced by your patch, as you are
> just moving these error messages around. But maybe while the topic is
> fresh in your mind it is a good time to improve it. I dunno. AFAICT
> nobody has ever actually hit this message, so maybe it doesn't matter.
> :)

The first of Google search results for the fatal error message only
shows one instance where the error was observed [1].  This was a case of
cloning using the rsync protocol, which I believe is now deprecated
(probably for exactly this reason).

I think that the gold-plated way to improve the error message would be
to pass the error back to the caller, who would have more context to
decide the most likely cause of the duplicate and give an appropriate
warning or error message.  But I think we can afford to wait until more
error reports appear before bothering with this.

Michael

[1] http://kerneltrap.org/mailarchive/git/2008/12/17/4438764

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
