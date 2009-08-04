From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Let mailsplit and mailinfo handle mails with CRLF
	line-endings
Date: Tue, 4 Aug 2009 19:26:38 +0200
Message-ID: <20090804172638.GA15136@blimp.localdomain>
References: <4A7735B0.2040703@zytor.com> <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com> <7v7hxk5b4y.fsf@alter.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 19:27:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYNms-00064P-Ac
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 19:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933100AbZHDR0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 13:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbZHDR0t
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 13:26:49 -0400
Received: from mout3.freenet.de ([195.4.92.93]:47990 "EHLO mout3.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932811AbZHDR0s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 13:26:48 -0400
Received: from [195.4.92.23] (helo=13.mx.freenet.de)
	by mout3.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #92)
	id 1MYNmf-0000Si-Na; Tue, 04 Aug 2009 19:26:45 +0200
Received: from x4e31.x.pppool.de ([89.59.78.49]:47685 helo=tigra.home)
	by 13.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #93)
	id 1MYNme-0007Rq-KF; Tue, 04 Aug 2009 19:26:45 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 8FC22277D8;
	Tue,  4 Aug 2009 19:26:40 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id DF08B36D28; Tue,  4 Aug 2009 19:26:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7hxk5b4y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-purgate-ID: 149285::1249406804-00000B39-D9BA82DD/0-0/0-0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124798>

It is not that uncommon to have mails with DOS line-ending, notably
Thunderbird and Gmail (when saving what they call "original" message).

Noticed by H. Peter Anvin.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen <raa.lkml@gmail.com> writes:

> Maybe it is as simple as that (not tested yet,
> and sent through gmail, so please be careful):

> --- a/builtin-mailsplit.c
> +++ b/builtin-mailsplit.c
> @@ -58,6 +58,8 @@ int read_line_with_nul(char *buf, int size, FILE *in)
> +	if (len && buf[len - 1] == '\r')
> +		--len;

That's wrong, of course. I missed the fact that \n stays in the
buffer. Corrected.

 builtin-mailsplit.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index ad5f6b5..188ffec 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -58,6 +58,8 @@ int read_line_with_nul(char *buf, int size, FILE *in)
 		if (c == '\n' || len + 1 >= size)
 			break;
 	}
+	if (len > 1 && buf[len - 2] == '\r')
+		buf[--len - 1] = '\n';
 	buf[len] = '\0';
 
 	return len;
-- 
1.6.4.30.gd4c0
