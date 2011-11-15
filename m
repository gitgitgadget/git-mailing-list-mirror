From: Junio C Hamano <gitster@pobox.com>
Subject: Re: odd name-rev behavior?
Date: Tue, 15 Nov 2011 15:23:31 -0800
Message-ID: <7vlirht1fw.fsf@alter.siamese.dyndns.org>
References: <20111115211514.GE27706@comcast.net>
 <7vpqgtt1kb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Walberg <twalberg@comcast.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 00:23:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQSLq-0005GA-FB
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 00:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757485Ab1KOXXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 18:23:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37275 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757284Ab1KOXXd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 18:23:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 249095BB8;
	Tue, 15 Nov 2011 18:23:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0bIBmOvVjp9xhjZHt/y9omQV0HQ=; b=ODYD3G
	ZCK03Vhe/iNTcis7CMp55JAeYi/qrnE6iz5P81msDaRZWsgb3T+nmGHA9v4WDIYE
	JngJnaafI1oeHi2sjYy7QfUvk6imG04GVJyw/bEj86B31qg+gXwWozWtTaOHJbzF
	VsziFEonoVF9txGqoKQBiSpdEnG89v5CmJPRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vacGFJZroLMK1M+LgUxc1MUrCvTs2Pnt
	GkLZcSlJxBO+v5pq5CJuGcEtrsARxXjEFAQVXYxqUu2BAP5A7YJ1kfmUIOSgmscf
	uWy2X4zmVG1O3L0Rd19NjQ2rbvb4YhfnzXmf/qXKpqtsE8smYGe37hxHgXLUd97L
	Ef2D9Af/820=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BC785BB7;
	Tue, 15 Nov 2011 18:23:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A72D25BB6; Tue, 15 Nov 2011
 18:23:32 -0500 (EST)
In-Reply-To: <7vpqgtt1kb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 15 Nov 2011 15:20:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5818014-0FE0-11E1-AA08-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185498>

Junio C Hamano <gitster@pobox.com> writes:

> Tim Walberg <twalberg@comcast.net> writes:
>
>> Never noticed this before - is this expected? It doesn't seem to
>> match documentation, in any case...
>>
>> Basically, 'git name-rev --all' lists a lot of lines that are
>> marked as "undefined", and most, if not all, of the objects
>> represented are trees, not commits... I wouldn't have expected
>> name-rev to follow the link from a commit to a tree and try to
>> process that result...
>
> I wouldn't either, but this does not look like a recent breakage. v1.6.0
> seems to show the same broken behaviour.

And this one-liner should be sufficient (untested).

 builtin/name-rev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 7864056..1b37458 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -291,7 +291,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		max = get_max_object_index();
 		for (i = 0; i < max; i++) {
 			struct object *obj = get_indexed_object(i);
-			if (!obj)
+			if (!obj || obj->type != OBJ_COMMIT)
 				continue;
 			show_name(obj, NULL,
 				  always, allow_undefined, data.name_only);
