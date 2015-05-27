From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: .gitconfig folder
Date: Wed, 27 May 2015 13:30:29 -0700
Message-ID: <xmqq7frtlq56.fsf@gitster.dls.corp.google.com>
References: <5565C6A7.60007@gmx.es>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jorge <griffin@gmx.es>
X-From: git-owner@vger.kernel.org Wed May 27 22:30:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxhyH-0003sB-8b
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 22:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbbE0Uac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 16:30:32 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38864 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbbE0Uab (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 16:30:31 -0400
Received: by igbjd9 with SMTP id jd9so8381241igb.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 13:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RkFQ53LNM1WYBYLZ3hIff4xzv7ieTwMTAydKE0Tezr0=;
        b=SpYMG3T4EejubJVW5rg5cifopOcRXbiWyeX4pttSoMSCY/PE/foepepW2gapLsfAJs
         hYP+lgWdLaNpyP3ZN6j807FvQbdSv1mMXxliHqFqV/YfTHjA25Yi4ABEYQW4Irj566bS
         4q0JeB8/65YYlL4bl+0MAsFNSRRXx2EgoTnZll+C313CTJlKBA4/dOSSss4cEwMZkE62
         id63YCrAa+PUyow7ULh5MILr4QLQJf/4ZcQDyipjowGp5WvhIAdorEdjqjt24HNXLRSu
         DPT5bY5zwJBy9wjFmeNkhpy9/0MH2wpIZ9JuR9fKF2rUvVkRtPYi1Qx323wZEwH9Sr4W
         1Deg==
X-Received: by 10.50.61.130 with SMTP id p2mr6933020igr.9.1432758630560;
        Wed, 27 May 2015 13:30:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id n14sm69417ion.5.2015.05.27.13.30.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 13:30:30 -0700 (PDT)
In-Reply-To: <5565C6A7.60007@gmx.es> (Jorge's message of "Wed, 27 May 2015
	15:29:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270083>

Jorge <griffin@gmx.es> writes:

> If you have a folder named ~/.gitconfig instead of a file with that
> name, when you try to run some global config editing command it will
> fail with a wrong error message:
>
>     "fatal: Out of memory? mmap failed: No such device"

That indeed is a funny error message.

How about this patch?

-- >8 --
We show that message with die_errno(), but the OS is ought to know
why mmap(2) failed much better than we do.  There is no reason for
us to say "Out of memory?" here.

Note that mmap(2) fails with ENODEV when the file you specify is not
something that can be mmap'ed, so you still need to know that "No
such device" can include cases like having a directory when a
regular file is expected, but we can expect that a user who creates
a directory to a location where a regular file is expected to be
would know what s/he is doing, hopefully ;-)

 sha1_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index ccc6dac..551a9e9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -720,7 +720,7 @@ void *xmmap(void *start, size_t length,
 		release_pack_memory(length);
 		ret = mmap(start, length, prot, flags, fd, offset);
 		if (ret == MAP_FAILED)
-			die_errno("Out of memory? mmap failed");
+			die_errno("mmap failed");
 	}
 	return ret;
 }
