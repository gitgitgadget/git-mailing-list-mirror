From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCHv3 1/4] am: avoid re-directing stdin twice
Date: Fri, 05 Sep 2014 15:25:06 -0700
Message-ID: <xmqqfvg5puws.fsf@gitster.dls.corp.google.com>
References: <1409911611-20370-1-git-send-email-judge.packham@gmail.com>
	<1409911611-20370-2-git-send-email-judge.packham@gmail.com>
	<540A1C7B.80109@kdbg.org>
	<CAFOYHZBct1CRA+NumVMvbbuELWTRoGL5FkhBfHD2Wk7QZVe1fA@mail.gmail.com>
	<xmqqoautpw1g.fsf@gitster.dls.corp.google.com>
	<xmqqk35hpvbg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, GIT <git@vger.kernel.org>,
	Chris Packham <judge.packham@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 00:25:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ1wT-0000eK-CY
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 00:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbaIEWZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 18:25:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53029 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931AbaIEWZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 18:25:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 34B23371A1;
	Fri,  5 Sep 2014 18:25:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9uISCWmhiXWVyT6B4M8VFRD6JFs=; b=aQYoOp
	vZxrmbJtt1/7vllLjNqfo/jAJ8vCMFAkN9FqCRkq73o0+3SV+vcw1C4zcwNVXt42
	rW/PbO03Z/lCTT19pST/UUjvWGcW2KPwqKtds6py746M5lECjWXD3YWdltjuoNmp
	DMosGXoik925rSy8dwyhKnV/4LAVY4SrciZHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OpLshGiJ7EZkCN7adfPyWsgvOEjgx2qv
	8ATglW356BIWVHqrSpRCOfNfV2kZNiouKzeg5NFq1XMmEehVnKFDMrA83WrTkRKO
	nN7F+cVYmvQxKmRRDBOUmTd0600N82xosinW0x13xXFuaW/fyO6qSDYlRdapHvbp
	hKnmZ8bHQpc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F213371A0;
	Fri,  5 Sep 2014 18:25:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 896833719F;
	Fri,  5 Sep 2014 18:25:08 -0400 (EDT)
In-Reply-To: <xmqqk35hpvbg.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 05 Sep 2014 15:16:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7E4D6572-354B-11E4-93B4-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256547>

Junio C Hamano <gitster@pobox.com> writes:

> Redoing what e3f67d30 (am: fix patch format detection for
> Thunderbird "Save As" emails, 2010-01-25) tried to do without
> wasting a fork and a pipe may be a workable improvement.
>
> I see Stephen who wrote the original "Thunderbird save-as" is
> already on the Cc list.  How about doing it this way instead?

Not that way, but more like this.

 git-am.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index ee61a77..32e3039 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -250,8 +250,7 @@ check_patch_format () {
 			# discarding the indented remainder of folded lines,
 			# and see if it looks like that they all begin with the
 			# header field names...
-			tr -d '\015' <"$1" |
-			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p |
+			sed -n -e 's/\r$//' -e '/^$/q' -e '/^[ 	]/d' -e p |
 			sane_egrep -v '^[!-9;-~]+:' >/dev/null ||
 			patch_format=mbox
 		fi
