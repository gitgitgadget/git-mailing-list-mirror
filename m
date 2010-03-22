From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] send-email: lazily assign editor variable
Date: Mon, 22 Mar 2010 17:12:53 +0100
Message-ID: <eb0d92cf28820eb9783e789a8c4c62c3af4dd0d0.1269274203.git.git@drmicha.warpmail.net>
References: <20100322145947.GA1709@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 22 17:16:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtkIS-0002F5-Vh
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 17:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab0CVQPm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 12:15:42 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39223 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752364Ab0CVQPl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 12:15:41 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D452EE480C;
	Mon, 22 Mar 2010 12:15:40 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 22 Mar 2010 12:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=smtpout; bh=BPgq63BJm+sQFLZ44IFS0MiMdyA=; b=B/AhlH8t6vecf85S9M3jyr7ecc600Xve2LbkONcy+2WYW6e9C9trGmfgZNOUpWHvYpKnpDQzezXqR5GTtXOJP9qzTq60cilu+8JCOEL8b9IQjIxll3Ree7TCfO9whOiFMaGzEJl68yblUp92iXn+SzeTEGmH8ewMP37Wo3tbvvM=
X-Sasl-enc: PbB4M3EzJMh6DdpPGtj9wjxrXYwve+b6nDfEueOQOPz7 1269274540
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 41652B96A;
	Mon, 22 Mar 2010 12:15:40 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.3.435.g097f4
In-Reply-To: <20100322145947.GA1709@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142942>

b4479f0 (add -i, send-email, svn, p4, etc: use "git var GIT_EDITOR",
2009-10-30) introduced the use of git var GIT_EDITOR which may lead to
problems when send-mail is used without a tty.

Therefore, use git var GIT_EDITOR only when we actually edit something.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Reported-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 git-send-email.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d612ae8..bb09c0d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -162,9 +162,12 @@ my $compose_filename;
=20
 # Handle interactive edition of files.
 my $multiedit;
-my $editor =3D Git::command_oneline('var', 'GIT_EDITOR');
+my $editor;
=20
 sub do_edit {
+	if (!defined($editor)) {
+		$editor =3D Git::command_oneline('var', 'GIT_EDITOR');
+	}
 	if (defined($multiedit) && !$multiedit) {
 		map {
 			system('sh', '-c', $editor.' "$@"', $editor, $_);
--=20
1.7.0.3.435.g097f4
