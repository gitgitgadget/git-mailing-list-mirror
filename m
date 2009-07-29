From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] post-receive-email: Set content-type and encoding in
 generated mail
Date: Wed, 29 Jul 2009 10:46:11 -0400
Message-ID: <20090729144610.GA5060@coredump.intra.peff.net>
References: <1248875304-13167-1-git-send-email-emmes@informatik.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fabian Emmes <emmes@informatik.rwth-aachen.de>
X-From: git-owner@vger.kernel.org Wed Jul 29 16:47:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWAQr-0002Ev-96
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 16:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbZG2OqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 10:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbZG2OqP
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 10:46:15 -0400
Received: from peff.net ([208.65.91.99]:59953 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387AbZG2OqO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 10:46:14 -0400
Received: (qmail 8202 invoked by uid 107); 29 Jul 2009 14:48:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 29 Jul 2009 10:48:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Jul 2009 10:46:11 -0400
Content-Disposition: inline
In-Reply-To: <1248875304-13167-1-git-send-email-emmes@informatik.rwth-aachen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124355>

On Wed, Jul 29, 2009 at 03:48:24PM +0200, Fabian Emmes wrote:

> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -197,6 +197,7 @@ generate_email_header()
>  	cat <<-EOF
>  	To: $recipients
>  	Subject: ${emailprefix}$projectdesc $refname_type, $short_refname, ${change_type}d. $describe
> +	Content-Type: text/plain; charset=utf-8
>  	X-Git-Refname: $refname
>  	X-Git-Reftype: $refname_type
>  	X-Git-Oldrev: $oldrev

Shouldn't this be $(git config i18n.logOutputEncoding), since you will
be inserting the output of git rev-list into the mail?

And as Teemu mentioned, you need a mime-version and a transfer-encoding
header, as well.

So maybe (totally untested):

---
diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 2a66063..0c1c6ad 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -192,11 +192,16 @@ generate_email()
 
 generate_email_header()
 {
+	encoding=`git config i18n.logOutputEncoding`
+	test -z "$encoding" && encoding=utf-8
 	# --- Email (all stdout will be the email)
 	# Generate header
 	cat <<-EOF
 	To: $recipients
 	Subject: ${emailprefix}$projectdesc $refname_type, $short_refname, ${change_type}d. $describe
+	MIME-Version: 1.0
+	Content-Type: text/plain; charset=$encoding
+	Content-Transfer-Encoding: 8bit
 	X-Git-Refname: $refname
 	X-Git-Reftype: $refname_type
 	X-Git-Oldrev: $oldrev
