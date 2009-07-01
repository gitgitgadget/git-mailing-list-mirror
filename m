From: Jason Holden <jason.k.holden@gmail.com>
Subject: Re: [PATCH 2/2] Don't clean any untracked submodule's .git dir by
 default in git-clean
Date: Tue, 30 Jun 2009 21:44:01 -0400
Message-ID: <4A4ABF61.7040009@gmail.com>
References: <1246327845-22718-1-git-send-email-jason.k.holden@gmail.com>	<1246327845-22718-2-git-send-email-jason.k.holden@gmail.com>	<1246327845-22718-3-git-send-email-jason.k.holden@gmail.com>	<4A49B36D.2080103@viscovery.net>	<7vljna9nuz.fsf@alter.siamese.dyndns.org> <7vws6t490z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 03:44:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLorv-0004mK-Vv
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 03:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbZGABoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 21:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754019AbZGABoD
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 21:44:03 -0400
Received: from mail-qy0-f193.google.com ([209.85.221.193]:60189 "EHLO
	mail-qy0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbZGABoB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 21:44:01 -0400
Received: by qyk31 with SMTP id 31so708300qyk.33
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 18:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=3jMuOZzeRn2eD0fyDwWQATxy/f0K/HG1u47tjHk7ZeA=;
        b=SUp5IhJo5KHkW5pvEWqe4JTWRjLmpBbEAUspGDGD5i+NpD/IRRtHdHffZy8iUdeIB3
         pftGv6N26VDI8qPHWgcds9FP6zmcbC2kcfONWtwkO2UTN1yVdC6NiNLPDHvWTtDzzAvF
         88ZZYR8aIXa5pe5wJdRUSJzp8qyEa4sHU+lBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=p+2zRCKU0rwQApvoP6Fzj3FhTSXeXeHgqrVUq9tEzwjBiUHObq0csSiaWAZ1FqF3d5
         TYCNDIXS4bT8eYPr7i7DGZDZoM/Nxkl/g7NCpkL7HPnOUr5rBXt7uPcFX5JDBUb20JNm
         h8c6mI+bQlg9aGYDmmDro3niDPdskKDq+xiJw=
Received: by 10.224.37.66 with SMTP id w2mr8007487qad.333.1246412643304;
        Tue, 30 Jun 2009 18:44:03 -0700 (PDT)
Received: from ?192.168.1.105? (c-75-69-254-77.hsd1.nh.comcast.net [75.69.254.77])
        by mx.google.com with ESMTPS id 7sm1498903qwb.20.2009.06.30.18.44.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Jun 2009 18:44:02 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <7vws6t490z.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
OpenPGP: url=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122560>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> diff --git a/dir.c b/dir.c
> index bbfcb56..d0cfe74 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -800,12 +800,20 @@ int is_empty_dir(const char *path)
>  	return ret;
>  }
>  
> -int remove_dir_recursively(struct strbuf *path, int only_empty)
> +int remove_dir_recursively(struct strbuf *path, int flag)
>  {
> -	DIR *dir = opendir(path->buf);
> +	DIR *dir;
>  	struct dirent *e;
>  	int ret = 0, original_len = path->len, len;
> +	int only_empty = (flag & REMOVE_DIR_EMPTY_ONLY);
> +	unsigned char submodule_head[20];
>  
> +	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
> +	    !resolve_gitlink_ref(path->buf, "HEAD", submodule_head))
> +		/* Do not descend and nuke a nested git work tree. */

Add a printout here to indicate that we didn't end up removing the
directory.  Otherwise when you run git clean -f -d you just end up
with something like:
"Removing attachement_fu/"
even when we didn't actually end up removing it.  Paolo noticed this
same issue in my original patch.

> +		return 0;
> +
> +	dir = opendir(path->buf);
>  	if (!dir)

I was able to test this patch and everything seems to behave as
expected.

If this becomes the final fix, don't forget to update
Documentation/git-clean.txt

I'm leaving for vacation tomorrow, so you won't hear any more from
me until ~July 8th.  Thanks for the quick responses.

-- 
Regards,
Jason Holden
Get my PGP Key at
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x6B7FBC8D
