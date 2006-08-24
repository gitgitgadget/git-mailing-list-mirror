From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 8] gitweb: Add git_get_rev_name_tags function
Date: Thu, 24 Aug 2006 19:41:23 +0200
Message-ID: <200608241941.23804.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Aug 24 19:46:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGJHT-000163-PA
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 19:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbWHXRqB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 24 Aug 2006 13:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbWHXRqB
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 13:46:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:14929 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030433AbWHXRp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 13:45:59 -0400
Received: by nf-out-0910.google.com with SMTP id o25so638000nfa
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 10:45:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tkjAYEUFxuhtL+clmaRblfmclSCIocIb92V6EgFgS7HaSZinUS7UHirQBlqjMFmTqh4i6STx4e+gcM3NmYQLYWTZ8puVPpv8G1+cp+YDzx2KLR6HhEcG432FEV7SMNd8RK6VMPsFH2dRXbnxRoVRoIEB1CYEcSnD66I9Z1FHAxE=
Received: by 10.48.220.15 with SMTP id s15mr4037292nfg;
        Thu, 24 Aug 2006 10:45:58 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id p20sm4867170nfc.2006.08.24.10.45.57;
        Thu, 24 Aug 2006 10:45:58 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25966>

Add git_get_rev_name_tags function, for later use in
git_commitdiff('plain') for X-Git-Tag: header.

This function, contrary to the call to
  git_get_following_references($hash, "tags");
_does_ strip "tags/" and returns bare tag name.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio C Hamano wrote:
>> =A0* "commitdiff_plain" now only generates X-Git-Tag: line only if
>> there is tag pointing to the current commit.
>
> Hmph...
>
>> =A0 =A0...; besides we are
>> =A0 =A0interested rather in tags _preceding_ the commit, and _heads_
>> =A0 =A0following the commit.
>
> Interesting observation. =A0When somebody says "feature X was
> introduced in such and such commit", people would want to know (1)
> the point release they are using has the feature -- which means you
> would want to know the earliest tag that comes after the commit, or
> (2) if the branch they are working on already has that
> feature -- which again means if the head follows the commit. =A0So
> I am not sure when preceding tag is interesting...

This commit introduces function which does job that was intended
I guess for X-Git-Tag: header... perhaps it should be renamed...

 gitweb/gitweb.perl |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a068a81..3bc3ff3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -800,6 +800,22 @@ sub git_get_preceding_references {
 	return @reflist;
 }
=20
+sub git_get_rev_name_tags {
+	my $hash =3D shift || return undef;
+
+	open my $fd, "-|", $GIT, "name-rev", "--tags", $hash
+		or return;
+	my $name_rev =3D <$fd>;
+	close $fd;
+
+	if ($name_rev =3D~ m|^$hash tags/(.*)$|) {
+		return $1;
+	} else {
+		# catches also '$hash undefined' output
+		return undef;
+	}
+}
+
 ## -------------------------------------------------------------------=
---
 ## parse to hash functions
=20
--=20
1.4.1.1
