From: Iain Paton <ipaton0@gmail.com>
Subject: Re: git no longer prompting for password
Date: Sun, 26 Aug 2012 10:57:59 +0100
Message-ID: <5039F327.9010003@gmail.com>
References: <5037E1D0.6030900@gmail.com> <20120824212501.GA16285@sigill.intra.peff.net> <5038E781.1090008@gmail.com> <20120825203904.GA10470@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 12:05:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5ZiE-0002Yo-Fq
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 12:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814Ab2HZKEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 06:04:45 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:49771 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794Ab2HZKE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2012 06:04:27 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Aug 2012 06:04:26 EDT
Received: by wgbdq11 with SMTP id dq11so1718418wgb.5
        for <git@vger.kernel.org>; Sun, 26 Aug 2012 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=CGQrTVe5blc/y+wYcv+PHCLjMaqFpBUCn04rCOgfR4w=;
        b=AlElW3hy2QOUvYN6XA+DCcAf0rRO89lj2yRlwIzOYTE5zTOiPFlwKdoIMFxinZtbbf
         303f1w2jGzaqBYpfTHiocum/ZS+ryznsM7CJtZHaw1DCgZZjcFP4s0p7zZ1f4GyITTYg
         qiWLvg0SukhlJo2ZrkNJt7vYNM+QsyIRVeeQu1lhdN2wvLFu+no4EsYycQR23h2FLOiw
         XlsP/IhPP87XzTxAXSC79ibcb5hwWv6denyQFiMbNYB/JwZdxa8peafn5vkof07WJ/pf
         1gTuIXx1aXxIpQzaQLP96ok9WwnX8TcznsjuIVZckW0bnEdtVr2tXk/IAMHXquI0mZvO
         uIwg==
Received: by 10.180.105.130 with SMTP id gm2mr17593970wib.6.1345975113618;
        Sun, 26 Aug 2012 02:58:33 -0700 (PDT)
Received: from [10.44.16.58] (hades.darkvoyage.org.uk. [81.187.177.1])
        by mx.google.com with ESMTPS id o2sm12595920wiz.11.2012.08.26.02.58.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 26 Aug 2012 02:58:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <20120825203904.GA10470@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204295>

On 25/08/12 21:39, Jeff King wrote:

> I think your regex is the culprit. The first request comes in with:
> 
>>> GET /git/test.git/info/refs?service=git-receive-pack HTTP/1.1
> 
> The odd URL is because we are probing to see if the server even supports
> smart-http. But note that it does not match your regex above, which
> requires "/git-receive-pack". It looks like that is pulled straight from
> the git-http-backend manpage. I think the change in v1.7.8 broke people
> using that configuration.

Yes, it was lifted straight out of the manpage, albeit a couple of years 
ago now and there have been additions to the manpage since then. 
I did check, and the basic config is identical in the current manpage.

I can't be the only one using a config that's based on the example in 
the manpage surely ?  So I'm surprised this hasn't come up previously.


> I tend to think the right thing is to fix the configuration (both on
> your system and in the documentation), but we should probably also fix
> git to handle this situation more gracefully, since it used to work and
> has been advertised in the documentation for a long time.

So after some head scratching trying to work out how to do the equivalent of 
LocationMatch but on the query string I came up with the following:

ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/

<Directory /usr/libexec/git-core>
        Require ip 10.44.0.0/16
        <If "%{THE_REQUEST} =~ /git-receive-pack/">
                AuthType Basic
                AuthUserFile /data/git/htpasswd
                AuthGroupfile /data/git/groups
                AuthName "Git Access"

                Require group committers
        </If>
</Directory>

and I've removed the LocationMatch section completely.

So for accesses to git-http-backend I require auth if anything in the request 
includes git-receive-pack and that causes a prompt for the username/password 
as required, while at the same time it still allows anonymous pull.

It appears that the clone operation uses

GET /git/test.git/info/refs?service=git-upload-pack HTTP/1.1

to probe for smart-http ?  So this would be ok ?

I'm not sure this is ideal, I don't really know enough about the protocol to know 
if I'll see git-receive-pack elsewhere. Possibly if someone includes it in the 
name of a repo it'll blow up in my face.
I can always change it to match only on QUERY_STRING and put the LocationMatch 
back in if that happens.

If that's all that's required, I'm fine with an easy change to httpd.conf

Thanks for the help Jeff.
