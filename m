From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] daemon: accept "git program" as well
Date: Wed, 25 Jun 2008 15:47:50 -0700
Message-ID: <7v4p7hxhbd.fsf@gitster.siamese.dyndns.org>
References: <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org>
 <20080625120832.6117@nanako3.lavabit.com>
 <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org>
 <7vprq66vqd.fsf_-_@gitster.siamese.dyndns.org>
 <20080625034538.GW11793@spearce.org>
 <7vk5ge6soc.fsf@gitster.siamese.dyndns.org>
 <20080625044409.GE11793@spearce.org>
 <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org>
 <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org>
 <7vy74u5bkk.fsf@gitster.siamese.dyndns.org>
 <20080625053848.GJ11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>, Miklos Vajna <vmiklos@frugalware.org>,
	pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 00:49:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBdnx-000625-Eo
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 00:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbYFYWsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 18:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755463AbYFYWsN
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 18:48:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbYFYWsM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 18:48:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 09A94A3C1;
	Wed, 25 Jun 2008 18:48:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C1340A296; Wed, 25 Jun 2008 18:47:59 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C84CD1A8-4308-11DD-91B0-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86361>

This is a step to futureproof git-daemon to accept clients that
ask for "git upload-pack" and friends, instead of using the more
traditional dash-form "git-upload-pack".  By allowing both, it
makes the client side easier to handle, as it makes "git" the only
thing necessary to be on $PATH when invoking the remote command
directly via ssh.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 "Shawn O. Pearce" <spearce@spearce.org> writes:

 > Junio C Hamano <gitster@pobox.com> wrote:
 >
 >> Ok, let's map this out seriously.
 >
 > This plan makes a lot of sense to me.  I'm behind it.  For whatever
 > that means.  At least I'll shutup and stop making noise about this
 > issue if you take this approach.  :-)
 >  
 >> * 1.6.0 will install the server-side programs in $(bindir) so that 
 >>   people coming over ssh will find them on the $PATH
 >> 
 >> * In 1.6.0 (and 1.5.6.1), we will change "git daemon" to accept both
 >>   "git-program" and "git program" forms.  When the spaced form is used, it
 >>   will behave as if the dashed form is requested.  This is a prerequisite
 >>   for client side change to start asking for "git program".
 >> 
 >> * In the near future, there will no client-side change.  "git-program"
 >>   will be asked for.
 >> 
 >> * 6 months after 1.6.0 ships, hopefully all the deployed server side will
 >>   be running that version or newer.  Client side will start asking for
 >>   "git program" by default, but we can still override with --upload-pack
 >>   and friends.
 >> 
 >> * 12 months after client side changes, everybody will be running that
 >>   version or newer.  We stop installing the server side programs in
 >>   $(bindir) but people coming over ssh will be asking for "git program"
 >>   and "git" will be on the $PATH so there is no issue.
 >> 
 >> The above 6 and 12 are yanked out of thin air and I am of course open to
 >> tweaking them, but I think the above order of events would be workable.
 >
 > Yea, 6 and 12 seem like a good idea.  Its a couple of releases and
 > gives people time to migrate their server installations.

 So this obviously needs to be queued to 'maint' to be included in 1.5.6.1
 and 1.6.0.

 daemon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/daemon.c b/daemon.c
index 63cd12c..621c567 100644
--- a/daemon.c
+++ b/daemon.c
@@ -586,7 +586,7 @@ static int execute(struct sockaddr *addr)
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		struct daemon_service *s = &(daemon_service[i]);
 		int namelen = strlen(s->name);
-		if (!prefixcmp(line, "git-") &&
+		if ((!prefixcmp(line, "git-") || !prefixcmp(line, "git ")) &&
 		    !strncmp(s->name, line + 4, namelen) &&
 		    line[namelen + 4] == ' ') {
 			/*
