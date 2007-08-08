From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: 'pu' branch for StGIT
Date: Thu, 9 Aug 2007 01:23:49 +0200
Message-ID: <20070808232349.GA23172@diana.vm.bytemark.co.uk>
References: <20070807022043.GA8482@diana.vm.bytemark.co.uk> <1186549433.2112.34.camel@dv> <20070808092027.GB7860@diana.vm.bytemark.co.uk> <20070808213917.GA22521@diana.vm.bytemark.co.uk> <1186611514.7383.4.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 01:24:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIusj-0001df-W1
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 01:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760913AbXHHXX4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 8 Aug 2007 19:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760672AbXHHXXz
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 19:23:55 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2470 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760267AbXHHXXz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 19:23:55 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IIusX-0006Q1-00; Thu, 09 Aug 2007 00:23:49 +0100
Content-Disposition: inline
In-Reply-To: <1186611514.7383.4.camel@dv>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55395>

On 2007-08-08 18:18:34 -0400, Pavel Roskin wrote:

> On Wed, 2007-08-08 at 23:39 +0200, Karl Hasselstr=F6m wrote:
>
> > I can't reproduce.
>
> OK, it's trickier. There are some bad patch names that don't get
> imported properly. In particular, patches ending with ".diff" are
> committed after import.

Ah, sneaky. And it turns out to be not a problem with import, but a
problem with dots in patch names. It's just that import is the only
place those are typically created.

It was all due to a sloppy regexp. This is the fix:

diff --git a/stgit/stack.py b/stgit/stack.py
index 4186ba9..c403f51 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -391,11 +391,11 @@ def read_refs(branch):
     given branch. The patches are listed by name; the branch head is
     None."""
     refs =3D {}
-    patchpat =3D re.compile(r'^refs/patches/%s/([^\.]+)$' % branch)
+    patchpat =3D re.compile(r'^refs/patches/%s/(.+)$' % branch)
     for line in git._output_lines('git-show-ref'):
         sha1, ref =3D line.split()
         m =3D re.match(patchpat, ref)
-        if m:
+        if m and not m.group(1).endswith('.log'):
             refs[m.group(1)] =3D sha1
         elif ref =3D=3D 'refs/heads/%s' % branch:
             refs[None] =3D sha1

Thanks for taking the time to track this down -- with the detailed
symptoms you gave, I found it in no time. I've pushed an updated
series (as well as the other patches I've posted tonight) to
git://repo.or.cz/stgit/kha.git.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
