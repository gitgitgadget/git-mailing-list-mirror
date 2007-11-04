From: Simon Sasburg <simon.sasburg@gmail.com>
Subject: [PATCH] Make git-mailsplit strip whitespace from the start of the mailbox file.
Date: Sun,  4 Nov 2007 14:32:00 +0100
Message-ID: <1194183120-3660-1-git-send-email-Simon.Sasburg@gmail.com>
References: <7v8x5h58qj.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Simon Sasburg <Simon.Sasburg@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 04 14:32:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iofan-0001I5-5V
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 14:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034AbXKDNcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 08:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755644AbXKDNcK
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 08:32:10 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:1763 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614AbXKDNcI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 08:32:08 -0500
Received: by py-out-1112.google.com with SMTP id u77so2462505pyb
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 05:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        bh=McXnMPbiL6cGPivNSMjx69zfvn5evvy6lo8VCrPocdc=;
        b=nmgTc4Z5ezrdn+Oxw2yp1TOTvGGZP720JKEMTVbnR8xQK7L93YBirkGJYfupH+ZjYdKGfSpp3NjOPortuOiw2IQsXjdQirozP8UDvO6+9THyw8jL2glKNg2QbSGzMSAHgNpGFFXkXM0jFOHSZgdAjt5JyGb2lPUbRPL1zqpBWKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=Hsm2WjleM7KAx7ZqIG0tWEvnvkjF4tp+Y3PeXCUd6GRKcjoXG7BqSmKUUahPXW5i6OrdaidBzqdyON9H9gycfwcfo79ROyJo0ivEos7K4rt8vZBTaS47xU3rd+lR/jOxXz96l1S+9WqDOEuJcKRvNcnbsDzU+L0fhFNV0mN3sTo=
Received: by 10.65.15.19 with SMTP id s19mr10733159qbi.1194183127523;
        Sun, 04 Nov 2007 05:32:07 -0800 (PST)
Received: from localhost.localdomain ( [86.85.232.104])
        by mx.google.com with ESMTPS id d27sm5305977nfh.2007.11.04.05.32.05
        (version=SSLv3 cipher=OTHER);
        Sun, 04 Nov 2007 05:32:06 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4.504.gdf75-dirty
In-Reply-To: <7v8x5h58qj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63399>

This will allow it to handle the files gotten through gmail's web interface via its 'Show original' option.
These files contain the mail headers and the mail body, but start with some whitespace.
Now you can give these files to git-am without having to remove the whitespace yourself.

Signed-off-by: Simon Sasburg <Simon.Sasburg@gmail.com>
---

On Nov 2, 2007 9:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I wonder why this is not using isspace(peek).

Fixed.

On Nov 1, 2007 11:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ah, I meant "git-mailsplit", which is the command internally run
> by "git-am" to preprocess the file and to split it into
> individual mail pieces to be fed to "git-mailinfo".
> 
> That may suggest the change is better done in git-mailsplit not
> git-mailinfo.

The files from gmail only contain 1 mail per file, but having git-mailspit
massage these into a proper file that git-mailinfo can parse seems like
a sane solution to me.

 builtin-mailsplit.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 43fc373..74b0470 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -164,6 +164,7 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 {
 	char name[PATH_MAX];
 	int ret = -1;
+	int peek;
 
 	FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "r");
 	int file_done = 0;
@@ -173,6 +174,11 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 		goto out;
 	}
 
+	do {
+		peek = fgetc(f);
+	} while (isspace(peek));
+	ungetc(peek, f);
+
 	if (fgets(buf, sizeof(buf), f) == NULL) {
 		/* empty stdin is OK */
 		if (f != stdin) {
-- 
1.5.3.4.504.gdf75-dirty
