From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] create_ref_entry(): move check_refname_format() call
 to callers
Date: Mon, 30 Apr 2012 22:29:01 +0200
Message-ID: <4F9EF60D.8030301@alum.mit.edu>
References: <1335680288-5128-1-git-send-email-mhagger@alum.mit.edu> <20120429115831.GC24254@sigill.intra.peff.net> <4F9EBB6D.3090900@alum.mit.edu> <7vd36pgn0e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 22:29:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOxDg-00047k-Tr
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 22:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756727Ab2D3U3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 16:29:11 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40184 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947Ab2D3U3K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 16:29:10 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.140] (p4FC0A468.dip.t-dialin.net [79.192.164.104])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3UKT19G018300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Apr 2012 22:29:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <7vd36pgn0e.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196604>

On 04/30/2012 07:14 PM, Junio C Hamano wrote:
> Michael Haggerty<mhagger@alum.mit.edu>  writes:
>
>> There are not two but three classes of refnames:
>>
>> 1. Fully legal refnames (according to the rules of check-ref-format).
>>
>> 2. Refnames that might cause parsing trouble in some circumstances but
>> could otherwise be tolerated (with a warning) in the hope that the
>> user can delete them before they cause further confusion.  These
>> include all illegal refnames that aren't covered by (3).
>>
>> 3. Refnames that are so pathological that we don't want to let them
>> into our code at all, under any circumstances.  This category, I
>> think, includes refnames that include "/../" (because they could cause
>> our code to walk up the filesystem) or LF (because if written to a
>> packed-refs file they would make it unreadable) and perhaps "//"
>> (because they would confuse the loose reference code and the
>> hierarchical reference cache code).  And depending on how much you
>> trust shell scripts to do quoting correctly, other patterns might also
>> be risky.
>>[...]
>> Treating category (3) the same as category (2) was more or less the
>> status quo before the changes, but I think it is dangerous, especially
>> when dealing with references that might come from remote sources (do
>> you disagree?).
>
> I actually do. [...example involving class (2) refname omitted...]
>
> What kind of "danger" do you have in mind?

I agree with you about how class (2) refnames can be handled, namely on 
a best-effort basis, without paranoia.  The "danger" that I worry about 
is if we treat class (3) refnames the same non-paranoid way that we 
treat class (2) refnames.  To be sure, my worries are at the level of 
"it seems like a lot of data paths have to be trusted and I have not 
personally verified that there is no danger and I have a vivid 
imagination" rather than "I have figured out how to implement an exploit".

For example, have all of the following code paths been audited to make 
sure that they cannot introduce class (3) refnames into a repository 
(including via symbolic refs with class (3) targets) even in the face of 
a malicious remote?  Can we (and do we want to) rely on this level of 
vigilance being sustained in the future?

* git clone (for all transport types)?

* git push (for all transport types)?

* git fast-import?

* git am?

* All kinds of remote helpers (git svn, etc.) and import scripts (e.g., 
the malicious refs might come directly from a Subversion repository)?

...no doubt there are others.

What if a malicious repository is copied using rsync (i.e., not "git 
clone rsync:..." but straight rsync)?  Granted, the victim would have 
worse problems if he didn't delete any version of $GIT/config that was 
contained in the copy before using it.

Banning class (3) references at lib level would provide a second level 
of defense against errors in the outer level.  Allowing "class 3" 
references at the lib level, by comparison, means putting a lot of 
confidence in the auditing of all of the ref-creating code paths.

It's true that a loose reference cannot (by construction) contain 
constructs like "/../" or "//".  And packed refs are not stored via 
filesystem paths, so such constructs are not a direct hazard.  But there 
are lots of ways that a packed ref can be turned into a loose ref, and 
the process of creating a loose ref from a class (3) packed ref could 
cause trouble.

I propose that I implement a REFNAME_NONSTRICT flag which relaxes the 
normal rules as follows:

* ".." is only forbidden if it is a complete refname component

* All characters (including control characters, '?', '*', and '[') are 
allowed, except for NUL, SP, LF, ':', and '\'.

* The character sequence "@{" is *not* prohibited.

The reason I suggest excluding ':' and '\' is because of their 
significance in DOS pathnames; let me know if you think this is unnecessary.

Do you want these changes in master or in maint (or even older)?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
