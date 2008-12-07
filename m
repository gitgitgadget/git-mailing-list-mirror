From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Sun, 7 Dec 2008 14:25:52 +0300
Organization: HOME
Message-ID: <200812071425.52908.angavrilov@gmail.com>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com> <492D7CF5.1020202@drmicha.warpmail.net> <alpine.DEB.1.00.0811261804550.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AL7OJ0yxJbzOG/N"
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Ondrej Certik <ondrej@certik.cz>,
	Git Mailing List <git@vger.kernel.org>,
	Fabian Seoane <fabian@fseoane.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 07 12:28:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9HoK-0004MB-U0
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 12:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbYLGL1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 06:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753512AbYLGL1K
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 06:27:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:5951 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbYLGL1I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 06:27:08 -0500
Received: by fg-out-1718.google.com with SMTP id 19so590820fgg.17
        for <git@vger.kernel.org>; Sun, 07 Dec 2008 03:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :message-id;
        bh=scK49q+1oCaf6x0rFz18JoQM6sMtHXr7GaL9jTIaTp8=;
        b=N1iT+sMEsasc164CNgFyLskPjNxFdN/5WuVWLC4CibzWy1Yt1LtNIoMQO4GQWfiVOW
         tQ040EB8t/DD+hVVozASIK2gAE2oo4S6xauQLYNFVreLzWgzn5/0XJk5YQhqzG66Y1de
         DLEti+YMxjvVnh+FuCHT3b/TCv0ctfZ1F5h5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:message-id;
        b=tDGYoITxO1Kd6L6+wkyMqF5sjip0lQbOIBGzEe4H9fxWOTR8qv/hZk0OgB4kFj/W2I
         H76iEJnnOgsZ25rxFEh+98EC3zJKhpUfh04yHIvE5QvDSXlDi+sRbWIlwhlUDi9wv/HO
         rzq0J1rMZt2m5OfHxJPXBJOnHp8kyeKCYWL8I=
Received: by 10.180.232.9 with SMTP id e9mr783777bkh.198.1228649225170;
        Sun, 07 Dec 2008 03:27:05 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id 13sm14895863fks.3.2008.12.07.03.27.03
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 07 Dec 2008 03:27:04 -0800 (PST)
User-Agent: KMail/1.10.3 (Linux/2.6.27.5-123.fc10.i686; KDE/4.1.3; i686; ; )
In-Reply-To: <alpine.DEB.1.00.0811261804550.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102497>

--Boundary-00=_AL7OJ0yxJbzOG/N
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 26 November 2008 20:08:54 Johannes Schindelin wrote:
> On Wed, 26 Nov 2008, Michael J Gruber wrote:
> > Looking at the source I suspect that fast-export fails to denote 
> > parenthood in the case of yet unmarked parents (last for-loop of 
> > handle_commit() in builtin_fast_export.c). But I don't really know that 
> > code at all.
> 
> I strongly doubt so.  Noticed the use of has_unshown_parent(commit) in 
> both cases before calling handle_commit()?
> 
> In any case, here is a script that I wrote _long_ time ago, to be able to 
> reconstruct history from the output of "git rev-list --all --parents".  
> Maybe this helps you in reconstructing something that is handled 
> incorrectly by fast-export | fast-import, but is lighter than a full-blown 
> repository.

Today I had time to investigate this problem, and found:

1) The root of the problem is that fast-export really wants to walk
    revisions in topological order, but actually receives them in date
    order. While it is usually a good guess at topology, this repository
    contains some children that are older than their parent commits,
    e.g. see dd22c7d51a4debf18a3b2e35c61a1fec0175e4e0

2) It tries to fix minor deviations by checking the SHOWN flag.
   However, it still breaks in two ways:

  a) SHOWN is apparently set by simply walking the commits, so
      if the parent was earlier encountered on a different branch of
      the DAG, it will be handled as already shown. Basically, this
      check is only good to determine if we reached the end of the
      chain, and should start to backtrack.

  b) If I modify the code to use a completely separate flag, it still
      doesn't work, because the commits are placed on the stack in
      the wrong order, so handle_tail gets stuck, and fails to unwind
      it completely.

So, apparently, the only way to fix it is to require topological order:


diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 7d5d57a..d9261fa 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -490,6 +490,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
        git_config(git_default_config, NULL);

        init_revisions(&revs, prefix);
+       revs.topo_order = 1; /* force topological ordering */
        argc = setup_revisions(argc, argv, &revs, NULL);
        argc = parse_options(argc, argv, options, fast_export_usage, 0);
        if (argc > 1)


(It is also possible to specify --topo-order on the command line)

As for the failure to import the output of fast-export with copy detection,
it is a natural consequence of a messed up order of commits, because
copy and move commands depend on the original file being there.

The attachment contains a (proper) export of a simplified sample of the
structure around dd22c7d51a4d, which clearly reproduces the problem
because all of the timestamps were made identical as a side effect of
simplification. By crafting timestamps it is probably possible to minimize
it even further.

Alexander

--Boundary-00=_AL7OJ0yxJbzOG/N
Content-Type: text/plain;
  charset="iso-8859-1";
  name="patchesx3b"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patchesx3b"

