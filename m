From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Avoid unportable nested double- and backquotes in shell
 scripts.
Date: Sat, 8 Jan 2011 12:22:01 -0600
Message-ID: <20110108182201.GB29788@burratino>
References: <20110108090105.GB14536@gmx.de>
 <20110108161441.GA28898@burratino>
 <20110108162353.GB4786@gmx.de>
 <20110108164825.GC28898@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 08 19:22:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbdQd-0000sa-PT
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 19:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498Ab1AHSWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 13:22:10 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44577 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab1AHSWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 13:22:09 -0500
Received: by gxk9 with SMTP id 9so4524566gxk.19
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 10:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DtchuRQaXGrwq0NVGHMNa/GXSTC/HbPlb+yWp5KL4pY=;
        b=oGhQZpcp8pcBnpi4XM6f3/DR1yEZ29AhRx0zpFMBbOQwQ4+dqQl5ZNgBz+F0ClNPAv
         Rn9qCrlxv2MOwSAgwozwsT/cLfejlqrPN+1ygxWfDaa8SNcC131SZJZxy7TpkmLDKLGj
         4LYNNc9B/wmZCTqA3Yi2fgIUiRJ8w1P6x3wxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=u21rA0lGFda0cqFlUznG7ULaAJm/X8fFtdmUS9wCyUHrnGt1+eJT86MgeM2JdybbaF
         F9q+UtrfJaPgrLA2kX5My1jeuR7EXEvrlAOIbxenje/NPxIzuq/tY0QEl93Fwl527tzT
         oHzZ4iicgOAqLsYLlJ9aAVny758VY4xbYpxOo=
Received: by 10.151.43.7 with SMTP id v7mr26255787ybj.201.1294510928251;
        Sat, 08 Jan 2011 10:22:08 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id v4sm1178822ybe.5.2011.01.08.10.22.06
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 Jan 2011 10:22:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110108164825.GC28898@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164835>

Jonathan Nieder wrote:

> From a quick grep, it seems you are right:
> 
>  $ git grep -c -F -e '`' -- 't/*.sh' | cut -d: -f2 | sum
>  65126     1
>  $ git grep -c -F -e '$(' -- 't/*.sh' | cut -d: -f2 | sum
>  64807     1
>  $ git grep -c -F -e '`' -- '*.sh' | cut -d: -f2 | sum
>  13350     1
>  $ git grep -c -F -e '$(' -- '*.sh' | cut -d: -f2 | sum
>  07810     1

sum does something totally different than I expected.  With [1]
comes the more reasonable

 $ git grep -c -F -e '`' -- 't/*.sh' | cut -d: -f2 | addup
 485
 $ git grep -c -F -e '$(' -- 't/*.sh' | cut -d: -f2 | addup
 2620
 $ git grep -c -F -e '`' -- '*.sh' | cut -d: -f2 | addup
 594
 $ git grep -c -F -e '$(' -- '*.sh' | cut -d: -f2 | addup
 3133

So the code bloat and use of backticks are less dire than I feared.

[1] 
	addup () {
		sum=0
		while read term
		do
			: $((sum = $sum + $term))
		done
		echo $sum
	}
