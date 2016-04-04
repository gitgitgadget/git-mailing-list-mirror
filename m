From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [sort-of-BUG] merge-resolve cannot resolve "content/mode" conflict
Date: Mon, 04 Apr 2016 10:34:34 -0700
Message-ID: <xmqqh9fh5lcl.fsf@gitster.mtv.corp.google.com>
References: <20160403052627.GA10487@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 04 19:34:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an8Of-0001EF-Vv
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 19:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834AbcDDRei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 13:34:38 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753591AbcDDReh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 13:34:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 20DDA4FD30;
	Mon,  4 Apr 2016 13:34:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2RPT9Bt8GWLP7WYx0RgRx824YJ4=; b=pGeKik
	SdnjlE+Hb3g4fmln/CoxSqqYqm9HDgAljU5XBCPo5ASpNw8x1b2djaetGndPsF3v
	gAJpy/KVwARX3JCrjLBTp0bKrFaL0kHmjlvQKFs659yDoB3SBj0p1oOMOyZDJZEf
	PqmzwORrBm9VBNoVJH3rjhssB3nP74UwlSUxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bcBYofEu+rodTeY3868+NdJaST+mS75P
	zjYa9KRT2QXlPO2ytpmxa4gW37ouDQO9/BUVtU7VOLdgCOjAt9WSwtmcsZZL0MXa
	Al5erZC9rgmbBbT5/qBiKoIjiYHDgc2R5C2tbseWSooZusb0tUuhiCYG3Nvpr8wA
	9w4Kt9818lI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 18D334FD2F;
	Mon,  4 Apr 2016 13:34:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8BC7F4FD2D;
	Mon,  4 Apr 2016 13:34:35 -0400 (EDT)
In-Reply-To: <20160403052627.GA10487@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 3 Apr 2016 01:26:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7FC7CA12-FA8B-11E5-9D0F-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290706>

Jeff King <peff@peff.net> writes:

> Imagine a merge where one side changes the content of a path and the
> other changes the mode. Here's a minimal reproduction:
>
>   git init repo && cd repo &&
>
>   echo base >file &&
>   git add file &&
>   git commit -m base &&
>
>   echo changed >file &&
>   git commit -am content &&
>
>   git checkout -b side HEAD^
>   chmod +x file &&
>   git commit -am mode
> ...
> This is a leftover from my experiments with merge-resolve versus
> merge-recursive last fall, which resulted in a few actual bug-fixes. I
> looked into fixing this case, too, at that time. It seemed possible, but
> a little more involved than you might think (because the logic is driven
> by a bunch of case statements, and this adds a multiplicative layer to
> the cases; we might need to resolve the permissions, and _then_ see if
> the content can be resolved).

Perhaps I am missing some other codepath in the "multiplicative"
layer, but is this not sufficient?

The convoluted "update-index/chmod" dance is to help those on
filesystems that lack proper executable bits.  Otherwise the last
"update-index --chmod" is not needed.


 git-merge-one-file.sh | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 424b034..36bcdcc 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -142,8 +142,19 @@ case "${1:-.}${2:-.}${3:-.}" in
 	git checkout-index -f --stage=2 -- "$4" && cat "$src1" >"$4" || exit 1
 	rm -f -- "$orig" "$src1" "$src2"
 
-	if test "$6" != "$7"
+	# Three-way merge of the permissions
+	perm= ;# assume the result is the same from stage #2, i.e. $6
+	if test "$6" = "$7" || test "$5" = "$7"
+	then
+		: nothing
+	elif test "$5" = "$6"
 	then
+		case "$7" in
+		100644)	perm=-x ;;
+		100755) perm=+x ;;
+		*) echo "ERROR: $7: funny filemode not handled." >&2 ;;
+		esac
+	else
 		if test -n "$msg"
 		then
 			msg="$msg, "
@@ -157,7 +168,17 @@ case "${1:-.}${2:-.}${3:-.}" in
 		echo "ERROR: $msg in $4" >&2
 		exit 1
 	fi
-	exec git update-index -- "$4"
+
+	if test -n "$perm"
+	then
+		chmod "$perm" -- "$4"
+	fi &&
+	git update-index -- "$4" &&
+	if test -n "$perm"
+	then
+		git update-index --chmod="$perm" -- "$4"
+	fi
+	exit
 	;;
 
 *)
