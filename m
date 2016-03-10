From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Sample pre-push hook can crash
Date: Thu, 10 Mar 2016 13:43:08 -0800
Message-ID: <xmqq37rydn6b.fsf@gitster.mtv.corp.google.com>
References: <CAH8BJxHeyfpKsvjGfg5ZJ5YDQk6pzZp4ufHVEV=cFriL8j_4uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stephen Morton <stephen.c.morton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 22:43:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae8MV-0006Cs-Gh
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 22:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbcCJVnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 16:43:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55915 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932180AbcCJVnL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 16:43:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2FB7649C81;
	Thu, 10 Mar 2016 16:43:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7RSz0327eqLN6CRpASWyIudfbfg=; b=yNiGXY
	2AZOEkTccHxImFnYPjKhnPJCDBg3davbGBpQEt7KSw+8AM/fAAHjTE6EBCdO2WA9
	jXnFO8dwZFzqVLmB7v/ZebnY2i7w8bZMAP03scGSto9Ua+txhbhQDkJMJSw9LbLV
	x9vv5shXlz0jVhhT8rfJz1wQ7RW03TU9EHJdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Inkk9GcPRKJnoWl04RGi33WCXBok0hjk
	OgZmeBpaXF8Kwhv6QV+er/gBUl53VHZV8TecydIE6yQ3OqIe7C7Lxn3S7XUQx5oo
	p+kzWAh1zDvLTFgfTBZmhbxfirat2eQ0ZQAW1sbzg2u3uOaBprU/ATF8EO2FAcl0
	m2o435JXCF8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2659349C80;
	Thu, 10 Mar 2016 16:43:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9884849C7D;
	Thu, 10 Mar 2016 16:43:09 -0500 (EST)
In-Reply-To: <CAH8BJxHeyfpKsvjGfg5ZJ5YDQk6pzZp4ufHVEV=cFriL8j_4uw@mail.gmail.com>
	(Stephen Morton's message of "Thu, 10 Mar 2016 16:22:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 14EBC58A-E709-11E5-9541-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288647>

Stephen Morton <stephen.c.morton@gmail.com> writes:

> The sample pre-push hook provided with git [1] will crash if the local
> repo is not up to date with the remote as $remote_sha is not present
> in the local repo. I'm not sure if this patch is exactly correct, it's
> just provided as an example.
>
> Given that people are likely crafting their own solutions based on the
> examples, it's probably good to get right.

It's probably good to get right, but I do not think use of @{u} is
making it right, unfortunately.  You may not necessarily have @{u}
configured, and you may not even pushing to the configured remote
branch.

The spirit of the sample hook, I think, is to validate the new
commits you are publishing, so if you cannot even determine which
ones are new and which ones are not, failing the "push" by exiting
with non-zero status is the right behaviour for this sample.

So perhaps something like this may be more appropriate as an
example.

 templates/hooks--pre-push.sample | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
index 6187dbf..7ef6780 100755
--- a/templates/hooks--pre-push.sample
+++ b/templates/hooks--pre-push.sample
@@ -41,7 +41,12 @@ do
 		fi
 
 		# Check for WIP commit
-		commit=`git rev-list -n 1 --grep '^WIP' "$range"`
+		commit=`git rev-list -n 1 --grep '^WIP' "$range"` || {
+			# we do not even know about the range...
+			echo >&2 "Non-ff update to $remote_ref"
+			echo >&2 "fetch from there first"
+			exit 1
+		}
 		if [ -n "$commit" ]
 		then
 			echo >&2 "Found WIP commit in $local_ref, not pushing"
