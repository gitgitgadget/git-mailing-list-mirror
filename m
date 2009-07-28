From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git-send-email generates mail with invalid Message-Id
Date: Tue, 28 Jul 2009 11:27:43 +0200
Message-ID: <200907281127.44558.trast@student.ethz.ch>
References: <200907280446.22890.elendil@planet.nl> <40aa078e0907280217g76cbfai8544edde605f8772@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Frans Pop <elendil@planet.nl>, git@vger.kernel.org
To: "Erik Faye-Lund" <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 11:28:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MViyY-0007jQ-5n
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 11:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbZG1J1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 05:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbZG1J1y
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 05:27:54 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:9634 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718AbZG1J1y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 05:27:54 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 11:27:53 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 11:27:52 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <40aa078e0907280217g76cbfai8544edde605f8772@mail.gmail.com>
X-OriginalArrivalTime: 28 Jul 2009 09:27:53.0044 (UTC) FILETIME=[AEB12940:01CA0F65]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124227>

Erik Faye-Lund wrote:
> On Tue, Jul 28, 2009 at 4:46 AM, Frans Pop<elendil@planet.nl> wrote:
> > I assume that this is a configuration issue in the git setup of the
> > sender, but shouldn't git-send-email refuse to send out messages with an
> > invalid Message-Id?
> 
> Not quite. git-send-email generates these message-ids itself (those
> who contain "-git-send-email-", that is), and should as such be able
> to rely on them being generated correctly. [...]
> I'm no perl-expert, but the code looks pretty much correct to me.

git-format-patch generates its own message IDs if it needs them for
threading, with gen_message_id() (in builtin-log.c).  That one appends
the committer email address blindly, without verifying that it has an
@ in it.

Blame the committer's broken config, I guess.  The untested patch at
the end might catch this, but then it's still a fair ways from correct
address verification _and_ email addresses aren't required to have a
hostname part.

diff --git i/builtin-log.c w/builtin-log.c
index fe8e4e1..7003784 100644
--- i/builtin-log.c
+++ w/builtin-log.c
@@ -604,9 +604,12 @@ static void gen_message_id(struct rev_info *info, char *base)
 	const char *committer = git_committer_info(IDENT_WARN_ON_NO_NAME);
 	const char *email_start = strrchr(committer, '<');
 	const char *email_end = strrchr(committer, '>');
+	const char *email_at = strrchr(committer, '@');
 	struct strbuf buf = STRBUF_INIT;
 	if (!email_start || !email_end || email_start > email_end - 1)
 		die("Could not extract email from committer identity.");
+	if (!email_at || email_start > email_at - 1 || email_at > email_end - 1)
+		die ("Committer email address invalid, cannot form message-id");
 	strbuf_addf(&buf, "%s.%lu.git.%.*s", base,
 		    (unsigned long) time(NULL),
 		    (int)(email_end - email_start - 1), email_start + 1);
