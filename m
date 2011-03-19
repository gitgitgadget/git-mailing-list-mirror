From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/9] vcs-svn: implement perfect hash for top-level keys
Date: Sat, 19 Mar 2011 03:57:37 -0500
Message-ID: <20110319085737.GC6706@elie>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300518231-20008-5-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 09:57:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0ryr-0004VU-Jm
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 09:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab1CSI5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 04:57:49 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39724 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564Ab1CSI5s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 04:57:48 -0400
Received: by iyb26 with SMTP id 26so4786314iyb.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 01:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7aJQBDXEbeof4Zohn3LQUYa39GkLpjoGQiorHvhgRaw=;
        b=LjUylUk1X94KwFrvalYbzxw6NWdtkR9c2FYNo330PaXtttA+VtcdSC81AfLgLDC5Rd
         ZA0Yic7he9uZKY6fA4HLWKCsqAatyafXIu5UnmnZg8RaSK9nRHou1JiDoDCmeH7ZQ2ip
         2XZcvnZKJg1D3Q67KBBConkr3KS4rrabxt4VI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rfL7mwQb5FtBtCvpnk4NvUaF38w2rhyLTzUiL2f/Tjltgz9hmxlQkEvvyywrmYyVSL
         chHsF6nz1xTstxfLTckGN3uHLlOCY/cyO7Wvdu5zE1kEQ/zcDhIXKBKxQ00NqaeaaJTa
         lVXmrVbQes2/qWG1HhuWZJYhR7+bUvVP6oDS8=
Received: by 10.42.137.130 with SMTP id y2mr504919ict.486.1300525067765;
        Sat, 19 Mar 2011 01:57:47 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id vr5sm235262icb.12.2011.03.19.01.57.42
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 01:57:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300518231-20008-5-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169418>

David Barr wrote:

> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -323,16 +296,25 @@ void svndump_read(const char *url)
>  			continue;
>  		*val++ = '\0';
>  		*val++ = '\0';
> -		key = pool_intern(t);
>  
> -		if (key == keys.svn_fs_dump_format_version) {
> +		/* strlen(key) */
> +		switch (val - t - 2) { 
> +		case 26:
> +			if (memcmp(t, "SVN-fs-dump-format-version", 26))
> +				continue;

Same comments as the previous patch apply here.

Might make sense to split out the loop body (or at least the giant
switch statement) as a separate function for easier contemplation.

[...]
> -		} else if (key == keys.content_length) {
> +			break;
> +		case 14:
> +			if (memcmp(t, "Content-length", 14))
> +				continue;
>  			len = atoi(val);

Thanks for a very clean patch.
