From: "Dana How" <danahow@gmail.com>
Subject: Re: [RFD/PATCH] Implement pack.compression and pack-objects --compression=N
Date: Wed, 2 May 2007 15:51:25 -0700
Message-ID: <56b7f5510705021551q2d48f1e5i3f4a5c2f9891368a@mail.gmail.com>
References: <463802ED.1080200@gmail.com>
	 <7vk5vr3w8n.fsf@assigned-by-dhcp.cox.net>
	 <56b7f5510705021155k40b576d6ke286e65494fc8b05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 03 00:51:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjNfY-0004Fp-ND
	for gcvg-git@gmane.org; Thu, 03 May 2007 00:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767162AbXEBWv3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 18:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767164AbXEBWv3
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 18:51:29 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:14994 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767162AbXEBWv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 18:51:27 -0400
Received: by an-out-0708.google.com with SMTP id b33so304221ana
        for <git@vger.kernel.org>; Wed, 02 May 2007 15:51:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PfthR4vWhOwJiGed+FjDpe3Ptlb+VtRt3kweFPEMBlNqWj5azlStLizUKrA8nYj/5+2qsxjTLFODZNQXuu40XJH9EsWE+qGhkRwNR8zbz8I+myM79wlgv8gBLMAEbHToBbo3D8gTQaulGC75IBqfhBy5PUpDSiMyuA8z+wKL980=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J39Y/K0nH0rJn3Lu5vRvN8wKuk/Tz1acZ5suGgTfFbaSBZ1W+8HK5vEzqmxzNty/Irtt4gNizkynod9j9rpjvikGwNHZg5VNvTEIWmEZjzZih+pcYGBIBrlm+O9QifOBSqDUaL4thNcrd8sWVBCdoNxyaWjfZcGqzjyjSTaIVAo=
Received: by 10.114.126.1 with SMTP id y1mr413767wac.1178146285884;
        Wed, 02 May 2007 15:51:25 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Wed, 2 May 2007 15:51:25 -0700 (PDT)
In-Reply-To: <56b7f5510705021155k40b576d6ke286e65494fc8b05@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46050>

On 5/2/07, Dana How <danahow@gmail.com> wrote:
> On 5/2/07, Junio C Hamano <junkio@cox.net> wrote:
> > Dana How <danahow@gmail.com> writes:
> > > Consequently,  for such a usage pattern it is useful
> > > to specify different compression levels for loose
> > > objects and packs.  This patch implements a config
> > > variable pack.compression in addition to the existing
> > > core.compression,  meant to be used for repacking.
> > > It also adds --compression=N to pack-objects,
> > > meant for push/pull/fetch,  if different,  or if different
> > > on a per-repository basis.
> > >
> > > ** THIS PATCH IS UNTESTED AND MEANT FOR DISCUSSION. **
> >
> > I think we tweaked this area in the past, but I do not think
> > the current setting was determined to be the best tradeoff for
> > all workloads.  To be able to discuss the patch, I think it
> > needs to come with benchmark numbers using publicly available
> > repositories as guinea pigs and set of typical git operations,
> > so people can reproduce and compare notes.
>
> OK, but this patch doesn't mandate any particular setting.
>
> Its motivation in my work environment is for pack.compression
> to be what core.compression currently is,  and to set
> core.compression to 0 to speed up large commits
> (the resulting space-inefficient loose objects will be scrubbed away
>  by a later off-line repack).
> Thus,  my config settings (almost) change the gzip's behind a git-add to cp's.
> Do you want me to submit timings for a git-add/git-commit -a
> on a typical 50-file commit I would be interested in,
> with the (new) settings that I would use?

Note the linux-2.6 git tree from a week ago has 22K checked-out files
of average size 11KB; the largest is fs/nls/nls-cp949.c at 874KB.
(The largest file in git is gitk at 176K.)

The tree I'm interested in maintaining with git is almost 70GB
checked-out in 13K files of average size >5.2MB.  This is over
2 orders of magnitude larger average file size than current git users.
(Some of these numbers may decrease after a little retraining ;-).)
I would like git to perform as responsively as possible on files
up to ~500MB.  Within this tree,  the largest file is 1234MB
[I think checking this in was a mistake!]
and I did the following experiments on it:

$ rm -rf .git
$ git-init
Initialized empty Git repository in .git/
$ git-config core.compression -1
$ wc large.spef
  12762072   37832482 1234082774 large.spef
$ /usr/bin/time git-add large.spef
41.54user 0.70system 0:49.76elapsed 84%CPU (0avgtext+0avgdata 0maxresident)k
$ ls -lR .git/objects/??
.git/objects/d5:
total 83836
-r--r--r--  1 how group 85670068 May  2 15:11
d6cde2af063cdfa835038385f29a897bf9533b

$ rm -rf .git
$ git-init
Initialized empty Git repository in .git/
$ git-config core.compression 1
$ wc large.spef
  12762072   37832482 1234082774 large.spef
$ /usr/bin/time git-add large.spef
23.66user 0.74system 0:34.07elapsed 71%CPU (0avgtext+0avgdata 0maxresident)k
$ ls -lR .git/objects/??
.git/objects/d5:
total 105116
-r--r--r--  1 how group 107419557 May  2 15:13
d6cde2af063cdfa835038385f29a897bf9533b

So for a 25% increase in blob size I get 33% less elapsed time
in git-add, all by changing core.compression from -1 to 1.
I'll definitely take that improvement.  [For the compressible files
we typically have, using 0 is a bad idea:  the CPU "advantage"
is swamped out by the time to write a much larger file.]

Since I don't care [to the same degree] about the responsiveness of
packing,  I'd rather pack with -1 or better to keep packs small.
(And inflation time seems independent of compression setting.)
Since someone might be working while the packing is happening,
I'd rather not change the config setting to achieve this.
Hence the patch.

Concerning various public repositories, clearly the patch has no
impact if you don't specify different core.compression and pack.compression
values.  If you do specify different values,  I doubt there would be much
noticeable speed-up for e.g. the linux-2.6 repo stats I included above.
There would be some,  but that wasn't the motivation for the patch.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
