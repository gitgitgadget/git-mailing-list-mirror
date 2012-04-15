From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/2] parse-options: Add support for dumping out long
	options
Date: Sun, 15 Apr 2012 14:49:19 +0200
Message-ID: <20120415124919.GD2900@goldbirke>
References: <1334140165-24958-1-git-send-email-bebarino@gmail.com>
	<1334140165-24958-2-git-send-email-bebarino@gmail.com>
	<20120411140651.GR2289@goldbirke> <4F868060.1000709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, spearce@spearce.org,
	felipe.contreras@gmail.com, jrnieder@gmail.com
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 14:49:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJOtU-0008Pv-08
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 14:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab2DOMtW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Apr 2012 08:49:22 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:51141 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105Ab2DOMtW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 08:49:22 -0400
Received: from localhost6.localdomain6 (p5B13091B.dip0.t-ipconnect.de [91.19.9.27])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MH5lK-1SW6D41054-00EDSs; Sun, 15 Apr 2012 14:49:20 +0200
Content-Disposition: inline
In-Reply-To: <4F868060.1000709@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:+nF4zsTzFYCiWQzWDXZIPpaFcb3zuNbsHi6U6MH4ODP
 rCKDH6hFzylaAL6pXQqN415WVC0ccNeOCyu/X9S9QVF+25rniG
 nn15HMjCKN7EfssV4Tof+DHYblWlj+NyU0pop77mOt2OWE0l8f
 Yc6Y8/i3xzNK7iS0Xk5TNJyQ2BIEGT960C69e5sX/O0YSgD2hf
 1WiTSCQReLZRtVCJvblasZ4tEePTDD3JW4qcoQ1rIMGJUIwpTw
 QUQKgiDVrQYtUXWFf5eTC2nGU9S2R1ueZ1w81s3BG1QhgDs+QK
 8lk6URl9ieUXYj/6mWMusuzRB2fAhk3WiLsXZg2KOFhlIw599k
 YMmp8gS0nGdEyhD+vPBs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195565>

Hi,


On Thu, Apr 12, 2012 at 12:12:32AM -0700, Stephen Boyd wrote:
> On 04/11/2012 07:06 AM, SZEDER G=E1bor wrote:
> > On Wed, Apr 11, 2012 at 03:29:24AM -0700, Stephen Boyd wrote:
> >> The bash completion script wants to know what the long options are=
 for a
> >> certain command at runtime. Add a magical long option that nobody =
could
> >> possibly ever use (--dump-raw-long-options) to get this informatio=
n.
> >>
> >> Some example output:
> >>
> >>  $ git clone --dump-raw-long-options
> >>  --no-verbose --no-quiet --progress --no-progress --no-checkout
> >>  --checkout --bare --no-bare --mirror --no-mirror --local --no-loc=
al
> >>  --no-hardlinks --hardlinks --shared --no-shared --recursive
> >>  --no-recursive --recurse-submodules --no-recurse-submodules --tem=
plate=3D
> >>  --no-template --reference=3D --no-reference --origin=3D --no-orig=
in
> >>  --branch=3D --no-branch --upload-pack=3D --no-upload-pack --depth=
=3D
> >>  --no-depth --single-branch --no-single-branch --separate-git-dir=3D
> >>  --no-separate-git-dir --config=3D --no-config
> >>
> >=20
> > I think this is a good idea; there are many completion functions th=
at
> > fell behind and lack an option or two.
> >=20
> > However, in the completion script we deliberately miss options like
> > '--force', but with your series such options will be offered, too.
> >=20
>=20
> Hm.. I meant to say something about that in the commit text. I'm will=
ing
> to live with wading through some more options when I tab complete if =
it
> means the script never falls out of date with my git installation.
>=20
> I can envision us putting more smarts into the parse options code to
> hide certain options from the raw dump but I'm not sure how useful th=
at
> is. Do we need that?

It's not just about wading through some more options.

Parse options already has the PARSE_OPT_HIDDEN flag to omit an option
from the default usage.  Your patch already respects that option, so
e.g. 'git commit --<TAB>' won't offer '--allow-empty', which is meant
for foreign SCM interface scripts.  This is good.

However, '--force' is different, because it should be shown in the
default usage, but since it's a "dangerous" option it should be use
with great care.  That's the reason the completion script doesn't
offer it for any of the commands.

I'm not sure whether there are any such options besides '--force',
though.  If that is the only one, then maybe this is all we need:


diff --git a/parse-options.c b/parse-options.c
index 6c37497c..1a2b0328 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -371,6 +371,8 @@ static int parse_options_raw(const struct option *o=
pts)
 			continue;
 		if (!opts->long_name)
 			continue;
+		if (!strcmp(opts->long_name, "force"))
+			continue;
 		switch (opts->type) {
 		case OPTION_BIT:
 		case OPTION_NEGBIT:


Best,
G=E1bor
