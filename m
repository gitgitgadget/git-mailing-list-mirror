From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: unable to resolve reference refs/tags/v3.1-rc8: Success (Re:
 git problem)
Date: Sun, 02 Oct 2011 23:15:48 -0500
Message-ID: <4E8936F4.5060506@lwfinger.net>
References: <4E892483.7070605@lwfinger.net> <20111003035907.GA17134@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Oct 03 06:16:20 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RAZwx-0007Z1-Eo
	for glk-linux-kernel-3@lo.gmane.org; Mon, 03 Oct 2011 06:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab1JCEPy (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 3 Oct 2011 00:15:54 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55143 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab1JCEPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2011 00:15:51 -0400
Received: by iaqq3 with SMTP id q3so4562517iaq.19
        for <multiple recipients>; Sun, 02 Oct 2011 21:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vkuTYCa74V0aS0YwT4yb+Phrbu97DmUfDK/gzmFa7bA=;
        b=bdB/OSIjjWq2BtFbMkskeLNG89RVXpiFscNNQ7qkTlG1XDhZM3e2/G0wIJ7RF+jvG9
         Mg68GMiPFjt+xqAzeZd4eOB1ziB83QHPvs2OmbMFfsXu2J6pESrWV0qZeU8+9UEKfkeg
         /gDnxt+VMWCckX9Y808ywXMr6e5z25uayv18o=
Received: by 10.42.73.201 with SMTP id t9mr7066877icj.11.1317615351339;
        Sun, 02 Oct 2011 21:15:51 -0700 (PDT)
Received: from larrylap.site (cpe-65-28-92-85.kc.res.rr.com. [65.28.92.85])
        by mx.google.com with ESMTPS id fy35sm26547811ibb.4.2011.10.02.21.15.49
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Oct 2011 21:15:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <20111003035907.GA17134@elie>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182619>

On 10/02/2011 10:59 PM, Jonathan Nieder wrote:
> Hi,
>
> Larry Finger wrote:
>
>> I had my system freeze when doing a pull from Linus's repo. Since then,
>> every pull results in the following errors:
>>
>> ~>  git pull
>> error: unable to resolve reference refs/tags/v3.1-rc8: Success
>>  From git://github.com/torvalds/linux
>>   ! [new tag]         v3.1-rc8   ->  v3.1-rc8  (unable to update local ref)
>
> Could you try pulling again with
> "/path/to/git/sources/bin-wrappers/git pull" after applying this
> patch?
>
> Thanks,
>
> diff --git i/refs.c w/refs.c
> index a615043b..b15f78a4 100644
> --- i/refs.c
> +++ w/refs.c
> @@ -493,12 +493,15 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
>   		char *buf;
>   		int fd;
>
> -		if (--depth<  0)
> +		if (--depth<  0) {
> +			errno = ELOOP;
>   			return NULL;
> +		}
>
>   		git_snpath(path, sizeof(path), "%s", ref);
>   		/* Special case: non-existing file. */
>   		if (lstat(path,&st)<  0) {
> +			int saved_errno = errno;
>   			struct ref_list *list = get_packed_refs(NULL);
>   			while (list) {
>   				if (!strcmp(ref, list->name)) {
> @@ -509,6 +512,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
>   				}
>   				list = list->next;
>   			}
> +			errno = saved_errno;
>   			if (reading || errno != ENOENT)
>   				return NULL;
>   			hashclr(sha1);
> @@ -562,7 +566,8 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
>   			*flag |= REF_ISSYMREF;
>   	}
>   	if (len<  40 || get_sha1_hex(buffer, sha1))
> -		return NULL;
> +		die("ref %s is corrupt: length=%d, content=%.*s", ref,
> +		    (int) len, (int) len, buffer);
>   	return ref;
>   }

After applying that patch, I get

finger@larrylap:~/linux-2.6> ~/git/git pull
fatal: ref refs/tags/v3.1-rc8 is corrupt: length=41, content=

Larry
