From: Yann Dirson <ydirson@altern.org>
Subject: Wrapper scripts to help git-cvsimport cope with cvs 1.12 breakage
Date: Tue, 3 Jul 2007 23:43:36 +0200
Message-ID: <20070703214336.GC6361@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 23:44:09 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5qAH-0005Zl-Q2
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 23:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759327AbXGCVoA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 17:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758471AbXGCVoA
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 17:44:00 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:42955 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757537AbXGCVn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 17:43:59 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A4AC25A245
	for <git@vger.kernel.org>; Tue,  3 Jul 2007 23:43:57 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 637B21F150; Tue,  3 Jul 2007 23:43:36 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51537>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Some of you may have noticed that cvs 1.12.x has a bad habit, when a
file gets added on a branch, of creating a dummy 1.x.2.1 revision of
the empty file on the branch.  What's annoying, is that the dummy
revision gets an erroneous timestamp, which makes the cvsps output
wrong, following the well-known GIGO principle.

Until someone (maybe me, but I can give no guaranty whatsoever) finds
the time to deal with this bug in cvsps, as well as avoiding at the
cvsps level the extra "file initially added on branch" dummy
revisions, here is a little perl filter that sanitizes the csvps
output, and a customizable git-cvsimport wrapper using it.

Best regards,
-- 
Yann

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cvsps-filter

#!/usr/bin/perl
use strict;
use warnings;

$/='---------------------';

our @branches = qw/HEAD/;
our %parents = ();		# parents not yet recorded

# parsing state
our $patchset_is_valid;
our $patchset;

while(<>) {
  $patchset = $_;

  # skip first separator line
  if ($patchset eq $/) {
    print $patchset;
    next;
  }

  $patchset_is_valid = 1;
  my ($branch, $ancestor);
  if (m/^Branch: (.*)/m) {
    $branch = $1;
    if (!grep { $_ eq $branch } @branches) {
      push @branches, $branch;
    }
  } else {
    die "no branch in $patchset";
  }

  if (m/^Ancestor branch: (.*)/m) {
    $ancestor = $1;
    if (!grep { $_ eq $ancestor } @branches or
	m/^file .* was added on branch /m) {
      print STDERR "preparing $branch fixup\n";
      $patchset_is_valid = 0;
      $parents{$branch} = $ancestor;
    }
  }

  if (m/^file .* was added on branch /m) {
    $patchset_is_valid = 0;
  }

  if (defined $parents{$branch} and $patchset_is_valid) {
    print STDERR "finalizing $branch fixup\n";
    my $line = 'Ancestor branch: ' . $parents{$branch} . "\n";
    $patchset =~ s/^(?=Tag:)/$line/m;
    delete $parents{$branch};
  }

--XsQoSWH+UP9D9v3l
Content-Type: application/x-sh
Content-Disposition: attachment; filename="fetch-from-cvs.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0Atargetrepo=3D<path to the imported git repo>=0Acvsroot=3D<=
your cvs root>=0Amodule=3D<your module>=0A=0Agit-cvsimport -v -i \=0A    -d=
 $cvsroot \=0A    -C $targetrepo \=0A    -P <( CVSROOT=3D$cvsroot cvsps -x =
-A $module | cvsps-filter ) \=0A    $module=0A
--XsQoSWH+UP9D9v3l--
