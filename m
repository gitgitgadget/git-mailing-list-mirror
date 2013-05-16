From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/4] resolve_ref: close race condition for packed refs
Date: Thu, 16 May 2013 07:50:50 +0200
Message-ID: <519473BA.9030106@alum.mit.edu>
References: <20130507023610.GA22053@sigill.intra.peff.net> <20130507023802.GA22940@sigill.intra.peff.net> <51901E05.1080905@alum.mit.edu> <20130516034721.GD13296@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 16 07:51:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucr5i-000811-Lx
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 07:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724Ab3EPFu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 01:50:57 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:56524 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752104Ab3EPFu4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 May 2013 01:50:56 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-4e-519473c09e08
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 1D.69.02295.0C374915; Thu, 16 May 2013 01:50:56 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4G5oqDC014546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 16 May 2013 01:50:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130516034721.GD13296@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqHugeEqgwfVJ7BZdV7qZLBp6rzBb
	zLu7i8niR0sPswOLx6WX39k8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujN878wu2
	ilQ8+f2ZqYHxOX8XIyeHhICJxMc1h5ghbDGJC/fWs3UxcnEICVxmlJhz/DIrSEJI4DqTxMVF
	biA2r4C2xKO/s1i6GDk4WARUJU7vLAEJswnoSizqaWYCsUUFwiRWrV/GDFEuKHFy5hMWEFtE
	QFbi++GNjCA2s0C6xNu2d2BxYQEvif+/ZjFB7N3BKNF06y0bSIJTwFqi98haJpBdzALqEuvn
	CUH0yktsfzuHeQKjwCwkK2YhVM1CUrWAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6hXm5m
	iV5qSukmRkgg8+xg/LZO5hCjAAejEg+vxfTJgUKsiWXFlbmHGCU5mJREeS8VTQkU4kvKT6nM
	SCzOiC8qzUktPsQowcGsJMI7IxUox5uSWFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoE
	k5Xh4FCS4JUDRqyQYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChG44uBUQqS4gHa
	aw/SzltckJgLFIVoPcWoyzHjx+R3jEIsefl5qVLivMogRQIgRRmleXArYGnrFaM40MfCEKN4
	gCkPbtIroCVMQEs0SyaBLClJREhJNTBmsERN3rRjtqqc/23eb8wl87+6X7CuPivg8lLRg+nt
	9FUicxzNnx4XkH/JsjXxvJCioAhf7onqW6nZ7HO3RU+umpAXOEO0qfr8a9tvd/Jy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224480>

On 05/16/2013 05:47 AM, Jeff King wrote:
>> I probably would have separated the rest of the patch, which is a pure
>> refactoring, from this last chunk, which is a functional change.  But
>> that's just me.
> 
> Yeah, I go back and forth on whether it is better to have strict
> refactors followed by changes or not. Sometimes it is hard to understand
> the motivation for the refactor without seeing the change, and you end
> up explaining it twice.

A pure refactoring doesn't need much justification.  Something like
"extract function foo()" plus maybe "this function will soon have
multiple callers" is IMO usually adequate, especially if the function is
well-named and documented in the patch itself.

> My usual rule of thumb is:
> 
>   - If you are factoring out some code, and then are going to change
>     that code, make it two separate changes. That keeps the diffs
>     readable (the first one is pure movement and you do not need to look
>     closely, and the second shows a sane diff of the change).
> 
>   - If you are factoring out some code, and then adding more callers,
>     it's OK to do it together. The new caller provides the motivation
>     for the refactor.
> 
> This is the latter case. But I'm open to arguments that the rule is not
> a good one. :)

Yes, I see how keeping the changes together makes the justification of
the refactoring more obvious.  On the other hand, splitting has the
following benefits:

1. Reviewers have a single thing to check in each patch: "Did he
   transcribe the code correctly into a function and choose a good
   API?" vs. "Does it make sense to call the function from this new
   place?"  The threads of feedback emails about each patch are
   similarly separated.

   On the other hand, of course these two changes are not completely
   independent, because having an idea what new callers want to do
   with the function affects what its API should be.

2. If the patch series needs to be revised, it is quite possible that
   the revisions affect only one patch or the other.  Therefore, the
   unaffected patch can be carried along through interactive rebases
   etc. intact, or might serve as a building block for an alternative
   solution.

3. If there's a problem, bisect can figure out which half of the change
   was to blame.

That being said, this case is very much in the gray area where it is a
matter of personal preference and I don't mind at all if you leave it as
a single patch.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
