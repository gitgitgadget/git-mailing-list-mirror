From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] gc --aggressive: three phase repacking
Date: Tue, 18 Mar 2014 01:07:27 -0400
Message-ID: <20140318050727.GA14769@sigill.intra.peff.net>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
 <1394976904-15395-6-git-send-email-pclouds@gmail.com>
 <20140318045050.GB8240@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 06:07:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPmFS-0001Ty-5M
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 06:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbaCRFHa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Mar 2014 01:07:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:41638 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751083AbaCRFH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 01:07:29 -0400
Received: (qmail 22078 invoked by uid 102); 18 Mar 2014 05:07:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Mar 2014 00:07:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Mar 2014 01:07:27 -0400
Content-Disposition: inline
In-Reply-To: <20140318045050.GB8240@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244330>

On Tue, Mar 18, 2014 at 12:50:50AM -0400, Jeff King wrote:

> On Sun, Mar 16, 2014 at 08:35:04PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>=20
> > As explained in the previous commit, current aggressive settings
> > --depth=3D250 --window=3D250 could slow down repository access
> > significantly. Notice that people usually work on recent history on=
ly,
> > we could keep recent history more loosely packed, so that repo acce=
ss
> > is fast most of the time while the pack file remains small.
>=20
> One thing I have not seen is real-world timings showing the slowdown
> based on --depth. Did I miss them, or are we just making assumptions
> based on one old case from 2009 (that, AFAIK does not have real numbe=
rs,
> just speculation)? Has anyone measured the effect of bumping the delt=
a
> cache size (and its hash implementation)?

Just as a very quick, rough data point, here are before-and-after
timings for the patch below doing "git rev-list --objects --all" on my
linux.git, which is a mix of "--aggressive" and normal packing (I didn'=
t
do a "repack -f", but it's partially what I've downloaded from k.org an=
d
what I've repacked in various experiments over the past few months).

  [before]
  real    0m28.824s
  user    0m28.620s
  sys     0m0.232s

  [after]
  real    0m21.694s
  user    0m21.544s
  sys     0m0.172s

The numbers below are completely pulled out of a hat, so we can perhaps
do even better. But I think it shows that there is room for improvement
in the delta base cache.

---
diff --git a/environment.c b/environment.c
index c3c8606..73ed670 100644
--- a/environment.c
+++ b/environment.c
@@ -37,7 +37,7 @@ int core_compression_seen;
 int fsync_object_files;
 size_t packed_git_window_size =3D DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit =3D DEFAULT_PACKED_GIT_LIMIT;
-size_t delta_base_cache_limit =3D 16 * 1024 * 1024;
+size_t delta_base_cache_limit =3D 128 * 1024 * 1024;
 unsigned long big_file_threshold =3D 512 * 1024 * 1024;
 const char *pager_program;
 int pager_use_color =3D 1;
diff --git a/sha1_file.c b/sha1_file.c
index b37c6f6..a9ab8e3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1944,7 +1944,7 @@ static void *unpack_compressed_entry(struct packe=
d_git *p,
 	return buffer;
 }
=20
-#define MAX_DELTA_CACHE (256)
+#define MAX_DELTA_CACHE (1024)
=20
 static size_t delta_base_cached;
=20
