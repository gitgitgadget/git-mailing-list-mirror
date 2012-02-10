From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 28/51] refs.c: rename ref_array -> ref_dir
Date: Fri, 10 Feb 2012 15:51:47 +0100
Message-ID: <4F352F03.2030104@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu> <1323668338-1764-29-git-send-email-mhagger@alum.mit.edu> <7v7h21xps9.fsf@alter.siamese.dyndns.org> <4EE6E61F.8080405@alum.mit.edu> <7vk461vuy9.fsf@alter.siamese.dyndns.org> <4EE7A387.3070400@alum.mit.edu> <4EE7CDF2.3040408@alum.mit.edu> <7vzkewt5qu.fsf@alter.siamese.dyndns.org> <4F158E99.2020906@alum.mit.edu>
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
X-From: git-owner@vger.kernel.org Fri Feb 10 15:52:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvrqE-0007M1-SI
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 15:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759428Ab2BJOwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 09:52:38 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:44039 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014Ab2BJOwh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 09:52:37 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1AEplg9024763
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 10 Feb 2012 15:51:48 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.26) Gecko/20120131 Lightning/1.0b2 Thunderbird/3.1.18
In-Reply-To: <4F158E99.2020906@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190412>

On 01/17/2012 04:07 PM, Michael Haggerty wrote:
> On 12/14/2011 12:24 AM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>> ...  But there are so many calls to the
>>> for_each_ref*() family of functions that I wasn't able to determine
>>> exactly which should allow for extra refs and which shouldn't.
>>
>> Only the ones that follow add_extra_ref() in the control flow.
>>
>> builtin/clone.c adds them in setup_reference() to deal with --reference.
>> The objects known to be complete in these repositories we borrow from
>> need to be marked complete on our end (i.e. clone does not have to fetch)
>> and transport_fetch_refs() that eventually goes to fetch_refs_via_pack()
>> that calls fetch_pack() uses this information. All three for_each_ref()
>> calls in builtin/fetch-pack.c are about "what are the objects that we know
>> are complete?" and needs to pay attention to extra refs.
>>
>> Having said that, I have a slight suspicion that you might be able to
>> eliminate this one in clone.  setup_reference() adds the reference
>> repository to the $GIT_DIR/objects/info/alternates, and the fetch logic
>> already knows to account for the refs in alternate repositories via
>> insert_alternate_refs() callchain.
> 
> If I comment out the call from add_one_reference() to add_extra_ref()
> then I get a single failure, in t5700:
> 
> not ok - 8 fetched no objects
> #	! grep "^want" "$U"
> 
> So your suspicion does not seem to be borne out (at least not in the
> naivest form).
> 
> Still studying...

I finally had some time to get back to this puzzle.  It took me a while
to narrow down the problem, and I still don't understand it entirely.

It seems like Junio should be right that setup_reference() doesn't need
to add the alternate references to extra_refs.  Indeed, if I remove the
call to add_extra_ref(), I see the alternate references being added to
ref_list via insert_one_alternate_ref().  However, in the context of
t5700, clone nevertheless sends "want" lines for one of those references
and test 8 fails.  Something is screwy.

So how do the extra_refs prevent the "want" lines from being emitted?
It turns out that when the alternate refs *are* added as extra_refs,
then find_common() is not called at all.  do_fetch_pack() calls
everything_local(), which returns true, and do_fetch_pack() skips over
the call to find_common().

So ISTM that there are two problems:

First problem: everything_local() seems to be either broken or used
incorrectly.  I can't decide which because I don't know what its
semantics are *supposed* to be.

If everything_local() is trying to check that the references are all in
the local repository itself, then it is incorrect for clone to enter
alternates into extra_refs because everything_local() then mistakes them
for local.

If everything_local() is trying to check that the references are in the
local repository plus alternates, then it is incorrect that
everything_local() doesn't consider alternate references in its
determination.  My guess is that this is the case, and that something
like the following might be the fix:

> ----------------------------- builtin/fetch-pack.c -----------------------------
> index 9500f35..4257a8d 100644
> @@ -581,6 +581,11 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
>  	*refs = newlist;
>  }
>  
> +static void mark_alternate_complete(const struct ref *ref, void *unused)
> +{
> +	mark_complete(NULL, ref->old_sha1, 0, NULL);
> +}
> +
>  static int everything_local(struct ref **refs, int nr_match, char **match)
>  {
>  	struct ref *ref;
> @@ -609,6 +614,7 @@ static int everything_local(struct ref **refs, int nr_match, char **match)
>  
>  	if (!args.depth) {
>  		for_each_ref(mark_complete, NULL);
> +		for_each_alternate_ref(mark_alternate_complete, NULL);
>  		if (cutoff)
>  			mark_recent_complete_commits(cutoff);
>  	}

With this patch, then the full test suite passes even if I take out the
code that adds the alternate refs to extra_refs.

Second problem: it seems like the presence of alternate refs is not
suppressing the "want" lines for those refs in all cases.  Strangely, in
the case of t5700, adding the two alternate refs to ref_list
insert_one_alternate_ref() causes the "want" line for one of them to be
suppressed, but not for the other.

Specifically: (without the above patch) I commented out the call to
add_extra_ref() in clone.c:add_one_reference(), then ran t5700 through
step 8 then aborted.  insert_one_alternate_ref() was called four times:

insert_one_alternate_ref(ccc25a1f9655742174c93f48f616bea8ad0bc6ff)
insert_one_alternate_ref(ccc25a1f9655742174c93f48f616bea8ad0bc6ff)
insert_one_alternate_ref(5355551c5a927a2b6349505ada2da4bb702c0a49)
insert_one_alternate_ref(5355551c5a927a2b6349505ada2da4bb702c0a49)

(The duplication here seems strange.)  However, UPLOAD_LOG still
contains "want" lines (2 of them!) for one of the commits:

#S
#E
#S
#S
#E
want 5355551c5a927a2b6349505ada2da4bb702c0a49 multi_ack_detailed
side-band-64k thin-pack ofs-delta
want 5355551c5a927a2b6349505ada2da4bb702c0a49
#E

The "5355551c" object corresponds to refs/remotes/origin/master in the
alternate object store:

$ (cd B; git for-each-ref)
ccc25a1f9655742174c93f48f616bea8ad0bc6ff commit	refs/heads/master
5355551c5a927a2b6349505ada2da4bb702c0a49 commit	refs/remotes/origin/HEAD
5355551c5a927a2b6349505ada2da4bb702c0a49 commit	refs/remotes/origin/master

It seems to me that even in the absence of short-circuiting due to
everything_local() returning true, the presence of the alternate refs
should be suppressing the "want" lines for those references.

I have some patches that seem to work (and get rid of extra_refs
entirely, hurrah!), but I don't want to submit them until I understand
what the correct behavior is *supposed* to be.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
