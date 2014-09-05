From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCHv3 1/4] am: avoid re-directing stdin twice
Date: Fri, 05 Sep 2014 15:16:19 -0700
Message-ID: <xmqqk35hpvbg.fsf@gitster.dls.corp.google.com>
References: <1409911611-20370-1-git-send-email-judge.packham@gmail.com>
	<1409911611-20370-2-git-send-email-judge.packham@gmail.com>
	<540A1C7B.80109@kdbg.org>
	<CAFOYHZBct1CRA+NumVMvbbuELWTRoGL5FkhBfHD2Wk7QZVe1fA@mail.gmail.com>
	<xmqqoautpw1g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, GIT <git@vger.kernel.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 00:16:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ1o1-0002i8-0T
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 00:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbaIEWQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 18:16:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60147 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740AbaIEWQX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 18:16:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 72C9636D8B;
	Fri,  5 Sep 2014 18:16:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B2DET7GLOr7tDI1UjMF4xxHSqtg=; b=pdDa6v
	IDTdvAIcIwuEzzW03Z1Hi4QHTMrfDtL6Kz74iTSh/WvJ+p+nMEyL8kAkQ95qlh6L
	sIuN1nTnNF93aUnlKIOIt81UOZyylit01/TX+aqcUZjuf3Iy1KysrGk6rsWfUyiV
	J5XjLaHh8eLWC4BZjYnX5bVExS6/hiTAEM6/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AXsKKHGNRClpC23gHeaDyHzyCph+tGCy
	Sc24rcfo07n0aBialcPICoCYsIWhFE4rIFWJJBqezaL7dhzbKu0ABItOpcj1yTLr
	yX/0ZQ7V8SAK0+qAdtRudkLqqsiFAaeVeDCWuPEaqcpzRD2V2BLeG0ReRpYTujB5
	CTJj4+5oB3g=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 69CE836D8A;
	Fri,  5 Sep 2014 18:16:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DBFA636D88;
	Fri,  5 Sep 2014 18:16:21 -0400 (EDT)
In-Reply-To: <xmqqoautpw1g.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 05 Sep 2014 15:00:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 446261D8-354A-11E4-81E0-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256545>

Junio C Hamano <gitster@pobox.com> writes:

> Also,
>
>>>> -                     tr -d '\015' <"$1" |
>>>>                       sed -n -e '/^$/q' -e '/^[       ]/d' -e p |
>>>>                       sane_egrep -v '^[!-9;-~]+:' >/dev/null ||
>>>>                       patch_format=mbox
>
> as the tr is at an upsteam of this pipeline, it does not really
> matter to the outcome if it gives a write-error error message or not
> (the downstream sane_egrep would have decided, based on the data it
> was given, if the payload was mbox format), so...
>
> An easier workaround may be to update the sed script downstream of
> tr.  It stops reading as soon as it finished to save cycles, and tr
> should know that it does not have to produce any more output.  For a
> broken tr installation, the sed script could be taught to slurp
> everything in the message body (without passing it to downstream
> sane_egrep, of course), and your "tr" would not see a broken pipe.
>
> But that is still a workaround, not a fix, and an expensive one at
> that.

Redoing what e3f67d30 (am: fix patch format detection for
Thunderbird "Save As" emails, 2010-01-25) tried to do without
wasting a fork and a pipe may be a workable improvement.

I see Stephen who wrote the original "Thunderbird save-as" is
already on the Cc list.  How about doing it this way instead?

 git-am.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index ee61a77..9db3846 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -250,8 +250,7 @@ check_patch_format () {
 			# discarding the indented remainder of folded lines,
 			# and see if it looks like that they all begin with the
 			# header field names...
-			tr -d '\015' <"$1" |
-			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p |
+			sed -n -e '/^$/q' -e '/^\r$/q' -e '/^[ 	]/d' -e p <"$1" |
 			sane_egrep -v '^[!-9;-~]+:' >/dev/null ||
 			patch_format=mbox
 		fi
