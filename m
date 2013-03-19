From: Junio C Hamano <gitster@pobox.com>
Subject: Re* git merge <tag> behavior
Date: Tue, 19 Mar 2013 10:54:03 -0700
Message-ID: <7v7gl3jmx0.fsf_-_@alter.siamese.dyndns.org>
References: <1363704914.6289.39.camel@test.quest-ce.net>
 <7vfvzrjrad.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 18:54:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI0k8-0004Jn-VY
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 18:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933411Ab3CSRyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 13:54:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57133 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933011Ab3CSRyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 13:54:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D3C9ACD9;
	Tue, 19 Mar 2013 13:54:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G9LRxPfeeYPVGmf/oAgwOsQFafw=; b=DQPaiD
	sNwbalYBRFykbLPVq1sThNBIQ9dHYAKn3A6DCO4WYRXHa2zVC0v0KUrks2DJXYe1
	4cl6fCUFswsXtE2+YZAtfGORZ9NIJgGk16np8lRlOQmOfW0FY1mV4qf2etOAL0og
	9hQDPztuIeGpych+hX1HrV2Mm+K3GxK3GL1PY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XjjZcHlWcNtY4xkXCKtouToQGb+melqo
	iSpn8eMdofnAZZD3BI9ecPBawU64dULJrTgm2QIFEjcZGtXw5vWPxmyZAyvNvc0A
	mbkGN/DO7shKxLEnJWM+svyjie0A48kr4UqDGbEFTtyReIWJhDgBDpzS3OjqcqqZ
	09vWv2EnCVo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44F40ACD5;
	Tue, 19 Mar 2013 13:54:06 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88282ACD0; Tue, 19 Mar 2013
 13:54:05 -0400 (EDT)
In-Reply-To: <7vfvzrjrad.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 19 Mar 2013 09:19:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDCA8228-90BD-11E2-B13C-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218540>

Junio C Hamano <gitster@pobox.com> writes:

>> 2) git merge <tag> VS git merge <object-id>
>> ...
>> It would be great to have Git using the tag message and check the
>> signature.
>
> Perhaps, but if you feed the $(git rev-parse v1.12.2) to merge, your
> subject will not be able to say "Merge tag 'v1.12.2'" in the first
> place, so I do not think you would want to encourage such usage in
> the first place.

A patch to do so may look like this.  You would probably want to
also do read_sha1_file(desc->obj->sha1) here and parse out the
header line "tag " to replace the "remote" to recover the symbolic
tag name, but I didn't bother in this illustration.

diff --git a/builtin/merge.c b/builtin/merge.c
index 0ec8f0d..990e90c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -516,6 +516,19 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		strbuf_release(&line);
 		goto cleanup;
 	}
+
+	if (remote_head->util) {
+		struct merge_remote_desc *desc;
+		desc = merge_remote_util(remote_head);
+		if (desc && desc->obj && desc->obj->type == OBJ_TAG) {
+			strbuf_addf(msg, "%s\t\t%s '%s'\n",
+				    sha1_to_hex(desc->obj->sha1),
+				    typename(desc->obj->type),
+				    remote);
+			goto cleanup;
+		}
+	}
+
 	strbuf_addf(msg, "%s\t\tcommit '%s'\n",
 		sha1_to_hex(remote_head->object.sha1), remote);
 cleanup:
