From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] ident: check /etc/mailname if email is unknown
Date: Mon, 03 Oct 2011 12:13:05 -0700
Message-ID: <7vty7pga7y.fsf@alter.siamese.dyndns.org>
References: <20111003045745.GA17604@elie>
 <7v8vp2iqvc.fsf@alter.siamese.dyndns.org> <20111003061633.GB17289@elie>
 <4E895FBD.8020904@viscovery.net> <20111003074433.GD17289@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Matt Kraai <kraai@ftbfs.org>, Gerrit Pape <pape@smarden.org>,
	Ian Jackson <ijackson@chiark.greenend.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 21:13:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAnx0-0002Og-VK
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 21:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757317Ab1JCTNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 15:13:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34035 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756915Ab1JCTNN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 15:13:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DB265333;
	Mon,  3 Oct 2011 15:13:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yxCDEemeSvn24com+me4raLk9uM=; b=OUlBxV
	uud5Fjzuq5F7MRsqCdp7+bd5MPv3aUYLkDsXluq68b6TU8sW6sZ36tpY2kCaRdhv
	ED3G4sKnhEUGENDdQKdC0d2qccsSAEuiLomHYRhFTTsYXTx5w/HDfxn/tjY+buZA
	FXW90rqK0UmJNFr5bwX9/QOInC8w2tGnZ7Cnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xyQKRDfcKt88Qjzy4LBlRxnl6upuE7M/
	JF4A9++l8xdz47Q0bZU63+lc4BmmELBj3mEF7tQs9j0B7kWHYZBVUTPpPA1g3esW
	412IqGTmPbRyiAvAEhEx8VhkehWwS18Tz1t6j4kIEcUdiAtZ4L+EdkbX4IRje6ry
	Pl1rixRaQGo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 644955332;
	Mon,  3 Oct 2011 15:13:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D073532D; Mon,  3 Oct 2011
 15:13:06 -0400 (EDT)
In-Reply-To: <20111003074433.GD17289@elie> (Jonathan Nieder's message of
 "Mon, 3 Oct 2011 02:44:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9CA306E-EDF3-11E0-B928-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182696>

Jonathan Nieder <jrnieder@gmail.com> writes:

> In the long term it would be nice to find a way to warn when the
> mailname we tried to retrieve was actually going to be used, but short
> of that, the least confusing behavior is to just not warn at all.

I would think that if we widely advertise that we read from /etc/mailname
if/when it exists, a user who wonders why it is not used would appreciate
it if Git tells them why when it cannot use it.

But I agree that has to happen _after_ we flip the logic so that
setup_ident() does not trigger when the user gave us the necessary
information.

I wonder if that "flipping the logic" would be as simple as something like
this. It probably is about time for us to stop using the static array that
is hardwired MAX_GITNAME bytes long and start using strbuf, so I didn't
bother with strlcpy().


 ident.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/ident.c b/ident.c
index edb4314..9cc55f7 100644
--- a/ident.c
+++ b/ident.c
@@ -239,6 +239,10 @@ const char *fmt_ident(const char *name, const char *email,
 	int warn_on_no_name = (flag & IDENT_WARN_ON_NO_NAME);
 	int name_addr_only = (flag & IDENT_NO_DATE);
 
+	if (name && !git_default_name[0])
+		strcpy(git_default_name, name);
+	if (email && !git_default_email[0])
+		strcpy(git_default_email, email);
 	setup_ident();
 	if (!name)
 		name = git_default_name;
