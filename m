From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-remote-hg: set stdout to binary mode on win32
Date: Sun, 19 May 2013 06:23:56 -0500
Message-ID: <CAMP44s2h6O9_H=e9r_pSqdyU5O_NAFD94S8kZNC_eN_CJz-g7g@mail.gmail.com>
References: <CAFGOX=V0A=2kMpxtNvsjgEtMt=zsm_-zX_DJo0qkV9y1_C4Haw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Amit Bakshi <ambakshi@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:24:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue1if-0001ab-C3
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105Ab3ESLYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 07:24:00 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:61079 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922Ab3ESLX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 07:23:59 -0400
Received: by mail-la0-f43.google.com with SMTP id ez20so4401418lab.30
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=aWGyQVo1ddT+C60cad6GTNGlzU/WoAkSC19v+xIReyc=;
        b=BVGwuj+9wkJ1fiu0Hxk9M7xFCAfx+4TAlmhyJcYCRtiBJT0NhjByclb09N72xoO0Xm
         2IpL+I0hF4f8Ml72gpvWXMyEDPqAPjSZVdFieP4YlBjnzks8oK/7o8x0IlXsHwNA9uss
         hsNHNlSGRf7pK94y7mJM0yS9GPh79bX+nXLITUmgaf6sSRaqqAUR506Q0DGRX9Pandpc
         P4k8tMeXJcmSoWKNlWHGOMsFXCeA8V1lQpTcwonPs/hdNlTOhj9KEYMYN2qHBniQoOlk
         JaGNNcm6IJt43rmITRUuhbCmtxccPe+2iVe4iaKbjRelLTKYGzBvFH90EEz2u8MKNkAQ
         IhdQ==
X-Received: by 10.112.145.72 with SMTP id ss8mr26075435lbb.12.1368962636898;
 Sun, 19 May 2013 04:23:56 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sun, 19 May 2013 04:23:56 -0700 (PDT)
In-Reply-To: <CAFGOX=V0A=2kMpxtNvsjgEtMt=zsm_-zX_DJo0qkV9y1_C4Haw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224852>

On Mon, Jan 28, 2013 at 4:13 PM, Amit Bakshi <ambakshi@gmail.com> wrote:
> git clone hangs on windows (msysgit/cygwin), and
> file.write would return errno 22 inside of mercurial's
> windows.winstdout wrapper class. This patch sets
> stdout's mode to binary, fixing both issues.
> ---
>  contrib/remote-helpers/git-remote-hg | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/contrib/remote-helpers/git-remote-hg
> b/contrib/remote-helpers/git-remote-hg
> index 328c2dc..95f4c1f 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -62,6 +62,24 @@ def get_config(config):
>      output, _ = process.communicate()
>      return output
>
> +#
> +# On Windows (msysgit/cygwin) have to set stdout to binary
> +# mode (_O_BINARY is 32768). Otherwise clone hangs, and pushing
> +# to remote fails when doing a write to mercurial's wrapper
> +# windows.winstdout wrapper class.
> +#
> +def set_binmode(fd):
> +    try:
> +        if sys.platform == "win32":
> +            import msvcrt
> +            msvcrt.setmode(fd, os.O_BINARY)
> +        elif sys.platform  == 'cygwin':
> +            import ctypes
> +            msvcrt = ctypes.CDLL('msvcrt.dll')
> +            msvcrt._setmode(fd, 32768) # On Cygwin os.O_BINARY is different
> +    except OSError:
> +        pass

I tried many things, and it seems it's true that we need to set the
binary mode in Windows, but it seemed to work fine cygwin. I saw in
many places the workaround for 'win32', but I didn't find the one for
'cygwin'. Where did you find it? Did you test in cygwin? Is it needed
there?

Cheers.

-- 
Felipe Contreras
