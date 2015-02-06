From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] apply: do not allow reversing a 'copy' patch
Date: Fri, 06 Feb 2015 15:06:01 -0800
Message-ID: <xmqqa90qd4iu.fsf@gitster.dls.corp.google.com>
References: <xmqqvbjed76s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 00:06:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJryV-0002xo-5P
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 00:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245AbbBFXGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 18:06:06 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55364 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753096AbbBFXGE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 18:06:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 10D07344C4;
	Fri,  6 Feb 2015 18:06:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S4Shd96ZhyLRt+SXg8n3Fh0KFdk=; b=HZmIrI
	WxnAIYI9bMUYym55VzAVemYBiNFf/lUkTltMMFwf+gn2JaXGOrZnOy0wtn7NWsO1
	w+X0qTip6nEXpePRUPcvWB+qab9rOCy5GUZiKngHVSu7cg1+lCBNWkkjyrfjnv2q
	A2qO9JOG9sNUeBKQJ5zfkPaqJLviLhvfhOcrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wLRZFk5e5T8jgxvDpgFwx96FYMYX7lnl
	sMITCG3g3lvJ8RMha0ILjg/4czu1YIU3rIQhdYUCfHgQzcCOKvHYnL0vC/kdQOlI
	Rho8UmK9RG2jZVOsv+nP3PqDZwK5f3AGmbla7SwLK6doBoZPLa/uODcF0FAa68CL
	q/tlP/HWu2E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 07F27344C3;
	Fri,  6 Feb 2015 18:06:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80E3D344C2;
	Fri,  6 Feb 2015 18:06:02 -0500 (EST)
In-Reply-To: <xmqqvbjed76s.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 06 Feb 2015 14:08:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B89700E4-AE54-11E4-ADCF-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263434>

Junio C Hamano <gitster@pobox.com> writes:

>         Action item: warn users against using "apply -R" on a
>         patchset with such a patch while this is fixed.

This needs to be replaced with the logic to properly reverse a patch
that creates a new file by copying from somewhere else, but for now,
this would be a good idea to prevent lossages from happening.

 builtin/apply.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index 0aad912..b33b403 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2069,6 +2069,9 @@ static void reverse_patches(struct patch *p)
 	for (; p; p = p->next) {
 		struct fragment *frag = p->fragments;
 
+		if (p->is_copy)
+			die(_("sorry, cannot apply a 'copying' patch in reverse (yet)"));
+
 		swap(p->new_name, p->old_name);
 		swap(p->new_mode, p->old_mode);
 		swap(p->is_new, p->is_delete);
