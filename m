From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] git-merge-one-file: revise merge error reporting
Date: Mon, 25 Mar 2013 10:04:56 -0700
Message-ID: <7vk3ovz9zb.fsf@alter.siamese.dyndns.org>
References: <CAJDDKr4swZzzv3e+Huz72CVmisFKU8T74jFj3-uGmZHReRGVBw@mail.gmail.com>
 <1364127985-13366-1-git-send-email-kevin@bracey.fi>
 <1364127985-13366-4-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon Mar 25 18:05:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKAqH-0001S6-B2
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 18:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373Ab3CYRFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 13:05:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33658 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758688Ab3CYRE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 13:04:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69C6EB47F;
	Mon, 25 Mar 2013 13:04:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yZns0CyOpZqVFZKulqregqS/yC8=; b=ZQSRxi
	NpygdjsaAQQ6Xg8zrAX261zeTq/FW650E+pqqlCHV0EwOrANOILvmohXdCg+IkA8
	4ir+b/Lb2yEFzMXlQcX9FGqPRUVJtZIh+MDDcZz7/Ee8lK6IpXly6QfhvTBl+CVE
	7y+S8kkHVCeAcask3B11TVt7xLbMtiWAozCxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w5CTSbJE4UpUaJjtIMVFym6Ho0bfN8MP
	YJoL7X7APLEsL1jyL/dL1G7fQ5fmtF6hOpc8fU0LNY0kZqj8oTpcDpYPMql/89lE
	vTBKKo6wJhFKqK//whManCrm23JX5UnkKuFeJwXutcyKSQmu3tfK4JhvPmnObex7
	UPzcZL8CKiA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DF01B47E;
	Mon, 25 Mar 2013 13:04:58 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD756B47D; Mon, 25 Mar 2013
 13:04:57 -0400 (EDT)
In-Reply-To: <1364127985-13366-4-git-send-email-kevin@bracey.fi> (Kevin
 Bracey's message of "Sun, 24 Mar 2013 14:26:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F41347E-956E-11E2-99A9-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219046>

Kevin Bracey <kevin@bracey.fi> writes:

> Commit 718135e improved the merge error reporting for the resolve
> strategy's merge conflict and permission conflict cases, but led to a
> malformed "ERROR:  in myfile.c" message in the case of a file added
> differently.
>
> This commit reverts that change, and uses an alternative approach without
> this flaw.
>
> Signed-off-by: Kevin Bracey <kevin@bracey.fi>

We used to treat "Both added differently" as a separate "info"
message, just like the "Auto-merging" message, and let "content
conflict" that is an "error" to happen naturally by doing such a
merge, possibly followed by permission conflict which is another
kind of "error".  We coalesced these two into a single message.

And this patch breaks them into separate messages.  I am not sure if
that aspect of the change is desirable.

The source of "malformed" message seems suspicious.  Isn't the root
cause of $msg being empty that merge-file can (sometimes) cleanly
merge two files using the phoney base in the "both added
differently" codepath?

If you resolve that issue by forcing a "conflicted" failure when we
handle "add/add" conflict, I think the behaviour of the remainder of
the code is better in the original than the updated one.

Perhaps something like this (I am applying these on 'maint')?

 git-merge-one-file.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 25d7714..aa06282 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -107,6 +107,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 		;;
 	esac
 
+	add_add_conflict=
 	src2=`git-unpack-file $3`
 	case "$1" in
 	'')
@@ -121,6 +122,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 		# If we do not have enough common material, it is not
 		# worth trying two-file merge using common subsections.
 		expr $sz0 \< $sz1 \* 2 >/dev/null || : >$orig
+		add_add_conflict=yes
 		;;
 	*)
 		echo "Auto-merging $4"
@@ -128,15 +130,13 @@ case "${1:-.}${2:-.}${3:-.}" in
 		;;
 	esac
 
-	# Be careful for funny filename such as "-L" in "$4", which
-	# would confuse "merge" greatly.
 	src1=`git-unpack-file $2`
-	git merge-file "$src1" "$orig" "$src2"
-	ret=$?
-	msg=
-	if test $ret != 0
+
+	ret=0 msg=
+	if git merge-file "$src1" "$orig" "$src2" || test -n "$add_add_conflict"
 	then
 		msg='content conflict'
+		ret=1
 	fi
 
 	# Create the working tree file, using "our tree" version from the
