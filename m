From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] GIT-VERSION-GEN: support non-standard $GIT_DIR path
Date: Tue, 18 Jun 2013 09:20:06 +0200
Message-ID: <1371540006.32543.5.camel@localhost>
References: <20130615230108.GA21005@kaarsemaker.net>
	 <7v38sgcxjp.fsf@alter.siamese.dyndns.org>
	 <7vy5a8biu8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 09:20:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoqDS-0001aD-4J
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 09:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096Ab3FRHUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 03:20:12 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38056 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab3FRHUK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 03:20:10 -0400
Received: by mail-wi0-f172.google.com with SMTP id c10so3081779wiw.5
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 00:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:x-mailer:mime-version:content-transfer-encoding
         :x-gm-message-state;
        bh=d45RE/O7KjcLB7tbRY828HCiDM3ortfsV5OItbvKoUY=;
        b=COMl7ANRZiSlX0FsLcBhCeBQ35vtGayJiKfrSEKpI+kBvllgNNLAqUbuNqwtkLvtNL
         GnW3Y/Np7yLNyJcAJo3ktKe0w+yq5ukxT0PhnurEkAIjnNWqewBN3E0tFmpwZZ/OiNuJ
         VaGZbu7tLzQKiZ4eeSuNUEVfUxXusdENdS32KqgEigHNkLocu2oxOwugny4TxsozWAiO
         fF8OjR6xYfCUvkXw/zpTc6R2j3Xt3km9PH6yFjiak+nAA7UtjSvxuw/c6D13L+mQ28N7
         HUzEpZHHq+PSq5zSx914HwhGjo8w0OhhmwVs0huiJFV0aYGvzw5E8TDWog6tZrBqKrjK
         VArw==
X-Received: by 10.194.174.137 with SMTP id bs9mr9910604wjc.59.1371540009197;
        Tue, 18 Jun 2013 00:20:09 -0700 (PDT)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPSA id o14sm26764231wiv.3.2013.06.18.00.20.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 00:20:08 -0700 (PDT)
In-Reply-To: <7vy5a8biu8.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
X-Gm-Message-State: ALoCoQlrqrZ19X510wPTa+TkzIXg4a8M8HU/g9KSdboBu1OdjWKogx/PkXSO5snZmhajXvOyF57L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228165>

On ma, 2013-06-17 at 13:09 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> >
> >>  I'm doing daily builds of git, using many workers and a shared git.git,
> >>  with per-worker checkouts
> >
> > OK, so GIT_DIR is explicitly specified in these "workers".

Yes, both GIT_DIR and GIT_WORK_TREE are set and the use of .git/HEAD and
anything relying on it is shunned, so workers can run checkout as they
please.

> > Makes sense.
>
> Actually it does not.  What if GIT_DIR is an empty string or not set
> at all?  The patch breaks the build for everybody else, doesn't it?

It does indeed, I only tested in my setup and not with a normal make
test. Apologies.

> Perhaps like this instead?
>
>  GIT-VERSION-GEN | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 2908204..91ec831 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -11,7 +11,7 @@ LF='
>  if test -f version
>  then
>  	VN=$(cat version) || VN="$DEF_VER"
> -elif test -d .git -o -f .git &&
> +elif test -d ${GIT_DIR:-.git} -o -f .git &&
>  	VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) &&
>  	case "$VN" in
>  	*$LF*) (exit 1) ;;

Yes, that makes a lot more sense and actually works in normal make test
and with a detached .git. Do you want me to send an updated patch?

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
