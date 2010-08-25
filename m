From: Thomas Rast <trast@student.ethz.ch>
Subject: Remote corruption issue, linked to thin pack code?
Date: Wed, 25 Aug 2010 22:53:26 +0200
Message-ID: <201008252253.26521.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jonas Thiem <contact@eloxoph.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 25 22:54:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoMyq-0007oG-Ej
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 22:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287Ab0HYUxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 16:53:52 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:4979 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615Ab0HYUxu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 16:53:50 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 25 Aug
 2010 22:53:48 +0200
Received: from thomas.site (84.74.100.241) by CAS12.d.ethz.ch (172.31.38.212)
 with Microsoft SMTP Server (TLS) id 14.0.702.0; Wed, 25 Aug 2010 22:53:27
 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154471>

Hi *,

This one sounds fairly similar to

  http://thread.gmane.org/gmane.comp.version-control.git/123244/

which was never resolved.

Jonas reported repo corruption on IRC along the lines of

  $ make gitpush
  cd dist && git push ssh://<user>@eloxoph.com/repos/mainrepo/bla.git master
   
    -  W e l c o m e   t o   E L O X O P H  -
               friendly landlord

  <user>@eloxoph.com's password: 
  Counting objects: 201, done.
  Delta compression using up to 2 threads.
  Compressing objects: 100% (132/132), done.
  Writing objects: 100% (133/133), 1.01 MiB, done.
  Total 133 (delta 118), reused 0 (delta 0)
  fatal: pack has 114 unresolved deltas
  error: unpack failed: index-pack abnormal exit
  To ssh://<user>@eloxoph.com/repos/mainrepo/bla.git
   ! [remote rejected] master -> master (n/a (unpacker error))
  error: failed to push some refs to 'ssh://<user>@eloxoph.com/repos/mainrepo/bla.git'
  make: *** [gitpush] Error 1

The respective repos show no errors with git-fsck.  Jonas kindly
provides a download link for both:

  http://eloxoph.com/localrepo.zip
  http://eloxoph.com/remoterepo.zip

Versions are 1.7.2.1 locally and 1.5.4.3 remotely.

Beware, there are hooks in both.  Disabling them, however, only
changes the error slightly:

  [...]
  Total 133 (delta 118), reused 0 (delta 0)
  fatal: pack has 114 unresolved deltas
  error: unpack failed: index-pack abnormal exit
  To ssh://mainrepo@eloxoph.com/repos/mainrepo/bla.git
   ! [remote rejected] master -> master (n/a (unpacker error))
  error: failed to push some refs to 'ssh://mainrepo@eloxoph.com/repos/mainrepo/bla.git'
  make: *** [gitpush] Error 1

What's even stranger is that fetching from the repo is also not
possible:

  fatal: git-upload-pack: cannot find object e28ae6b61c384732c506544626c5083557dd2d75:
  fatal: The remote end hung up unexpectedly

despite the object being there.

What's also strange is that while there is a temporary pack inside
objects/, I get

  $ git index-pack --stdin < objects/tmp_pack_oEUkIc
  fatal: pack has 114 unresolved deltas
  $ git index-pack --fix-thin -v --stdin < objects/tmp_pack_oEUkIc
  Receiving objects: 100% (133/133), 1.01 MiB, done.
  Resolving deltas: 100% (118/118), completed with 63 local objects.
  pack    061120577b0a1fec7ba636d6e3162f95f83543aa

So it seems the remote side got a thin pack and can't cope.  But
a4503a1 (Make --no-thin the default in git-push to save server
resources, 2007-09-09), merged way back in 1.5.3.2, claims to enable
--no-thin all the time.  So how did a thin pack get there?

Any ideas?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
