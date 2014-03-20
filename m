From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Thu, 20 Mar 2014 08:25:40 +0700
Message-ID: <CACsJy8D01gxeSoxgD9QkLgS85B=Af8aXytuqn6CBkF+_7WjZtQ@mail.gmail.com>
References: <20140319213556.2FC3D4062B@wince.sfo.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Stefan Zager <szager@chromium.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 02:26:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQRkp-0000V7-Ac
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 02:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbaCTB0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 21:26:13 -0400
Received: from mail-qa0-f43.google.com ([209.85.216.43]:33945 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbaCTB0M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 21:26:12 -0400
Received: by mail-qa0-f43.google.com with SMTP id j15so164141qaq.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 18:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=3oQPdPJLf8QVhHTIwkQLzl1XIGKT4mHqaOMSdjGb5Rg=;
        b=sJmWbPhjSXF55riWd6In0t04Gs4++WgAP7q9A58Zk+MF1qKlptRm3Z6uxsq1HYhzF9
         pYv+TClXIIlbWeOGinqM3yEc65BsgmQIpmT7C6BxSmbrs3inJ1dn9o+bbZc1HAbz5ip7
         BcthwFslhz2lfZcxq5iq17PhLVYqBCl3awftqUeXjfe0afA9nVr8f54nivEz+7uvmwkz
         RJkP4QYLUEBWr+9CUYNH3Mqnqd+sb0BXraX3Vi6xLCVYiO9aOhbR7W0rf523sIhdD+N6
         /SGQKDfif6GIOVfXJ6tiFB9mK8ljNvDrfudHKTW7NmcaVkl8/IW+2p+Ee7Nj3A4pOs0x
         d8wA==
X-Received: by 10.140.51.161 with SMTP id u30mr27677385qga.69.1395278771921;
 Wed, 19 Mar 2014 18:26:11 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Wed, 19 Mar 2014 18:25:40 -0700 (PDT)
In-Reply-To: <20140319213556.2FC3D4062B@wince.sfo.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244512>

On Thu, Mar 20, 2014 at 4:35 AM, Stefan Zager <szager@chromium.org> wrote:
> This adds a Windows implementation of pread.  Note that it is NOT
> safe to intersperse calls to read() and pread() on a file
> descriptor.  According to the ReadFile spec, using the 'overlapped'
> argument should not affect the implicit position pointer of the
> descriptor.  Experiments have shown that this is, in fact, a lie.
>
> To accomodate that fact, this change also incorporates:
>
> http://article.gmane.org/gmane.comp.version-control.git/196042
>
> ... which gives each index-pack thread its own file descriptor.

If the problem is mixing read() and pread() then perhaps it's enough to do

output_fd = dup(output_fd);

after pack_fd is set in open_pack_file(), to make sure that
fixup_pack_header_footer() has its own file handle. If that works, we
don't need one pack_fd per thread.

compat/mmap.c uses pread() and its bad interaction with read() could
turn it into a nightmare. Fortunately Windows (except Cygwin) does not
use this implementation. Not sure if we should make a note about this.

It makes me wonder if sliding mmap window (like we do for pack access
in sha1_file.c) would be better than pread(). index-pack used to do
mmap() [1] in the past with poor performance but I don't think sliding
window was mentioned.

[1] http://thread.gmane.org/gmane.comp.version-control.git/34741/focus=34832

> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -474,7 +474,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  endif
>  ifneq (,$(findstring MINGW,$(uname_S)))
>         pathsep = ;
> -       NO_PREAD = YesPlease
>         NEEDS_CRYPTO_WITH_SSL = YesPlease
>         NO_LIBGEN_H = YesPlease
>         NO_POLL = YesPlease

What about the "ifeq ($(uname_S),Windows)" section? I think MSVC and
MinGW builds share a lot of code.
-- 
Duy
