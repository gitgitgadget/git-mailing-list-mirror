From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git error in tag ...: unterminated header
Date: Thu, 25 Jun 2015 14:21:25 -0700
Message-ID: <xmqqoak3wkkq.fsf@gitster.dls.corp.google.com>
References: <20150625155128.C3E9738005C@gemini.denx.de>
	<xmqqegkzzoaz.fsf@gitster.dls.corp.google.com>
	<20150625201309.5026A384E81@gemini.denx.de>
	<xmqqegkzy1ri.fsf@gitster.dls.corp.google.com>
	<2b124e09d9c89ff3892f246ea91aa3c4@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 25 23:21:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8EaU-00043V-AR
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 23:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbbFYVVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 17:21:30 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34333 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbbFYVV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 17:21:28 -0400
Received: by igcsj18 with SMTP id sj18so18455153igc.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Gn6YRkHVWjQPel+FdFeIk9hcuf8go91dcO5wIKPIoYE=;
        b=cfdThWXq1YkBKOPPdUQNp8+yCOApFOIsFoTkJo1bKCGs2BeTnv77UAnKfVN/5ketpR
         2Ioq2ReKQzFDhzEVKYxWLUxtjZ/0ZJ6idfBDKK5gGBTtB70SM1IrmhW0/gf3SmxqYyKM
         IvpM2+xXJ2+GUgQF/6AAvZwKzztZA3yE8wKCIaBVwTik2Df4sYuQ6Nzd2x96zFdhmCha
         go2wawjLc0BurUL0tvPjwMibI+zn0H/LL6sPum+CkEUBwCCq1JbPdTa/yVyJX5RTw5/a
         MWa1URb5zR5fcukUmbyL8ZdzIpp9nbRg3q6FHaIWTI5P4xxqhVAt5nUSKjJkmT0QC2sz
         9xlA==
X-Received: by 10.107.14.65 with SMTP id 62mr51913934ioo.67.1435267287801;
        Thu, 25 Jun 2015 14:21:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id k74sm20383897iok.30.2015.06.25.14.21.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 14:21:27 -0700 (PDT)
In-Reply-To: <2b124e09d9c89ff3892f246ea91aa3c4@www.dscho.org> (Johannes
	Schindelin's message of "Thu, 25 Jun 2015 23:07:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272737>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Hi Junio & Wolfgang,
>
> On 2015-06-25 22:24, Junio C Hamano wrote:
>> Wolfgang Denk <wd@denx.de> writes:
>> 
>>> In message <xmqqegkzzoaz.fsf@gitster.dls.corp.google.com> you wrote:
>>>>
>>>> > Question is: how can we fix that?
>>>>
>>>> It could be that 4d0d8975 is buggy and barking at a non breakage.
>
> Well, I would like to believe that this commit made our code *safer*
> by making sure that we would never overrun the buffer. Remember: under
> certain circumstances, the buffer passed to the fsck machinery is
> *not* terminated by a NUL. The code I introduced simply verifies that
> there is an empty line because the fsck code stops there and does not
> look further.
>
> If the buffer does *not* contain an empty line, the fsck code runs the
> danger of looking beyond the allocated memory because it uses
> functions that assume NUL-terminated strings, while the buffer passed
> to the fsck code is a counted string.
>
> The quick & dirty work-around would be to detect when the buffer does
> not contain an empty line and to make a NUL-terminated copy in that
> case.

Yes, I can totally understand its quick-and-dirty-ness would break
a valid case where there is no need for a blank after the header.

> A better solution was outlined by Peff back when I submitted those
> patches: change all the code paths that read objects and make sure
> that all of them are terminated by a NUL. AFAIR some code paths did
> that already, but not all of them.

I do not think you necessarily need a NUL.  As you said, your input
is a counted string, so you know the length of the buffer.  And you
are verifying line by line.  As long as you make sure the buffer
ends with "\n" (instead of saying "it has "\n\n" somewhere),
updating the existing code that does

	if (buffer is not well formed wrt "tree")
		barf;
	else
        	advance buffer to point at the next line;
	if (buffer is not well formed wrt "parent")
        	barf;
	...

to do this instead:

	if (buffer is not well formed wrt "tree")
		barf;
	else
        	advance buffer to point at the next line;
	if (buffer is now beyond the end of the original length)
		barf; /* missing "parent" */
	if (buffer is not well formed wrt "parent")
        	barf;
	...

shouldn't be rocket science, no?
