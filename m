From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Reference has invalid format: check maybe a bit to harsh?
Date: Tue, 01 Nov 2011 10:59:59 +0100
Message-ID: <4EAFC31F.4090206@alum.mit.edu>
References: <60007404.ge1WXNp2Qn@soybean> <7vty6pos20.fsf@alter.siamese.dyndns.org> <7vpqhcq5h2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Peter Oberndorfer <kumbayo84@arcor.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 11:00:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLB8h-0007ZD-3w
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 11:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab1KAKAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 06:00:08 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:53560 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811Ab1KAKAH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 06:00:07 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pA1A00bq007230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 1 Nov 2011 11:00:00 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vpqhcq5h2.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184563>

On 10/31/2011 09:19 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> I agree that we would want to give users an escape hatch.  That is, if we
>> can make something like this to work:
>>
>>     c=$(git rev-parse --force refs/patches/obd_development/blah:_vari...)
>>     git update-ref refs/patches/obd_development/blah--various-improvements $c
> 
> Also we would need to be able to say
> 
>     git update-ref -d refs/patches/obd_development/blah:_vari...
> 
> to get rid of the offending one.
> 
>> I think we would be in a good shape.
> 
> Having said all that, I think we should in general loosen the checks done
> on the reading side a lot more. The "checks" themselves should stay, can
> give loud warnings, and even can error out when appropriate, but in an
> operation that is necessary to recover from _existing_ breakage (like the
> one in this thread, a file with a colon in its name in .git/refs/), the
> ability to read and to remove is essential for recovery.
> 
> I vaguely recall we had to apply a fix in the same spirit to loosen
> reading side after the offending topic was merged to 'master' during this
> cycle about $GIT_DIR/config not possibly being a ref getting warned, or
> something.
> 
> Michael, what do you think?

Supporting invalid reference names some places, but not others, and this
perhaps (as in the case of ":") platform-dependent would be a big can of
worms (as can be seen by my attempt to summarize the situation, a few
paragraphs below).

I see the situation as a conflict between security and reliability on
the one hand and backwards-compatibility and/or the ability to recover
from old mistakes on the other hand.  For example, reference names like
the following are problematic in earlier git releases:

* "refs/heads/foo/../../../../etc/passwd" -- here be dragons

* "refs/heads/foo.lock/bar" -- screws up the locking of a reference
called "refs/heads/foo"

* "refs/heads/prn:/waste/my/paper" -- is questionable on Windows, I believe

* "refs/heads//foo" -- would be normalized to "refs/heads/foo" in
certain circumstances but not others

Perhaps instead of arguing about exactly what command arguments are
treated strictly vs laxly and attempting to half-support invalid
reference names, we could solve 98% of the problem with a couple of
localized measures:

1. Something in the git_snpath() callchain could prevent paths referring
to files outside of $GIT_DIR from being generated (by normalizing the
paths, stripping out "." and "..", etc).  I suppose that this change
would remove a lot of potential security issues at a stroke, and make it
less important for refname handling to be paranoid.

2. Invalid references could be detected and fixed via some mode of "git
fsck".  This would then be the only codepath that has to handle invalid
reference names, and would take that burden off of the rest of the code.
 "git fsck" could sanitize the names of invalid references and move them
to some kind of "lost+found" namespace.  (Disadvantage: it could be
impractical to run "git fsck" on a remote repository to which one
doesn't have filesystem access.)


If one would want to plunge in with a complicated solution, things will
get messy.  Here is an attempt at an exhaustive summary of the changes
since v1.7.7 that affect how strictly refnames are checked for validity,
and ideas for how one could work around problems of backwards
compatibility in the particular cases.

1. read_packed_refs() -- the old behavior was to accept *anything* found
in the packed-refs file; however, invalid references could not be worked
with reliably.  Now checks that packed-refs refnames are valid and
die()s if not.

   a. The old behavior could be restored for now.
   a'. The old behavior could be restored, except that renames with
leading, trailing, or duplicate slashes could silently be normalized.
This could lead to collisions between unnormalized and normalized names
that were previously distinct.  Such a collision is harmless if the two
symbols have the same value, but currently causes a fatal error if they
have distinct values.
   b. Invalid references could be silently ignored (this would cause
them to be silently discarded at the next pack-refs).
   c. Invalid references could be ignored with a warning (the warning
could include the SHA1).  This would cause a lot of warnings to be
output until the next pack-refs or the repository is fixed some other way.

2. get_ref_dir() (reads loose refs) -- the old behavior was to accept
anything that was found as a filesystem path under "$GIT_DIR/refs"
except paths with components starting with "." or ending with ".lock".
Now checks that loose-ref refnames are valid and die()s if not.

   a. The old behavior could be restored for now.
   b. Invalid references could be silently ignored (this would cause
them to be carried around forever in the local repository, including
after a pack-refs, but omitted when the local repository is cloned).
   c. Invalid references could be ignored with a warning (the warning
could include the SHA1).  This would cause a lot of warnings to be
output until the repository is fixed somehow.

3. add_extra_ref() -- old behavior was to accept anything.  But since
extra refs are generated locally and the names are not used, this
behavior shouldn't be a problem and could be restored for now.

4. check_refname_format() -- now disallows any refname component than
ends with ".lock" (previously only the last component was checked).  Now
disallows DEL character in refnames, in agreement with the old
specification.

5. resolve_ref() -- previously passed its argument to git_snpath() and
tried to open the path without any verification whatsoever.  Treated the
contents of symbolic refs similarly.  Now checks the validity of
refnames at both steps.

   a. The old behavior could be restored, but this would be very
questionable given how refs like "foo/../../../etc/passed" might be handled.
   b. There could be some laxer level of checking of security-relevant
issues without enforcing all of the refname rules.

6. The infamous change that caused files that looked like loose
references but have invalid *contents* to cause a warning to be emitted
(strictly speaking, this doesn't affect refnames but reference contents).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
