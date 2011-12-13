From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 08/51] is_dup_ref(): extract function from sort_ref_array()
Date: Tue, 13 Dec 2011 05:35:38 +0100
Message-ID: <4EE6D61A.2030300@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu> <1323668338-1764-9-git-send-email-mhagger@alum.mit.edu> <7vvcplxq4r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 05:36:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaK66-00024p-CK
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 05:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752Ab1LMEgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 23:36:06 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:46536 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab1LMEgD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 23:36:03 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEDFA7.dip.t-dialin.net [84.190.223.167])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBD4Zcre021391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 13 Dec 2011 05:35:39 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vvcplxq4r.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187000>

On 12/12/2011 11:33 PM, Junio C Hamano wrote:
> mhagger@alum.mit.edu writes:
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
> At this step, is_dup_ref() is only called from sort_ref_array() which in
> turn is only called on either a collection of loose or packed refs, so
> warning is warranted. IOW I do not see anything wrong with _this_ patch.

I agree.

> Later in the series, however, the collection of extra refs seems to be
> shoved into a phoney "direntry" and made to go through the same add_ref()
> machinery that uses find_containing_direntry() which in turn calls
> search_ref_dir() that smells like a definite no-no.

Correct.

I had remembered your explanation of the purpose of extra refs and also
that they have unusual names, but I hadn't allowed for the possibility
that multiple extra_refs can have the same name.  The old code never
sorted the extra refs and therefore never checked or eliminated
duplicates.  The new code does, as sorting is an intrinsic part of
looking up references and reference subdirectories in the hierarchical
cache.  It is introduced along with the meat of the change in

    [PATCH v2 29/51] refs: store references hierarchically

So...the new code would die if two extra refs have the same name but
different SHA1s, and emit a warning if they have the same name and the
same SHA1s.  (However, it is no problem for an extra ref to have the
same name as a packed or loose ref.)

Is it *really* possible to have multiple extra_refs with the same name,
or is this more of a hypothetical problem that requires more careful
analysis?

If the former, then I will have to do some work.  My approach would
probably be to allow sorting without de-duplication; that way extra_refs
can continue to share most of the code used for the other ref caches.
It would be relatively easy to add such a fix on top of the patch
series, where every ref_entry knows the ref_cache with which it is
associated.  It would be quite a bit more painful to massage such a fix
through the whole patch series.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
