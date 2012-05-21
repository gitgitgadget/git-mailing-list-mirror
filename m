From: Bryan Turner <bturner@atlassian.com>
Subject: git rev-list %an, %ae, %at bug in v1.7.10.1 and beyond
Date: Mon, 21 May 2012 18:01:50 +1000
Message-ID: <CAGyf7-G3nNTTP1bKdd9HLKEn-8+LoxCeY2R08x9gKZwS0L_N6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 10:01:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWNYz-0008Cl-C0
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 10:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210Ab2EUIBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 04:01:53 -0400
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:54831 "HELO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751505Ab2EUIBw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2012 04:01:52 -0400
Received: from mail-gg0-f177.google.com ([209.85.161.177]) (using TLSv1) by na3sys009aob121.postini.com ([74.125.148.12]) with SMTP
	ID DSNKT7n2b6GJLqf5AIybOmfFGOGoXMXsz3CW@postini.com; Mon, 21 May 2012 01:01:52 PDT
Received: by ggcs5 with SMTP id s5so4646198ggc.36
        for <git@vger.kernel.org>; Mon, 21 May 2012 01:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :x-gm-message-state;
        bh=GlQ91Ny3KIecBlJj6+2BYAaCA2DbFHDOPUYevMOHgvA=;
        b=oJfpx81dqZ+0WquzzwsrGgWSo2ZdXJLFyiagKkAzv0JxwDPDvaGZCa6GZxVd3TvfpD
         sTPqdHm+cFuhn/Zo54sBRDdj3nCE2soERFcWkyjHklzHaaYpTjDWO0bnsD6cQGT8NGIJ
         ZgUesxW20wfu5w63t9zaPXWkO6Y69iJtbHcqZbBv/gM+woguKev89tCC3j44gmw46Ka4
         U1XGc9zx/v6Z1ny8PDS+V1vK0CM28EBR5vC9llhFQrOdp5ax1pge57mVYAjmFb4uqiC7
         vbCNXJwyAngY1JMPDofSt+wc3PxcBvxhlZlWpdeBuwkMEMWmbM/FrmxAz460uqzn/CZ6
         /3Tw==
Received: by 10.50.85.196 with SMTP id j4mr5876604igz.30.1337587310953; Mon,
 21 May 2012 01:01:50 -0700 (PDT)
Received: by 10.231.65.12 with HTTP; Mon, 21 May 2012 01:01:50 -0700 (PDT)
X-Gm-Message-State: ALoCoQn8KxAz94vcvYistTbGnJwDKuP9V8tzH/mh3gj06wzLBA3ahtc7+zfca2dxmiOnPCRmrrax
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198089>

Hello all,

I believe I've found an issue in git v1.7.10.1 and v1.7.10.2 (and
master) where the output of git rev-list has changed for some commits.
Most commits do not appear to trigger the issue; it may be related to
Unicode characters being used in the author name. I've run a git
bisect and it appears the bug was introduced in
4b340cfab9c7a18e39bc531d6a6ffaffdf95f62d.

Built from master (as well as using the 1.7.10.1 and 1.7.10.2 release
tags), I get output like this:
================================ Output =====================================
aphrael:qa-resources.git bturner$ git rev-list
--format="%H|%h|%P|%p|%an|%ae|%at%n%B%n@@object_end@@" -1
5c1ccdec5f84aa149a4978f729fdda70769f942f
commit 5c1ccdec5f84aa149a4978f729fdda70769f942f
5c1ccdec5f84aa149a4978f729fdda70769f942f|5c1ccde|02c78bc39ac6192623bf080e3e2ac892a4f5764c|02c78bc|||
commit with unicode name

@@object_end@@
================================ End ========================================

Note that the author name, e-mail and timestamp values are all missing
(the three |'s in a row at the end).

Built from 0dbe6592ccbd1a394a69a52074e3729d546fe952, the parent of
4b340cf, and in previous versions of git (1.7.10 and earlier), I got
output like this:
================================ Output =====================================
aphrael:qa-resources.git bturner$ git rev-list
--format="%H|%h|%P|%p|%an|%ae|%at%n%B%n@@object_end@@" -1
5c1ccdec5f84aa149a4978f729fdda70769f942f
commit 5c1ccdec5f84aa149a4978f729fdda70769f942f
5c1ccdec5f84aa149a4978f729fdda70769f942f|5c1ccde|02c78bc39ac6192623bf080e3e2ac892a4f5764c|02c78bc|a|farmas@atlassian.com|1327876222
commit with unicode name

@@object_end@@
================================ End ========================================

Note that the author name, e-mail and timestamp are all present. The
"a" appears as ASCII here, but it's actually a UTF-16LE character (the
terminal on the Mac is being "helpful").

To try and verify whether the difference is a bug or a bugfix (because
I wasn't certain whether perhaps the output from earlier versions was
the result of a bug which was fixed in 1.7.10.1 and on), I compared
the git rev-list output with git cat-file -p (again, built from
master):
================================ Output =====================================
aphrael:qa-resources.git bturner$ git cat-file -p
5c1ccdec5f84aa149a4978f729fdda70769f942f
tree dd173cb70baaac07bdf405f4e3db110e7fafd180
parent 02c78bc39ac6192623bf080e3e2ac892a4f5764c
author a <farmas@atlassian.com> 1327876222 +1100
committer a <farmas@atlassian.com> 1327876222 +1100

commit with unicode name
================================ End ========================================

The git cat-file output is consistent across versions of git where I'm
seeing the rev-list issue and versions where I'm not.

I would be happy to provide a zip file containing the repository with
the commit shown in all the output above, if that will facilitate
testing/fixing the issue. Just let me know where to put it. I lack the
C chops to provide a patch myself; sorry about that.

Best regards,
Bryan Turner
