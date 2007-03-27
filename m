From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] gitweb: Support comparing blobs (files) with different names
Date: Tue, 27 Mar 2007 21:56:27 +0200
Message-ID: <20070327195627.GA23205@auto.tuwien.ac.at>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <200703261912.09445.jnareb@gmail.com> <20070326204116.GB1128@auto.tuwien.ac.at> <200703270256.24295.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 21:56:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWHmX-0008Hb-0w
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 21:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261AbXC0T4b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 27 Mar 2007 15:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbXC0T4b
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 15:56:31 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:54959 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965261AbXC0T43 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 15:56:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id BD5CA7386C1E;
	Tue, 27 Mar 2007 21:56:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3RRq5iG2VLDm; Tue, 27 Mar 2007 21:56:27 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 661007386C01; Tue, 27 Mar 2007 21:56:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200703270256.24295.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43301>

On Tue, Mar 27, 2007 at 01:56:24AM +0100, Jakub Narebski wrote:
> Martin Koegler wrote:
> > My idea is, that if I got hb:f and hpb:fp, the user exactly specifi=
ed
> > the blobs to be compared. Then I don't want any guessing logic.
>=20
> I'd rather you reuse the "no hash_parent" code, which also hand-craft=
s
> diffinfo. Perhaps removing "git-diff-tree hpb hb -- f" code entirely.
> Besides, code dealing with "blobdiff" coming from "commit", "commitdi=
ff"
> and "history" views are tested to work as expected, not so with
> arbitrary diffs.

I don't like the whole rename detection code, so I offer to simplify
git_blobdiff. For all calls to git_blobdiff (except those from git_hist=
ory),
I'm sure, that I can assume $file_parent ||=3D $file_name.

If you think, its safe, I can simplify git_blobdiff. I propose
doing the following way (pseudo-code):

sub git_blobdiff {
$file_parent ||=3D $file_name;

if (defined $hash_base && defined $file_name && !defined $hash)
$hash=3Dgit_get_hash_by_path($hash_base,$file_name);

if (defined $hash_parent_base && defined $file_parent && !defined $hash=
_parent)
$hash_parent=3Dgit_get_hash_by_path($hash_parent_base,$file_parent);

if (!defined $hash || ! defined $hash_parent )
die_error(....);

$diffinfo{'from_mode'} =3D $diffinfo{'to_mode'} =3D "blob";
$diffinfo{'from_file'} =3D $file_parent || $hash_parent;
$diffinfo{'to_file'}   =3D $file_name || $hash;
$diffinfo{'status'} =3D '2';
$diffinfo{'to_id'}   =3D $hash;
$diffinfo{'from_id'}   =3D $hash_parent;

 open $fd, "-|", git_cmd(), "diff", '-p', @diff_opts,
    $hash_parent, $hash
    or die_error(undef, "Open git-diff failed");

/* print output */

}

Else I will keep a reworked version of my patch.

> By the way, if you call git_get_hash_by_path (which is expensive, as =
it
> calls git command), you can use resulting hash in place of
> hash_base:filename as an argument to git-diff.
=20
I must check, if we need to resolve $hash ($hash_parent) by
git_get_hash_by_path, if we construct it out of $hash_base and
$file_name. Maybe we can avoid this call.

mfg Martin K=F6gler
=20
