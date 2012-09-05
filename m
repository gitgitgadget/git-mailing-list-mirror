From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 7/7] t0000: verify that real_path() removes extra slashes
Date: Wed, 5 Sep 2012 17:52:10 +0700
Message-ID: <CACsJy8DAbp1uDsNFFk1g9tuEV1qMnM2DZtxOwp5H9_VE7VwO1g@mail.gmail.com>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
 <1346746470-23127-8-git-send-email-mhagger@alum.mit.edu> <7v1uihbqhf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: mhagger@alum.mit.edu, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Orgad and Raizel Shaneh <orgads@gmail.com>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 12:52:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9DE1-00027T-TB
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 12:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054Ab2IEKwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 06:52:42 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33307 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842Ab2IEKwl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 06:52:41 -0400
Received: by ieje11 with SMTP id e11so811381iej.19
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 03:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aLwJZI9gpt0EeC7IA10RkKwKF41xD7CnrT2Q619vTrE=;
        b=vV/k5uTWk1FIMWJWKw9mf6CbtxrTHqDJ4KdAjVKMvCapF4KSi41FrD1KG0+3qSsT2l
         17GujsCMXW22O6X5720FIWTmH0ryX1GZ9D83+PKCczb6jYLdUnUkcY+q9U90pt2+0iH0
         KGtrQ9h0huMJQmIUvkKx30shd7fXvxcs55JuTlEfeO6HYVJJPoJ2oufF7aulgBM2z0zG
         +6E7oksEbjT4SJZbVkBRR+HX2wC5tdSet9epZ3GlFJHEHJeuX9SKGX7y6NfJl3oU6xp1
         +CL02jzeYOLpFgA7VCnk8VU4LGGRdKzUUvmgX9VjOJgvlNrqNy4Z6j1vm6AzNpQEXnEJ
         eGEA==
Received: by 10.50.159.130 with SMTP id xc2mr17420501igb.15.1346842360616;
 Wed, 05 Sep 2012 03:52:40 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Wed, 5 Sep 2012 03:52:10 -0700 (PDT)
In-Reply-To: <7v1uihbqhf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204810>

On Wed, Sep 5, 2012 at 1:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> mhagger@alum.mit.edu writes:
>
>> From: Michael Haggerty <mhagger@alum.mit.edu>
>>
>> These tests already pass, but make sure they don't break in the
>> future.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>
>> It would be great if somebody would check whether these tests pass on
>> Windows, and if not, give me a tip about how to fix them.
>
> I think this (perhaps unwarranted) removal of the double leading
> slashes is the root cause of
>
>     http://thread.gmane.org/gmane.comp.version-control.git/204469
>
> (people involved in that thread Cc'ed).

I gave up on that thread because I did not have a proper environment
to further troubleshoot. Thanks Mike for giving me the clue about
real_path(). I traced link_alt_odb_entry() and it does this:

	if (!is_absolute_path(entry) && relative_base) {
		strbuf_addstr(&pathbuf, real_path(relative_base));
		strbuf_addch(&pathbuf, '/');
	}
	strbuf_add(&pathbuf, entry, len);
	normalize_path_copy(pathbuf.buf, pathbuf.buf);

The culprit might be normalize_path_copy (I don't have Windows to test
whether real_path() strips the leading slash in //server/somewhere). I
tested normalize_path_copy() separately and it does strip leading
slashes, so it needs to be fixed. Something like maybe:

diff --git a/path.c b/path.c
index 66acd24..ad2881c 100644
--- a/path.c
+++ b/path.c
@@ -503,6 +503,10 @@ int normalize_path_copy(char *dst, const char *src)
                *dst++ = *src++;
                *dst++ = *src++;
        }
+#ifdef WIN32
+       else if (src[0] == '/' && src[1] == '/')
+               *dst++ = *src++;
+#endif
        dst0 = dst;

        if (is_dir_sep(*src)) {

I'm not suitable for following this up as I don't have environment to
test it. Maybe some msysgit guy want to step in?
-- 
Duy
