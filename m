From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Cannot push anything via export transport helper after push fails.
Date: Sat, 11 May 2013 08:57:14 -0500
Message-ID: <CAMP44s1YhQR0o-0CLc2PG-EJTZdN4tha-4BVEUy-K_Av81D=GQ@mail.gmail.com>
References: <20130511162936.0354e5d7@opensuse.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 15:57:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbAIb-0005cw-0V
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 15:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742Ab3EKN5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 09:57:16 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:59688 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab3EKN5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 09:57:16 -0400
Received: by mail-la0-f47.google.com with SMTP id fh20so4799087lab.20
        for <git@vger.kernel.org>; Sat, 11 May 2013 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=41DNUzP4kUCzES8+rJ4JQ+TXmfdVHYgrXRGNaoH047E=;
        b=qGNRXBB7TDoQoG3RF14ALCUosoz0DFfQAQbWuWsm+90lh8Uye0XdMtPb/jw4TOzXV6
         m5TJSGaBPv3Z2sqXML3MIdKephKpFPUFMf9dT6iduUF1cqMguufAe78n7UdlFROWt3dx
         AEJTawvw0jwkB3dMHgvcR6I9DYkzNRnHzGeAzedlXJRTRs66jQEqA9ax9lXmuKU4bBy3
         p3fKzLFqemlB9QaOxnn4Ip84NC0CM8lH5EwI1EH/9LvvTEDwPlCY8MZqawVLXDSUsuMs
         s07c2vney3DDwcTwN2Zt0oa4tLcVFe0EFvL+aguv3AOINnmKMH3QssLtGIZ+EBvAit5v
         todQ==
X-Received: by 10.152.116.71 with SMTP id ju7mr9728071lab.38.1368280634595;
 Sat, 11 May 2013 06:57:14 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sat, 11 May 2013 06:57:14 -0700 (PDT)
In-Reply-To: <20130511162936.0354e5d7@opensuse.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223972>

On Sat, May 11, 2013 at 7:29 AM, Andrey Borzenkov <arvidjaar@gmail.com> wrote:
> I noticed that using git-remote-bzr, but as far as I can tell this is
> generic for all transport helpers using fast-export.
>
>
>
> What happened was "git push" failed due to merge conflict. So far so
> good - but from now on git assumes everything is up to date.
>
> bor@opensuse:/tmp/test/git> git push origin master
> To bzr::bzr+ssh://bor@localhost/tmp/test/bzr
>  ! [rejected]        master -> master (non-fast-forward)
> error: failed to push some refs to 'bzr::bzr+ssh://bor@localhost/tmp/test/bzr'
> hint: Updates were rejected because the tip of your current branch is behind
> hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')
> hint: before pushing again.
> hint: See the 'Note about fast-forwards' in 'git push --help' for details.
> bor@opensuse:/tmp/test/git> git push origin master
> Everything up-to-date
> bor@opensuse:/tmp/test/git>
>
> The problem seems to be that git fast-export updates marks
> unconditionally, whether export actually applied or not. So next time
> it assumes everything is already exported and does nothing.
>
> Is it expected behavior?

Indeed, this is the way it currently works, and it's not easy to fix.
We would need some way to make fast-export wait until we know the exit
status of the remote helper, and then tell it when it failed, so the
marks are not updated.

However, the way remote-bzr/hg work is that the commits are still
there anyway. So if you merge the next time you push those commits are
already converted, so it's not a problem if fast-export is not
exporting them again.

So even though it's not ideal, it should work.

The problem is when the remote-helper crashes and the marks of
fast-export and the remote-helper are out of sync, and then the user
is really screwed.

Cheers.

-- 
Felipe Contreras
