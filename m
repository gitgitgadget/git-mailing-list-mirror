From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: do not lose SQUASH_MSG contents
Date: Mon, 14 Mar 2016 13:19:08 -0700
Message-ID: <xmqq4mc8ak3n.fsf@gitster.mtv.corp.google.com>
References: <56DAB71E.6000509@cs-ware.de> <56DE5272.2080009@cs-ware.de>
	<xmqq60wwlt0s.fsf@gitster.mtv.corp.google.com>
	<xmqqfuvzil3y.fsf@gitster.mtv.corp.google.com>
	<xmqqziu7h01f.fsf@gitster.mtv.corp.google.com>
	<56E5B3F9.6070404@cs-ware.de>
	<xmqqpouwapnd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Mon Mar 14 21:19:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afYxT-0001KG-Sf
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 21:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068AbcCNUTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 16:19:16 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753187AbcCNUTM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 16:19:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 89AA54BC31;
	Mon, 14 Mar 2016 16:19:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lj9DWxxzLHpns2h/YrvRnF2Nwjs=; b=JJUene
	P14R5EOJ4CurwlJjntWsrF3Sl+hCSYAZBdweyhsdxXF27O10MKzZnUOoyVcGzwms
	qLjsUO2ka5KPuWhNlFKKgBFK4gel+ti9WdOys2ErXbR3pLP9sYqq/Evxh7J5iAzT
	KhedwpzJBjKPCUe6MWfvudxNLsQTzo8QMbcd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a+uYtRjk8gsU08fTluEs5k/ctIllTFam
	XXU3uusit98SJeuLPofP2/pyVuD1s2buhXqiY22eOFrc3tQwt43UO/Cyd+1ipM44
	/CoaEneDA3Al+jnLRwXJPuhY+JL3t3USngrguCK3w3zCH416aeRYI7+YgUirkZQd
	drK1+aqRdLE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7EA774BC30;
	Mon, 14 Mar 2016 16:19:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EDE654BC2F;
	Mon, 14 Mar 2016 16:19:09 -0400 (EDT)
In-Reply-To: <xmqqpouwapnd.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 14 Mar 2016 11:19:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 02B4F29E-EA22-11E5-93AB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288805>

Junio C Hamano <gitster@pobox.com> writes:

>> Place the contents from SQUASH_MSG at the beginning, just like we
>> show the commit log skeleton first when concluding a normal merge,
>> and then show the "# Conflicts:" list, to help the user write the
>> log message for the resulting commit.
>>
>> Signed-off-by: Sven Strickroth <sven@cs-ware.de>
>> ---
>>  builtin/commit.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> The updated code looks good to me; sorry for misleading you with
> fuzzy comments earlier.
>
> We may want to have a test to prevent this from getting broken in
> the future updates.

Perhaps like so:

 t/t7600-merge.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 75c50ee..55b9da4 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -33,9 +33,11 @@ printf '%s\n' 1 2 3 4 5 6 7 8 9 >file
 printf '%s\n' '1 X' 2 3 4 5 6 7 8 9 >file.1
 printf '%s\n' 1 2 3 4 '5 X' 6 7 8 9 >file.5
 printf '%s\n' 1 2 3 4 5 6 7 8 '9 X' >file.9
+printf '%s\n' 1 2 3 4 5 6 7 8 '9 Y' >file.9y
 printf '%s\n' '1 X' 2 3 4 5 6 7 8 9 >result.1
 printf '%s\n' '1 X' 2 3 4 '5 X' 6 7 8 9 >result.1-5
 printf '%s\n' '1 X' 2 3 4 '5 X' 6 7 8 '9 X' >result.1-5-9
+printf '%s\n' 1 2 3 4 5 6 7 8 '9 Z' >result.9z
 >empty
 
 create_merge_msgs () {
@@ -128,6 +130,12 @@ test_expect_success 'setup' '
 	git tag c2 &&
 	c2=$(git rev-parse HEAD) &&
 	git reset --hard "$c0" &&
+	cp file.9y file &&
+	git add file &&
+	test_tick &&
+	git commit -m "commit 7" &&
+	git tag c7 &&
+	git reset --hard "$c0" &&
 	cp file.9 file &&
 	git add file &&
 	test_tick &&
@@ -218,6 +226,26 @@ test_expect_success 'merge c1 with c2' '
 	verify_parents $c1 $c2
 '
 
+test_expect_success 'merge --squash c3 with c7' '
+	git reset --hard c3 &&
+	test_must_fail git merge --squash c7 &&
+	cat result.9z >file &&
+	git commit --no-edit -a &&
+
+	{
+		cat <<-EOF
+		Squashed commit of the following:
+
+		$(git show -s c7)
+
+		# Conflicts:
+		#	file
+		EOF
+	} >expect &&
+	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
+	test_cmp expect actual
+'
+
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 and c3' '
-- 
2.8.0-rc2-154-gd146b22
