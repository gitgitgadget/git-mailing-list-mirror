From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/6] Improved infrastructure for refname normalization
Date: Fri, 09 Sep 2011 17:33:37 +0200
Message-ID: <4E6A31D1.5020404@alum.mit.edu>
References: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu> <4E6A1D7D.6050602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	cmn@elego.de
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Fri Sep 09 17:34:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R235h-0007W2-1k
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 17:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759265Ab1IIPd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 11:33:59 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58765 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226Ab1IIPd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 11:33:58 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p89FXcnd014000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 9 Sep 2011 17:33:38 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <4E6A1D7D.6050602@gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181078>

On 09/09/2011 04:06 PM, A Large Angry SCM wrote:
> On 09/09/2011 07:46 AM, Michael Haggerty wrote:
>> As a prerequisite to storing references caches hierarchically (itself
>> needed for performance reasons), here is a patch series to help us get
>> refname normalization under control.
>>
>> The problem is that some UI accepts unnormalized reference names (like
>> "/foo/bar" or "foo///bar" instead of "foo/bar") and passes them on to
>> library routines without normalizing them.  The library, on the other
>> hand, assumes that the refnames are normalized.  Sometimes (mostly in
>> the case of loose references) unnormalized refnames happen to work,
>> but in other cases (like packed references or when looking up refnames
>> in the cache) they silently fail.  Given that refnames are sometimes
>> treated as path names, there is a chance that some security-relevant
>> bugs are lurking in this area, if not in git proper then in scripts
>> that interact with git.
> 
> Why can't the library do the normalization instead of expecting every
> other component that deals with reference names having to do it for the
> library?

The library could do the normalization, but

1. It would probably cost a lot of redundant checks as reference names
pass in and out of the library and back in again

2. Normalization requires copying or overwriting the incoming string, so
each time a refname crosses the library perimeter there might have to be
an extra memory allocation with the associated headaches of dealing with
the ownership of the memory.

3. The library doesn't encapsulate all uses of reference names; for
example, for_each_ref() invokes a callback function with the refname as
an argument.  The callback function is free to do a strcmp() of the
refname (normalized by the library) with some arbitrary string that it
got from the command line.  Either the caller has to do the
normalization itself (i.e., outside of the library) or the library has
to learn how to do every possible filtering operation with refnames.

>> * Forbid ".lock" at the end of any refname component, as directories
>>    with such names can conflict with attempts to create lock files for
>>    other refnames.
> 
> I find this overly restrictive. If you need to create a lock based on a
> reference name or component, use a name for the lock object that starts
> with one of the characters that reference names or components are
> already forbidden from starting with.

I agree; this is unpleasantly restrictive.

But please remember that refnames already cannot end in ".lock"
("foo/bar.lock" is already forbidden; this change also prohibits
"foo.lock/bar").

However, your suggested solution would cause problems if two versions of
git are running on the same machine.  An old version of git would not
know to respect the new version's lock files.  ISTM that this would be
too dangerous.  Suggestions welcome.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
