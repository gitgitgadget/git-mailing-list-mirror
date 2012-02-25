From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/4] index-pack improvements
Date: Sat, 25 Feb 2012 17:56:12 +0700
Message-ID: <1330167376-24859-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 11:54:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1FGW-0000Sj-Tf
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 11:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145Ab2BYKyA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 05:54:00 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51114 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754833Ab2BYKx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 05:53:59 -0500
Received: by daed14 with SMTP id d14so3412318dae.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 02:53:58 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.194.65 as permitted sender) client-ip=10.68.194.65;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.194.65 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.194.65])
        by 10.68.194.65 with SMTP id hu1mr18314795pbc.75.1330167238883 (num_hops = 1);
        Sat, 25 Feb 2012 02:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=fvJbOtShNdLd1mSODZDzdyt7FRuuZlDpyZvVSkQq6OQ=;
        b=R8RagYAjwHJD0EcoT6fTSw7xK4G6Tp+YJR1SBRIQoNX8Qy5rpwjJQk/lHRneUP3Y08
         EPn3YtMWfu//tvww1Jhthoahl8UDY0Am+HF9aw9Ff8jRawG89srAHrZY34RmHD5kF0A4
         TtJGOS+1kdOhkcKmkv+9lqMN9R4xbBU3qFJzM=
Received: by 10.68.194.65 with SMTP id hu1mr15210441pbc.75.1330167238828;
        Sat, 25 Feb 2012 02:53:58 -0800 (PST)
Received: from tre ([115.74.53.120])
        by mx.google.com with ESMTPS id q8sm6927363pbn.20.2012.02.25.02.53.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Feb 2012 02:53:58 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 25 Feb 2012 17:56:17 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191517>

The first two patches are posted already, which help keep memory usage
down in the present of large blobs. The forth patch attempts to
resolve deltas in parallel.

$ time ./git index-pack --threads=3D1 --verify -v XXXX
Indexing objects: 100% (165375/165375), done.
Resolving deltas: 100% (124749/124749), done.

real    1m15.470s
user    1m14.899s
sys     0m0.552s

$ time ./git index-pack --threads=3D2 --verify -v XXXX
Indexing objects: 100% (165375/165375), done.
Resolving deltas: 100% (124749/124749), done.

real    0m41.339s
user    1m15.116s
sys     0m0.680s

$ time ./git index-pack --threads=3D3 --verify -v XXXX
Indexing objects: 100% (165375/165375), done.
Resolving deltas: 100% (124749/124749), done.

real    0m37.008s
user    1m35.742s
sys     0m0.803s

$ time ./git index-pack --verify -v XXXX   # four core machine
Indexing objects: 100% (165375/165375), done.
Resolving deltas: 100% (124749/124749), done.

real    0m33.701s
user    1m51.316s
sys     0m0.768s

$ time ./git index-pack --threads=3D8 --verify -v XXXX
Indexing objects: 100% (165375/165375), done.
Resolving deltas: 100% (124749/124749), done.

real    0m33.638s
user    1m51.783s
sys     0m0.773s

So there's improvement from user persepective, but overhead is too
high (user time from 1m14 to 1m51). Making threaded_second_pass to
process 512 consecutive objects each iteration to reduce contention on
work_mutex does not help. Any ideas?

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  index-pack --verify: skip sha-1 collision test
  index-pack: reduce memory usage when the pack has large blobs
  index-pack: move second pass code into separate function
  index-pack: support multithreaded delta resolving

 Documentation/config.txt         |    4 +
 Documentation/git-index-pack.txt |   10 ++
 Makefile                         |    2 +-
 builtin/index-pack.c             |  298 ++++++++++++++++++++++++++++++=
+-------
 4 files changed, 260 insertions(+), 54 deletions(-)

--=20
1.7.8.36.g69ee2
