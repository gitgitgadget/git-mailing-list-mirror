From: Jakub Narebski <jnareb@gmail.com>
Subject: PATCH/RFC] gitweb.js: Workaround for IE8 bug
Date: Tue, 8 Dec 2009 17:29:10 +0100
Message-ID: <200912081729.11890.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <1260147860.1579.47.camel@swboyd-laptop> <1260148741.1579.50.camel@swboyd-laptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 17:29:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI2wP-00057K-Hk
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 17:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbZLHQ3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 11:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbZLHQ3U
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 11:29:20 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44283 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756027AbZLHQ3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 11:29:20 -0500
Received: by bwz27 with SMTP id 27so4511154bwz.21
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 08:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ytLOGtHWm6z32LeKG3HXoD0AwKA0lorBCcqyDT/K4Iw=;
        b=OzdYj+KnW4yPqK0tnydtOG4FgW8m0WR+wQ66RvLaqrXFrk1xpjyKQmG83JkB9dG1oh
         vcyuuWsp8WcP4UcJdjuCQG5vyeA2OAZ5K3mLnIWY3fcnLeRnzGD3Tur9OXRbKJSYAdOY
         SDSjTyVuiQtctR+jYOdijeS+Qgc26V0yW76UM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XXpib/0Fagp8qe0e9ow/XWI0go4qPr0STRFJXbFopWVJ5L4AOBj2jBcMOfcM/JpU6M
         783Q2ntZoY9pouwhW6IQblh1TUqb/cTUAonUhVWBAHRlX3w62RF3PF+CMw2o8Rde11NF
         stkGdCiwwEu7KMagyaOZLz8vPD3Lqd3zuzFj0=
Received: by 10.204.32.204 with SMTP id e12mr4874205bkd.51.1260289764573;
        Tue, 08 Dec 2009 08:29:24 -0800 (PST)
Received: from ?192.168.1.13? (abwp196.neoplus.adsl.tpnet.pl [83.8.239.196])
        by mx.google.com with ESMTPS id 14sm1882729bwz.9.2009.12.08.08.29.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 08:29:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1260148741.1579.50.camel@swboyd-laptop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134893>

On Mon, 7 Dec 2009, Stephen Boyd wrote:
> On Sun, 2009-12-06 at 17:04 -0800, Stephen Boyd wrote:
> > 
> > Ok. It's December and I've had some more time to look into this.
> > Initializing 'xhr' to null seems to get rid of the "Unknown error"
> > problem (see patch below).
> > 
> 
> Ah sorry. Seems this doesn't work and I was just getting lucky.

Does the following fixes the issue for IE8 for you (it works for me)?

As for testing, try with blaming 'revision.c' and 'gitweb/gitweb.perl'
using 'blame_incremental' view.


With probably too long commit message, and not detailed enough title:

-- >8 --
Subject: [PATCH] gitweb.js: Workaround for IE8 bug

In Internet Explorer 8 (IE8) the 'blame_incremental' view, which uses
JavaScript to generate blame info using AJAX, sometimes hang at the
beginning (at 0%) of blaming, e.g. for larger files with long history
like git's own gitweb/gitweb.perl.

The error shown by JavaScript console is "Unspecified error" at char:2
of the following line in gitweb/gitweb.js:

  if (xhr.readyState === 3 && xhr.status !== 200) {

Debugging it using IE8 JScript debuger shown that the error occurs
when trying to access xhr.status (xhr is XMLHttpRequest object).
Watch for xhr object shows 'Unspecified error.' as "value" of
xhr.status, and trying to access xhr.status from console throws error.

This bug is some intermittent bug, depending on XMLHttpRequest timing,
as it doesn't occur in all cases.  It is probably caused by the fact
that handleResponse is called from timer (pollTimer), to work around
the fact that some browsers call onreadystatechange handler only once
for each state change, and not like required for 'blame_incremental'
as soon as new data is available from server.  It looks like xhr
object is not properly initialized; still it is a bug to throw an
error when accessing xhr.status (and not use 'null' or 'undefined' as
value).

Work around this bug in IE8 by using try-catch block when accessing
xhr.status.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.js |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.js b/gitweb/gitweb.js
index 2a25b7c..9c66928 100644
--- a/gitweb/gitweb.js
+++ b/gitweb/gitweb.js
@@ -779,7 +779,12 @@ function handleResponse() {
 	}
 
 	// the server returned error
-	if (xhr.readyState === 3 && xhr.status !== 200) {
+	// try ... catch block is to work around bug in IE8
+	try {
+		if (xhr.readyState === 3 && xhr.status !== 200) {
+			return;
+		}
+	} catch (e) {
 		return;
 	}
 	if (xhr.readyState === 4 && xhr.status !== 200) {
-- 
1.6.5.3
