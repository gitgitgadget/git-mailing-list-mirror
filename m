From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad file descriptor
Date: Wed, 25 Feb 2015 02:19:55 -0800
Message-ID: <801181a93d829d68b96c4b61d1ebdc3@74d39fa044aa309eaea14b9f57fe79c>
References: <CABNxngNDwf_Cy77OzvMg__kCNoTz5y1a2KKG1vobYjE_m_aLkQ@mail.gmail.com> <20150129233429.GA7162@dcvr.yhbt.net> <CABNxngPErFiTzUNK6P90Ug5fVtJSYD9XrGrQzK8+mt2u4g=Xyg@mail.gmail.com> <20150130002247.GA22519@dcvr.yhbt.net> <CABNxngMVsaSLmzf0ZsaXZqXhD+hOaRmz-uuSzm0ALDFhKjnrXA@mail.gmail.com> <20150130013017.GA10713@dcvr.yhbt.net> <CAK6Z60cGnvPP0ctnyV4tHfMmBGYRidEJzkAG+J2h9BunmtOAsQ@mail.gmail.com> <CABNxngNH20O52QHSivQLvRFSW2hqnVTYuBv0CWn1L53cL+XoGw@mail.gmail.com> <20150212191807.GA30062@dcvr.yhbt.net> <CAK6Z60dZu_0kNJF2-eJMgnjYVhxfyps53mcfZT41V1DBZZ+zhw@mail.gmail.com> <20150217061707.GA4308@dcvr.yhbt.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>, Mike <ipso@snappymail.ca>,
	Minty <mintywalker@gmail.com>,
	=?UTF-8?q?Nico=20Schl=C3=B6mer?= <nico.schloemer@gmail.com>,
	Valery Yundin <yuvalery@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 11:20:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQZ4l-0000AX-9k
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 11:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbbBYKUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 05:20:07 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:39083 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbbBYKUF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 05:20:05 -0500
Received: by pdjy10 with SMTP id y10so3944112pdj.6
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 02:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=APf7tXh2DrqbzejIKug8C64gyq5fV0foWRGmLwh/w1E=;
        b=FKByic+RerGqHz+uhVSmRZ3G8qDL3pYnJOO4zlOcykbbAPvrFFGUE9MFKWiQEoAGEW
         TY5MdKfrGuwJ4QMr+JISdyBz7WPYbeBp1t53gU1LOqg9iz6PcTlh0u8sH2vUjg7GN1AD
         z5AU+s8u1nj8PwP2Q/hRbvD7Td5ark9F2ggG+sEZZOxP9Sez4z6o4btz/MeyC4NPAz8A
         FoN9GxU8BRZYr6x+nZUOvx/Kkg/ddGgFR3HU7ois0FvHvMuus6iq9B/nBNaaspDsorkq
         W2fSsfPIRTdE2XQQDREEJvJCycUyrE+rV/ZSzVsvVnG+YuxbArK4ZcOrsxG93cYSnR3g
         4tCA==
X-Received: by 10.70.23.69 with SMTP id k5mr4248589pdf.68.1424859604708;
        Wed, 25 Feb 2015 02:20:04 -0800 (PST)
Received: from localhost.localdomain ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id gt10sm37403376pac.32.2015.02.25.02.20.02
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Feb 2015 02:20:03 -0800 (PST)
In-Reply-To: <20150217061707.GA4308@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264379>

I believe I have been able to track down this problem and implement a
fix.  Please report back if this patch fixes the problem for you.

-Kyle

-- 8< --
Subject: [PATCH] Git::SVN::Fetcher: avoid premature 'svn_hash' temp file closure

Since b19138b (git-svn: Make it incrementally faster by minimizing temp
files, v1.6.0), git-svn has been using the Git.pm temp_acquire and
temp_release mechanism to avoid unnecessary temp file churn and provide
a speed boost.

However, that change introduced a call to temp_acquire inside the
Git::SVN::Fetcher::close_file function for an 'svn_hash' temp file.
Because an SVN::Pool is active at the time this function is called, if
the Git::temp_acquire function ends up actually creating a new
FileHandle for the temp file (which it will the first time it's called
with the name 'svn_hash') that FileHandle will end up in the SVN::Pool
and should that pool have SVN::Pool::clear called on it that FileHandle
will be closed out from under Git::temp_acquire.

Since the only call site to Git::temp_acquire with the name 'svn_hash'
is inside the close_file function, if an 'svn_hash' temp file is ever
created its FileHandle is guaranteed to be created in the active
SVN::Pool.

This has not been a problem in the past because the SVN::Pool was not
being cleared.  However, since dfa72fdb (git-svn: reload RA every
log-window-size, v2.2.0) the pool has been getting cleared periodically
at which point the FileHandle for the 'svn_hash' temp file gets closed.
Any subsequent calls to Git::temp_acquire for 'svn_hash', however,
succeed without creating/opening a new temporary file since it still has
the now invalid FileHandle in its cache.  Callers that then attempt to
use that FileHandle fail with an error.

We avoid this problem by making sure the 'svn_hash' temp file is created
in the same place the 'svn_delta_...' and 'git_blob_...' temp files are
(and then temp_release'd) so that it can be safely used inside the
close_file function without having its FileHandle end up in an SVN::Pool
that gets cleared.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 perl/Git/SVN/Fetcher.pm | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 10edb277..613055a3 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -322,6 +322,14 @@ sub apply_textdelta {
 	# (but $base does not,) so dup() it for reading in close_file
 	open my $dup, '<&', $fh or croak $!;
 	my $base = $::_repository->temp_acquire("git_blob_${$}_$suffix");
+	# close_file may call temp_acquire on 'svn_hash', but because of the
+	# call chain, if the temp_acquire call from close_file ends up being the
+	# call that first creates the 'svn_hash' temp file, then the FileHandle
+	# that's created as a result will end up in an SVN::Pool that we clear
+	# in SVN::Ra::gs_fetch_loop_common.  Avoid that by making sure the
+	# 'svn_hash' FileHandle is already created before close_file is called.
+	my $tmp_fh = $::_repository->temp_acquire('svn_hash');
+	$::_repository->temp_release($tmp_fh, 1);
 
 	if ($fb->{blob}) {
 		my ($base_is_link, $size);
--
