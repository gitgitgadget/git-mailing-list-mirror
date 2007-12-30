From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Optimize prefixcmp()
Date: Sun, 30 Dec 2007 15:50:07 +0100
Message-ID: <e5bfff550712300650j2ea70032jaca893b734592184@mail.gmail.com>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com>
	 <Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	 <e5bfff550712291239y5648b923y8d332d9c40a8c97b@mail.gmail.com>
	 <Pine.LNX.4.64.0712292307210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	 <e5bfff550712300502p543680b9jbeb9469a5a970f0@mail.gmail.com>
	 <20071230135557.GA25917@artemis.madism.org>
	 <20071230135820.GB25917@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Pierre Habouzit" <madcoder@debian.org>,
	"Marco Costalba" <mcostalba@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 30 15:50:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8zV1-00080Q-0Y
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 15:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423AbXL3OuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 09:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753125AbXL3OuK
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 09:50:10 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:58167 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362AbXL3OuI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 09:50:08 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4207050rvb.1
        for <git@vger.kernel.org>; Sun, 30 Dec 2007 06:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0jcOhLuXou+2fkse8h0cygfkTDOLBbZghu/L0VQKAOw=;
        b=cwZDhdow73g4IOtsqQehXVwjph/+YjXZJN9KV6bpaBim79pIu/29w+Xu1HdeC3AaLYIW3f7+RAM4tEuW212nAKTZXZrX7cvyem6Wao/0hXkbmuZxMzpNGGb+eGwKslSoaM+DI9kzx0sVtVJ92UYo/nYeekmmvsTdByeWRVqtLuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HDxJ3TIX3lDPZhEzQI+6C8O33tWOkW3Vb+nqWgR7XNy5b/cMOP/1ckjdWqPWajZO81vI1RTJvHForFkWI8BjEK/jVHD2Ycg7/64hT9X4fCtWHfKc9Zw6a7vFi+GRgCzril3uFDgs8Mu447FQMaLtmB9P+cIuK9SaumqTeNFRE2Y=
Received: by 10.140.148.3 with SMTP id v3mr5830615rvd.129.1199026207528;
        Sun, 30 Dec 2007 06:50:07 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 30 Dec 2007 06:50:07 -0800 (PST)
In-Reply-To: <20071230135820.GB25917@artemis.madism.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69364>

On Dec 30, 2007 2:58 PM, Pierre Habouzit <madcoder@debian.org> wrote:
> >
> >   This code doesn't work if prefix is "". You want something like:
> >
> >     for (; *prefix; prefix++, str++) {
> >         if (*str != *prefix)
> >             return *(unsigned const char *)prefix - *(unsigned const char *)str;
> >     }
> >     return 0;
>
>   Which happens to be basically the same than what Dscho wrote, though I
> suppose the compiler can compile that more efficiently than his code.
>

Yes, your version covers the *prefix == "" case too. If this case is
important for us we could use something as

static inline int prefixcmp(const char *str, const char *prefix)
{
	do {
		if (*str != *prefix)
			return (!*prefix ? 0 : *(unsigned const char *)prefix - *(unsigned
const char *)str);

		if (!*(++prefix))
			return 0;

		str++;

	} while (1);
}


But your code is *surely* nicer then this one. But, for unknown
reasons, this code happens to be faster, probably as you say the
compiler optimizes away the second check in the return statement so
that this version is slightly faster then the 'for' loop one, but
admitelly we are going to much in the academic now.

If *prefix == "" case is to be considered I vote for your/Johannes
version because it's "better code" (tm).


Marco
