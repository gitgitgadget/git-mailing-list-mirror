From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] git-bundle: avoid packing objects which are in the prerequisites
Date: Thu, 08 Mar 2007 15:36:41 -0500
Message-ID: <45F073D9.7060209@gmail.com>
References: <45ECEB40.4000907@gmail.com> <7vejo2stlw.fsf@assigned-by-dhcp.cox.net> <45EE1242.8080405@gmail.com> <7vhcsxkb8n.fsf@assigned-by-dhcp.cox.net> <45EE2ECA.60403@gmail.com> <Pine.LNX.4.63.0703070419410.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45EE36A1.30001@gmail.com> <Pine.LNX.4.63.0703070504140.22628@wbgn013.biozentrum.uni-wuerzburg.de> <30e4a070703070834s3dd5bdd7x2e1639aa2979d1cf@mail.gmail.com> <Pine.LNX.4.63.0703072330200.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vfy8geikk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703080039420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 08 21:36:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPPLx-0005H4-3d
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 21:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbXCHUgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 15:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933045AbXCHUgk
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 15:36:40 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:55349 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244AbXCHUgj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 15:36:39 -0500
Received: by an-out-0708.google.com with SMTP id b33so584875ana
        for <git@vger.kernel.org>; Thu, 08 Mar 2007 12:36:39 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RUgqfu0+l7avoZB4aWicRN6F+lWtvAt3BO0RK1VGzPagSzgNxv2ZxcgtpY7rIAY3/figvapa+Zz+qojDSYGFwJMLFAP6xpto8p3OmFbUTWPfWKGTI6ipZ/IWwEaDlz53IAE50ypj3V8eOSm20vwz4r1g4xjFT50OSFmYSDAWCF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=KFFubW6BXCTp/k7k7MOiunJOkcyg9YmsUq4WuYco5cmeeGzSy6nYs5L5yReBRO89Fq7aZh9yTPqkmH/G8PgpTltCOcQCV/ljPmhVY/BONJ5hLf0g5PAYGl1APraHIn9/6fJ87usJduzAMX3DSdlXoqemUKZ0gv482B4A3OcQrPc=
Received: by 10.100.197.15 with SMTP id u15mr653870anf.1173386199010;
        Thu, 08 Mar 2007 12:36:39 -0800 (PST)
Received: from ?192.168.1.8? ( [209.168.216.145])
        by mx.google.com with ESMTP id c39sm3607921anc.2007.03.08.12.36.37;
        Thu, 08 Mar 2007 12:36:38 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <Pine.LNX.4.63.0703080039420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41771>

Johannes Schindelin wrote:

Using next (2432cbc253e8ef5cf09062abb8f7325813476d1d) that has your 
patches for creating a thin-pack and limiting objects, I generally find 
the bundle file created cannot be used.

Specific example you can repeat in a current git repo:

git>git branch foo 2432cbc253e8ef5c
git>git bundle create t.bdl foo~1..foo
Generating pack...
Done counting 20 objects.
Result has 14 objects.
Deltifying 14 objects.
 100% (14/14) done
Writing 14 objects.
 100% (14/14) done
Total 14 (delta 10), reused 10 (delta 6)
git>git fetch t.bdl
fatal: pack has junk at the end
error: index-pack exited with status 128
fatal: Fetch failure: t.bdl
git>


Also, we get an interesting failure if the references are not touched in 
a given date range:
git>git bundle create t.bdl --since=5.minutes.ago foo
warning: ref 'foo' is excluded by the rev-list options
Generating pack...
Done counting 38321 objects.
Deltifying 38321 objects.
 100% (38321/38321) done
Writing 38321 objects.
 100% (38321/38321) done
Total 38321 (delta 26678), reused 38180 (delta 26551)
git>

No references requies 38000+ objects?? In this case, the bundle includes 
every object in the repository, the exact opposite of what should happen 
(zero objects).

Mark
