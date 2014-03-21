From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Fri, 21 Mar 2014 08:33:35 +0700
Message-ID: <CACsJy8A_CZYtHvVo5iMzgmP5t7XLxHNRD6n4D=_jiOLOvBgmWQ@mail.gmail.com>
References: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>
 <532AF304.7040301@gmail.com> <CAHOQ7J9drXwcTt4b0Tcyw97KTGcifwsO5rtFNQYf7CVr3WD7zQ@mail.gmail.com>
 <532B5F0D.2070300@gmail.com> <CAHOQ7J-sUt3HGYNE7n=X3ZmV3Q-n+n9hMDAtzLbH3YU8iAqoqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@chromium.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 02:34:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQoML-0003H4-GD
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 02:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967037AbaCUBeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 21:34:11 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:45232 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965915AbaCUBeI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 21:34:08 -0400
Received: by mail-qg0-f47.google.com with SMTP id 63so5124122qgz.6
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 18:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZQnh73tn1FDRqTf94IF5akeQyV5PE3ETPZaxmuanRrc=;
        b=ENdnOIhPEjwpkyp8sL+W3+wvv+z70HFxw7TPG102MS3FuhEoVoydTWi3IQ7Sfr/qOC
         MTM1uOpwBhx6r7EPkuRNkYIZ10YmX6m2erG7aXOSY/X4cqJp4RWBfi8HcZMUf3QkK4fx
         gdaF7ISC2MQIUUulmPmAKaxoRh5CuQWn2EaoVkct2rBT6HVaXiQUonEbd+FdwqmYaCVw
         zHLm4htDWHQ184G+AHd0XWGd8qr2R0Jj85x8L/s3Nz2ewmJ8X73pb79kq28qRUvs3oyl
         YYrsMGvpdWMqxq7sRTcn2Yhlm+1Jcn0zwnhu/3cVcTON4PCJ3e9WBRuWR6yXnXq3fH58
         jpCQ==
X-Received: by 10.224.122.20 with SMTP id j20mr29654784qar.79.1395365646848;
 Thu, 20 Mar 2014 18:34:06 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Thu, 20 Mar 2014 18:33:35 -0700 (PDT)
In-Reply-To: <CAHOQ7J-sUt3HGYNE7n=X3ZmV3Q-n+n9hMDAtzLbH3YU8iAqoqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244627>

On Fri, Mar 21, 2014 at 4:56 AM, Stefan Zager <szager@chromium.org> wrote:
>> Considering all that, Duy's solution of opening separate file descriptors per thread seems to be the best pattern for future multi-threaded work.
>
> Does that mean you would endorse the (N threads) * (M pack files)
> approach to threading checkout and status?  That seems kind of
> crazy-town to me.  Not to mention that pack windows are not shared, so
> this approach to multi-threading can have the side-effect of blowing
> out memory consumption.

Maybe we could protect and share the delta cache. Pack windows are
mmap'd so we should not need to worry about their memory consumption.

> We have already had to dial back settings for
> pack.threads and core.deltaBaseCacheLimit, because threaded index-pack
> was causing OOM errors on 32-bit platforms.

Hm.. I don't think index-pack uses sha1_file.c heavily. Local pack
access is only needed for verifying identical objects (and that should
never happen often). Something is fishy with these OOM errors.

> Cygwin (and MSVC) should be able to share a "mostly" compliant pread
> implementation.  I don't have any insight into NonstopKernel; does is
> really not have a thread-safe pread implementation?  If so, then I
> suppose we have to #ifdef NO_PREAD, just as we do now.
>
> I realize that these are deep changes.  However, the performance of
> msysgit on the chromium repositories is pretty awful, enough so to
> motivate this work.
-- 
Duy
