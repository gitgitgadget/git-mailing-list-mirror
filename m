From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] stash: default listing to "--cc --simplify-combined-diff"
Date: Wed, 30 Jul 2014 12:43:09 -0700
Message-ID: <xmqqtx5yy6nm.fsf@gitster.dls.corp.google.com>
References: <20140729175300.GA21536@peff.net>
	<20140729175725.GE31181@peff.net>
	<xmqqppgo2dqr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 30 21:43:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCZmV-0005DR-9M
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 21:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbaG3TnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 15:43:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54382 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbaG3TnS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 15:43:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 21F622CE38;
	Wed, 30 Jul 2014 15:43:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hswPYC9t8sKBXxq5UyEkU70bvlg=; b=hS9PGQ
	BSqrr4/Pdd2JlAum3C5Ay3DW3NzYd4VxIrEZgjtMfVG25U+9JY72MQ5jxTB3zCl8
	VETJvAfkaOedPfwgEp5BLpX3+vSrQbNKxodJ90szGaroOXrP52+1Y9qmN6AH/8rO
	h8fOyb+bCKtalV+puQm0FXMj1hhRqesyMntFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TDoVBEY0Yq8ZvD6muPCi+bJfbsn5hY5f
	ieENSHHNDfWlAcHiD3giPFKvXKck6D4y2S1yq6Y376de99rI5VHCXUp0TMr2LhSg
	EU6sLqr/ZvKFwqWCa5cUnh67gAwCZW33WtVKOdCh324hLo2nWiuQusu0NC5obnc3
	Y32SAoNnfqM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 17C8E2CE37;
	Wed, 30 Jul 2014 15:43:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C9912CE2F;
	Wed, 30 Jul 2014 15:43:11 -0400 (EDT)
In-Reply-To: <xmqqppgo2dqr.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 29 Jul 2014 11:58:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BD1F8AB0-1821-11E4-84DF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254514>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> When you list stashes, you can provide arbitrary git-log
>> options to change the display. However, adding just "-p"
>> does nothing, because each stash is actually a merge commit.
>>
>> This implementation detail is easy to forget, leading to
>> confused users who think "-p" is not working. We can make
>> this easier by specifying "--cc" as a default ourselves
>> (which does nothing if no diff format is requested by the
>> user).
>
> Sigh.
>
> "git log --cc" is one of the things I wanted for a long time to fix.
> When the user explicitly asks "--cc", we currently ignore it, but
> because we know the user wants to view combined diff, we should turn
> "-p" on automatically.  And the change this patch introduces will be
> broken when we fix "log --cc" ("stash list" will end up always
> showing the patch, without a way to disable it).
>
> Can you make this conditional?  Do this only when <options> are
> given to "git stash list" command and that includes "-p" or
> something?

Perhaps something along this line?

 git-stash.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index ae73ba4..0db1b19 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -297,8 +297,15 @@ have_stash () {
 
 list_stash () {
 	have_stash || return 0
-	git log --format="%gd: %gs" -g --cc --simplify-combined-diff \
-		"$@" $ref_stash --
+	case " $* " in
+	*' --cc '*)
+		;; # the user knows what she is doing
+	*' -p '* | *' -U'*)
+		set x "--cc" "--simplify-combined-diff" "$@"
+		shift
+		;;
+	esac
+	git log --format="%gd: %gs" -g "$@" $ref_stash --
 }
 
 show_stash () {
