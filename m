From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/4] completion: simplify __git_remotes
Date: Mon, 30 Jan 2012 11:34:46 -0600
Message-ID: <20120130173446.GF10618@burratino>
References: <1327944197-6379-1-git-send-email-felipec@infradead.org>
 <1327944197-6379-2-git-send-email-felipec@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipec@infradead.org>
X-From: git-owner@vger.kernel.org Mon Jan 30 18:35:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrv88-00025J-41
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 18:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab2A3Rez convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 12:34:55 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55410 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab2A3Rey convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 12:34:54 -0500
Received: by yenm6 with SMTP id m6so1894970yen.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 09:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uPbOdFJynHL3tSht/1ghwh0FnJzStZXHylrelBOfmpY=;
        b=KSydaXmWXgzpqqkWo57HddcNLh9OQwOv4Mk0ff7ZfZalZTtLoYoNBRBIAxT89Yr00D
         yOewo11YuA37CsX8SLQdIk2IvSRkVPGRgVu+D0jQxug2lbBr1PrgmB2+uOJzJGv3atMd
         qs1OLvgj+DZEPtq1rWY5DOiSPudj9f9GkUUkY=
Received: by 10.236.79.37 with SMTP id h25mr27102953yhe.76.1327944893838;
        Mon, 30 Jan 2012 09:34:53 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id r68sm32984317yhm.18.2012.01.30.09.34.52
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 09:34:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1327944197-6379-2-git-send-email-felipec@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189380>

=46elipe Contreras wrote:

> From: Felipe Contreras <felipe.contreras@gmail.com>
>
> There's no need for all that complicated code that requires nullglob,
> and the complexities related to such option.
>
> As an advantage, this would allow us to get rid of __git_shopt, which=
 is
> used only in this fuction to enable 'nullglob' in zsh.

That is all a longwinded way to say "zsh doesn't support the same
interface as bash for setting the nullglob option, so let's avoid
it and use 'ls' which is simpler", right?

There's a potential speed regression involved --- using "ls" involves
an extra fork/exec.  I believe you have thought about this and done a
little to mitigate it; could you explain this in the commit message so
future coders know what features of your code need to be preserved?

Please consider squashing this with patch 2/4.  It will make both
patches way easier to understand on their own.

Cc-ing G=C3=A1bor, who I imagine is more familiar with this code than I=
 am.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 1496c6d..086e38d 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -644,12 +644,7 @@ __git_refs_remotes ()
>  __git_remotes ()
>  {
>  	local i ngoff IFS=3D$'\n' d=3D"$(__gitdir)"
> -	__git_shopt -q nullglob || ngoff=3D1
> -	__git_shopt -s nullglob
> -	for i in "$d/remotes"/*; do
> -		echo ${i#$d/remotes/}
> -	done
> -	[ "$ngoff" ] && __git_shopt -u nullglob
> +	test -d "$d/remotes" && ls -1 "$d/remotes"
>  	for i in $(git --git-dir=3D"$d" config --get-regexp 'remote\..*\.ur=
l' 2>/dev/null); do
>  		i=3D"${i#remote.}"
>  		echo "${i/.url*/}"
> --=20
> 1.7.8
>
