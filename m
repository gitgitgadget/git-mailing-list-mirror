From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 0/8] Fix GIT_CEILING_DIRECTORIES that contain symlinks
Date: Tue, 13 Nov 2012 12:50:18 -0800
Message-ID: <CAJDDKr5F5EcXaTuPWgE5MZJQ=Of6MwW+RmRhhXOLyfQzanjEwQ@mail.gmail.com>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
	<7v7gqkgvxe.fsf@alter.siamese.dyndns.org>
	<CAJDDKr4ki+NjSeuZpAU6bM=YAQ_3mdHCtawstdCqe9Ewvp=arQ@mail.gmail.com>
	<508E0FAC.5050600@alum.mit.edu>
	<7v4nkuiuhe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	"Lars R. Damerow" <lars@pixar.com>, Jeff King <peff@peff.net>,
	Marc Jordan <marc.jordan@disneyanimation.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:50:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYNRK-0006kc-6i
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 21:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755790Ab2KMUuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 15:50:21 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:53730 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680Ab2KMUuT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 15:50:19 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so4709544qcr.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 12:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=78dDSR9XB5AOBk+7+IbKsaWFZlLFZtctEuSyeiH6z9E=;
        b=JopG3BAM1PmtYVS0JEc9vdyYYTimLqKi6oKV+l0LwFeh5ipSoEneHqMVD/dNAYhbQ7
         vjRy9iSWouSJDsLmTENsMmwmey5RoSxU0XsX9CS9RkGyNSdsNJKY1qUkegJeBj0bebkL
         cQXp5GxTxRg4vyx0UAxAkzSEf89YMMinp6HHkEU3WpIW2Rtgg1LeYeAK+/JT5RY1cbgz
         1ph7lryIkQA969N8C4sOEcJ6K2WO+9ZA+gmov+3Yk+Ewwr6I28ZMWE5/2wOmvTGSCkYU
         DLAfaNtpSwkGQUg9Ep6PFWKK7OZpf1SEw/c0rx7q1oYyRNJHdZIQnUaRp7+t162dpQCP
         URKg==
Received: by 10.49.82.68 with SMTP id g4mr23408193qey.54.1352839818819; Tue,
 13 Nov 2012 12:50:18 -0800 (PST)
Received: by 10.49.85.227 with HTTP; Tue, 13 Nov 2012 12:50:18 -0800 (PST)
In-Reply-To: <7v4nkuiuhe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209673>

On Mon, Nov 12, 2012 at 9:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> The log message of the original commit (0454dd93bf) described the
>> following scenario: a /home partition under which user home directories
>> are automounted, and setting GIT_CEILING_DIRECTORIES=/home to avoid
>> hitting /home/.git, /home/.git/objects, and /home/objects (which would
>> attempt to automount those directories).  I believe that this scenario
>> would not be slowed down by my patches.
>>
>> How do you use GIT_CEILING_DIRECTORIES that the proposed changes cause a
>> slowdown?
>
> Yeah, I was also wondering about that.
>
> David?

I double-checked our configuration and all the parent directories
of those listed in GIT_CEILING_DIRECTORIES are local,
so our particular configuration would not have a performance hit.

We do have multiple directories listed there.  Some of them share
a parent directory.  I'm assuming the implementation is simple and
does not try and avoid repeating the check when the parent dir is
the same across multiple entries.

In any case, it won't be a problem in practice based on my
reading of the current code.



>>> Is there another way to accomplish this without the performance hit?
>>> Maybe something that can be solved with configuration?
>>
>> Without doing the symlink expansion there is no way for git to detect
>> that GIT_CEILING_DIRECTORIES contains symlinks and is therefore
>> ineffective.  So the user has no warning about the misconfiguration
>> (except that git runs slowly).
>>
>> On 10/29/2012 02:42 AM, Junio C Hamano wrote:
>>> Perhaps not canonicalize elements on the CEILING list ourselves? If
>>> we make it a user error to put symlinked alias in the variable, and
>>> document it clearly, wouldn't it suffice?
>>
>> There may be no other choice.  (That, and fix the test suite in another
>> way to tolerate a $PWD that involves symlinks.)
-- 
David
