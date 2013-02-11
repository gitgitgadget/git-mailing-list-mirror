From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 0/5] Add git-credential support to git-send-email
Date: Mon, 11 Feb 2013 12:48:11 -0500
Message-ID: <20130211174811.GK16402@sigill.intra.peff.net>
References: <cover.1360599057.git.mina86@mina86.com>
 <20130211165136.GC16402@sigill.intra.peff.net>
 <xa1tk3qeg46r.fsf@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Michal Nazarewicz <mina86@mina86.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 18:48:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4xUd-0005jl-95
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 18:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758443Ab3BKRsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 12:48:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44418 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758433Ab3BKRsO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 12:48:14 -0500
Received: (qmail 24425 invoked by uid 107); 11 Feb 2013 17:49:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 12:49:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 12:48:11 -0500
Content-Disposition: inline
In-Reply-To: <xa1tk3qeg46r.fsf@mina86.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216068>

On Mon, Feb 11, 2013 at 06:18:04PM +0100, Michal Nazarewicz wrote:

> On Mon, Feb 11 2013, Jeff King wrote:
> > I have two minor comments, which I'll reply inline with. But even with
> > those comments, I think this would be OK to merge.
> 
> I'll send a new patchset tomorrow with.

Based on our discussion, I think it would just need the patch below
squashed into your 4/5 (this handles the "undef" thing, and I also fixed
a few typos in the API documentation):

---
diff --git a/perl/Git.pm b/perl/Git.pm
index 0e6fcf9..35893e6 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1038,7 +1038,7 @@ sub credential_read {
 	return %credential;
 }
 
-=item credential_read( FILE_HANDLE, CREDENTIAL_HASH )
+=item credential_write( FILE_HANDLE, CREDENTIAL_HASH )
 
 Writes credential key-value pairs from hash referenced by C<CREDENTIAL_HASH>
 to C<FILE_HANDLE>.  Keys and values cannot contain new-line or NUL byte
@@ -1102,7 +1102,7 @@ sub _credential_run {
 =item credential( CREDENTIAL_HASH, CODE )
 
 Executes C<git credential> for a given set of credentials and
-specified operation.  In both form C<CREDENTIAL_HASH> needs to be
+specified operation.  In both forms C<CREDENTIAL_HASH> needs to be
 a reference to a hash which stores credentials.  Under certain
 conditions the hash can change.
 
@@ -1126,11 +1126,14 @@ sub _credential_run {
 	}
 
 In the second form, C<CODE> needs to be a reference to a subroutine.
-The function will execute C<git credential fill> to fill provided
-credential hash, than call C<CODE> with C<CREDENTIAL> as the sole
-argument, and finally depending on C<CODE>'s return value execute
-C<git credential approve> (if return value yields true) or C<git
-credential reject> (otherwise).  The return value is the same as what
+The function will execute C<git credential fill> to fill the provided
+credential hash, then call C<CODE> with C<CREDENTIAL> as the sole
+argument. If C<CODE>'s return value is defined, the function will
+execute C<git credential approve> (if return value yields true) or
+C<git credential reject> (if return value is false). If the return
+value is undef, nothing at all is executed; this is useful, for
+example, if the credential could neither be verified nor rejected due
+to an unrelated network error. The return value is the same as what
 C<CODE> returned.  With this form, the usage might look as follows:
 
 	if (Git::credential {
@@ -1152,7 +1155,9 @@ sub credential {
 	if ('CODE' eq ref $op_or_code) {
 		_credential_run $credential, 'fill';
 		my $ret = $op_or_code->($credential);
-		_credential_run $credential, $ret ? 'approve' : 'reject';
+		if (defined $ret) {
+			_credential_run $credential, $ret ? 'approve' : 'reject';
+		}
 		return $ret;
 	} else {
 		_credential_run $credential, $op_or_code;
