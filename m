From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] rebase should desambiguate abbreviated hashes before starting
Date: Thu, 27 Jun 2013 10:01:51 -0700
Message-ID: <7vppv7trls.fsf@alter.siamese.dyndns.org>
References: <20130627105513.6bf84060@chalon.bertin.fr>
	<CAMPXz=pSseQKebNVPVYogTZ2FUc1LqubgmS+pN76sveV=eqC0A@mail.gmail.com>
	<vpq1u7n3jdh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David <bouncingcats@gmail.com>, Yann Dirson <dirson@bertin.fr>,
	git list <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 27 19:01:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsFa3-0005Xa-10
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 19:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367Ab3F0RBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 13:01:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34241 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708Ab3F0RBy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 13:01:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5949429673;
	Thu, 27 Jun 2013 17:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gtBJ4GKHcI3OQk3zepfdYcsXKcA=; b=l3W0XG
	EmCuJ/wZQ4GIAlAobYB/IzP9ndY+VfYXgvrtDZsEbEnhz5vwxJFOpKNeJYPr/0jn
	AgeGUatZO9o6gjqGh4Imrsb7+sQ+Q5hi5srz4QTxSp9PT15tAhI0K/KNVes0I18i
	hNlSju7FligIG6WVzI/YIFlC1duK7lwo4W4OQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VQ3QIhC+2vxvq1ynwO0wiqaLUn9skhFH
	edrbtKKQEATCt48JEcmhA+vxgYzOD/GAtVYardT0AxWaf+tQKM9nwRbtjw0+tD0n
	rS3TE03sRgtqqICWfAhSNJ+saxU2Uc/D6WZGqkFdemejL0Ns1gMMEEK+A4gl8R2g
	MjUMoFYj+y4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D62729672;
	Thu, 27 Jun 2013 17:01:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9827629670;
	Thu, 27 Jun 2013 17:01:52 +0000 (UTC)
In-Reply-To: <vpq1u7n3jdh.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	27 Jun 2013 13:04:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43B9E2D4-DF4B-11E2-83DD-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229120>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> David <bouncingcats@gmail.com> writes:
>
>> I'm not sure that rebase could predict the new hashes without actually creating
>> the prior commits? So maybe the "short" SHA1 is "too short"?
>
> It's OK to show the short sha1 to the user, but "git rebase" could and
> should expand these to complete sha1 right after the editor is closed. I
> think that's what Yann means.

Yes, any "short" is by definition "too short".  I agree that it is
OK to show short one in "rebase -i" instruction sheet, as they are
uniquely generated before the actual replaying of commits begins,
and it is a sensible thing to do to convert them to the full form
before starting to do the real work.

It could be something as simple like this (not tested).

 git-rebase--interactive.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f953d8d..6766b44 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -678,6 +678,23 @@ skip_unnecessary_picks () {
 	die "Could not skip unnecessary pick commands"
 }
 
+# expand shortened commit object name to the full form
+expand_todo_commit_names () {
+	while read -r command rest
+	do
+		case "$command" in
+		'#'*)
+			;;
+		*)
+			sha1=$(git rev-parse --verify --quiet ${rest%% *})
+			rest="$sha1 ${rest#* }"
+			;;
+		esac
+		printf '%s\n' "$command${rest:+ }$rest"
+	done <"$todo" >"$todo.new" &&
+	mv -f "$todo.new" "$todo"
+}
+
 # Rearrange the todo list that has both "pick sha1 msg" and
 # "pick sha1 fixup!/squash! msg" appears in it so that the latter
 # comes immediately after the former, and change "pick" to
@@ -979,6 +996,8 @@ git_sequence_editor "$todo" ||
 has_action "$todo" ||
 	die_abort "Nothing to do"
 
+expand_todo_commit_names
+
 test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
 
 output git checkout $onto || die_abort "could not detach HEAD"
