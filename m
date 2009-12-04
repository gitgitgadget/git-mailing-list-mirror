From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v2 1/8] Pass unknown protocols to external protocol
	handlers
Date: Fri, 4 Dec 2009 09:55:45 -0800
Message-ID: <20091204175545.GC1483@spearce.org>
References: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi> <1259942168-24869-4-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Dec 04 19:02:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGcUP-0000o5-Om
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 19:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbZLDSCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 13:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbZLDSCd
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 13:02:33 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:51531 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264AbZLDSCc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 13:02:32 -0500
Received: by yxe17 with SMTP id 17so2300971yxe.33
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 10:02:39 -0800 (PST)
Received: by 10.101.113.11 with SMTP id q11mr456872anm.178.1259949348585;
        Fri, 04 Dec 2009 09:55:48 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 5sm1625318yxg.64.2009.12.04.09.55.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 09:55:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1259942168-24869-4-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> Change URL handling to allow external protocol handlers to implement
> new protocols without the '::' syntax if helper name does not conflict
> with any built-in protocol.
> 
> foo:// now invokes git-remote-foo with foo:// URL.
...

Uh, great, but...

> @@ -30,6 +50,7 @@ static struct child_process *get_helper(struct transport *transport)
>  	const char **refspecs = NULL;
>  	int refspec_nr = 0;
>  	int refspec_alloc = 0;
> +	int duped;
>  
>  	if (data->helper)
>  		return data->helper;
...
> +	/* Open the output as FILE* so strbuf_getline() can be used.
> +	   Do this with duped fd because fclose() will close the fd,
> +	   and stuff like disowning will require the fd to remain.
> +
> +	   Set the stream to unbuffered because some reads are critical
> +	   in sense that any overreading will cause deadlocks.
> +	*/
> +	if((duped = dup(helper->out)) < 0)
> +		die_errno("Can't dup helper output fd");
> +	data->out = xfdopen(duped, "r");
> +	setvbuf(data->out, NULL, _IONBF, 0);
> +

This is an entirely unrelated change.  Please split it into its
own commit so its easier to review, test, blah blah blah.

-- 
Shawn.
