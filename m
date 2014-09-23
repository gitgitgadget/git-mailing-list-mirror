From: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH for-maint] apply: gitdiff_verify_name(): accept "/dev/null\r"
Date: Tue, 23 Sep 2014 21:31:50 +0200
Message-ID: <5421CAA6.3040107@redhat.com>
References: <1411434583-27692-1-git-send-email-lersek@redhat.com> <xmqq1tr2jhg2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jordan.l.justen@intel.com,
	matt.fleming@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 21:32:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWVog-0006Gk-18
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 21:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbaIWTb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 15:31:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10264 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753291AbaIWTb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 15:31:57 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8NJVslY002243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Sep 2014 15:31:54 -0400
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-33.ams2.redhat.com [10.36.116.33])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s8NJVplE030960;
	Tue, 23 Sep 2014 15:31:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <xmqq1tr2jhg2.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257434>

On 09/23/14 20:54, Junio C Hamano wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
> 
>>   git format-patch master..branch1
> 
> The output from this has these (excerpt from "od -xc" output):
> 
> 0000360       f   2  \n  \n   d   i   f   f       -   -   g   i   t
>            6620    0a32    640a    6669    2066    2d2d    6967    2074
> 0000400   a   /   f   2       b   /   f   2  \n   n   e   w       f   i
>            2f61    3266    6220    662f    0a32    656e    2077    6966
> 0000420   l   e       m   o   d   e       1   0   0   6   4   4  \n   i
>            656c    6d20    646f    2065    3031    3630    3434    690a
> 0000440   n   d   e   x       0   0   0   0   0   0   0   .   .   f   3
>            646e    7865    3020    3030    3030    3030    2e2e    3366
> 0000460   5   d   3   e   6  \n   -   -   -       /   d   e   v   /   n
>            6435    6533    0a36    2d2d    202d    642f    7665    6e2f
> 0000500   u   l   l  \n   +   +   +       b   /   f   2  \n   @   @
>            6c75    0a6c    2b2b    202b    2f62    3266    400a    2040
> 0000520   -   0   ,   0       +   1       @   @  \n   +   h   e   l   l
>            302d    302c    2b20    2031    4040    2b0a    6568    6c6c
> 0000540   o       w   o   r   l   d  \r  \n   -   -      \n   2   .   1
>            206f    6f77    6c72    0d64    2d0a    202d    320a    312e
> 
> The structural parts of the diff, including "--- /dev/null" line,
> are all terminated by "\n" (as they should be), and the only CR
> appears in the message is at the end of "+hello world" line.

That's right -- until the patch email goes through an MTA that turns all
line endings into CRLF. (Did you email the patch to yourself as
requested in the reproducer?)

Such CRLFs are normally transparent because git-am strips them. The
keepcr=true setting preserves them, but not only for the source code
lines (where it's the right thing to do): it also preserves them in the
git diff header lines. Which is not a problem in general, *except* when
said header line includes /dev/null.

> So I do not think apply should need to loosen its sanity check and
> take a random whitespace after the "/dev/null" as a valid "this is a
> creation event for the path" marker (e.g. "--- /dev/null whoa"?).
> 
> is_dev_null() is used to in the fallback code path that parses
> traditional patch output (e.g. GNU diff) which throws random cruft
> (e.g. timestamp) after the /dev/null marker, e.g.
> 
>     $ diff -u /dev/null f2
>     --- /dev/null   2014-09-17 18:22:57.995111003 -0700
>     +++ f2  2014-09-23 11:37:09.000000000 -0700
>     @@ -0,0 +1 @@
>     +hello world
> 
> and we'd be hesitant to allow that kind of looseness for Git patches
> where we know we end the line after the "/dev/null" marker.

Okay, let's say I only relax the check in question to accept "\r\n" in
addition to the current "\n". Will you take that?

>> 3. In the reviewer / tester / maintainer role, save the patch from your
>> email client to a local file. Assume that your email client does not
>> corrupt the patch when saving it.
> 
> Perhaps compare this saved file with the output from the above
> format-patch to see where things got broken?
> 
> SMTP transport may be CRLF-unsafe, so I have a suspicion that it may
> turn out that what you are trying to do might be an equilvalent of
> 
> 	git format-patch ... |
>         # first lose all \r\n
>         dos2unix | 
> 	# then make everything \r\n
>         unix2dos |
>         # and apply
>         git am
> 
> which is not workable in the first place.  I dunno.

I agree with your analysis. It is indeed the MTA (or the MUA, not sure)
that turns all line endings into uniform CRLFs -- it is a requirement in
RFC 2822 / 822bis.

http://cr.yp.to/docs/smtplf.html
http://www.rfc-editor.org/rfc/rfc2822.txt

> 2.3. Body
>
>    The body of a message is simply lines of US-ASCII characters.  The
>    only two limitations on the body are as follows:
>
>    - CR and LF MUST only occur together as CRLF; they MUST NOT appear
>      independently in the body.

But why is this situation "not workable"? The same happens with *all*
patches that people mail around, it's just not visible to them, because
git-am strips all CRs indiscriminately.

People who are forced to work with CRLF repositories don't have this
luxury with git-am, and bump into the /dev/null problem all the time.

What do you think about accepting only "/dev/null\n" and "/dev/null\r\n"?

Another question I had about gitdiff_verify_name() -- what ensures there
that the memcmp(), with the fixed size of 9 bytes, won't fall off the
end of the line? Some of the outer caller functions verify the line
length before their comparisons, but I don't see any length checks in
gitdiff_verify_name() for /dev/null specifically.

Thank you,
Laszlo
