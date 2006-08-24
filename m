From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 6] gitweb: Add git_get_{following,preceding}_references functions
Date: Thu, 24 Aug 2006 19:37:04 +0200
Message-ID: <200608241937.04849.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Aug 24 19:46:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGJHF-00011m-AC
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 19:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbWHXRp7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 24 Aug 2006 13:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbWHXRp6
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 13:45:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:14929 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030427AbWHXRp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 13:45:57 -0400
Received: by nf-out-0910.google.com with SMTP id o25so638000nfa
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 10:45:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Pu0u82h/PEa/csrnWxDwkxvrma/fL0YM+1UpDMP5RZs5xZasHc/nGpUvc/lW4GDR4nFMjez/qMdZuq0ysNb8rkH+C3wN1QNkPrXxb5dYovoHVxteWhyAz7B4LqUm3tVn62PdLuEsuHXwLUviCm1mpITGdnJX0X1wrWxDvZs8S7Y=
Received: by 10.48.210.16 with SMTP id i16mr3995139nfg;
        Thu, 24 Aug 2006 10:45:56 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id p20sm4867170nfc.2006.08.24.10.45.55;
        Thu, 24 Aug 2006 10:45:56 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25963>

Adds git_get_following_references function, based on code which was
used in git_commitdiff_plain to generate X-Git-Tag: header,
and companion git_get_preceding_references function.

Both functions return array of all references of given type (as
returned by git_get_references) following/preceding given commit in
array (list) context, and last following/first preceding ref in scalar
context.

Stripping ref (list of refs) of "$type/" (e.g. "tags/") is left to
caller.

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

Actually, the two following patches adresses this, not this patch...

 gitweb/gitweb.perl |   52 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d72b19a..2d3776a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -749,6 +749,58 @@ sub git_get_references {
 	return \%refs;
 }
=20
+sub git_get_following_references {
+	my $hash =3D shift || return undef;
+	my $type =3D shift;
+	my $base =3D shift || $hash_base || "HEAD";
+
+	my $refs =3D git_get_references($type);
+	open my $fd, "-|", $GIT, "rev-list", $base
+		or return undef;
+	my @commits =3D map { chomp; $_ } <$fd>;
+	close $fd
+		or return undef;
+
+	my @reflist;
+	my $lastref;
+
+	foreach my $commit (@commits) {
+		foreach my $ref (@{$refs->{$commit}}) {
+			$lastref =3D $ref;
+			push @reflist, $lastref;
+		}
+		if ($commit eq $hash) {
+			last;
+		}
+	}
+
+	return wantarray ? @reflist : $lastref;
+}
+
+sub git_get_preceding_references {
+	my $hash =3D shift || return undef;
+	my $type =3D shift;
+
+	my $refs =3D git_get_references($type);
+	open my $fd, "-|", $GIT, "rev-list", $hash
+		or return undef;
+	my @commits =3D map { chomp; $_ } <$fd>;
+	close $fd
+		or return undef;
+
+	my @reflist;
+	my $firstref;
+
+	foreach my $commit (@commits) {
+		foreach my $ref (@{$refs->{$commit}}) {
+			$firstref =3D $ref unless $firstref;
+			push @reflist, $ref;
+		}
+	}
+
+	return wantarray ? @reflist : $firstref;
+}
+
 ## -------------------------------------------------------------------=
---
 ## parse to hash functions
=20
--=20
1.4.1.1
