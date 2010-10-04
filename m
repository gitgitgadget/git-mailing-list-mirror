From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: checkout/temporary branch switch restoring modification
 times
Date: Mon, 4 Oct 2010 00:11:48 -0500
Message-ID: <20101004051148.GG24884@burratino>
References: <4CA95B18.5090008@cockos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Justin Frankel <justin@cockos.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 07:15:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2dOL-0005rx-JZ
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 07:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128Ab0JDFPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 01:15:05 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36661 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab0JDFPE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 01:15:04 -0400
Received: by gxk9 with SMTP id 9so1554985gxk.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 22:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RpduE9zk6JhxfJ1NK2iqNCcnyQPlnjHknR2SVxHZHQw=;
        b=sTsFmulJlPfUmrCsuTdYzcMicbPrEiMhelhadbEnN2hH0vbYRQiW+EheqM9+AxSu3g
         xSbJJSCd9UolXLDNOWXIV3AheBq2taGpFWfySgTHVam/K6NL9H3sA1Yp3ImzqoiBJdhq
         GdGSFZzrBu6b/DSoIXrQI8W6Qwd6UcwUrenX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=d2goZSG3XZqS1Cm8aRFCJuZ/yioN0DV7Jalyux/oQwp6J8xutvvndGg2tXnLsb7j7u
         HR+B6kmaV87t7UaUCBZKXxoUHy4lFbDVvKNXrpKOTP2W1dylcnfmJDTt80Vy1jhou/Fb
         mI2/UZiAQfWfKxrXQaa2wJjaBkrQE5y2PBzIM=
Received: by 10.100.142.5 with SMTP id p5mr4976349and.50.1286169303197;
        Sun, 03 Oct 2010 22:15:03 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id q7sm8455300anf.26.2010.10.03.22.15.01
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 22:15:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CA95B18.5090008@cockos.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157978>

Hi,

Justin Frankel wrote:

> git cop master
> ; build
> git cop some-branch-that-affects-lots-of-files
> ; edit some things, commit
> git cop master
> ; build (fast, nothing changed)

Interesting.  I guess the intended use is that you only ever build
on the master branch?

Have you ever tried the contrib/workdir/git-new-workdir script?
I find it fits the use case well for me:

 git clone $repo
 cd repo
 make
 # oh, shoot! I need to try something out real quick.
 cd ..
 git new-workdir repo repo2 origin/master
 cd repo2
 git am patch-to-test
 make
 # okay, back to what I was doing...
 cd ../repo

Maybe it could be helpful for you, too?

Limitations:

 - requires a file system with support for symbolic links
   (I think Pierre Habouzit and Junio discussed changing
   that);

 - workdirs share refs.  If you update master in one
   workdir and another workdir also has master checked
   out, the new changes will appear as staged changes.

 - workdirs do not share HEAD.  "git gc" from one
   workdir can completely trash another if it has a
   detached HEAD pointing to a commit that is not part
   of any local or remote branch.
