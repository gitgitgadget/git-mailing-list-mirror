From: Tom Grennan <tgrennan@redback.com>
Subject: Re: [PATCH] Make "git request-pull" use the configured
	remote.REMOTE.uploadpack
Date: Tue, 28 Jul 2009 18:30:02 -0700
Message-ID: <20090729013002.GM4850@redback.com>
References: <1248728563-23906-1-git-send-email-tgrennan@redback.com> <adf1fd3d0907281713t378440eamb39baae3be6d41c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>
To: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 03:39:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVy8a-0004N0-PB
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 03:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413AbZG2BjM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jul 2009 21:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755328AbZG2BjM
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 21:39:12 -0400
Received: from mgate.redback.com ([155.53.3.41]:44708 "EHLO mgate.redback.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755060AbZG2BjM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 21:39:12 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jul 2009 21:39:12 EDT
X-IronPort-AV: E=Sophos;i="4.43,285,1246863600"; 
   d="scan'208";a="3955074"
Received: from prattle.redback.com ([155.53.12.9])
  by mgate.redback.com with ESMTP; 28 Jul 2009 18:29:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by prattle.redback.com (Postfix) with ESMTP id 29706D6C15A;
	Tue, 28 Jul 2009 18:29:34 -0700 (PDT)
Received: from prattle.redback.com ([127.0.0.1])
 by localhost (prattle [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18886-06; Tue, 28 Jul 2009 18:29:34 -0700 (PDT)
Received: from localhost (login004.redback.com [155.53.12.57])
	by prattle.redback.com (Postfix) with ESMTP id B588ED6C15B;
	Tue, 28 Jul 2009 18:29:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <adf1fd3d0907281713t378440eamb39baae3be6d41c4@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124292>

On Tue, Jul 28, 2009 at 05:13:30PM -0700, Santi B=E9jar wrote:
>2009/7/27 Tom Grennan <tgrennan@redback.com>:
>> git-request-pull.sh should use git-parse-remote:get_uploadpack() to
>> load a configured remote.REMOTE.uploadpack like "git remote show" an=
d
>> "git fetch". This allows one to specify the path of git-upload-pack =
on
>> the remote side.
>
>Sorry, but I removed all unused functions from git-parse-remote in 62d=
955f
>(parse-remote: remove unused functions, 2009-06-12), and it is in
>v1.6.4-rc1. I don't think there is much problem reverting part of that=
 commit,
>but I wonder if the problem is that "git ls-remote" does not read the
>remote.<remote>.uploadpack by itself as it reads the remote.<remote>.u=
rl.
>
>Santi

Thanks for the hint.

Yes, "git ls-remote" is retrieving remote.<remote>.uploadpack when
dest is a configured remote.  However, git-request-pull runs ls-remote
after converting its URL argument from remote.<remote>.url

The following works with v1.6.4-rc3-12-gdf73af5

If you wish, I'll submit an alternative patch.

--=20
TomG

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 5917773..fd95bea 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -28,13 +28,13 @@ headrev=3D`git rev-parse --verify "$head"^0` || exi=
t
 merge_base=3D`git merge-base $baserev $headrev` ||
 die "fatal: No commits in common between $base and $head"
=20
-url=3D$(get_remote_url "$url")
 branch=3D$(git ls-remote "$url" \
 	| sed -n -e "/^$headrev	refs.heads./{
 		s/^.*	refs.heads.//
 		p
 		q
 	}")
+url=3D$(get_remote_url "$url")
 if [ -z "$branch" ]; then
 	echo "warn: No branch of $url is at:" >&2
 	git log --max-count=3D1 --pretty=3D'tformat:warn:   %h: %s' $headrev =
>&2
