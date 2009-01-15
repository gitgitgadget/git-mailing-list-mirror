From: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
Subject: Re: [Q] git rebase -i -p conflicts with squash
Date: Thu, 15 Jan 2009 17:25:17 +0300
Message-ID: <85647ef50901150625r161d5e9eh4df78701a6c74c59@mail.gmail.com>
References: <85647ef50901140813r6e62ae53u1dbcd48cc472dbcc@mail.gmail.com>
	 <alpine.DEB.1.00.0901150137070.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 15:26:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNTBF-0003dh-E3
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 15:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759200AbZAOOZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 09:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757156AbZAOOZV
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 09:25:21 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:35287 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759109AbZAOOZT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 09:25:19 -0500
Received: by bwz14 with SMTP id 14so3448117bwz.13
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 06:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SvNnTioT7q0bxBh6SfnI6kVEcPudLcibdZj4wZYhCJE=;
        b=tIwPgNFO22OjE5ZKlVPQXyPazpjY5mGGUV3PLO9PgDROIhalO62j1+Ua7I6Duj7pGf
         0oJOTDVaTnQrEkv2X5W2wIOokIYTpdM87ucIbjw9crUpY9X5BEmXCSM6rDk5Fv3sZEDx
         sCYKAiA2e135EDk2G7PVkkOay28Z8B0oIO0O8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VOV60wq6xAHcHPb7w2waWQkYWNJnMWNgIJXiqc6+RDo94CkgBTA5eUn1F9sZ2nTKBx
         jkx6GclwnFjls5pBiAD32ioMpR0cNNM2swa6BPrEyQwyCpHPZcTM2xKZNzCn8A5hwlTJ
         dOCadyjAtrkqJF65ueynI4kW+ftrXMBY1jz4Q=
Received: by 10.181.148.2 with SMTP id a2mr451715bko.117.1232029517224;
        Thu, 15 Jan 2009 06:25:17 -0800 (PST)
Received: by 10.181.143.16 with HTTP; Thu, 15 Jan 2009 06:25:17 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901150137070.3586@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105820>

Here is a reproduction recipe:

Goto to some empty directory and do the following commands on (cygwin,
git 1.6.0.4):

git init
echo data1 > f.txt
git add f.txt
git commit -m second
echo data2 >> f.txt
git add f.txt
git commit -m second
echo data3 >> f.txt
git add f.txt
git commit -m third
echo '#!/usr/bin/sh' >myed.sh
echo "echo -e '2\ns/pick/s/\np\nw\nq' | ed \$1"  >>myed.sh
chmod a+x myed.sh
export GIT_EDITOR=`pwd`/myed.sh
git rebase -p -i master~2

The git rebase will exit with error writing something like the
following on stderr:
Refusing to squash a merge: 3b9e0d80da20e3543225679906be1cc5cf1a9f44

Constantine

On Thu, Jan 15, 2009 at 3:38 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 14 Jan 2009, Constantine Plotnikov wrote:
>
>> If I run git rebase --interactive with --preserve-merges option and
>> select "squash" for one of the commit, the rebase process fails with the
>> message "Refusing to squash a merge:
>> 5e775c536654640c173ba71a0af7e84bf8bc618a". However the neither commit
>> participating in the squash is a merge commit. Even more, there are no
>> merge commits in the repository at all.
>>
>> From my limited understanding of squash operation, it should fail only
>> if one of squashed commits is a merge commit, but it should be possible
>> to squash non-merge commits without problem as it looks like quite safe
>> and local operation (and I might want to preserve merges that happened
>> after squashed commits). Is it the current behaviour a bug or a feature?
>
> From your description, it seems that you are hitting an ordering bug of
> rebase -i -p.
>
> But without a reproduction recipe (preferably as a patch against our
> testsuite), I cannot tell.
>
> Ciao,
> Dscho
>
>
