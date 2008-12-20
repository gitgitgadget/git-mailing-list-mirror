From: "David Aguilar" <davvid@gmail.com>
Subject: Re: how to check remote git repo for updates without pull/fetch
Date: Sat, 20 Dec 2008 15:41:13 -0800
Message-ID: <402731c90812201541r510170tbe1d56b7261e8146@mail.gmail.com>
References: <494BC89F.9070107@gmail.com> <m3skoi21m3.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Ivan Zorin" <ivan.a.zorin@gmail.com>, git@vger.kernel.org
To: "James Cloos" <cloos@jhcloos.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 00:45:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEBVs-0007oL-TJ
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 00:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbYLTXlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 18:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbYLTXlQ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 18:41:16 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:27247 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbYLTXlP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 18:41:15 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1602232wfd.4
        for <git@vger.kernel.org>; Sat, 20 Dec 2008 15:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=dMBSKf4CSE1VoRJCf9Q2cJEVU6D2UwIdMggOtsjVJJg=;
        b=XZfKqnyrfW19oDwtjOsZ52xq2/riBZKRiZWXJQe+etAgRF3Wr4sH5MhGUR7VfhHEhn
         k0PukgNE4cgVvEgo0Com+j8Qo0uuOyM/dBsFYSHQ4fp/4j3tITXjqYTTXheeLhf0t1RO
         DdWIzjQnPQfi3H2f4kKRpby2YA/TRcK8GFRuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tYvT1+tn6YzfPc7oaxyK2qkhV80HhM5ieDpTBsMBqav26RFcrneR6vGuRTBmQ/IeHZ
         w7zKNtUUfBJXTtCWOuxMYvckblsHHq9BOUfWfDE6hF/AKWr51bYazPTueIYymWBxnUVt
         sgNrEvbR8rasgurXJnlvYPM9ULZCpir5AOSKY=
Received: by 10.142.191.5 with SMTP id o5mr2012570wff.91.1229816473877;
        Sat, 20 Dec 2008 15:41:13 -0800 (PST)
Received: by 10.142.156.11 with HTTP; Sat, 20 Dec 2008 15:41:13 -0800 (PST)
In-Reply-To: <m3skoi21m3.fsf@lugabout.jhcloos.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103674>

2008/12/20 James Cloos <cloos@jhcloos.com>:
>
> #!/bin/bash
> #
> # does this git repo need a pull?
> #
> l=$(git log|head -1|awk '{print $NF}')
> r=$(git ls-remote origin heads/master|awk '{print $1}')
> test "${r}" != "${l}"
>
>
> -JimC
> --
> James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
>
>

Hello

Your script will report false positives if you run that in a branch
where you've made local commits since git log's output will list a
commit that's not on the remote side.  Thus it'lll say 'you need to
pull' when really what happened was that you committed locally and the
sha1 test is no longer equal.  This is one of the reasons why it's a
good idea to always keep your local master clean.

There's two things you can do:

1. assume that you always keep your local 'master' branch clean.
That'll let you quickly compare your local master versus origin's
master:

#!/bin/sh
remotemaster=$(git ls-remote origin heads/master | awk '{print $1}')
localmaster=$(git rev-parse master)
test "$remotemaster" = "$localmaster"


2. You might have a local branch that's not called master but is
tracking origin/master.  Or, your master branch might not be clean.
You can accomodate that workflow with:

#!/bin/sh
remotemaster=$(git ls-remote origin heads/master | awk '{print $1}')
branchpoint=$(git merge-base origin/master HEAD)
test "$remotemaster" = "$branchpoint"


The difference is that we're checking against the branch point.  If
origin/master is beyond the branch point then chances are you need to
pull.



---- off topic, but related ----

BTW one sound recommendation that I've heard on this list is that your
topic branches should really be free of any unrelated changes.
Pulling stuff in "just because" changes the branch.  It's no longer
just "topic" -- it's now "topic" + whatever they happened to push
upstream.  That has some implications in that it makes it harder to
review what exactly went into the specific topic/feature since the
branch's history now contains unrelated changes.

An advantage of keeping your topic branches clean is that you can run:

    git diff $(git merge-base HEAD origin/master)

in your topic branch and you'll see *only* the changes that went into
that branch.  If you get into the habit of pulling stuff in then
you'll see your changes *and* stuff you've pulled in, which probably
has nothing to do with the original topic/feature, etc. etc.

Anyways, this is an entirely different topic/conversation and might
not apply to your specific circumstance but I figured I'd mention it
nonetheless.


-- 
    David
