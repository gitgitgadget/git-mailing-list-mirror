From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] create_ref_entry(): move check_refname_format() call
 to callers
Date: Mon, 30 Apr 2012 18:18:53 +0200
Message-ID: <4F9EBB6D.3090900@alum.mit.edu>
References: <1335680288-5128-1-git-send-email-mhagger@alum.mit.edu> <20120429115831.GC24254@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 18:19:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOtJt-00006x-Ub
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 18:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248Ab2D3QTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 12:19:19 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:38201 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115Ab2D3QTP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 12:19:15 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.140] (p4FC0A468.dip.t-dialin.net [79.192.164.104])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3UGIrEq002259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Apr 2012 18:18:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <20120429115831.GC24254@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196574>

On 04/29/2012 01:58 PM, Jeff King wrote:
> On Sun, Apr 29, 2012 at 08:18:08AM +0200, mhagger@alum.mit.edu wrote:
>
>> I will work on providing more infrastructure for checking refnames at
>> varying levels of strictness, but I don't know enough about the code
>> paths to be able to find the places where the strictness levels need
>> tweaking.
>>
>> For this to work, the various callers of check_refname_format() will
>> have to be able to influence the level of strictness that they want to
>> enforce.  This patch is one trivial step in that direction.
>
> It seems like the create_ref_entry code paths should _always_ just be
> issuing warnings, as they are about reading existing refs, no? The die()
> side should only come when we are writing refs.

There are not two but three classes of refnames:

1. Fully legal refnames (according to the rules of check-ref-format).

2. Refnames that might cause parsing trouble in some circumstances but 
could otherwise be tolerated (with a warning) in the hope that the user 
can delete them before they cause further confusion.  These include all 
illegal refnames that aren't covered by (3).

3. Refnames that are so pathological that we don't want to let them into 
our code at all, under any circumstances.  This category, I think, 
includes refnames that include "/../" (because they could cause our code 
to walk up the filesystem) or LF (because if written to a packed-refs 
file they would make it unreadable) and perhaps "//" (because they would 
confuse the loose reference code and the hierarchical reference cache 
code).  And depending on how much you trust shell scripts to do quoting 
correctly, other patterns might also be risky.

I would like to be able to distinguish between (2) and (3) before 
deciding what to do in any specific cases.  References in category (2) 
can probably be accepted (with a warning) in old data but we should not 
allow the user to create new ones.  References in category (3) are more 
critical; I see three options for dealing with them: die(), emit a 
warning then drop them on the floor, or emit a warning but handle them 
somehow (for example, by URL-encoding them).

Treating category (3) the same as category (2) was more or less the 
status quo before the changes, but I think it is dangerous, especially 
when dealing with references that might come from remote sources (do you 
disagree?).


Regarding create_ref_entry(), there are three callers:

* read_packed_refs(): Only used to read references from local
   packed-refs files.  Seems uncritical in terms of security, so for now
   I suppose we could change this caller to emit a warning but use the
   reference anyway.  (It would not be a good idea to emit a warning but
   *not* use the reference, because the next time the packed-refs file
   is rewritten the reference would be lost.)

* get_ref_dir(): Only used to read loose references from the local
   filesystem.  Seems uncritical in terms of security, so for now
   I suppose we could change this caller to emit a warning but use the
   reference anyway.  Alternately, we could emit a warning but not use
   the reference; this would not result in any data loss because nobody
   would have a reason to remove the loose reference file.

* add_packed_ref(): Used by write_remote_refs() to insert references
   from a cloned repository into the local packed-refs file.  Here I
   think we have to be paranoid about accepting refnames in category
   (3).  For example, it might be reasonable to emit a warning
   mentioning the illegal reference name *and the SHA1 that it referred
   to* then to drop it on the floor.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
