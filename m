From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Buggy handling of non-canonical ref names
Date: Thu, 25 Aug 2011 09:54:18 +0200
Message-ID: <4E55FFAA.9030904@alum.mit.edu>
References: <4E551D70.9080509@alum.mit.edu> <7vaaayps9z.fsf@alter.siamese.dyndns.org> <7vaaayo369.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 09:54:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwUlg-0007xY-Fu
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 09:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875Ab1HYHyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 03:54:23 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:50814 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab1HYHyW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 03:54:22 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7P7sJVb023937
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 25 Aug 2011 09:54:19 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7vaaayo369.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180064>

On 08/25/2011 12:27 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>> What is the policy about reference names and their canonicalization?
>>
>> The overall policy has been that we care about well-formed input, and
>> everything else is "undefined", even though as you found out some of them
>> try to work sensibly.
>>
>>>     $ git check-ref-format /foo/bar ; echo $?
>>>     0
>>>
>>>     $ git check-ref-format --print /foo/bar
>>>     /foo/bar
>>
>> I think these are bogus. Patches welcome.
> 
> I actually think the former is correct and the latter should strip the
> leading slash. Essentially what "check-ref-format" (and the underlying
> check_ref_format() function) validates is if the given user string can be
> used under $GIT_DIR/refs/ to name a ref, and $GIT_DIR/refs//foo/bar is
> (because we "tolerate duplicated slashes" cf. comment in the function) the
> same as $GIT_DIR/refs/foo/bar and is allowed.

I can live with either way, but I should point out that such an extra
slash can be problematic when used naively in conjunction with Python's
standard glue-together-pathname function, os.path.join() [1]:

    $ python
    >>> import os
    >>> os.path.join('.git', '/foo/bar')
    '/foo/bar'
    >>>

Maybe there are other examples of libraries with these semantics.

> I think what is missing is a unified way to canonicalize the refnames
> (which led to the inconsistencies you observed), and I strongly suspect
> that check_ref_format() should learn to return the canonicalized format
> (if asked by the caller) and the caller should use the canonicalized
> version after feeding end-user input to it.
> 
> Then the plumbing "check-ref-format --print" can use it just like any
> other caller that should be (or already are) using check_ref_format()
> to validate the end-user input.

Indeed, regardless of the policy about leading slashes, this is a good
plan.  I will try to find time to work on it.

> Yes, such a change will update the overall policy I stated earlier and
> narrow the scope of "undefined" down a bit, by uniformly codifying that
> leading and duplicate slashes are removed to be nice to the user.

Michael

[1] http://docs.python.org/library/os.path.html#os.path.join

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
