From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Ask for "git program" when asking for "git-program" over SSH
 connection
Date: Tue, 24 Jun 2008 20:26:18 -0700
Message-ID: <7vprq66vqd.fsf_-_@gitster.siamese.dyndns.org>
References: <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org>
 <20080621121429.GI29404@genesis.frugalware.org>
 <7vwskfclfs.fsf@gitster.siamese.dyndns.org>
 <9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl>
 <20080624160224.GA29404@genesis.frugalware.org>
 <alpine.DEB.1.00.0806241709330.9925@racer>
 <20080624185403.GB29404@genesis.frugalware.org>
 <alpine.DEB.1.00.0806242007150.9925@racer>
 <7vskv2d0lp.fsf@gitster.siamese.dyndns.org>
 <20080624221049.GE29404@genesis.frugalware.org>
 <7vk5gea0ff.fsf@gitster.siamese.dyndns.org>
 <20080624233236.GI29404@genesis.frugalware.org>
 <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org>
 <20080625120832.6117@nanako3.lavabit.com>
 <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 05:27:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBLfQ-0003R2-C6
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 05:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240AbYFYD0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 23:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754148AbYFYD0h
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 23:26:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015AbYFYD0g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 23:26:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 175B116B8D;
	Tue, 24 Jun 2008 23:26:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A9D7916B8C; Tue, 24 Jun 2008 23:26:27 -0400 (EDT)
In-Reply-To: <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 24 Jun 2008 20:22:17 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 83792C72-4266-11DD-B039-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86208>

The daemon expects to see the dashed form and we cannot change older
servers.  But when invoking programs on the remote end over SSH, the
command line the client side build is under client's control.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This I haven't even compile tested at all, but it feels right.  We
   probably should do this before bindir=>libexecdir move; as long as this
   is in place on the client side the version running on the server end
   should not matter.

 connect.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/connect.c b/connect.c
index e92af29..fd1da26 100644
--- a/connect.c
+++ b/connect.c
@@ -589,6 +589,10 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 	conn = xcalloc(1, sizeof(*conn));
 
 	strbuf_init(&cmd, MAX_CMD_LEN);
+	if (protocol != PROTO_GIT && !strncmp(prog, "git-", 4)) {
+		strbuf_addstr(&cmd, "git ");
+		prog += 4;
+	}
 	strbuf_addstr(&cmd, prog);
 	strbuf_addch(&cmd, ' ');
 	sq_quote_buf(&cmd, path);
-- 
1.5.6.56.g29b0d
