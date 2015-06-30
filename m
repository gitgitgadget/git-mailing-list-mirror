From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 6/7] git-reflog: add create and exists functions
Date: Tue, 30 Jun 2015 12:48:53 -0700
Message-ID: <xmqq3819c6ze.fsf@gitster.dls.corp.google.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
	<1435609076-8592-7-git-send-email-dturner@twopensource.com>
	<CAPig+cROJJNTcZnZfMP0meA8ZWGcSHcQCMTCkuC+kn_+OQZ-zA@mail.gmail.com>
	<xmqqbnfx89iz.fsf@gitster.dls.corp.google.com>
	<CAPig+cQ7tQV6uG0sVMsPJX=8V3g+zufRCYcdfDo4ixwwUp5hZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 21:49:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA1Wf-00056s-CN
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 21:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbbF3Ts6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 15:48:58 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37510 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbbF3Ts4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 15:48:56 -0400
Received: by igblr2 with SMTP id lr2so20200286igb.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 12:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JMpnbNPcutPHS91HBHASrj5h2npvECtfv5pj17F1LXE=;
        b=G66a2v4GdeJ3JOU6O096mv0VopxSYed9qPS2xNHV1pLYINoLJKNK8tWzNRFlc0uvxk
         pFuy2g2Ef8IkBVhzFv8FkQs00BTOpa6ASqCZEM7cLHO8sO97ztUI9MkV0vrPKwZnpBS4
         2wN1MWNQy2119BxenMFtRY5SBJD0ganM52wA87cTH0RlZ2u3clZv7lidjhu3+Q5aqVHx
         s+qqFmBDvk4L9+HiRHXPLgiTCF8Ud2kvxlX3Fk7Oa7sv8R9I2V0QT8LN+ji5uWXWN4Hv
         AaTZe4Tp/y62/MdAklIFF2mOrK7ddrdl/Ir8owQOeHIM9iJwKBge9iIHPuUVzcd7+S4k
         H9Cw==
X-Received: by 10.50.143.104 with SMTP id sd8mr26584479igb.14.1435693735172;
        Tue, 30 Jun 2015 12:48:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id k74sm30742978iok.30.2015.06.30.12.48.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 12:48:54 -0700 (PDT)
In-Reply-To: <CAPig+cQ7tQV6uG0sVMsPJX=8V3g+zufRCYcdfDo4ixwwUp5hZA@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 30 Jun 2015 14:20:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273103>

Eric Sunshine <sunshine@sunshineco.com> writes:

>>> Alternatives would be strbuf_reset() or declaring and releasing the
>>> strbuf within the for-loop scope.
>>
>> Because _reset() just rewinds the .len pointer without deallocating,
>> you would need an extra _release() before it goes out of scope. If
>> it is expected that the strbuf will be reused for a number of times,
>> the length of the string each iteration uses is similar, and you
>> will iterate the loop many times, "_reset() each time and _release()
>> to clean-up" pattern would save many calls to realloc/free.
>
> Yep, that's why I suggested strbuf_reset() as an alternative (and
> likely would have chosen it myself).

OK, then let's do that by squashing this in.

 builtin/reflog.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 3080865..e9ba600 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -733,10 +733,11 @@ static int cmd_reflog_create(int argc, const char **argv, const char *prefix)
 		if (safe_create_reflog(argv[i], &err, 1)) {
 			error("could not create reflog %s: %s", argv[i],
 			      err.buf);
+			strbuf_reset(&err);
 			status = 1;
-			strbuf_release(&err);
 		}
 	}
+	strbuf_release(&err);
 	return status;
 }
 
