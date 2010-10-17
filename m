From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Trim ending whitespaces in exclude file if needed.
Date: Sat, 16 Oct 2010 21:41:33 -0500
Message-ID: <20101017024133.GF26656@burratino>
References: <AANLkTinUHQzuLJhZnVMKngEO75W=+5sES0WZFAFw5bDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Vasyl' <vvavrychuk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 04:45:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7JFV-0000pd-7o
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 04:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757248Ab0JQCpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 22:45:07 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56108 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757228Ab0JQCpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 22:45:06 -0400
Received: by ywi6 with SMTP id 6so909139ywi.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 19:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/mY8fTRdZnNXzv69MVXRO2OYQVUi/ZngYiTaD0ncUDg=;
        b=frSatlcF+QSoBl4HYvE8tQbZMferxSu+dsc2umdYy1JZ3VtOTva/bQJyYE7PJjvuFY
         GNpSExS2M/lfT3SUpyulGY8taOOYjKNmV1L5z7RswRjTSBNkc95j6oCifbjYNXqc0jxB
         PlKgBVieNN76u2s020b8OxWZKIancxFxckhUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fRwHH0QaO1yDzwBH1TlzEl2jK0zfxk3HZ2E4vogEarx8mQq/YjJ8/RXiEagZOGAs+X
         kqlWIvHj3mgRhTwNbZDuW1PzAZWZufJvuVVJ8L+h+rG9zBWFByF0CtbdQVs4/RPYn3ht
         PpZ0mMdsQW5C27LY6pXFgxijbW1zbtArWENjo=
Received: by 10.236.110.44 with SMTP id t32mr3847251yhg.60.1287283506005;
        Sat, 16 Oct 2010 19:45:06 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id i70sm5762633yha.22.2010.10.16.19.45.04
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 19:45:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinUHQzuLJhZnVMKngEO75W=+5sES0WZFAFw5bDw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159188>

(+cc: msysgit)

Vasyl' wrote:

> Hope this can save someone's time debugging git.

It sounds like there's a story behind this one.  Could you tell it?
That would help future readers of this code to easily determine
why they shouldn't break it.

> --- a/dir.c
> +++ b/dir.c
> @@ -171,7 +171,15 @@ void add_exclude(const char *string, const char *base,
>  		to_exclude = 0;
>  		string++;
>  	}
> +

Why?

>  	len = strlen(string);
> +	if (len && isspace((unsigned char)string[len - 1])) {

This cast is not needed (see git-compat-util.h).

> +		struct strbuf trim_buf = STRBUF_INIT;
> +		strbuf_add(&trim_buf, string, len);
> +		strbuf_rtrim(&trim_buf);

Missing free(string)?

> +		string = strbuf_detach(&trim_buf, &len);
> +	}
> +
>  	if (len && string[len - 1] == '/') {

Thanks for a clear and pleasant read.
Jonathan
