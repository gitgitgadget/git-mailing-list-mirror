From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] travis-ci: override CFLAGS properly, add -Wdeclaration-after-statement
Date: Tue, 09 Feb 2016 09:47:41 -0800
Message-ID: <xmqqlh6t4vya.fsf@gitster.mtv.corp.google.com>
References: <1454921958-53129-1-git-send-email-larsxschneider@gmail.com>
	<20160208122551.GD24217@sigill.intra.peff.net>
	<9FBB5AFB-D44C-43A1-A0C5-A5A45675A122@gmail.com>
	<20160209173622.GA28699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>, linux.mdb@gmail.com,
	Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 18:47:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTCOD-0000Ig-9a
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 18:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbcBIRrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 12:47:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61919 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932103AbcBIRro (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 12:47:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 78D0E409A1;
	Tue,  9 Feb 2016 12:47:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1C4TbJoCgvZH9MoofUceRIZbsO8=; b=h3VaAV
	F1R1CmPlhI/TzkhFO2aXe5EMnfgrJJbl5Re1h7p6UzY2v5m3d3uK/ywwMLAOC/mn
	qI2uKXy7/qziiPN1aoQQ/ooumAf7HisnijLZLR4DQak1GDFcg4dsprNp2xfJwfTe
	rXDdjm/Zo0f3C40scjwKyUAH4eBMoEse/zNUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IT0tFExawNL5m27jJFRgYEqPG/VEIZ6n
	gklZAYu9Rk1MLKARYeRbL625KmKMYc41BmCQ9zr4zZGZ6dfydMa+k0y/LynnqDFk
	hAqx3YgT2MJo8Qy32BHVHd/tdWmCfTPNsfJImRkxAnU168AukJDLcWhjlUuhArUY
	sc5yZlNtqns=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 70CCE409A0;
	Tue,  9 Feb 2016 12:47:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D6BD74099F;
	Tue,  9 Feb 2016 12:47:42 -0500 (EST)
In-Reply-To: <20160209173622.GA28699@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 9 Feb 2016 12:36:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 385F6A9C-CF55-11E5-B7D2-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285844>

Jeff King <peff@peff.net> writes:

> Perhaps. I'm not sure that people actually use checkpatch.pl for git.
>
> Out of curiosity, I tried:
>
>   mkdir out
>   git format-patch -o out v2.6.0..v2.7.0
>   checkpatch.pl out/*
>
> It's rather noisy, and after skimming, I'd say (subjectively) that only
> a small fraction are actual style issues we try to enforce. So it would
> certainly need a fair bit of tweaking for regular use, I think.
>
> -Peff

FWIW, I use the attached (it assumes a recent kernel checkout at
certain location and checkpatch-original.pl being a symlink to it)
occasionally.  I found patches from some people are consistently
clean and suspect they may be running checkpatch themselves.

-- >8 -- Meta/CP (not on 'todo' branch) -- >8 --
#!/bin/sh

# Run checkpatch on the series
Meta=$(git rev-parse --show-cdup)Meta
cp0="$Meta/checkpatch-original.pl"
cp1="$Meta/checkpatch.pl"
tmp="/var/tmp/CP.$$"

mkdir "$tmp" || exit
trap 'rm -fr "$tmp"' 0

if	! test -f "$cp1" ||
	test "$cp0" -nt "$cp1"
then
	cat "$cp0" >"$cp1" &&
	(cd "$Meta" &&
patch -p1 <<\EOF
--- a/checkpatch.pl
+++ b/checkpatch.pl
@@ -282,6 +282,8 @@
 	Reviewed-by:|
 	Reported-by:|
 	Suggested-by:|
+	Helped-by:|
+	Mentored-by:|
 	To:|
 	Cc:
 )};
@@ -2338,7 +2340,7 @@
 
 # check for new typedefs, only function parameters and sparse annotations
 # make sense.
-		if ($line =~ /\btypedef\s/ &&
+		if (0 && $line =~ /\btypedef\s/ &&
 		    $line !~ /\btypedef\s+$Type\s*\(\s*\*?$Ident\s*\)\s*\(/ &&
 		    $line !~ /\btypedef\s+$Type\s+$Ident\s*\(/ &&
 		    $line !~ /\b$typeTypedefs\b/ &&
@@ -2607,8 +2609,7 @@
 
 				# No spaces for:
 				#   ->
-				#   :   when part of a bitfield
-				} elsif ($op eq '->' || $opv eq ':B') {
+				} elsif ($op eq '->') {
 					if ($ctx =~ /Wx.|.xW/) {
 						ERROR("SPACING",
 						      "spaces prohibited around that '$op' $at\n" . $hereptr);

EOF
)
fi || exit

cat "$@" | git mailsplit -b -o"$tmp" >/dev/null

for mail in "$tmp"/*
do
	(
		git mailinfo -k "$mail.msg" "$mail.patch" >"$mail.info" <"$mail"
		echo
		cat "$mail.msg"
		printf "%s\n" -- "---"
		cat "$mail.patch"
	) >"$mail.mbox"
	perl "$Meta/checkpatch.pl" $ignore --no-tree --max-line-length=120 "$mail.mbox" || {
		grep "Subject: " "$mail.info"
		printf "%s\n" -- "------------------------------------------------"
	}
done
