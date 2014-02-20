From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 24/25] prune: strategies for linked checkouts
Date: Thu, 20 Feb 2014 20:19:40 +0700
Message-ID: <CACsJy8Bxp2sfP0M6htwNg-LP1CcFMpZbhE=sgR6xXJkj-5shcw@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1392730814-19656-25-git-send-email-pclouds@gmail.com> <CAPig+cQgphSBA6iAYqLJ7RnEwSzBA1dApcLWAydZEXarQRcTKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 14:20:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGTY3-00039c-7B
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 14:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbaBTNUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 08:20:12 -0500
Received: from mail-qc0-f182.google.com ([209.85.216.182]:55712 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586AbaBTNUL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 08:20:11 -0500
Received: by mail-qc0-f182.google.com with SMTP id w7so950955qcr.13
        for <git@vger.kernel.org>; Thu, 20 Feb 2014 05:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2/XPn+Wvhk0qGINYi4hhvrqrngQX1K4X72uMWE0z4Ws=;
        b=HGgXPPmNAX6QMf+D+D3igYl5f06P9DVx3Ij4t+XZLmFIn98iChbAeDeGBZX1hseuTj
         xu1FUNmk5UkHMVKLmicdluTSsO6bDbfQ+bM31YJyj9yOIgvRR87JjrdLI5c/b2ybgptb
         QH5nZbXAu8ENpKuk/sAyHxwkmCA4GesgpV5c+b/uoHGlMm0alcx1Dmnk5oPru7Ql/ZCl
         8STz8DIoxPZYIo2p3tzW13hYWp6TdTFwJqtmB50cLGEZ0VWi1wHWrQyOrNTa0tC73Bhs
         gBYqvFpGS5TZumI2y5m4L4NTGg0Fvp/ytvAeyBcvWQk7ax5HJhfH2L1/gu0HDHPIHAr4
         qPdw==
X-Received: by 10.224.36.129 with SMTP id t1mr1479732qad.8.1392902410240; Thu,
 20 Feb 2014 05:20:10 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 20 Feb 2014 05:19:40 -0800 (PST)
In-Reply-To: <CAPig+cQgphSBA6iAYqLJ7RnEwSzBA1dApcLWAydZEXarQRcTKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242433>

On Thu, Feb 20, 2014 at 5:08 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +static dev_t get_device_or_die(const char *path)
>> +{
>> +       struct stat buf;
>> +       if (stat(path, &buf))
>> +               die_errno("failed to stat '%s'", path);
>> +       /* Ah Windows! Make different drives different "partitions" */
>> +       if (buf.st_dev == 0 && has_dos_drive_prefix("c:\\"))
>> +               buf.st_dev = toupper(real_path(path)[0]);
>
> This invocation of has_dos_drive_prefix() with hardcoded "c:\\" at
> first looks like an error until the reader realizes that it's an
> #ifdef-less check if the platforms is Windows. Would it make more
> sense to encapsulate this anomaly and abstract it away by fixing
> compat/mingw.c:do_lstat() to instead set 'st_dev' automatically like
> you do here? In particular, this line in mingw.c:
>
>     buf->st_dev = buf->st_rdev = 0; /* not used by Git */
>

I don't want to hide too much magic behind compat curtain, especially
when these magic is just about 90% as real, the rest is mysterious
corner cases. I guess we could just add an inline function
is_windows() that always returns 0 or 1 based on #ifdef.
-- 
Duy
