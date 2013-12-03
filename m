From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] path_treatment: also ignore $GIT_DIR if it's not .git
Date: Tue, 03 Dec 2013 16:18:34 +0100
Message-ID: <529DF64A.70801@gmail.com>
References: <1385922611.3240.6.camel@localhost> <20131201190447.GA31367@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ingy@ingy.net
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 03 16:18:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnrkH-0001sB-2o
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 16:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607Ab3LCPSh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Dec 2013 10:18:37 -0500
Received: from mail-ea0-f181.google.com ([209.85.215.181]:57779 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466Ab3LCPSg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 10:18:36 -0500
Received: by mail-ea0-f181.google.com with SMTP id m10so10067970eaj.40
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 07:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gmif7B87cPwPWsZGJlW2lQ/Cq9V+3A1iy9HW5Moohao=;
        b=sXhrHwM1gWLRBkbR7UTIamY+2ms9M0qpQF0sMxtkLPW/bCdlUjtiN/EoyofkO1yPri
         TfYpYFolVmKKzMZBFfdZUYuULuiIh/nWrGE0+Vc4yMVYvGQmBOQCykT/xVPh7RTD8ISr
         79o5/MlP3J7bZ4WxT/EA3uYP1gkXEliudTZSYEx8RaHk6cm+Ljjt+q9UeZz/6CReir++
         x5hRQpgNAq1b/nUL1YUIm3qOuwSsYPdIP4tFZ2v+0BLUADasH5ZnUADaR7YNpGVWfZ/m
         sEIrQgNZWrZx/uLwMkPMRV3QwC9pbHW7SlBD4jsT7/PAocr+gUHDBQ7X3lWYVa0WrxRb
         tTdw==
X-Received: by 10.14.172.130 with SMTP id t2mr3200419eel.68.1386083915201;
        Tue, 03 Dec 2013 07:18:35 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id g47sm83717673eeo.19.2013.12.03.07.18.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 03 Dec 2013 07:18:34 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <20131201190447.GA31367@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238698>

Am 01.12.2013 20:04, schrieb Dennis Kaarsemaker:
> We always ignore anything named .git, but we should also ignore the g=
it
> directory if the user overrides it by setting $GIT_DIR
>=20
> Reported-By: Ingy d=F6t Net <ingy@ingy.net>
> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> ---
>  dir.c             | 2 +-
>  t/t7508-status.sh | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/dir.c b/dir.c
> index 23b6de4..884b37d 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1198,7 +1198,7 @@ static enum path_treatment treat_path(struct di=
r_struct *dir,

The special case for ".git" is hardcoded in many places in git, includi=
ng the line immediately above this diff hunk. So I figure that GIT_DIR =
is not meant to _rename_ the ".git" dir, but to point somewhere _outsid=
e_ the worktree (or somewhere within the .git dir).

If we want to support the rename case fully, I think there are a few mo=
re questions to answer (and a few more places to change), e.g.:
- What if GIT_DIR=3D.foo and someone upstream adds a ".foo" directory?
- Should it be possible to track ".git" as a normal file or directory i=
f its not the GIT_DIR?
- What about other commands than status, e.g. does 'git clean -df' leav=
e the GIT_DIR alone?

If we don't want to support this, though, I think it would be more appr=
orpiate to issue a warning if GIT_DIR points to a worktree location.
