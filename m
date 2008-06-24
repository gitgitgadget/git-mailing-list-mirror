From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] implement some resilience against pack corruptions
Date: Mon, 23 Jun 2008 21:49:55 -0700
Message-ID: <7vhcbje8ss.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0806232122180.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 06:51:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB0Ue-0001gT-Vv
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 06:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbYFXEuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 00:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbYFXEuE
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 00:50:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbYFXEuD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 00:50:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 975F81247D;
	Tue, 24 Jun 2008 00:50:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DF1851247A; Tue, 24 Jun 2008 00:49:58 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 01C6DE30-41A9-11DD-BD7A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85987>

Nicolas Pitre <nico@cam.org> writes:

> We should be able to fall back to loose objects or alternative packs when
> a pack becomes corrupted.  This is especially true when an object exists
> in one pack only as a delta but its base object is corrupted.  Currently
> there is no way to retrieve the former object even if the later is
> available in another pack or loose.

All three patches applied, but with the following squashed in.  Thanks

 sha1_file.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index a5cef94..9330bc4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1418,8 +1418,8 @@ const char *packed_object_info_detail(struct packed_git *p,
 		case OBJ_OFS_DELTA:
 			obj_offset = get_delta_base(p, &w_curs, &curpos, type, obj_offset);
 			if (!obj_offset)
-				die("pack %s contains bad delta base reference",
-				    p->pack_name, type);
+				die("pack %s contains bad delta base reference of type %s",
+				    p->pack_name, typename(type));
 			if (*delta_chain_length == 0) {
 				revidx = find_pack_revindex(p, obj_offset);
 				hashcpy(base_sha1, nth_packed_object_sha1(p, revidx->nr));
