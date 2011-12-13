From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 28/51] refs.c: rename ref_array -> ref_dir
Date: Tue, 13 Dec 2011 20:12:07 +0100
Message-ID: <4EE7A387.3070400@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu> <1323668338-1764-29-git-send-email-mhagger@alum.mit.edu> <7v7h21xps9.fsf@alter.siamese.dyndns.org> <4EE6E61F.8080405@alum.mit.edu> <7vk461vuy9.fsf@alter.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Tue Dec 13 20:12:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaXmB-00077f-3t
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 20:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755556Ab1LMTM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 14:12:26 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:54346 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104Ab1LMTM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 14:12:26 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBDJC7KQ003014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 13 Dec 2011 20:12:07 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vk461vuy9.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187047>

On 12/13/2011 07:37 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Apropos testing, it is unsettling that our test suite doesn't show any
>> failures after my changes.  The dir entries in extra_refs are now always
>> sorted and de-duped when do_for_each_ref() is called.  Could it be that
>> duplicate ".have" references never come up in the test suite?  It sounds
>> like an important code path is not being tested.  In particular, I won't
>> be able to test whether my fix works :-/
> 
> I doubt anybody thought of using more than one --reference while cloning
> or having more than one entry in $GIT_DIR/objects/info/alternates in a
> repository that is being pushed into, even though we might have tests for
> simpler single --reference and single alternate cases.

Even with a single alternate database, multiple references are
advertised with the same name ".have".  But the tests never push from a
repository with more than one reference in its alternates (verified by
instrumenting code).  That is why my changes didn't cause test failures.
 When I, for example, change the setup function in t5519 to push *two*
references to alice-pub, then master works fine, my ref-api branch
fails, and my fixup patch fixes the failure.

> As to the order of the changes, my gut feeling is that it would make it
> harder to debug your series to delay the removal of "extra_ref" hackery,
> as it would be a corner case that your "hierarchical" structure never has
> to worry about in the end result.
> 
> Another possibility is to keep the extra_ref interface in refs.c, without
> any of your changes (i.e. keep it just as a flat list, with the original
> interface to append to it without any dedup and other fancy features) and
> also keep the special casing of it in for_each_ref(). AFAIK, that is the
> only iterator that should care about the extra refs. Thinking about it a
> bit more, removal of add_extra_ref() API may be unnecessarily complex with
> no real gain. For example, extra refs added in builtin/clone.c is used by
> builtin/fetch-pack.c, meaning that the codepath that discovers and
> remembers these extra history anchor points and the codepath that uses
> them while walking the history are not localized and we would need some
> sort of "extra ref API" anyway. I am leaning towards this option.

In a few minutes I will post a series of patches that store extra_refs
in a linked list separate from the reference caches, and iterates over
them only from for_each_ref().  I could rebase my ref-api-D changes on
top of this patch series in such a way that the extra refs are kept in
non-hierarchical storage.  But I leave for vacation on Thursday so it is
quite likely that I won't be able to get it finished before I return in
the new year.

An alternative is to use my one-patch fix on top of the ref-api-D
changes (plus another patch to beef up t5519).  The fix is isolated and
I'm confident that it is safe (though I would inspect and test it better
before formally submitting it).  The advantage is that is less work, so
it can be ready tomorrow instead of in two weeks.  The disadvantage is
that there would be an interval of commits on the feature branch (from
the middle of the ref-api-D patch series until the fix) that are
non-functional, albeit in a way that the test suite doesn't detect.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
