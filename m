From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit: Remove backward goto in read_craft_line()
Date: Wed, 1 Dec 2010 13:44:42 -0600
Message-ID: <20101201194441.GB27347@burratino>
References: <1291230959-3894-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 20:44:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNsbo-0001Xd-Ro
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 20:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756741Ab0LATow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 14:44:52 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61543 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576Ab0LATov (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 14:44:51 -0500
Received: by vws16 with SMTP id 16so610926vws.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6JiL/lOj6clFmxicdvV7fA5oTQ0oGB4fCmsjwqlmzGA=;
        b=q4AuL0Hl3h3V7cZr3yjCFw4cb1188+NqcB6IISH5Y8baMRQQA9tb3XQilTANVSXf+V
         MY1vhkPi6zI8fLHr+wjLwFhKn/wvPmYhWY8dTdFw7mNBj4xFwRchaTfHxyaHmzfgt7L9
         rtlRU/KXfTCPHcCg5F2W4/3dGfGBGCUEHOpHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ms41FXKP/69wjtFlDd/11l8pAPIpVlf4SNAu4YqB/RgPjx0livkPXjFC5oarWyXa3a
         SPibafBAPfifA77kNJ/r7OkBjlRhWm2dolcf9utJA9LoW4BR9f6bk2+g4e/CIjyUpfEY
         OkErwCakrUj3BcHdnCn51OFhR0BJKRfkt7NEQ=
Received: by 10.220.189.9 with SMTP id dc9mr2702041vcb.9.1291232689674;
        Wed, 01 Dec 2010 11:44:49 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id fv6sm149598vbb.8.2010.12.01.11.44.48
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 11:44:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291230959-3894-1-git-send-email-ralf.thielow@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162585>

Ralf Thielow wrote:

> In case of bad graft data which is determine on many
> places we go back to the first place of detection,
> so move it to the end of the function.

I like it.  Three tiny nits.

Perhaps the log message could be clarified like so:

 bad graft data is noticed in several places in read_graft_line and
 in each case we go back to the first site of detection.  Move the
 error handling to the end of the function for better readability.

> --- a/commit.c
> +++ b/commit.c
> @@ -137,12 +137,8 @@ struct commit_graft *read_graft_line(char *buf, int len)
>  		buf[--len] = '\0';
>  	if (buf[0] == '#' || buf[0] == '\0')
>  		return NULL;
> -	if ((len + 1) % 41) {
> -	bad_graft_data:
> -		error("bad graft data: %s", buf);
> -		free(graft);
> -		return NULL;
> -	}
> +	if ((len + 1) % 41) 
> +		goto bad_graft_data;

Trailing whitespace.  (You can avoid this in the future with
"git diff --check".)

[...]
> @@ -155,6 +151,11 @@ struct commit_graft *read_graft_line(char *buf, int len)
>  			goto bad_graft_data;
>  	}
>  	return graft;
> +
> +bad_graft_data:
> +	error("bad graft data: %s", buf);

A space before the "bad_graft_data:" label would improve future
diff --show-c-function output.

Except as noted above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
---
diff --git a/commit.c b/commit.c
index d86159a..d5144f6 100644
--- a/commit.c
+++ b/commit.c
@@ -137,7 +137,7 @@ struct commit_graft *read_graft_line(char *buf, int len)
 		buf[--len] = '\0';
 	if (buf[0] == '#' || buf[0] == '\0')
 		return NULL;
-	if ((len + 1) % 41) 
+	if ((len + 1) % 41)
 		goto bad_graft_data;
 	i = (len + 1) / 41 - 1;
 	graft = xmalloc(sizeof(*graft) + 20 * i);
@@ -152,7 +152,7 @@ struct commit_graft *read_graft_line(char *buf, int len)
 	}
 	return graft;
 
-bad_graft_data:
+ bad_graft_data:
 	error("bad graft data: %s", buf);
 	free(graft);
 	return NULL;
