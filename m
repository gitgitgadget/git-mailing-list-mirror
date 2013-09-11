From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Regression in e02ca72: git svn rebase is broken on Windows
Date: Wed, 11 Sep 2013 12:41:09 +0800
Message-ID: <CANYiYbECYK90Hp49rd9Ow8X_CdcnKREeSafwHTXRnut+qABMqA@mail.gmail.com>
References: <17231378818848@web5m.yandex.ru>
	<xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
	<loom.20130911T001650-550@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 06:42:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJcFm-0001dJ-UE
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 06:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056Ab3IKElQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 00:41:16 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:57750 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755043Ab3IKElK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 00:41:10 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so6357390wes.41
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 21:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1lUSPiG/94dw5YNqPMQa1ho9qnmLOSg+dS8jljGaNdI=;
        b=JSrvBAGobhsuwzddhq9Fi8ZB4dAbSamDy5GUNVPISdQj8RdaY4m3TKY92u9vm7WXLl
         zrp8KrE7/qkw5N3ppwbp/WRDBCpuVqNA11N6QXYxR6VNqsAdCo6OxM1A0UqlKijrIjNh
         MNN8fQ5B7NEOIR5NreVTajbkitfMqu5fvUB2gxKOeDYlgjupVuKhpF1rkic9eYGRI0fj
         NnfZyOyyEYvtMVSCFBZgHGi69PuTt6HkQn9rNeVmjU+VEL+cDWfUpbNlAHRagdVgHsOI
         43zis0dCV5EN9Dt4PDFMhvYjYJpRUSaJ2Z9u8ZvCUWn8hPGS3glNYJsxPezatAS80KL3
         kiww==
X-Received: by 10.194.122.129 with SMTP id ls1mr8920613wjb.37.1378874469399;
 Tue, 10 Sep 2013 21:41:09 -0700 (PDT)
Received: by 10.194.71.175 with HTTP; Tue, 10 Sep 2013 21:41:09 -0700 (PDT)
In-Reply-To: <loom.20130911T001650-550@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234521>

2013/9/11 Karsten Blees <karsten.blees@gmail.com>:
> Junio C Hamano <gitster <at> pobox.com> writes:
>
>> The suspect commit and symptom look consistent.  You started from a
>> directory whose absolute path is "w:/work/..." and the updated code
>> mistakenly thoguht that something that begins with "w" (not '/') is
>> not an absolute, so added a series of ../ to make it relative, or
>> something silly like that.
>>
>> Jiang?
>>
>
> Indeed, this patch seems to change relative_path in a way that breaks git
> initialization, not just on Windows.
>
> Previously, relative_path was always called with two absolute paths, and it
> only returned a relative path if the first was a subdir of the second (so a
> better name would probably have been 'relative_path_if_subdir'). The purpose
> was to improve performance by making GIT_DIR shorter if it was a subdir of
> GIT_WORK_TREE.

Yes, it's what commit v1.5.6-1-g044bbbc says.

> After this patch, relative_path always tries to return a relative path, even
> if both absolute paths are completely disjunct. This not only defeats the
> purpose (by making GIT_DIR longer, thus hurting performance), it is also not

Sometimes longer, sometimes shorter maybe.

> possible in general. POSIX explicitly allows for '//hostname' notation
> referring to network resources that are not explicitly mounted under '/'.
> I.e. given two absolute paths '//hostname1/a' and '//hostname2/b', there is
> no relative path from a to b or vice versa.

Yes, path like "//hostname/path" can be used on Windows.
My hack "have_same_root" does not cover this case, so using
a "simple_relative_path" function instead of "relative_path" in setup.c
may be the better.


-- 
Jiang Xin
