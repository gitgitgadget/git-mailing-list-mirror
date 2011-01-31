From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] tree_entry_interesting(): with no pathspecs, everything will
 match
Date: Mon, 31 Jan 2011 12:21:40 -0800
Message-ID: <7v62t46cyz.fsf_-_@alter.siamese.dyndns.org>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
 <1292425376-14550-10-git-send-email-pclouds@gmail.com>
 <7vd3ngdaoa.fsf@alter.siamese.dyndns.org>
 <AANLkTik_7FUuocoXa7Rk5DWSR4ie7FBfYNa0MSQzwnsZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 21:22:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk0G6-0006yr-He
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 21:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293Ab1AaUVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 15:21:51 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729Ab1AaUVu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 15:21:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 13E363D76;
	Mon, 31 Jan 2011 15:22:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EC6l1pjJilpoAsPhQr6F7anYESM=; b=ebIO/E
	LCo6TqI4qjJht/bJcQYasotS0W9hJxljMErJNMXqCVpqgNjbKKJN+G9l1pbQU2jm
	wv1/opCqVcD/4VyNpAcfi2Z0REMKgKgOpQyJTSvi42GK7cD1MCT6A4rHXM/macDE
	kh3r+XC8NNrCSqAfYg0lPX8NDMKInas5Dg6SY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t70kizaAHKo1BH/KpULhsVRtEdXybgwm
	BQl+BMQ/BMH6oo5M1Ht6LEtSM24D/T5nD9CoAOteFsSHlt4JhTalD92p6W0xAsKk
	DFkhqc+6JW3Jnh2/gL7vdgmErBBb4pnOnr2LSp8LR76p41q0GfpifdiRPBkc8pgm
	MnFqGNbZsjY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DD1763D75;
	Mon, 31 Jan 2011 15:22:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B5EB53D74; Mon, 31 Jan 2011
 15:22:34 -0500 (EST)
In-Reply-To: <AANLkTik_7FUuocoXa7Rk5DWSR4ie7FBfYNa0MSQzwnsZ@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Sat\, 29 Jan 2011 10\:13\:50 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D925D040-2D77-11E0-8AB8-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165747>

Hence the function should return "2" in such a case as advertised.

Note that finding a directory that busts the depth limit does not mean non
directories at the same level would also bust the limit (they don't), so
we still need to return 1, not 2 in the within_depth() codepath.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
--- 

  Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

  >> When depth check is in effect, the result depends on the mode of the
  >> entry, so we cannot short-circuit by returning 2, but at least we should
  >> do so when (max_depth == -1), no?
  >
  > Yes, should be 2.

  Thanks.  I'll queue this.

 tree-walk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 9b43ad5..ece8cc0 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -560,7 +560,7 @@ int tree_entry_interesting(const struct name_entry *entry,
 
 	if (!ps->nr) {
 		if (!ps->recursive || ps->max_depth == -1)
-			return 1;
+			return 2;
 		return !!within_depth(base->buf + base_offset, baselen,
 				      !!S_ISDIR(entry->mode),
 				      ps->max_depth);
-- 
1.7.4.261.g705f2
