From: sean <seanlkml@sympatico.ca>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 9 May 2006 21:38:53 -0400
Message-ID: <BAYC1-PASMTP1056CADE82C96CB1DA9AA9AEAE0@CEZ.ICE>
References: <1147037659.25090.25.camel@dv>
	<BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
	<Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
	<7virogc90u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
	<7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
	<BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
	<BAYC1-PASMTP05953E2B948CB07A171FD8AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605082100460.3718@g5.osdl.org>
	<e3p5om$djs$1@sea.gmane.org>
	<Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzmhr3wje.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>
	<BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE>
	<BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605091543100.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 03:44:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FddkQ-0003Hl-9R
	for gcvg-git@gmane.org; Wed, 10 May 2006 03:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWEJBoH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 21:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWEJBoG
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 21:44:06 -0400
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:27573 "EHLO
	BAYC1-PASMTP10.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751021AbWEJBoE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 21:44:04 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP10.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 9 May 2006 18:45:58 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 0BE0E644C2A;
	Tue,  9 May 2006 21:44:03 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060509213853.0fd8af0f.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0605091543100.3718@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 10 May 2006 01:45:58.0515 (UTC) FILETIME=[7C2B6430:01C673D3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 9 May 2006 17:17:58 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> Here's a pretty lightly tested patch (on top of my previous one) that does 
> exactly that.

This patch or something like it is needed for repo-config in order to query
the new case sensitive portion of section names.   This is on top of your two
patches:

diff --git a/repo-config.c b/repo-config.c
index 63eda1b..9a9194f 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -65,11 +65,14 @@ static int show_config(const char* key_,
 static int get_value(const char* key_, const char* regex_)
 {
 	int i;
+	char *tl;
+
+	key = strdup(key_);
+	for (tl=key+strlen(key)-1; tl >= key && *tl != '.'; --tl)
+		*tl = tolower(*tl);
+	for (tl=key; *tl && *tl != '.'; ++tl)
+		*tl = tolower(*tl);
 
-	key = malloc(strlen(key_)+1);
-	for (i = 0; key_[i]; i++)
-		key[i] = tolower(key_[i]);
-	key[i] = 0;
 
 	if (use_key_regexp) {
 		key_regexp = (regex_t*)malloc(sizeof(regex_t));
