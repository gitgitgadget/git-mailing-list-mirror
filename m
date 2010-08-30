From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 11/13] remote-curl: accept empty line as terminator
Date: Sun, 29 Aug 2010 20:39:28 -0500
Message-ID: <20100830013928.GE2305@burratino>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-12-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 03:41:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OptN8-00088v-3T
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 03:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486Ab0H3BlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 21:41:13 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59355 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391Ab0H3BlM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 21:41:12 -0400
Received: by ywh1 with SMTP id 1so1485072ywh.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 18:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1uiOvGQadByoFhRDldk8XdDJZY5MkRQlGrhBv+17Iq8=;
        b=BTXOZgGosZuWt6putYz+EzwY3GYtSfBIy16bl27VqQ06//hjt3OvD2mJKTzohnMSA5
         SbzwUgHx89u0Guwbtf/ODQBsiWzl7/ZCooxFyjHdvMF2VdL2ntdrMVt6pb1tMh93ba7p
         3u4iSyLls0XL+nItCRu/5RB1H19wgyeHzVVp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HUbZ3EqN0S1iMo3+xlybnPyNpsmxu+kxh3KpODPCTFfNV2VHP1SgCVxgpAa27fCNjJ
         wOvXJt9C4op3w12tMW1vQSnoU+uh6clA/sACYxJbfS2R7FERoWIOFGqCCaTrJheX+Aag
         PGPxpYE4AfcovDkAu3XH4Lx0McUTd9li6Zjs4=
Received: by 10.151.10.6 with SMTP id n6mr4585682ybi.333.1283132471844;
        Sun, 29 Aug 2010 18:41:11 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id x3sm2092822ybl.22.2010.08.29.18.41.10
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 18:41:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283053540-27042-12-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154741>

Sverre Rabbelier wrote:

>   I noticed this when my tests suddenly broke. Bisecting pointed at
>   the 'more rigorous return value checking' patch

Shouldn't this go before "check status code of finish_command" for
bisectability, then?

>   I'm not very sure about the error message, if anyone feels it
>   should go (it indicates a bug in the remote helper infrastructure,
>   not a user error) it can be left out as far as I'm concerned.

No preference here.

> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -813,6 +813,8 @@ int main(int argc, const char **argv)
>  	do {
>  		if (strbuf_getline(&buf, stdin, '\n') == EOF)
>  			break;
> +		if (buf.len == 0)
> +			break;

This is just a bug, I think.  Other strbuf_getline() invocations in
that file all use the equivalent

	if (*buf->buf)
		break;

too.
 
> @@ -851,6 +853,7 @@ int main(int argc, const char **argv)
>  			printf("\n");
>  			fflush(stdout);
>  		} else {
> +			fprintf(stderr, "Unknown command '%s'\n", buf.buf);
>  			return 1;
>  		}

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
