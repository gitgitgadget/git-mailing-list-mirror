From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mailinfo may corrupt patch headers on attached files
Date: Sun, 06 Jul 2008 22:19:46 -0700
Message-ID: <7v1w269sp9.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0807061036500.3016@woody.linux-foundation.org>
 <1215379261-10802-1-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@linux-foundation.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 07:20:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFj9h-0004Ag-O0
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 07:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbYGGFTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 01:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbYGGFTz
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 01:19:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbYGGFTz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 01:19:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A414525E7B;
	Mon,  7 Jul 2008 01:19:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B867C25E75; Mon,  7 Jul 2008 01:19:48 -0400 (EDT)
In-Reply-To: <1215379261-10802-1-git-send-email-dzickus@redhat.com> (Don
 Zickus's message of "Sun, 6 Jul 2008 17:21:01 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 54B27C2C-4BE4-11DD-825E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87577>

Don Zickus <dzickus@redhat.com> writes:

> @@ -814,6 +814,9 @@ static void handle_body(void)
>  				return;
>  		}
>  
> +		/* line may have changed after handling boundary, check len */
> +		len = strlen(line);
> +
>  		/* Unwrap transfer encoding */
>  		len = decode_transfer_encoding(line, sizeof(line), len);
>  		if (len < 0) {

Sorry, but I have to reject this.  The reason this function treats "len"
in an unnatural way is that you cannot do strlen(line) if you want to
handle patches that touch lines with embedded NUL in them.  Ideally, the
array line[] in the global scope should be replaced with a pair of "char
line[] and int linelen" (or strbuf) so that the code will always know how
long the line is, but the conversion done by cce8d6f (mailsplit and
mailinfo: gracefully handle NUL characters, 2008-05-16) and 9aa2309
(mailinfo: apply the same fix not to lose NULs in BASE64 and QP codepaths,
2008-05-25) were done in minimally invasive way, so not all codepath in
the program can deal with lines with embedded NULs.  For that reason, the
code still uses fgets() and strlen() everywhere, but the two patches
quoted above should be careful enough to allow NULs in the contents part
of the message (structural parts such as mime boundaries cannot have NUL
with the code, but it should not be a problem in practice).

The point you inserted strlen() above, however, is one of the places that
line[] has patch text and can have NUL in it, so strlen() there would
break the earlier fix.

Here is the minimum replacement patch, still not handling embedded NULs
anywhere in the structural part of the message, that should work.  Sane
MUAs should quote embedded NULs in the original contents with QP or BASE64
to protect them from handle_boundary() and other functions, and after
decoding, these embedded NULs will be kept by decode_transfer_encoding(),
so I think this would work Ok in practice.

I tested this with both Linus's test message and it does not break t5100.

---

 builtin-mailinfo.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 97c1ff9..fa6e8f9 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -812,6 +812,7 @@ static void handle_body(void)
 					      np - newline);
 			if (!handle_boundary())
 				return;
+			len = strlen(line);
 		}
 
 		/* Unwrap transfer encoding */
