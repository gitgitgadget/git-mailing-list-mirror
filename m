From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-remote-hg: set stdout to binary mode on win32
Date: Sun, 19 May 2013 00:33:46 -0500
Message-ID: <CAMP44s3H5e3ffoA04pdJx-pfKMGiRBTmjAn6NceP+s6_TYo1GA@mail.gmail.com>
References: <CAFGOX=V0A=2kMpxtNvsjgEtMt=zsm_-zX_DJo0qkV9y1_C4Haw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Amit Bakshi <ambakshi@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 07:34:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdwFx-0007Ve-JE
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 07:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056Ab3ESFdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 01:33:49 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:38760 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928Ab3ESFds (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 01:33:48 -0400
Received: by mail-la0-f46.google.com with SMTP id er20so1264807lab.5
        for <git@vger.kernel.org>; Sat, 18 May 2013 22:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=UAwwvwkash7M2Zj2DJNRqhYwne8fQPBOk7PwXju3Stg=;
        b=a13SaSxvMODY2JaBGksxInwSm2s7wGS92uPiXLc25ynnkLXsOZYVZXVi5VoTAMFWY/
         fiTj08/0Ar22aWS6QYCc03PJPHQ4C1bZh95Sgbw3uGUASfgyxA/3SuCFYDf225fvGHda
         rl1HT0Nw4HRQgZ/UaiL9h8yAPcwJLu8YZCaKuUtKhv1lnMG0SRdJjVEtOoPsISjJbk0q
         VnSI7+Kv9AASL/guLpJu82G52Sip/V/eOT5xsb9wlejfi2u/zXJx/gE2Kq//LB9lquGD
         TjNsN6z310j/ZLVgsu9p3RWl4yjnT1IGRJLofR/4uamWQqcyzyzRkXZdYGZVKHayg2sm
         3wfw==
X-Received: by 10.152.87.69 with SMTP id v5mr26121236laz.24.1368941626566;
 Sat, 18 May 2013 22:33:46 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sat, 18 May 2013 22:33:46 -0700 (PDT)
In-Reply-To: <CAFGOX=V0A=2kMpxtNvsjgEtMt=zsm_-zX_DJo0qkV9y1_C4Haw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224816>

Hi,

Sorry Amit, I assumed this patch made it to the list, but I just
realized it didn't; it doesn't allow HTML, and mails and silently
dropped (I hate that).

So I'm sending it so the list can see it:

It seems OK for me, but I would like to try it, and so far I haven't
managed to access Mercurial libraries at all from python scripts in
Windows. What steps did you follow?

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
> +
>  class Marks:
>
>      def __init__(self, path):
> @@ -764,6 +782,9 @@ def main(args):
>      else:
>          is_tmp = False
>
> +    if sys.platform in ['win32','cygwin']:
> +        set_binmode(sys.stdout.fileno())
> +
>      gitdir = os.environ['GIT_DIR']
>      dirname = os.path.join(gitdir, 'hg', alias)
>      branches = {}
> --
> 1.8.1

-- 
Felipe Contreras
