From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] peel_onion: disambiguate to favor tree-ish when we want
 a tree-ish
Date: Sun, 31 Mar 2013 15:38:36 -0700
Message-ID: <7v38vbp53n.fsf_-_@alter.siamese.dyndns.org>
References: <51543FDB.9010109@alum.mit.edu>
 <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com>
 <515462FB.9040605@alum.mit.edu> <20130328153808.GB3337@sigill.intra.peff.net>
 <7vli97v558.fsf@alter.siamese.dyndns.org> <51565F96.1020203@alum.mit.edu>
 <7vk3opr0ke.fsf@alter.siamese.dyndns.org> <51567844.7030503@alum.mit.edu>
 <7vboa1qtnb.fsf@alter.siamese.dyndns.org>
 <7vhajtpdtc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 01 00:39:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMQu4-0003sG-Ob
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 00:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745Ab3CaWik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 18:38:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57178 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755614Ab3CaWij (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 18:38:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD3511194A;
	Sun, 31 Mar 2013 22:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jJEyJtyonnewSYv9WJFDOyEQvsY=; b=MDUd9M
	SOn06aV2/0GQYwqH74mQlCRNupVZ/IawpebiZm6tTyN4sIoSSDpyBG5W7Pqyl7Tx
	GpVIYzI/dvswPo1z0NH+4+uxyHLh95q088iTf98lOowDOtRXraCkx+RvSBpEU46d
	09s8n2scYdKOgswQV5PHedHFeGPazb1v5cTWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nQdux3Mw0MrtpCh6D1nKEC7toykE2scM
	MrVsN+PsY2Ftkgx14Z0af0W62YbqyouAAJRvtR9x4/USKSu/FHp2GHw20mQcYg3G
	sRx7142s/8A6vZJHvvfq9phGwuq4q3Rc7k1Ue/ixml+Ik4vgpG0gI4cXLzmcYZXu
	ifZC462OaF0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0D3F11949;
	Sun, 31 Mar 2013 22:38:38 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1102411947; Sun, 31 Mar
 2013 22:38:37 +0000 (UTC)
In-Reply-To: <7vhajtpdtc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 30 Mar 2013 00:05:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BAC276B2-9A53-11E2-834F-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219645>

The function already knows when interpreting $foo^{commit} to tell
the underlying get_sha1_1() to expect a commit-ish while evaluating
$foo.  Teach it to do the same when asked for $foo^{tree}; we are
expecting a tree-ish and $foo should be disambiguated in favor of a
tree-ish, discarding a possible ambiguous match with a blob object.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps something like this.  Note that the last hunk is unrelated
> thinko-fix I noticed while browsing the code.

 sha1_name.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sha1_name.c b/sha1_name.c
index c50630a..45788df 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -654,6 +654,8 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 
 	if (expected_type == OBJ_COMMIT)
 		lookup_flags = GET_SHA1_COMMITTISH;
+	else if (expected_type == OBJ_TREE)
+		lookup_flags = GET_SHA1_TREEISH;
 
 	if (get_sha1_1(name, sp - name - 2, outer, lookup_flags))
 		return -1;
-- 
1.8.2-441-g6e6f07b