blob
mark :1
data 5
2696

reset refs/heads/test
commit refs/heads/test
mark :2
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
e4644a29ab6cb1993fc0dab55c320b7f2076e17b 2696
M 100644 :1 foo/a1

blob
mark :3
data 5
2697

commit refs/heads/test
mark :4
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
d558c3feba34d69e8accc990267d60c3a11644c1 2697
from :2
M 100644 :3 foo/a1

blob
mark :5
data 5
2698

commit refs/heads/test
mark :6
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
2e24b35039e9253a9089162f40113e28069cce56 2698
from :4
M 100644 :5 foo/a1

blob
mark :7
data 5
2699

commit refs/heads/test
mark :8
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
0f78bea330e3a3b32f9204dfbdb9ca466ef78962 2699
from :6
M 100644 :7 foo/a1

blob
mark :9
data 5
2700

commit refs/heads/test
mark :10
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
681ea67a40527f192bf279ea6346004120c64702 2700
from :8
M 100644 :9 foo/a1

blob
mark :11
data 5
2701

commit refs/heads/test
mark :12
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
7faf0e5fb3c060385859caead8692d37c9700e55 2701
from :10
M 100644 :11 foo/a1

blob
mark :13
data 5
2702

commit refs/heads/test
mark :14
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
d6ea85387203d59a9cddda6746bd3266598dc91d 2702
from :12
M 100644 :13 foo/a1

blob
mark :15
data 5
2703

commit refs/heads/test
mark :16
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
fa22fab1d6d4cc192e288696fcb8947ebfd9e4a1 2703
from :14
M 100644 :15 foo/a1

blob
mark :17
data 5
2704

commit refs/heads/test
mark :18
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
dd22c7d51a4debf18a3b2e35c61a1fec0175e4e0 2704
from :16
M 100644 :17 foo/a1

blob
mark :19
data 5
2705

commit refs/heads/test
mark :20
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
84e2addc90ccf17d1cfcf657c241cf6cda5d46c1 2705
from :18
M 100644 :19 foo/a1

blob
mark :21
data 5
2706

commit refs/heads/test
mark :22
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
6584b0f9e720d3035739a33e5a24d3b4e3129127 2706
from :20
M 100644 :21 foo/a1

blob
mark :23
data 5
2707

commit refs/heads/test
mark :24
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
75e46ad7079a9841332731e4701b911b73b5be23 2707
from :22
M 100644 :23 foo/a1

blob
mark :25
data 5
2708

commit refs/heads/test
mark :26
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
52d087c1e3aba5c1d158e6fb35fea9c40602ac11 2708
from :24
M 100644 :25 foo/a1

blob
mark :27
data 5
2709

commit refs/heads/test
mark :28
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
384679f01372baa92ce6e43475b44e2eb607ce67 2709
from :26
M 100644 :27 foo/a1

blob
mark :29
data 5
2710

commit refs/heads/test
mark :30
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
98def8453c487d7f54ff01d92268a0aa2c68f872 2710
from :28
M 100644 :29 foo/a1

blob
mark :31
data 5
2711

commit refs/heads/test
mark :32
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
529c626be804ea6201d53856f9d4a30d62b75248 2711
from :30
M 100644 :31 foo/a1

blob
mark :33
data 5
2712

commit refs/heads/test
mark :34
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
c75ea627851e93d6fcbc3d45db1aff00832a403e 2712
from :32
merge :10
M 100644 :33 foo/a1

blob
mark :35
data 5
2713

commit refs/heads/test
mark :36
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
8c436c18ab0922c71fa2a111632d2fc9e1783342 2713
from :34
M 100644 :35 foo/a1

blob
mark :37
data 5
2714

commit refs/heads/test
mark :38
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
c71f0c84d5b812445f1857e23c8737eeb886ae3e 2714
from :36
merge :12
M 100644 :37 foo/a1

blob
mark :39
data 5
2715

commit refs/heads/test
mark :40
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
1086e78f66e10ca873e75d245442f8001f7893cf 2715
from :38
merge :14
M 100644 :39 foo/a1

blob
mark :41
data 5
2716

commit refs/heads/test
mark :42
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
8c3e2e17eb6892069c32696784795c737fb703dd 2716
from :40
merge :16
M 100644 :41 foo/a1

blob
mark :43
data 5
2717

commit refs/heads/test
mark :44
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
c9d47e2b0166eb0d3ff8af2cb65e315b96d02af8 2717
from :42
M 100644 :43 foo/a1

blob
mark :45
data 5
2718

commit refs/heads/test
mark :46
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
537dfcc8c4d15b6a1774e8b37e2ac808972c0cb5 2718
from :44
M 100644 :45 foo/a1

blob
mark :47
data 5
2719

commit refs/heads/test
mark :48
author Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
committer Alexander Gavrilov <angavrilov@gmail.com> 1228639325 +0300
data 46
594b654469e74362bf7e77872e5bc802a03fbf01 2719
from :46
M 100644 :47 foo/a1


--Boundary-00=_AL7OJ0yxJbzOG/N--
