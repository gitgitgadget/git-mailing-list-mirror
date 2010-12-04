From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git reset and ctime
Date: Fri, 3 Dec 2010 18:51:32 -0600
Message-ID: <20101204005131.GB15906@burratino>
References: <AANLkTimyYTup+PqJFJ+2g-tVwWXA2bxTT3noonEuKBSu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ghazel@gmail.com
X-From: git-owner@vger.kernel.org Sat Dec 04 01:51:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POgLy-00008L-RI
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 01:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab0LDAvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 19:51:48 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:65081 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab0LDAvs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 19:51:48 -0500
X-Greylist: delayed 154215 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2010 19:51:48 EST
Received: by gxk19 with SMTP id 19so5420848gxk.11
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 16:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=StIjTpxai7jfKBhK3K9jseRcH8OS9nZ6/+HQIpjYq/I=;
        b=vbdkn2yYZ0I1cLy4Nr9DW/x/XiutAq6qx3FRKXId5uF2l+yGVyPL6KmpBnAVTn2S5Z
         tdgxOm3As5jxHKoKRPX9ZBRfzZ0bXYNU3To4BQ/itmH1VI+o3rOTbi6gtDwcOD9Fpsus
         3o78blfusynDAN8Ne7nOmMnWfNcE1c5i3UhT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WH3bghEUYCgT1tl1Al0dirkf+wfFSfkVEUCXz7Odn1EqtRv5sBbRvpZCOt8C8t6y9W
         1/VMYQzHvpR1XmIaS6mQ2jLY/EIxioR9NMIQGUXZWLUzgPHDsx9vwZV08cnjE/KFYwwP
         WNcpaI4psgsUOfi0YMAo8sduOSs8kOUguhJsA=
Received: by 10.100.189.17 with SMTP id m17mr1984493anf.19.1291423906070;
        Fri, 03 Dec 2010 16:51:46 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id t1sm2368805ano.23.2010.12.03.16.51.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 16:51:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimyYTup+PqJFJ+2g-tVwWXA2bxTT3noonEuKBSu@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162876>

Hi Greg,

ghazel@gmail.com wrote:

> I've encountered a strange issue where "git reset --hard" insists on
> "Checking out files ..." when all that is changed is the ctime

There is a performance trade-off.  Refreshing the index requires
reading+hashing the existing file if the stat information changed;
this could be faster or slower than blindly overwriting depending on
the situation.

That said, I have no strong objection to an implicit refresh in "git
reset" (performance-sensitive scripts should be using read-tree
directly anyway).  Have you tried making that change to
builtin/reset.c?  How does it perform in practice?

>              My deploy process (capistrano) maintains a cached copy of
> a git repo, which it fetches, resets, and then hardlinks files from
> when a deploy occurs ( https://github.com/37signals/fast_remote_cache
> ). The hardlinking step is meant to save the time of copying the file.
> but hardlinking changes the ctime of the source files.

Interesting.  Setting "[core] trustctime = false" in the repository
configuration could be a good solution (no performance downside I can
think of).

Hope that helps,
Jonathan
