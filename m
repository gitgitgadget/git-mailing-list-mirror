From: Brandon Casey <drafnel@gmail.com>
Subject: Re: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 10:00:42 -0700
Message-ID: <CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>
	<CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
	<004701cd771e$21b7cbb0$65276310$@schmitz-digital.de>
	<CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com>
	<01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de>
	<7v628epzia.fsf@alter.siamese.dyndns.org>
	<000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de>
	<7vy5l9lj6m.fsf@alter.siamese.dyndns.org>
	<001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de>
	<7v4nnxld24.fsf@alter.siamese.dyndns.org>
	<002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	rsbecker@nexbridge.com
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:00:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4EIW-0000Ol-Te
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 19:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933151Ab2HVRAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 13:00:44 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:61077 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932992Ab2HVRAn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 13:00:43 -0400
Received: by vbbff1 with SMTP id ff1so1265164vbb.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=m7Lzov6XyqtNSTRKBjQjB+MIOiIr7uSOPAvnpXd0xpU=;
        b=J1TtOp4ojC6tZ5pPJ46nWtjLJ7HKSTvBxk3gBJo8bxCbqf1ZKNqEkUj+3gI1HLK7gQ
         cc1UjuLfPGj895i3CAI/mIfGCNDJS5BWz925QwqQh9RvvpY3V8Y107azaVxNBngZkdHC
         nJVnYXTimDvn1jhXiJR2u/n0OySbMxRCHyVImpvjALmXVaV+UwP+lHAUyKEF9mSzZuiX
         m7VsIoqthoP9jOsQ6K1uSBgK3sanlyyLulwXybf1Lo/j7+8JehWwdP+v30kkOSQlNGmS
         0F7UU1z84ZK+PCcT4hy7Kc4pWBlTwOQJE+qtbYCUsro4cK5KwMbHBAWfwtPdRpsn24NZ
         6mtg==
Received: by 10.52.176.194 with SMTP id ck2mr12306332vdc.29.1345654842208;
 Wed, 22 Aug 2012 10:00:42 -0700 (PDT)
Received: by 10.58.29.233 with HTTP; Wed, 22 Aug 2012 10:00:42 -0700 (PDT)
In-Reply-To: <002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204032>

On Wed, Aug 22, 2012 at 9:30 AM, Joachim Schmitz
<jojo@schmitz-digital.de> wrote:

> OK, so how about this:
> /usr/local/bin/diff -EBbu ./compat/mkdir.c.orig ./compat/mkdir.c
> --- ./compat/mkdir.c.orig       2012-08-21 05:02:11 -0500
> +++ ./compat/mkdir.c    2012-08-21 05:02:11 -0500
> @@ -0,0 +1,24 @@
> +#include "../git-compat-util.h"
> +#undef mkdir
> +
> +/* for platforms that can't deal with a trailing '/' */
> +int compat_mkdir_wo_trailing_slash(const char *dir, mode_t mode)
> +{
> +       int retval;
> +       char *tmp_dir = NULL;
> +       size_t len = strlen(dir);
> +
> +       if (len && dir[len-1] == '/') {
> +               if ((tmp_dir = strdup(dir)) == NULL)
> +                       return -1;
> +               tmp_dir[len-1] = '\0';
> +       }
> +       else
> +               tmp_dir = (char *)dir;
> +
> +       retval = mkdir(tmp_dir, mode);
> +       if (tmp_dir != dir)
> +               free(tmp_dir);
> +
> +       return retval;
> +}

Why not rearrange this so that you assign to dir the value of tmp_dir
and then just pass dir to mkdir.  Then you can avoid the recast of dir
to (char*) in the else branch.  Later, just call free(tmp_dir).  Also,
we have xstrndup.  So I think the body of your function can become
something like:

   if (len && dir[len-1] == '/')
       dir = tmp_dir = xstrndup(dir, len-1);

   retval = mkdir(dir, mode);
   free(tmp_dir);

-Brandon
