From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] builtin-mailinfo.c: check error status from rewind
	and ftruncate
Date: Tue, 29 Sep 2009 09:40:46 -0700
Message-ID: <20090929164046.GB25756@spearce.org>
References: <1254206409-13256-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 18:40:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msfkx-0005Oe-WA
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 18:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbZI2Qkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 12:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752617AbZI2Qkm
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 12:40:42 -0400
Received: from george.spearce.org ([209.20.77.23]:35349 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbZI2Qkm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 12:40:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7A9EF381FE; Tue, 29 Sep 2009 16:40:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1254206409-13256-1-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129313>

Junio C Hamano <gitster@pobox.com> wrote:
> A recent "cut at scissors" implementation rewinds and truncates the output
> file to store the message when it sees a scissors mark, but it did not
> check if these library calls succeeded.
...
> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index d498b1c..3306d9e 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -785,8 +785,10 @@ static int handle_commit_msg(struct strbuf *line)
>  
>  	if (use_scissors && is_scissors_line(line)) {
>  		int i;
> -		rewind(cmitmsg);
> -		ftruncate(fileno(cmitmsg), 0);
> +		if (rewind(cmitmsg))

Uh...

builtin-mailinfo.c: In function 'handle_commit_msg':
builtin-mailinfo.c:788: error: void value not ignored as it ought to be

I think you mean to squash this in, and use fseek instead:

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 3306d9e..c90cd31 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -785,7 +785,7 @@ static int handle_commit_msg(struct strbuf *line)
 
 	if (use_scissors && is_scissors_line(line)) {
 		int i;
-		if (rewind(cmitmsg))
+		if (fseek(cmitmsg, 0L, SEEK_SET))
 			die_errno("Could not rewind output message file");
 		if (ftruncate(fileno(cmitmsg), 0))
 			die_errno("Could not truncate output message file at scissors");

-- 
Shawn.
