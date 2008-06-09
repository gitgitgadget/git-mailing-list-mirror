From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] cat-file --batch / --batch-check: do not exit if hashes
 are missing
Date: Mon, 09 Jun 2008 20:21:09 +0200
Message-ID: <484D7495.3020407@gmail.com>
References: <1212967717-5165-1-git-send-email-LeWiemann@gmail.com> <484D3CCB.1000508@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 20:22:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5m0V-0000yr-CI
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 20:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbYFISVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 14:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbYFISVS
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 14:21:18 -0400
Received: from gv-out-0910.google.com ([216.239.58.187]:24920 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbYFISVR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 14:21:17 -0400
Received: by gv-out-0910.google.com with SMTP id e6so560599gvc.37
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=CTKysCkfXJhtiDt3LOsguLl01AkHerudMxmxSnLD97o=;
        b=Xpg1uitAelt1Rjy9phPKr3BWR9rGhQLPWKR+nE/qdgLPaN154Sr2YOXBARXKWWzLLJ
         P+YoRLYqQCPNrG6aguMVmM3L0jfQar9KCZfsnHknyMxtU1tYD2ZlDIetrSYeaj02w8Bx
         +S+Ll4fvhyOYp9LTIAZxwoKGd1wo3ozjNLPK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=NExzLNOZxG0OPdjSRhwldD+7+tYnqDX7FF3AnzgvYVa6Vy692XAub5YIe11PyezKI8
         Hs90Vt6sE6IUeSdJdxopDyYCzc+qxkLVdkh94eq/mc6lEbs08QA0sRP0xzr8mNYlOv6S
         DHp1x0/LXaxYGnUYuyXGg+IOX0pTnNIS725w4=
Received: by 10.103.17.10 with SMTP id u10mr2620909mui.76.1213035675429;
        Mon, 09 Jun 2008 11:21:15 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.245.180])
        by mx.google.com with ESMTPS id j10sm17506372muh.18.2008.06.09.11.21.12
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Jun 2008 11:21:13 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <484D3CCB.1000508@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84408>

Johannes Sixt wrote:
> With this change an invalid name and a non-existing SHA1 are treated as
> "missing". But an empty name is still an error  [...]: It is the first thing
> that the function checks, and there it exits with return 1.

An empty object name is actually not an error but just yields "SP 
missing".  The "if (!obj_name) return 1;" statement doesn't dereference 
obj_name, so it checks for null pointers.  However, batch_one_object 
gets called with buf.buf as its obj_name parameter, which according to 
api-strbuf.txt is never NULL.  So probably the check is pointless and 
can be removed (the tests still pass); someone more knowledgeable than 
me should confirm this though.

(FWIW, perhaps the original author intended to catch empty input this 
way, but I'm not convinced that this is even sensible.)

Unrelatedly, does anyone know how to stop sha1_object_info from barfing 
on non-existent hashes?  It causes the annoying "error: unable to find 
000..." on stderr if you run "echo 
0000000000000000000000000000000000000000 | git-cat-file --batch-check".

-- Lea
