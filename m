From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: Three issues from a Subversion-to-git migration
Date: Mon, 29 Mar 2010 11:57:32 -0400
Message-ID: <4BB0CDEC.8000708@gmail.com>
References: <20100326120906.F03BB20CD21@snark.thyrsus.com> <201003291100.13043.trast@student.ethz.ch> <20100329091056.GC10538@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Mar 29 17:57:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwHLb-0006Ac-9b
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 17:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332Ab0C2P5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 11:57:41 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47350 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324Ab0C2P5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 11:57:40 -0400
Received: by pwi5 with SMTP id 5so6699423pwi.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=TpFe5+uHWargDSXQzyp5QWZMHuMsHbWZVHjmlnrDO3A=;
        b=V8yUkkKHWOrvaZiFBggARIpP63IZtVk4FpWHEeudQ3dy+ktlIFow6cztnqLpJPLoWv
         y4SVdIOgQw77vW7gHBlXpJTP8YruV2t7yDfPFqH9Gf9QCA4cMWrPyhiXOVAjPoH9X6Gt
         60BDyW6VpyN6IK+CbDnpfZAXFvRm/HNLSAqBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=njkft6WlsR+vj0lBbQWdegNtYCbv2RfW1mndZlj5+ff2loF2tEBxpaJVEKsdbgjzAD
         5PG/JnqS5bzHxNeUl/nUSr8x+dlIEswwt1+gPIo6RgvUvIsIdWCv93bcrs6/n/D0OHUB
         lBxseoW3eqDl2vTSyVXBjCaBjLH7RpnZPaQr4=
Received: by 10.140.83.31 with SMTP id g31mr823301rvb.3.1269878259284;
        Mon, 29 Mar 2010 08:57:39 -0700 (PDT)
Received: from [10.145.1.205] (smtpin.revolutionlinux.com [69.70.10.188])
        by mx.google.com with ESMTPS id b17sm1373341rvf.8.2010.03.29.08.57.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 08:57:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
In-Reply-To: <20100329091056.GC10538@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143486>

Hello,

On 2010-03-29 05:10, Eric Raymond wrote:
> Thomas Rast <trast@student.ethz.ch>:
>> Eric Raymond wrote:
>>> 2. The git-svn migration logic does not handle unmodified SVN tag
>>> trees well.
>>
>> The problem here is that git-svn is designed to handle incremental
>> updates, where it can't know whether some insane SVN user decides to
>> modify the tag later on.
> 
> Yes.  Ideally, I suppose, git-svn (or whatever replaces it) would have
> behavior something like this:
> 
> 1. Turn unmodified tag directories into git tags
> 2. Turn odified tags into branches.
> 3. Recognize when a formerly unmodified tag has been modified, remove
>    the git tag, and turn it into a branch.
>  

The 3rd point seems a bit weird to me.. users don't expect tags to
disappear magically. Especially if it's done during a fetch while working.

Here's how I would change the scenario:

1. For each creation of a sub-directory in SVN's tag directory, create a
git tag on the revision that was referenced by the directory copy in SVN.
2. If (and only if) there are later modifications in the tag directory,
create a branch starting from that tag.

This way, the tag would be there but a branch would hold modifications
based on code at this point, if there is any.

The problem with my scenario, though is that it doesn't take care of tag
creation + modification in the same commit (yuukkkk, but it's possible
that it exists somewhere). If it could be possible to verify if
modifications were made during the tag creation, then we could make the
case hit both points.

The other big "thing" is that it expects a certain correct separation
into different directories (e.g. trunk/ tags/ branches/ ), which SVN
doesn't enforce.

-- 
Gabriel Filion
