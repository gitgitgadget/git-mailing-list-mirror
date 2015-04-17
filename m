From: Stefan Saasen <ssaasen@atlassian.com>
Subject: [BUG] Performance regression due to #33d4221: write_sha1_file:
 freshen existing objects
Date: Fri, 17 Apr 2015 17:30:22 +1000
Message-ID: <CADoxLGPYOkgzb4bkdHq5tK0aJS2M=nWGzO=YYXPDcy-gh45q-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 09:36:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj0pX-0008Uz-VI
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 09:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbbDQHgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 03:36:48 -0400
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:49379 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751647AbbDQHgr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2015 03:36:47 -0400
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Apr 2015 03:36:47 EDT
Received: from mail-ie0-f181.google.com ([209.85.223.181]) (using TLSv1) by na3sys009aob124.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVTC4DjKp4leUavhbqLF0VLUGWHPbi8Jk@postini.com; Fri, 17 Apr 2015 00:36:47 PDT
Received: by iecrt8 with SMTP id rt8so54190738iec.0
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 00:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=W3D5h90MDOuFj3sWXNZo4+T24E5n6Ov2dnVwpVfU+gI=;
        b=hblKNz9wVDw+KFZF9S3jAbDLeM1jeHvFXtVouDtanrNnuNmYzgcFyE8XXZUrCRCnB/
         koycjaMi/2L7hN7dIahU6w2SH0twZJpk2RgWRyxh59l2OAgKDCZ28FawqCHCRJnN0+y+
         6FxzReTqsosLr1oCniZx8Tk1ssOipvcXi7KMp/E6vbu+Q///J5s5NZZGHasK7MvA6JXD
         ZnIn14dPUeTnImp6/JYsuycQsrbKYC4jyqd9MTwRd9kQtM1FdcjNgZDt49NnU+Mk5JUQ
         m6mHUDFC5ZGr+Vb9wZs5VJOQIL2zEtjmeucIz54X121HqdtR62ev6Bi26ES/O/osVldj
         KCXA==
X-Received: by 10.50.66.37 with SMTP id c5mr1091064igt.26.1429255865239;
        Fri, 17 Apr 2015 00:31:05 -0700 (PDT)
X-Gm-Message-State: ALoCoQmH2eqzGnkYPiQU+ZkaVm4gv6rdF8hpra8TjWOMpSAwA7JM9IAeQDl5xUtKbyPrrXa7qUZHkP7E+NRrnbZ/3bg/DjgTLKiS8rzzsKvDcJqLD8FUcZxdYsAnHsLq9wRQqyVBvOcMWp9E7p9p/0cnOf6urGtNSw==
X-Received: by 10.50.66.37 with SMTP id c5mr1091055igt.26.1429255865100; Fri,
 17 Apr 2015 00:31:05 -0700 (PDT)
Received: by 10.36.118.133 with HTTP; Fri, 17 Apr 2015 00:30:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267349>

We became aware of slow merge times with the following setup:

The merge is created in a temporary location that uses alternates. The
temporary repository is on a local disk, the alternate object database
on an NFS mount.

After some investigation we believe that #33d4221 (present in git
2.2.0, absent in 2.1.4) is causing this regression in merge time.

The following are merge times (in seconds) with git@33d4221~
(2.1.2-393-gabcb865) (before the change)

      Elapsed         System            User
 Min.   :0.3700   Min.   :0.04000   Min.   :0.3000
 1st Qu.:0.3800   1st Qu.:0.05000   1st Qu.:0.3100
 Median :0.4000   Median :0.06000   Median :0.3300
 Mean   :0.4295   Mean   :0.05905   Mean   :0.3519
 3rd Qu.:0.4600   3rd Qu.:0.07000   3rd Qu.:0.3600
 Max.   :0.5900   Max.   :0.09000   Max.   :0.4900


The following are merge times with git@33d4221 (2.1.2-394-g33d4221):

      Elapsed         System            User
 Min.   : 8.58   Min.   :1.46   Min.   :0.4400
 1st Qu.: 9.63   1st Qu.:1.60   1st Qu.:0.4400
 Median :10.64   Median :1.66   Median :0.4800
 Mean   :10.50   Mean   :1.69   Mean   :0.4986
 3rd Qu.:11.13   3rd Qu.:1.81   3rd Qu.:0.5000
 Max.   :13.96   Max.   :2.05   Max.   :0.6700


As you can see the merge times are an order of magnitude slower after
the change.

The effect of  #33d4221 can be seen when strace'ing the merge:

Running strace on git@33d4221 yields
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 70.79    0.714852         178      4018           utime
 14.73    0.148789           3     50141     50123 lstat
 13.88    0.140198          17      8074      8067 access
  0.24    0.002455         614         4           rename
  0.15    0.001493           3       577           write
  0.06    0.000618          10        65           close
  0.04    0.000453           3       152           brk
  0.04    0.000433          27        16           mkdir
  0.03    0.000310           8        41           fstat


Running strace on git@33d4221~ yields

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 98.37    0.138516           3     50141     50123 lstat
  0.92    0.001292           2       577           write
  0.37    0.000520          14        38        31 access
  0.18    0.000252          36         7           getcwd
  0.17    0.000237           7        36        20 stat
  0.00    0.000000           0        40           read
  0.00    0.000000           0        87        30 open


My current hypothesis is that the additional `access`, but more
importantly the additional `utime` calls are responsible in the
increased merge times that we see.
NFS stats on the server for the tests seem to confirm this (see
nfsstat-{after,before}-change.txt on
https://bitbucket.org/snippets/ssaasen/oend).
This is certainly due to the fact that this will all happen over NFS
but in 2.1.4 this worked fine and starting with 2.2 this has become
very slow.

Looking at the detailed strace shows that utime will be called
repeatedly in same cases (e.g.
https://bitbucket.org/snippets/ssaasen/oend shows an example where the
same packfile will be updated more than 4000 times in a single merge).

http://www.spinics.net/lists/git/msg240106.html discusses a potential
improvement for this case. Would that be an acceptable avenue to
improve this situation?

Best regards,
Stefan Saasen
