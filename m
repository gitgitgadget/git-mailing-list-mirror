From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Issues with envelopesender and empty log messages using contrib/hooks/post-receive-email
Date: Mon, 20 Aug 2007 16:42:30 -0700
Message-ID: <7vsl6drcwp.fsf@gitster.siamese.dyndns.org>
References: <20070819081847.GA6166@spearce.org> <20070820225323.GA25430@ares>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
To: Matthew Gwynne <mathew.gwynne@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 01:42:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INGtS-0007FU-C2
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 01:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbXHTXmi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 19:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753626AbXHTXmi
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 19:42:38 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbXHTXmh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 19:42:37 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B87A1125272;
	Mon, 20 Aug 2007 19:42:54 -0400 (EDT)
In-Reply-To: <20070820225323.GA25430@ares> (Matthew Gwynne's message of "Mon,
	20 Aug 2007 23:53:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56267>

Matthew Gwynne <mathew.gwynne@gmail.com> writes:

> I've recently encountered 2 problems with use of the example
> post-receive-mail script in contrib/hooks/post-receive-email.

The script's author Andy Parkins Cc'ed.

> Firstly I found that having set hooks.envelopesender, the script ended
> up sending mail with the envelope sender set to the email address
> given literally surrounded by single quotes which caused the mail
> server to complain about invalid address syntax.
> ...
> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> index c589a39..a733d0c 100644
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -608,7 +608,7 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
>  	PAGER= generate_email $2 $3 $1
>  else
>  	if [ -n "$envelopesender" ]; then
> -		envelopesender="-f '$envelopesender'"
> +		envelopesender="-f \"$envelopesender\""
>  	fi
>  
>  	while read oldrev newrev refname

I do not think this is a correct fix either.

Suppose you have envelope sender "A B <c@d.xz>" and have
original or your version to massage that string.

A few lines below the part you quoted does this:

	/usr/sbin/sendmail -t $envelopesender

which would expand and split at $IFS into

	/usr/sbin/sendmail -t -f 'A    B      <c@d.xz>'
        $0                 $1 $2 $3    $4     $5 

which is wrong, but then your fixed version would read as:

	/usr/sbin/sendmail -t -f '"A   B      <c@d.xz>"'
        $0                 $1 $2 $3    $4     $5 

which looks just as wrong.

Perhaps you would need something like this (untested) patch.

---

 contrib/hooks/post-receive-email |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index c589a39..f1efd5f 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -607,13 +607,10 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
 	# resend an email; they could redirect the output to sendmail themselves
 	PAGER= generate_email $2 $3 $1
 else
-	if [ -n "$envelopesender" ]; then
-		envelopesender="-f '$envelopesender'"
-	fi
-
 	while read oldrev newrev refname
 	do
 		generate_email $oldrev $newrev $refname |
-		/usr/sbin/sendmail -t $envelopesender
+		/usr/sbin/sendmail -t ${envelopesender:+"-f"} \
+			${envelopesender:+"$envelopesender"}
 	done
 fi
