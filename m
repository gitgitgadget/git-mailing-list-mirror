From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Teach git-update-index about gitlinks
Date: Fri, 13 Apr 2007 09:42:47 +0200
Message-ID: <81b0412b0704130042k1f5be3bay30cbbb6b70259f6@mail.gmail.com>
References: <Pine.LNX.4.64.0704121218130.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 09:42:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcGQl-0007GH-Uv
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 09:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652AbXDMHmt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 03:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752655AbXDMHmt
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 03:42:49 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:32283 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbXDMHms (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 03:42:48 -0400
Received: by an-out-0708.google.com with SMTP id b33so831492ana
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 00:42:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AvNefwr0rA8TtbpuiYlLESouwCrjaSZE3VYCMbJP67rrS/BktwKZHwJPYiTmGx8Hd4ljGrxaqD2O+84lSgVyc0s3V/uCMmGrOBTmJTLn1BA8yyEt0GIJJYrHZ0TYMq7v4Xo1PmgsnaHqxMBBSWrLhK1eYa8fNP4p9LuVCx4Si2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rXHp+ywQhGRwgWDtnZGuhXT0TK3avRPZtJfOCTDIJd7JvGG3dbV1TY14GbncRCYdgDrUJ2suQdqZAAKsckY9SSVSMvq2TikJ6TNB5cof+eyngoX9KSZYlr2WxT8jSPdW2470pnA75SPNlMKDbjxBJSHEzcoVSJje8Umz0ru7elY=
Received: by 10.100.165.9 with SMTP id n9mr2256500ane.1176450167547;
        Fri, 13 Apr 2007 00:42:47 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Fri, 13 Apr 2007 00:42:47 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704121218130.4061@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44392>

On 4/12/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> +static int process_lstat_error(const char *path, int err)
> +{
> +       if (err == ENOENT || err == ENOTDIR)
> +               return remove_one_path(path);
> +       return error("lstat(\"%s\"): %s", path, strerror(errno));

You forgot to change errno to err in strerror.

> +static int add_one_path(struct cache_entry *old, const char *path, int len, struct stat *st)
...
>         option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
>         option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
>         if (add_cache_entry(ce, option))
> -               return error("%s: cannot add to the index - missing --add option?",
> -                            path);
> +               return error("%s: cannot add to the index - missing --add option?", path);

return error("%s: cannot add to the index%s", path, "\0 - missing
--add option?" + !allow_add);
is be nicer. We really do know whether "--add" was passed or not.

> + *    (NOTE! This is old and arguably fairly strange behaviour.
> + *    We might want to make this an error unconditionally, and
> + *    use "--force-remove" if you actually want to force removal).
...
> +               /* Should this be an unconditional error? */
> +               return remove_one_path(path);

Makes me uncomfortable too. Is it be possible anyone is depending
on it? Maybe it still can be changed?
