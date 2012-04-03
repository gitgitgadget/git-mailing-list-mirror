From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/3] Commit cache
Date: Tue,  3 Apr 2012 13:55:06 +0700
Message-ID: <1333436109-16526-1-git-send-email-pclouds@gmail.com>
References: <53707c0a-3782-47a4-8a35-da7136ff4822@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 08:56:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SExer-00046E-7C
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 08:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582Ab2DCGz4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Apr 2012 02:55:56 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:43387 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab2DCGzz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 02:55:55 -0400
Received: by dake40 with SMTP id e40so3341686dak.11
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 23:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YB5od6yBHDov3UegAufVjMQ7WTkUioqvWqeV9rxPit0=;
        b=eWjvOS99ZzcqvFlRdrd+H6FVcXDlNUrGWp4B0kxlkuhCJ84eiudjRatY+Ezlwh+LQY
         Ne1ZPqh1hZpUM0G0UUMwE7EgGOEqL7tTMBYEAiSxiaORlSz/boEnfKgdyGi4u6S2l4OX
         GjldNsktfQkbrjZoC3IYrqn5POIUvlgq5uWTvCV1/8eh2SvejFdcU17fBXTpYSVJnR2L
         Xpp49r7T/vNs+Vajl1vDKktlTOgl9yr73tjH4hCKBibFp5STLhq850tDtelOl9coiHSH
         agB0Stz6NWl4ynlPBiTJ1vfJx2LZZnu5PaTjNTuGjj7KbZqLNHPi77ClA+nEdaT0hSup
         Ao/A==
Received: by 10.68.136.69 with SMTP id py5mr26562404pbb.71.1333436154670;
        Mon, 02 Apr 2012 23:55:54 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id r10sm15693118pbf.22.2012.04.02.23.55.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 Apr 2012 23:55:53 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 03 Apr 2012 13:55:10 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <53707c0a-3782-47a4-8a35-da7136ff4822@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194596>

On Tue, Apr 3, 2012 at 12:55 PM, Martin Fick <mfick@codeaurora.org> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>> we could even store the data in a separate file to
>>> retain indexv2 compatibility).
>>>
>>> So it's sort-of a cache, in that it's redundant with the actual dat=
a.
>>> But staleness and writing issues are a lot simpler, since it only
>>gets
>>> updated when we index the pack (and the pack index in general is a
>>> similar concept; we are "caching" the location of the object in the
>>> packfile, rather than doing a linear search to look it up each time=
).
>>
>>I think I have something like that, (generate a machine-friendly
>>commit cache per pack, staying in $GIT_DIR/objects/pack/ too). It's
>>separate cache staying in $GIT_DIR/objects/pack, just like pack-.idx
>>files. It does improve rev-list time, but I'd rather wait for packv4,
>>or at least be sure that packv4 will not come anytime soon, before
>>pushing the cache route.
>
> I would love to try those patches out if you have them?

There you go. Note that these patches are not of high quality. I did no=
t even
run "make test". To create commit cache, simply run index-pack, e.g.

$ git repack -ad
$ git index-pack --stdin < .git/objects/pack/pack-XXX.pack

It will create two more files, pack-XXX.sha1 and pack-XXX.sidx. On
linux-2.6.git, "git rev-list --all --quiet HEAD" takes 1.9s with the
patches and 6.6s without. Disk usage:

total 531M
 56M pack-ab843186bdfb00956c1b1c0cdb4ed5e4aa3e549e.idx
460M pack-ab843185bdfb00956c1b1c0cdb4ed5e4aa3e549e.pack
9.7M pack-ab843185bdfb00956c1b1c0cdb4ed5e4aa3e549e.sha1
5.3M pack-ab843185bdfb00956c1b1c0cdb4ed5e4aa3e549e.sidx

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  parse_commit_buffer: rename a confusing variable name
  Add commit cache to help speed up commit traversal
  Add parse_commit_for_rev() to take advantage of sha1-cache

 Makefile             |    3 +
 builtin/index-pack.c |  113 ++++++++++++++++++++++++++++++++++-
 builtin/reflog.c     |    2 +-
 cache.h              |    9 +++
 commit.c             |   46 +++++++++++---
 commit.h             |    1 +
 log-tree.c           |    2 +-
 pack-write.c         |   11 +++-
 pack.h               |    1 +
 revision.c           |   10 ++--
 sha1_cache.c         |  161 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 sha1_cache.h         |    6 ++
 sha1_file.c          |   12 ++++-
 test-sha1-cache.c    |   19 ++++++
 upload-pack.c        |    2 +-
 walker.c             |    2 +-
 16 files changed, 377 insertions(+), 23 deletions(-)
 create mode 100644 sha1_cache.c
 create mode 100644 sha1_cache.h
 create mode 100644 test-sha1-cache.c

--=20
1.7.3.1.256.g2539c.dirty
