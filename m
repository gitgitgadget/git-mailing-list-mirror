From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v3 3/3] git-p4: fix Git LFS pointer parsing
Date: Sun, 24 Apr 2016 21:16:48 +0200
Message-ID: <CAHGBnuMs6h478FXGA_x2nP1D6BJCxGzhumR_xq5JFmNgzM6Sdw@mail.gmail.com>
References: <1461524292-20490-1-git-send-email-larsxschneider@gmail.com>
	<1461524292-20490-4-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, ben.woosley@gmail.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Sun Apr 24 21:17:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auPX0-0005h1-2x
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 21:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbcDXTQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 15:16:50 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33345 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbcDXTQu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 15:16:50 -0400
Received: by mail-yw0-f174.google.com with SMTP id t10so172903829ywa.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 12:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=eluIn/s+hoDMyCTYJLqOdSm6hyX0vssiNYpF+71zdMA=;
        b=dSTLfTfp/VQQyy2gIO+dmpDSNxNs+ZJCxoNfBD0L7P0izn1+IyGyt+npy1xlc9jdxS
         mjNJF31fwItcBCsLwBTpZ4NLMXewoyi/qfAYwPtNOqGUu/T9WrBGVU05RZDv+ZbjPGai
         GBRZb3zzkNZVNlt51oYmbGK4OLDEW3afiHtLGZxYcTZbhOiYnt+xKDX4haxwQMoKjXSQ
         A+iK46LjKXQUDnigu6WTGxzHqicmA4uJxOxc9ha5bzVDIpb0Yxrji7BvnSgjdgSh1Lhj
         c1Q9aKkU54d63TChTNfGnP7XAPXhlHB5nNqVXFXlV7h0Kwd3xEX2qcVVElU1GLzPLEzT
         6Lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=eluIn/s+hoDMyCTYJLqOdSm6hyX0vssiNYpF+71zdMA=;
        b=T6B0f376BJv0f8/vsd9V48WrPSUFZyxv4S20F5bzjdpBF+mgsP0x/+wCCCUOkqBxgJ
         yAveBIbmJOjJE90199IBOK976WxBSIAuSTaPF3uBcURetfdQLbLDBydlteWPUOQZLKV4
         5Or14VBeyxwwkeo1uxgZZ/0fYTNF5WT668I0RnIygnOFk70W/t02FodpckYRJvZ8k14V
         DaRn4YGTcuTKJsg4V7Ms02/SWFA7Owo1EdHc02PaM9CdjDNFYSSKEFaviXOKV0sVq71G
         smP25IO5v32SRSF9SwE7nBkYi/HRxARZ/hzCJfXzpjHixbwdsHv6mdm+fbU7qQ7udHs5
         y9rA==
X-Gm-Message-State: AOPr4FXmdmY75mviIq/dhM5G+yvMvo5gjvOiJ1STHVw4kUkhscOhzyIE+nKvJdtIO7TRicjRswHHoSeEW4xuHw==
X-Received: by 10.159.38.40 with SMTP id 37mr14645397uag.8.1461525409054; Sun,
 24 Apr 2016 12:16:49 -0700 (PDT)
Received: by 10.176.5.2 with HTTP; Sun, 24 Apr 2016 12:16:48 -0700 (PDT)
In-Reply-To: <1461524292-20490-4-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292431>

On Sun, Apr 24, 2016 at 8:58 PM,  <larsxschneider@gmail.com> wrote:

> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1064,8 +1064,15 @@ class GitLFS(LargeFileSystem):
>          if pointerProcess.wait():
>              os.remove(contentFile)
>              die('git-lfs pointer command failed. Did you install the extension?')
> -        pointerContents = [i+'\n' for i in pointerFile.split('\n')[2:][:-1]]
> -        oid = pointerContents[1].split(' ')[1].split(':')[1][:-1]
> +
> +        # Git LFS removed the preamble in the output of the 'pointer' command
> +        # starting from version 1.2.0. Check for the preamble here to support
> +        # earlier versions.
> +        # c.f. https://github.com/github/git-lfs/commit/da2935d9a739592bc775c98d8ef4df9c72ea3b43
> +        if pointerFile.startswith('Git LFS pointer for'):
> +            re.sub(r'Git LFS pointer for.*\n\n', '', pointerFile)

I liked the code from v2 better. I know Ben said "there could be
expansions or other modifications applied by git-lfs between input and
output", but I believe it's better to be too strict than too lenient
if you're omitting lines from the output. Also, the regex matches
against the whole multi-line string. That is, if the file for some
reason was ending in '\n\n' instead of just '\n', the '.*' would match
almost all content of the pointer file, not just the remains of the
preamble. One way to fix this would be to use

re.sub(r'Git LFS pointer for [^\n]+\n\n', '', pointerFile)

instead.

Regards,
Sebastian
