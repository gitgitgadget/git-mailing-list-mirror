From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: more explicit error message with bad URL or password
Date: Sun, 20 Jan 2008 15:00:54 -0800
Message-ID: <7v63xo6r15.fsf@gitster.siamese.dyndns.org>
References: <1200756171-11696-1-git-send-email-gb@gbarbier.org>
	<1200756171-11696-2-git-send-email-gb@gbarbier.org>
	<1200756171-11696-3-git-send-email-gb@gbarbier.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?utf-8?Q?Gr=C3=A9goire?= Barbier <gb@gbarbier.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 00:01:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGjAb-0007xd-Pg
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 00:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009AbYATXBM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2008 18:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755991AbYATXBL
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 18:01:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43712 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983AbYATXBK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2008 18:01:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 026FB2FF0;
	Sun, 20 Jan 2008 18:01:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 452832FEF;
	Sun, 20 Jan 2008 18:01:03 -0500 (EST)
In-Reply-To: <1200756171-11696-3-git-send-email-gb@gbarbier.org>
 (=?utf-8?Q?Gr=C3=A9goire?=
	Barbier's message of "Sat, 19 Jan 2008 16:22:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71201>

Gr=C3=A9goire Barbier <gb@gbarbier.org> writes:

> Previously, when URL or password where not set correctly (or
> when some network errors occur), the error message was "no DAV
> locking support".

The standard "Sign-off?" comment aside,...

I think something like this would be much less invasive and more
to the point.

-- >8 --
http-push: clarify the reason of error from the initial PROPFIND reques=
t

The first thing http-push does is a PROPFIND to see if the other
end supports locking.  The failure message we give is always
reported as "no DAV locking support at the remote repository",
regardless of the reason why we ended up not finding the locking
support on the other end.

This moves the code to report "no DAV locking support" down the
codepath so that the message is issued only when we successfully
get a response to PROPFIND and the other end say it does not
support locking.  Other failures, such as connectivity glitches
and credential mismatches, have their own error message issued
and we will not issue "no DAV locking" error (we do not even
know if the remote end supports it).

---

 http-push.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index eef7674..9f92cc1 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1563,9 +1563,17 @@ static int locking_available(void)
 				lock_flags =3D 0;
 			}
 			XML_ParserFree(parser);
+			if (!lock_flags)
+				error("Error: no DAV locking support on %s",
+				      remote->url);
+
+		} else {
+			error("Cannot access URL %s, return code %d",
+			      remote->url, results.curl_result);
+			lock_flags =3D 0;
 		}
 	} else {
-		fprintf(stderr, "Unable to start PROPFIND request\n");
+		error("Unable to start PROPFIND request on %s", remote->url);
 	}
=20
 	strbuf_release(&out_buffer.buf);
@@ -2230,7 +2238,6 @@ int main(int argc, char **argv)
=20
 	/* Verify DAV compliance/lock support */
 	if (!locking_available()) {
-		fprintf(stderr, "Error: no DAV locking support on remote repo %s\n",=
 remote->url);
 		rc =3D 1;
 		goto cleanup;
 	}
