From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] "fetch $there +refs/*:refs/*" fails if there is a stash
Date: Wed, 02 May 2012 09:26:56 -0700
Message-ID: <7vy5paim5r.fsf@alter.siamese.dyndns.org>
References: <7vsjfj7des.fsf@alter.siamese.dyndns.org>
 <4FA0FB4B.8080503@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 02 18:27:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPcOO-0001zP-Fh
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 18:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909Ab2EBQ07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 12:26:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42745 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088Ab2EBQ07 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 12:26:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1326A63E0;
	Wed,  2 May 2012 12:26:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3CDfPOLDeVJeOvNJNS3zCPbE6yQ=; b=Dl7s3C
	GxdxBHOiqS2tzvl4JShbaGuwdRWf7QjH8jyqGoc2jApIW1kbrHtsJzmuf4kHHCaq
	4EceN5Uy47iguba6LPLVbMMCA6ZEMRawiaETDjsm/KDAd3eXnoy140V22nSTObIl
	tjpOCLdVkgb3nmkUK6zwz1eKcm54dL0vuagSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m+Ies/StHjtt5D0PblE+V9LdkHU2fkT2
	ZJ3rQ71Dnblm1C/gSLEuuiavYGI1e8DAkopftrcX8Px+4aT9qMkCgiPZT0KKlwDE
	IYKMgWNemKrjPJMgQI2LsnK8WU6RATz7gIkS/g6ci0h/V/pBCb3reql5602F/ZWE
	WY/Pb6PDt/M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A27763DF;
	Wed,  2 May 2012 12:26:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6897A63DA; Wed,  2 May 2012
 12:26:57 -0400 (EDT)
In-Reply-To: <4FA0FB4B.8080503@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 02 May 2012 11:15:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2FBBB42-9473-11E1-961D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196838>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 05/02/2012 12:19 AM, Junio C Hamano wrote:
>
>> The specific failure of "refs/stash" is fixed with this patch, but I think
>> this call to check_ref_format() in the filter_refs() should be removed.
>> The function is trying to see what we _asked_ against what the remote side
>> said they have, and if we tried to recover objects from a broken remote by
>> doing:
>>
>> 	git fetch $somewhere refs/heads/a..b:refs/heads/a_dot_dot_b
>>
>> and the remote side advertised that it has such a ref (note that a..b is
>> an illegal path component), we should be able to do so without a misguided
>> call to check_refname_format() getting in the way.
>
> I agree; if the remote reference name never gets used as a local
> reference name, there is no reason to call check_ref_format() on it at
> all.  The local reference name that is derived from the remote
> reference name (even if it is derived via an identity operation)
> *should* be checked using check_ref_format(); presumably that is
> already the case?

We should make sure the ref the refspec mapping told us to update is a
valid ref locally (didn't I say that), but I do not know offhand if we do
so using check_ref_format() and/or if the check is not overly loose.

Honestly, I didn't expect _you_ to be _asking_ that question; as you are
the person who has been advocating tightening of the function, you would
know the callers of the function better than anybody, no?

>> It is the same story if the name advertised by a broken remote were
>> "refs/head/../heads/master".  As long as the RHS of the refspec
>> (i.e. refs/heads/a_dot_dot_b) is kosher, we must allow such a request to
>> succeed, so that people can interoperate in less than perfect world.
>
> A slightly more awkward question is if the broken remote advertises
> many references including "refs/head/../heads/master" and we fetch
> refspec "+refs/*:refs/*".  In this case it is pretty clear that we
> should fetch all of the valid references; otherwise, working around
> the problem would be quite awkward.

If we ignore what will be stored in FETCH_HEAD, we could either (1) fetch
histories leading to all the valid commits, but not store incorrectly
formatted refs, or (2) fetch histories leading to commits that will be
stored in only the valid _refs_.

But because we cannot ignore FETCH_HEAD, we have to do (1).  That is,
history leading to any ref the remote advertises that matches the LHS of
the refspec has to be fetched, and listed in the resulting FETCH_HEAD.
Some of them may map to invalid refs on the local side, and we do not
store it inside our refs/, so that they do not pollute our local ref
namespace.

> But what to do about
> "refs/head/../heads/master"?  I think we should emit a warning naming
> the reference that will not be fetched "because it is formatted
> incorrectly", and not include it in the "want" lines.  

We have to ask for it, so we include it "want".  Remember, $A without
colon is a short-hand for $A: (fetch but not store locally), and as long
as $A (the LHS of the refspec) matches the refs advertised by the remote
side, we fetch it and list it in FETCH_HEAD.

As the user is _not_ asking to store it locally in our refs/ namespace, we
won't store it.  But if the request were $A:$A for any invalid refname $A,
the story is the same.  We fetch it because LHS of refspec matches what
they advertise, and we list it in FETCH_HEAD.  We do _not_ store it in our
local refs/ space, because RHS of refspec is invalid.
