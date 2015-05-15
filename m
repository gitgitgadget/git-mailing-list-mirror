From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/clean.c: Handle disappearing files
Date: Thu, 14 May 2015 22:26:19 -0700
Message-ID: <xmqqy4kqh0n8.fsf@gitster.dls.corp.google.com>
References: <1431638200-20449-1-git-send-email-dturner@twitter.com>
	<xmqqk2waj0js.fsf@gitster.dls.corp.google.com>
	<1431640373.17436.16.camel@ubuntu>
	<xmqqbnhmiz78.fsf@gitster.dls.corp.google.com>
	<1431642839.17436.22.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 15 07:26:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt88g-0005CI-Om
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 07:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbbEOF0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 01:26:22 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38375 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbbEOF0V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 01:26:21 -0400
Received: by igcau1 with SMTP id au1so3992418igc.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 22:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=I+gVygZK6gdWzyygje7RQwD1VGhNxu/IjyS0Xav11Jc=;
        b=EuTrI7dRFvgQJky1XKyX6MKal4DrCBdkbo2Wo8NVIF+OoeZZ42JEPSCM3FbEziCBuD
         Jwl8Qg4T1NJQx8MuNqOBKjdIqUBOii/uNg4i8KUmGHOhDVuuIf4ny/clnZloRZ4gtxQG
         1VxM1dZICyLbYqADhcm4fA6UJws8Jv7rO8wQJJgdRMHbqHEVOEZ8P0/c8qceWddygvQS
         krJRr4NjASkd0thflRD0aV+3XEWT6P8fIDi0bgcnjsPymAmCHvyXD4boy8yVHwXnk0f2
         z/LLI1FX4lYpn3AO+2OBCHP1oLlTjOUH7wo64OKhdXGXmTtINUBDxR3WItTup+j5E4e9
         jKNg==
X-Received: by 10.43.152.204 with SMTP id kx12mr5748045icc.51.1431667581012;
        Thu, 14 May 2015 22:26:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1148:d596:44de:a92d])
        by mx.google.com with ESMTPSA id r39sm404159ioe.25.2015.05.14.22.26.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 22:26:20 -0700 (PDT)
In-Reply-To: <1431642839.17436.22.camel@ubuntu> (David Turner's message of
	"Thu, 14 May 2015 18:33:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269124>

David Turner <dturner@twopensource.com> writes:

>> > Of course, in interactive use, very little harm is done if clean dies
>> > here: the user simply must notice that the clean has failed and retry
>> > it.  But in non-interactive use, scripts could fail.
>> >
>> > At least, I think that's what could be causing us to hit this error; I
>> > haven't actually done any research to see if this is true.
>> 
>> I find that the above argues that this patch is a bad idea.
>> 
>> The change sweeps the problem under the rug, killing the canary in
>> the mine, instead of motivating you to figure out why it is
>> happening to you.
>
> But it's totally legit for processes to create and delete files in the
> working tree at any time.  Maybe I'm editing during the clean, and my
> editor creates a backup file (or creates a lock file which it's going to
> move on top of my old file).

Isn't that exactly what users need to be aware of the potential
problem waiting to bite them?  Maybe you are editing during the
clean, which may notice a funny file your editor creates and removes
it, and when the editor wants to do something useful using that
funny file, it no longer is there.  Sure, if your editor is quick
enough and race with "clean" in certain timing, it may cause "clean"
to notice and die.  But if "clean" does not die, that means it won
the race and removed what your editor needed to use, no?

Isn't it even worse for scripts?  If your "build statistics" thing
created a temporary before "clean" started to run (causing 'clean'
to notice that as a cruft), and if "clean" gets to remove it before
the "build statistics" thing finishes what it was doing accumulating
whatever data in that file, when "build statistics" thing finally
tries to use the file, it no longer is there.

And isn't it even more worse for scripts that drive "clean"?  By
letting "clean" what it thinks cruft, while other processes are
"creating and deleting files in the working tree at any time"
without coordination, such a script is actively making the other
processes unreliable.  If "clean" in such a script stops as soon as
it notices such a race before doing any more damage, it would be a
good thing.  Retrying "clean" (to finish cleaning) does not sound
like a remedy; not running "clean" when other people are still using
the working tree is.  It's like somebody is randomly running "make
clean" in the background every once in a while in a working tree
where I am trying to do a real work.  Why is it "totally legit"?
And hiding the problem by making "clean" ignore such a race would
not help the user to fix such a script, would it?

Perhaps there is some assumption you have in the way the working
tree is being used that I haven't considered, and it is entirely
possible that this change may make sense under that special case,
but without knowing what that untold assumption is, the more I hear
about this topic from you, the less I am convinced that this is a
good change.
