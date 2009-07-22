From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH v3] grep: Add --max-depth option.
Date: Wed, 22 Jul 2009 00:10:28 -0700
Message-ID: <4A66BB64.5070106@gmail.com>
References: <1248213064-1541-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBLaWVkcm93aWN6?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 09:10:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTVyK-0005k2-Cx
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 09:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbZGVHKd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 03:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbZGVHKd
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 03:10:33 -0400
Received: from mail-pz0-f203.google.com ([209.85.222.203]:53188 "EHLO
	mail-pz0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbZGVHKc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 03:10:32 -0400
Received: by pzk41 with SMTP id 41so39767pzk.33
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 00:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=elEUv5qJOP3glEBAgiJz1YZuKlDtKXyZQIP4QzQLMwQ=;
        b=jWyn4JDywrkSokog3tz+TB8ecmp06xRn4C/cguDiNel4y+au0yHjjYytGaoegCx4qT
         9c4ef75KufERycKF5xgHvCvMN9CXb0Mh4jxRJMtYNo5+0eUlCXQdSVFrGpjtDESW2I+9
         PFb/f5cpxovz1zZaUpLJU+4lAxSiwZ0MiCQeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=qIgiFgtFUOdInvE07DWTj3FwnJqX6t70u5weXmoS6B+ql6ZF0oyh/vpv25bR53g/Sk
         hfX7XpNC65XyTEHpfordHMNiGLB3PK3a5uqCndPArTjwOLBhqx2q9yZdbT/hBceyss4A
         9eNn5B3sDm9jHbT8KuESPjbkNN8iuo9kv4sds=
Received: by 10.114.192.4 with SMTP id p4mr58644waf.65.1248246631297;
        Wed, 22 Jul 2009 00:10:31 -0700 (PDT)
Received: from ?10.10.0.4? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id m6sm1376483wag.68.2009.07.22.00.10.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 00:10:30 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090629)
In-Reply-To: <1248213064-1541-1-git-send-email-michal.kiedrowicz@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123741>

Micha=C5=82 Kiedrowicz wrote:
>
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---

Would have been nice to see a comment here saying what's changed since
v2. Looks like you renamed it to --max-depth, added some new inline
functions, and fixed up the test style issues?

>
> diff --git a/builtin-grep.c b/builtin-grep.c
> index f477659..2ed2507 100644
> --- a/builtin-grep.c
> +++ b/builtin-grep.c
> @@ -52,26 +52,58 @@ static int grep_config(const char *var, const cha=
r *value, void *cb)
>  	return git_color_default_config(var, value, cb);
>  }
> =20
> +static inline int count_chars(const char *str, char c)
> +{
> +	int num =3D 0;
> +
> +	if (!str)
> +		return 0;
> +
> +	for (; *str; str++)
> +		if (*str =3D=3D c)
> +			num++;
> +	return num;
> +}
> +
> +static inline int accept_subdir(const char *path, int max_depth)
> +{
> +	return max_depth < 0 || count_chars(path, '/') <=3D max_depth;
> +}
> +

If count_chars() is only used by accept_subdir() why not just manually
inline the loop in accept_subdir()? Plus, you rightly return early if
max_depth is -1, but what if max_depth is something small like 1? Then
you still count all the slashes when you could return upon seeing the
second slash.

>
> @@ -692,6 +724,8 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
>  		OPT_SET_INT('I', NULL, &opt.binary,
>  			"don't match patterns in binary files",
>  			GREP_BINARY_NOMATCH),
> +		OPT_INTEGER(0, "max-depth", &opt.max_depth,
> +				"descend at most <n> levels"),

Please use OPTION_INTEGER here so you can use "<depth>" instead of
"<n>". This will make it more consistent with the documentation.
