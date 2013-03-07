From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Re: Questions/investigations on git-subtree and tags
Date: Thu, 7 Mar 2013 17:09:10 +0100 (CET)
Message-ID: <1027208424.206728.1362672550530.JavaMail.root@openwide.fr>
References: <CALeLG_noUfcOZ8gUjqftz8sfWiWdXP3kZUjkRNJ4W=_J+V70rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Thu Mar 07 17:09:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDdNz-0007un-Tp
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 17:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358Ab3CGQJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 11:09:13 -0500
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:37491 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830Ab3CGQJM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 11:09:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 36AD5280B8;
	Thu,  7 Mar 2013 17:09:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qce54pdlMaWy; Thu,  7 Mar 2013 17:09:10 +0100 (CET)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id A4D3E2804A;
	Thu,  7 Mar 2013 17:09:10 +0100 (CET)
In-Reply-To: <CALeLG_noUfcOZ8gUjqftz8sfWiWdXP3kZUjkRNJ4W=_J+V70rw@mail.gmail.com>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC25 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217599>

> 
> I think I tried adding the ^{} syntax, but I don't think it works on
> remote repos. Or I couldn't get the right syntax.
> 

indeed, it doesn't work on fetch, but it could be used somewhere between the fetch and the commit-tree to move from the ref to the associated commit




> 
> Latest patch:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/217257
> 

oh, that patch, yes I found it while looking around it is a step in the right direction but it doesn't help in my case since i'm using a valid remote ref that can be fetched

(on a side note you could use git ls-remote to check for the remote ref and avoid a fetch in case of an incorrect ref, but that's just a detail)



I just tested with it and here is what happens

git subtree add --squash -P br2 git://git.buildroot.net/buildroot 2013.02 => works ok, br2 is created

however the message of the squash commit is 


    Squashed 'br2/' content from commit f1d2c19
    
    git-subtree-dir: br2
    git-subtree-split: f1d2c19091e1c2ef803ec3267fe71cf6ce7dd948


which is not correct :

git ls-remote git://git.buildroot.net/buildroot 2013.02
f1d2c19091e1c2ef803ec3267fe71cf6ce7dd948	refs/tags/2013.02

git ls-remote git://git.buildroot.net/buildroot 2013.02^{}
15ace1a845c9e7fc65b648bbaf4dd14e03d938fd	refs/tags/2013.02^{}


as you can see git subtee thinks it splited from the tag SHA instead of the tag's commit SHA

this is incorrect because the tag isn't here, and at split time git subtree won't be able to find the correct ancestor. We just need to make sure we use the tag's commit instead
of the tag



changing
	revs=FETCH_HEAD
to
	revs=FETCH_HEAD^{}
in cmd_add_repository

seems to fix it, both for remote branch pull and remote tag pull


we still have a bug lurking around it's the case where the user does the fetch himself then use subtree add with a tag SHA. but let's discuss problems one at a time :)
