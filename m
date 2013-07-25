From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v3] remotes-hg: bugfix for fetching non local remotes
Date: Thu, 25 Jul 2013 21:53:19 +0200
Message-ID: <CALWbr2wN6k8JBCwLFC=TjTC_sg7Uh8AEsMOBKfH9aBxDEcV4oQ@mail.gmail.com>
References: <1374712977-3215-1-git-send-email-dev@joernhees.de>
	<CAMP44s16bRx0p_F=PTcy9bekg_5TVC_GsQjzOev6xkpCEWcjAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joern Hees <dev@joernhees.de>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 25 21:53:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2RbL-0006OU-Kn
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 21:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756640Ab3GYTxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 15:53:21 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:39331 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212Ab3GYTxU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 15:53:20 -0400
Received: by mail-qc0-f178.google.com with SMTP id b11so1172621qcw.9
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 12:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=57izQAL0hzwXIK2KRelYv2uaDJe/5u70bOD9M04g9lo=;
        b=bWxHH/Fx/fMcoerDBpu6hxCXyhHhk115C3lFXZw29kofFOXHPtM9l0xKwsI59SEGXY
         /gUxKZLvJ5ggegIMjGCgGWBL8uw4lkLa+IieOUWQ2toeKxI/xTM55sg2hWcHrzew26ws
         xaNgjK87eVVsSYpe9xxRlzNnUTC7a3g0LD/nLn7mbIWXvCCqWo49K7L8ORy0uGbUSjIA
         qKPYXNt9NTOJ1DVgqyQDM6NB0TH2yurbtt4MiZPGbYv8J+nrPn6CnPSVgSyGY0Qqzu56
         GdTxuWMIPdzf6+tFDQ7IhZzM4Z1zRpun6IQVvKrPZh6US6HyunKBIKBRDfifJtgFe0TP
         CG2w==
X-Received: by 10.49.49.101 with SMTP id t5mr2518715qen.33.1374782000037; Thu,
 25 Jul 2013 12:53:20 -0700 (PDT)
Received: by 10.49.64.67 with HTTP; Thu, 25 Jul 2013 12:53:19 -0700 (PDT)
In-Reply-To: <CAMP44s16bRx0p_F=PTcy9bekg_5TVC_GsQjzOev6xkpCEWcjAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231146>

On Thu, Jul 25, 2013 at 9:12 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Besides, I don't see
> the point of having a '.shared/.hg' directory, and nothing else on
> that '.shared' folder.

Is it not already true about the ".git/hg/$alias/clone/" directory ?

> So, here's my patch. If only Junio read them.
>
> Subject: [PATCH] remote-hg: add shared repo upgrade
>
> 6796d49 (remote-hg: use a shared repository store) introduced a bug by
> making the shared repository '.git/hg', which is already used before
> that patch, so clones that happened before that patch, fail after that
> patch, because there's no shared Mercurial repo.
>
> It's trivial to upgrade to the new organization by copying the Mercurial
> repo from one of the remotes (e.g. 'origin'), so let's do so.

I agree with you that we should consider migration. But there's
another use-case I think can fail.
What happens with the following:

git clone hg::/my/hg/repo
cd repo && git remote add newremote hg::http://some/hg/url

Git clone will create .git/hg/origin and with no hg clone (because
it's a local repository), and then create marks-file in there.

> Reported-by: Joern Hees <dev@joernhees.de>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg.py | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/contrib/remote-helpers/git-remote-hg.py
> b/contrib/remote-helpers/git-remote-hg.py
> index 0194c67..57a8ec4 100755
> --- a/contrib/remote-helpers/git-remote-hg.py
> +++ b/contrib/remote-helpers/git-remote-hg.py
> @@ -396,6 +396,13 @@ def get_repo(url, alias):
>                  hg.clone(myui, {}, url, shared_path, update=False, pull=True)
>              except:
>                  die('Repository error')
> +        else:
> +            # check and upgrade old organization
> +            hg_path = os.path.join(shared_path, '.hg')
> +            if not os.path.exists(hg_path):
> +                repos = os.listdir(shared_path)
> +                local_hg = os.path.join(shared_path, repos[0], 'clone', '.hg')
> +                shutil.copytree(local_hg, hg_path)

With the use-case I described above, I think shutil.copytree() would
raise an exception because local_hg doesn't exist.
