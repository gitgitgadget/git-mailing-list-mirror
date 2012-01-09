From: Jeff King <peff@peff.net>
Subject: Re: git-send-email: bug with sendemail.multiedit
Date: Mon, 9 Jan 2012 17:55:42 -0500
Message-ID: <20120109225542.GB9902@sigill.intra.peff.net>
References: <1AC16B4B-8376-4A50-A900-BB8E704FAB82@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>, pierre.habouzit@m4x.org,
	git@vger.kernel.org
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 09 23:55:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkO86-0003wp-8h
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 23:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933412Ab2AIWzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 17:55:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60791
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933483Ab2AIWzp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 17:55:45 -0500
Received: (qmail 3279 invoked by uid 107); 9 Jan 2012 23:02:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jan 2012 18:02:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jan 2012 17:55:42 -0500
Content-Disposition: inline
In-Reply-To: <1AC16B4B-8376-4A50-A900-BB8E704FAB82@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188198>

On Mon, Jan 09, 2012 at 02:09:30PM -0500, Jean-Francois Dagenais wrote:

> I think there is a bug with git-send-email.perl's evaluation of the
> sendemail.multiedit config variable.
> 
> I was only able to make the "do_edit()" function detect it as false by
> setting the variable to "0" instead of "false", like so:

I think it's this:

-- >8 --
Subject: [PATCH] send-email: multiedit is a boolean config option

The sendemail.multiedit variable is meant to be a boolean.
However, it is not marked as such in the code, which means
we store its value literally. Thus in the do_edit function,
perl ends up coercing it to a boolean value according to
perl rules, not git rules. This works for "0", but "false",
"no", or "off" will erroneously be interpreted as true.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d491db9..ef30c55 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -210,6 +210,7 @@ my %config_bool_settings = (
     "signedoffbycc" => [\$signed_off_by_cc, undef],
     "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
     "validate" => [\$validate, 1],
+    "multiedit" => [\$multiedit, undef]
 );
 
 my %config_settings = (
@@ -227,7 +228,6 @@ my %config_settings = (
     "bcc" => \@bcclist,
     "suppresscc" => \@suppress_cc,
     "envelopesender" => \$envelope_sender,
-    "multiedit" => \$multiedit,
     "confirm"   => \$confirm,
     "from" => \$sender,
     "assume8bitencoding" => \$auto_8bit_encoding,
-- 
1.7.8
