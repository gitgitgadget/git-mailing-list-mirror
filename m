From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-p4: Fix empty submit template when editor fires up
Date: Sun, 10 Jan 2010 05:11:53 -0600
Message-ID: <20100110111153.GA19612@progeny.tock>
References: <1262235876-1239-1-git-send-email-kevinlsk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Simon Hausmann <simon@lst.de>,
	gitster@pobox.com
To: Kevin Leung <kevinlsk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 10 12:11:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTvi3-00068t-IP
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 12:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495Ab0AJLLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 06:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753487Ab0AJLLr
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 06:11:47 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:61914 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426Ab0AJLLq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 06:11:46 -0500
Received: by iwn32 with SMTP id 32so4067406iwn.33
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 03:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tFoAb6Rh40I2N3tqMoRYoq0MiX6jmmVMq2k1Mb50BBk=;
        b=JnzXtrTNEx3gS+4hJTHySnOSXQKvfQb8LmL5e2RgA010xhS7uyy0Lr/E9KFJoxhBhE
         2xeo3FeKVv1fZ48+aQGVGWRh03/7pHc18NVY8BlLJTLQ5DsnWiF2RUBRQgfOVYBJGEwo
         K+Hiy6RCD7mb813h56gym8yUzo3+L6BB2lkV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eLbrYZCC+fTFvo5o8mOvLFrt/GYf91PU2vehuxWwAFkkWClgXeFS++XH3pL9YeKKfZ
         5BSVyevNBKwgycdA3I+FEIrtzXezGbLLD/ncikL8wt6wuwgla4tSBx/CacsGOLaLNFxE
         jgSS0Ap2urjOLyJGMAwn2IzLRPwgJQ10tsF1A=
Received: by 10.231.146.2 with SMTP id f2mr4146282ibv.23.1263121905982;
        Sun, 10 Jan 2010 03:11:45 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm760371iwn.10.2010.01.10.03.11.44
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Jan 2010 03:11:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1262235876-1239-1-git-send-email-kevinlsk@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136565>

Kevin Leung wrote:
> read_pipe() returns "\n". We need to remove it before passing it
> to system().
> 
> Signed-off-by: Kevin Leung <kevinlsk@gmail.com>

If I understand correctly, this is a cosmetic change: os.system()
calls system(3), which uses 'sh -c', which has no problem coping with
an extra newline at the end.  So 'need' seems too strong a word.
Still, the change sounds sensible.

> ---
>  contrib/fast-import/git-p4 |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 0cef242..04bf4f4 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -732,8 +732,8 @@ class P4Submit(Command):
>              if os.environ.has_key("P4EDITOR"):
>                  editor = os.environ.get("P4EDITOR")
>              else:
> -                editor = read_pipe("git var GIT_EDITOR")
> -            system(editor + " " + fileName)
> +                editor = read_pipe("git var GIT_EDITOR").strip()
> +            system("%s %s" % (editor, fileName))
>  
>              response = "y"
>              if os.stat(fileName).st_mtime <= mtime:
> -- 

What is the rationale for the rewritten system() line?  I would have
understood a change to

	os.spawnlp("sh", "-c", editor + " \"$@\"", fileName)

for better behavior when TMPDIR contains shell metacharacters, but
even this has nothing to do with read_pipe() returning a trailing
newline.

Just my two cents,
Jonathan
