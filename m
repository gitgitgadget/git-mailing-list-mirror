From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [RFC/PATCH v1] Towards MinGW(-W64) cross-compilation
Date: Mon, 28 Apr 2014 17:34:03 +0200
Message-ID: <CABPQNSZ3vxPg12HFXr4sP1b+4ifGj60fY1Z1N-x16hXgK-G0AA@mail.gmail.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:34:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wena0-00084h-QM
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbaD1Per (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:34:47 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:41711 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932115AbaD1Peo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:34:44 -0400
Received: by mail-ig0-f175.google.com with SMTP id h3so4908583igd.14
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=irIdLEaz0ZMAbhopyb14O/6+2fBKYP6QneWdMl5W8Yg=;
        b=cL9sLYczpFz8sxZxw2L1CI7F8fHGjIj03ZqOLOc6CVDVpMzA8/zQVpwKHUmf8vKfeJ
         nUG7Pb+P7lEueAwVCHlqRm82KRTE//Sr+XfnT0lezH3U/FSSC5GHuzIcYwstMmDHet+d
         OCPDG9rRbD5K1NC8WGa34PoxnKpbnE6YfdSFf0FRlHYQ2tVqh47GW+YvEA1tla1Aj/di
         /roTOm/tt3nGucnZZoMGKQz9SfZELbWV4iT3GNBHfm6EslZQdTHnvNZBIlTrl5m7dnYQ
         WDu/xbPwRzEweLqfavrCXyy7BiHJnzVFIum8J+1psrD51X9LDE1LRs2PMV6eZs3hy1Yi
         Ch1g==
X-Received: by 10.50.30.6 with SMTP id o6mr24445690igh.43.1398699283758; Mon,
 28 Apr 2014 08:34:43 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 08:34:03 -0700 (PDT)
In-Reply-To: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247366>

On Mon, Apr 28, 2014 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> This patch series fixes building on modern MinGW and (32bit only yet) MinGW-W64.
>
> *Compilation* tested on:
>  - MSVC (via WinGit environment)
>  - msysGit environment
>  - Linux cross-toolchain i686-pc-mingw32 (4.8.2) with mingw-runtime-3.20.2
>  - Linux cross-toolchain i686-w64-mingw32 (4.8.2) with mingw64-runtime-3.1.0
>
> Stuff still required to make Git build with x86_64 MinGW-W64 toolchain:
>
> 1. Drop -D_USE_32BIT_TIME_T that was added in fa93bb to config.mak.uname
> because time_t cannot be 32bit on x86_64. I haven't yet figured out what
> should break if this define is removed (pointers are welcome) and why it was
> added in the first place.
>
> 2. Stop passing --large-address-aware to linker. I wonder if it does anything
> for 32bit MinGW builds.
>
> 3. Fix several places with mismatched pointer size casts.
>
> Building it from Gentoo Linux:
>
> MinGW:
>
>   crossdev -t i686-pc-mingw32
>   ARCH=x86 emerge-i686-pc-mingw32 -u dev-libs/libiconv sys-libs/zlib net-misc/curl sys-devel/gettext expat
>   cd <git>
>   make CROSS_COMPILE=i686-pc-mingw32- CC=i686-pc-mingw32-gcc NO_OPENSSL=1 MINGW=1 CURLDIR=/usr/i686-pc-mingw32/usr
>
> MinGW-W64 (32 bit):
>
>   crossdev -t i686-w64-mingw32
>   ARCH=x86 emerge-i686-w64-mingw32 -u dev-libs/libiconv sys-libs/zlib net-misc/curl sys-devel/gettext expat
>   cd <git>
>   make CROSS_COMPILE=i686-w64-mingw32- CC=i686-w64-mingw32-gcc NO_OPENSSL=1 MINGW=1 CURLDIR=/usr/i686-w64-mingw32/usr
>
> Debian/Ubuntu build instructions are WIP (xdeb is non-trivial at all).

Apart from some minor nits, this looks good to me. Thanks a lot for
spending the time, and I look forward to a second iteration!
