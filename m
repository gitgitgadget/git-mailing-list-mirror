From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Git SSH Authentication
Date: Sat, 11 Feb 2012 10:35:42 +0530
Message-ID: <CAMK1S_jmY5KvBH8z6YKszroMai4O5ULeCBYGAGFT4CgVUAfmwg@mail.gmail.com>
References: <loom.20120211T045801-602@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: isawk <kwasi.gyasiagyei@4things.co.za>
X-From: git-owner@vger.kernel.org Sat Feb 11 06:06:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw5A7-0008WU-VD
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 06:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068Ab2BKFFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 00:05:43 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:48507 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750789Ab2BKFFn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 00:05:43 -0500
Received: by obcva7 with SMTP id va7so4607119obc.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 21:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GmPT4BT18SA32HxmOIWI/Eqpb2gF5PrOlTQGd8R2GhA=;
        b=yGCB3tqv3khdz1BQJ/FBblblBE1V5DdF0aB+kNWCQ/N7HgKiRCUDZv2qtnD4oqkWRB
         qemyxVG8PJ0G5MUtia44CI2S4ANt3ZVNW7mTp5pBvvF4miSLb2+MpKnAiv5LfI+x+be3
         mdYtOqDRrEzyvEGdW99JmTanK4Qc2FsUT780g=
Received: by 10.182.11.6 with SMTP id m6mr5331891obb.74.1328936742600; Fri, 10
 Feb 2012 21:05:42 -0800 (PST)
Received: by 10.182.28.161 with HTTP; Fri, 10 Feb 2012 21:05:42 -0800 (PST)
In-Reply-To: <loom.20120211T045801-602@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190483>

On Sat, Feb 11, 2012 at 9:31 AM, isawk <kwasi.gyasiagyei@4things.co.za> wrote:
> I'm unable to authenticate with git through ssh public key/password-less
> authentication.
>
> # git push origin master
> # Permission denied (publickey,gssapi-keyex,gssapi-with-mic).
> # fatal: The remote end hung up unexpectedly

if it didn't ask you for a password when pubkey access failed, that's
non-default.  Someone explicitly told sshd to do that.

Common causes of pubkey access fail:

  - wrong pubkey being used: run your ssh with '-vv' and look for
"offered".  make sure the pubkey that is being offered has been added
to the server side ~/.ssh/authorized_keys
  - wrong pubkey being offered: if you are using ssh-agent, make sure
you have 'ssh-add'ed the key you want to offer.  Confirm with 'ssh-add
-l'
  - wrong permissions on server side: sshd is very picky about
permissions.  Any directory component of $HOME/.ssh having g+w or o+w
will make it refuse.  Or wrong ownership (for example if you created a
file using root).
  - AllowUsers setting on server side /etc/ssh/ssd_config: this item
is not set by default, which allows everyone to log in.  But if
someone set it in for some reason, then the git user must also be
added to it.

In general, looking in server side /var/log/auth.log or
/var/log/secure or some such file will give you more information.
