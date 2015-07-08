From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subject: [PATCH] git am: Transform and skip patches via new hook
Date: Wed, 08 Jul 2015 15:57:01 -0700
Message-ID: <xmqq8uaqxnpe.fsf@gitster.dls.corp.google.com>
References: <CAJ3HoZ2YdAFVt1-4dTk04=0cLTUxQocJPNSVupr09Ee01tGCAQ@mail.gmail.com>
	<CAPig+cQy-KHAaK_byw2nMM-S8cNosTpOiyejkHzAL6VavncaOw@mail.gmail.com>
	<CAJ3HoZ317rF_JMiMnei4U8+o2Q9TN34GOHFS-i+GHAvZy9hEvg@mail.gmail.com>
	<20150708194844.GA895@flurp.local>
	<CAPig+cQx5TKwLk+MjsOJVHriqmwYbEcKUtARJVzef4HyN0thgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Robert Collins <robertc@robertcollins.net>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 00:57:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCyHA-0008E8-47
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 00:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbbGHW5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 18:57:07 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35107 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbbGHW5E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 18:57:04 -0400
Received: by igcqs7 with SMTP id qs7so67586074igc.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 15:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=X2gRveS0sIx8dw1d113yPLtOeiqKsaPE8VP0b8NblZE=;
        b=stvFbeB0zHwZ7qTFBXcpFlAyyLjoQT4QRi6CRGjFaTPeH5WPrCHgjQbwMU16O37l9V
         S9Jecd56BP/Kb8Y3G3P71W2QFZSnjEjI5bUw/AY6Ya/j2UOhfhR7Q3nxC4TmlP9wugj4
         hRk0t7vaWUdIVo/D0WZFosyjauTmUsZMDDge+/HZ0e9geDTEMVX1b9WhXQ/7GFp38y4L
         fDhsyejhLUwfaicYDUDx8Qiml+HmlllHNuBgVyCQFqVVQfyuD30Aq/AWgPO+8T/ihXKb
         +LWXgOLaD2/1APrR4uTp7vY/6ROsm7WhsY0FeYPOX8XPe0AlXZlTQtt+exdLKe15B179
         wnPw==
X-Received: by 10.107.30.69 with SMTP id e66mr20602834ioe.76.1436396223741;
        Wed, 08 Jul 2015 15:57:03 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6567:f006:f2bd:2568])
        by smtp.gmail.com with ESMTPSA id bf10sm15216507igb.12.2015.07.08.15.57.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jul 2015 15:57:02 -0700 (PDT)
In-Reply-To: <CAPig+cQx5TKwLk+MjsOJVHriqmwYbEcKUtARJVzef4HyN0thgg@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 8 Jul 2015 17:17:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273716>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> I forgot to mention in the previous review that this change probably
>> ought to be accompanied by tests. However, before spending more time
>> refining the patch, it might be worthwhile to wait to hear from Junio
>> whether he's even interested in this new hook. (Based upon previous
>> discussions of possible new hooks, he may not be interested in a hook
>> which adds no apparent value. Again, more on that below.)
>> ...
>> The commit message mentions the use-case "git format-patch | git am",
>> with git-am invoking a hook for each patch to transform or reject it,
>> however, it's not clear why you need a hook at all when a simple
>> pipeline should work just as well. For instance:
>>
>>     git format-patch | myfilter | git-am
>>
>> where myfilter is, for instance, a Perl script such as the following:
>>
>>     #!/usr/bin/perl
>>...
>>
>> This filter performs the exact transformations and rejections
>> described by the sample hook's comment block[*1*]. Aside from not
>> requiring any modifications to Git, it also is *much* faster since
>> it's only invoked once rather than once per patch (and, as a bonus,
>> it doesn't need to invoke the 'filterdiff' command three times per
>> patch, or create and delete several temporary files per patch).

Very well said.  The pipeline you showed above is exactly why "am"
reads from its standard input.  Incidentally, I have an "add-by"
filter (found on my 'todo' branch, which is checked out in the Meta
directory in my working tree), that I use every day when I apply
patches from my mailbox.  When I have a patch that was reviewed by
Eric, I type '|' (I happen to use Gnus; the '|' command asks for a
command and pipes the message to it) and say:

    Meta/add-by -r sunshine@ | git am -s

and the filter adds Reviewed-by: line at an appropriate place.

Another reason why a hook is a bad match for the use case under
discussion is because unlike "myfilter" in your example pipeline
above, you cannot pass options to tweak the customization to the
'transform patches' hook even if you wanted to.

People should learn to consider that hooks and filters are the last
resort mechanism, not the first choice.  There are cases where you
absolutely need to have them (e.g. when Git generates something and
then uses it internally, you _might_ want to tweak and customize
that something), but the use case presented here is a canonical
example of what you shouldn't use hooks for---preprocessing the
input to a Git command.
