From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Git does not handle changing inode numbers well
Date: Wed, 8 Aug 2012 17:22:30 +0200
Message-ID: <20120808152230.GQ21274@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4IKABJTiQIqPwmW"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 18:02:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz8iW-0005qb-77
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 18:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414Ab2HHQCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 12:02:34 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:51287 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030402Ab2HHQCd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 12:02:33 -0400
X-Greylist: delayed 2399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Aug 2012 12:02:33 EDT
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1Sz85e-0006fA-Um
	for git@vger.kernel.org; Wed, 08 Aug 2012 17:22:32 +0200
Received: (nullmailer pid 25612 invoked by uid 1000);
	Wed, 08 Aug 2012 15:22:30 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203095>


--z4IKABJTiQIqPwmW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(Please CC me, I'm not on the list)

Hi folks,

I've spent some time debugging an issue and I'd like to share the
results. The conclusion of my debugging is that git does not currently
handle changing inode numbers on files well.

I have a custom Fuse filesystem, and fuse dynamically allocates inode
numbers to paths, but keeps a limited cache of inode -> name mappings,
causing the inodes to change over time.

Now of course, you'll probably say, "it's the filesystem's fault, git
can't be expected to cope with that". You'll be right of course, but
since I already spent the time digging into this and figuring out what
goes on inside git in this case, I thought I might as well share the
analysis, just in case someone sees an easy fix in here, or in case
someone else stumbles upon this problem as well.

So, the actual problem I was seeing is that running "git status" showed
all symlinks as "modified", even though they really were identical
between the working copy, index and HEAD. Interestingly enough this only
happened when running "git status" without further arguments, when
running on a subdirectory, it would show no changes as expected.

I compared the output of stat to a hexdump of the index file and found
that everything matched, except for the inode numbers. I originally
thought I was misinterpreting what I saw, but gdb confirmed that it were
indeed the inode numbers that git observed as different.

Now, I could have stopped here and started trying to fix my filesystem
instead. But it was still weird that this problem only existed for
symlinks and that normal files acted as expected. So I dug in a bit
deeper, hoping to find some way to make this work for symlinks as well.

So, here's what happens (IIUC):
 - cmd_status calls refresh_index, which calls refresh_cache_ent for
   every entry in the index.
 - refresh_cache_ent notices that the inode number has changed (for both
   symlinks and regular files) and compares the file / symlink contents.
 - refresh_cache_ent sees the content hasn't changed, so it calls
   fill_stat_cache_info to update the stat info.
 - fill_stat_cache_info sets the EC_UPTODATE flag on the entry, but only
   if it is a regular file.
 - cmd_status calls wt_status_collect which calls
   wt_status_collect_changes_worktree which calls run_diff_files.
 - run_diff_files skips regular files, because of the EC_UPTODATE flag.
   For symlinks, however, it checks the stat info and notices that the
   inode number has changed (again). It does not do a content check at
   this point, but instead just outputs the file as "modified".


It turned out that the reason running "git status" on a subdirectory did
appear to work, was that the number of files in the subdir wasn't big
enough to overflow the inode number cache fuse keeps, so that numbers
didn't change in this case (the problem _did_ occur when trying a bigger
subdirectory).

So, it seems that git just doesn't cope well with changing inode numbers
because it checks the content in a first pass in refresh_index, but only
checks the stat info in the second pass in run_diff_files. The reason it
does work for regular files is EC_UPTODATE optimization introduced in
eadb5831: Avoid running lstat(2) on the same cache entry.

So, let's see if I can fix my filesystem now ;-)

Gr.

Matthijs

--z4IKABJTiQIqPwmW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAlAihDYACgkQz0nQ5oovr7zqqgCfUZ/gVU/cz5AqFyyqIvF7ShpJ
bKkAoNaPiVPZaebaZPbOfTp4K/wjFvoC
=Tg/t
-----END PGP SIGNATURE-----

--z4IKABJTiQIqPwmW--
