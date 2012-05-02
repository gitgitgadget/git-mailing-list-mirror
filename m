From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [BUG] "fetch $there +refs/*:refs/*" fails if there is a stash
Date: Wed, 02 May 2012 11:15:55 +0200
Message-ID: <4FA0FB4B.8080503@alum.mit.edu>
References: <7vsjfj7des.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 02 11:16:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPVfJ-00027l-00
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 11:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138Ab2EBJQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 05:16:00 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35620 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab2EBJP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 05:15:59 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q429FtIP002232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 2 May 2012 11:15:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <7vsjfj7des.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196796>

On 05/02/2012 12:19 AM, Junio C Hamano wrote:
> This ought to work:
>
>      $ git checkout HEAD^0 ;# make sure we are on detached HEAD
>      $ git fetch $somewhere +refs/*:refs/*
>
> if you want to pull down all the branches from somewhere, potentially
> nuking the refs we currently have.
>
> However, if $somewhere has a stash, i.e. refs/stash, even though our
> "fetch" sees it in the "ls-remote $somewhere" output and tries to make
> sure that the object comes over the wire, we never show "want" line for
> refs/stash, because we silently drop it with check_ref_format().

As you obviously know (but for the information of other readers), the 
reason for the failure is that "stash" (not "refs/stash") is passed to 
check_ref_format().  "stash" is not a valid refname because it has only 
a single level (i.e., does not contain a '/').  check_ref_format() would 
accept the refname if it were passed the REFNAME_ALLOW_ONELEVEL option, 
but passing it the full refname (as your patch does) is better.

> I have run out concentration before digging this through, but the attached
> single liner patch fixes it.  The thing is, this function is given a list
> of refs and drops refs/stash (which is not what I want in the context of
> the above +refs/*:refs/*), and modifies the caller's list of refs, and
> then the caller (i.e. do_fetch_pack() that called everything_local()) then
> uses updated list (i.e. without refs/stash) to run find_common() and
> get_pack(), but the layer higher above (namely, do_fetch() that calls
> fetch_refs() that in turn calls store_updated_refs(), all in
> builtin/fetch.c) is _not_ aware of this filtering and expects that the
> code at this layer *must* have asked for and obtained all the objects
> reachable from what was listed in ls-remote output, leading to an
> inconsistent state.
>
> [Michael CC'ed as he seems to be dead set tightening check_ref_format()]
>
> The specific failure of "refs/stash" is fixed with this patch, but I think
> this call to check_ref_format() in the filter_refs() should be removed.
> The function is trying to see what we _asked_ against what the remote side
> said they have, and if we tried to recover objects from a broken remote by
> doing:
>
> 	git fetch $somewhere refs/heads/a..b:refs/heads/a_dot_dot_b
 >
> and the remote side advertised that it has such a ref (note that a..b is
> an illegal path component), we should be able to do so without a misguided
> call to check_refname_format() getting in the way.

I agree; if the remote reference name never gets used as a local 
reference name, there is no reason to call check_ref_format() on it at 
all.  The local reference name that is derived from the remote reference 
name (even if it is derived via an identity operation) *should* be 
checked using check_ref_format(); presumably that is already the case? 
Optimally the local refnames should be checked *before* the transfer to 
avoid wasting the user's time.

> It is the same story if the name advertised by a broken remote were
> "refs/head/../heads/master".  As long as the RHS of the refspec
> (i.e. refs/heads/a_dot_dot_b) is kosher, we must allow such a request to
> succeed, so that people can interoperate in less than perfect world.

A slightly more awkward question is if the broken remote advertises many 
references including "refs/head/../heads/master" and we fetch refspec 
"+refs/*:refs/*".  In this case it is pretty clear that we should fetch 
all of the valid references; otherwise, working around the problem would 
be quite awkward.  But what to do about "refs/head/../heads/master"?  I 
think we should emit a warning naming the reference that will not be 
fetched "because it is formatted incorrectly", and not include it in the 
"want" lines.  If the user really wants the reference, he can fetch it 
to another name using an explicit "from:to" refspec.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
