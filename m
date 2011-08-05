From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC 4/6] git-check-attr: Normalize paths
Date: Fri, 05 Aug 2011 08:24:42 +0200
Message-ID: <4E3B8CAA.4030002@alum.mit.edu>
References: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu> <1311849425-9057-5-git-send-email-mhagger@alum.mit.edu> <7v4o1zg20r.fsf@alter.siamese.dyndns.org> <4E3A12B9.1010800@alum.mit.edu> <7vliv95cpb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 08:24:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpDq1-0003lG-Mz
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 08:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221Ab1HEGYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 02:24:48 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:44931 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141Ab1HEGYs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 02:24:48 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEC602.dip.t-dialin.net [84.190.198.2])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p756Ogkk022058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 5 Aug 2011 08:24:43 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7vliv95cpb.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178781>

On 08/04/2011 07:05 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>> I think passing down "prefix" (i.e. where your $(cwd) was relative to the
>>> root level of the working tree) and the user-supplied "pathspec" (which
>>> typically is relative to that original $(cwd)) is the canonical approach.
>>> The very original git worked only at the root level of the working tree,
>>> with paths specified relative to the root level of the tree, so many code
>>> do:
>>>
>>> 	- find out the root of the working tree;
>>>         - note where the $(cwd) was in "prefix";
>>>         - chdir to the root of the working tree;
>>> 	- prepend the "prefix" to user supplied pathspec;
>>>         - forget all the complexity and work on the whole tree.
>>>
>>> Then the "prefix" gets stripped away from the beginning of the paths when
>>> reporting.
>>>
>>> Your patch from a cursory look seems to follow that pattern, which is
>>> good.
>>
>> Thanks for the explanation.
>>
>> Yes, my code follows the pattern, except that in this case it is
>> unnecessary to chdir to the root of the working tree.
> 
> Just to make sure there is no misunderstanding. The chdir() should not be
> in the core part of the system that you may want to libify.
> 
> The above pattern was developed primarily so that older utility functions
> in the system that were written back when nobody ran git from anywhere
> other than the top level of the working tree can be easily adapted to main
> programs that can be launched from a subdirectory. The initial set-up part
> of the program is responsible for figuring out "prefix", turning relative
> paths given by the user into paths relative to the top of the working
> tree, and then chdir'ing to the top.
> 
> After all that happens, the library-ish parts of the system only have to
> deal with full paths relative to the root of the working tree. "prefix"
> comes into play when reporting the results (i.e. showing paths relative to
> user's $(cwd) in the output or in the error messages).

If I understand you correctly, the use of some API routines requires a
chdir by the caller (i.e., the surrounding application) *before* calling
into the routine.  This is certainly a bit cleaner than the library
chdiring itself, but it is still unusable in a multithreaded context.
Regardless of whether the library chdirs itself or whether it obligates
callers to chdir before calling into the library, the bottom line is
that it requires a change to global state to function correctly, and
that change can confuse other threads.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
