From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [BUG] difference of info from diff and blame
Date: Tue, 11 Jan 2011 14:40:08 +0100
Message-ID: <201101111440.08619.trast@student.ethz.ch>
References: <4D2C333A.3010401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Semyon Kirnosenko <semyon.kirnosenko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 14:40:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PceSQ-0007M5-Eh
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 14:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788Ab1AKNkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 08:40:12 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:27839 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753540Ab1AKNkK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 08:40:10 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 11 Jan
 2011 14:40:06 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 11 Jan
 2011 14:40:09 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <4D2C333A.3010401@gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164941>

Semyon Kirnosenko wrote:
[Word wrap fixed.]
> 
> I have jquery repo (https://github.com/jquery/jquery.git)
> Let's get blame for some file in some revision:
> git blame -l -s 2ad223aedd1f93c783d98d60adc9fda3bdfbb4b6 -- src/event/event.js
> According to blame, line 127 was added in revision 
> 2ad223aedd1f93c783d98d60adc9fda3bdfbb4b6.

The surrounding context (with authorship and some whitespace snipped,
obviously it's always the same) is

2ad223ae (124)		
2ad223ae (125)		// Pass along a fake event
2ad223ae (126)		data.unshift( this.fix({ type: type, target: element }) );
2ad223ae (127)
2ad223ae (128)		// Trigger the event
2ad223ae (129)		if ( (val = this.handle.apply( element, data )) !== false )
2ad223ae (130)			this.triggered = true;


> Let's get diff for that revision:
> git diff-tree -p 2ad223aedd1f93c783d98d60adc9fda3bdfbb4b6 -- src/event/event.js
> We can see this:
> @@ -105,19 +120,16 @@ jQuery.event = {
> 
>   		// Handle triggering a single element
>   		else {
> -			var handler = element["on" + type ], val,
> -				fn = jQuery.isFunction( element[ type
> +			var val, ret, fn = jQuery.isFunction( element
> +			
> +			// Pass along a fake event
> +			data.unshift( this.fix({ type: type, target:
> 
[this blank context line is line 127 in the postimage]
> -			if ( handler ) {
> 
> As you can see line 127 is not marked with '+' char, which means it was 
> not added in this revision. But blame sad otherwise.

git-blame internally runs a diff with no context lines to "pass
blame".  On all lines in this diff, the current commit can pass on
blame to the parent, thus avoiding having to take it for itself.

And indeed, running

  git show -U0 2ad223ae -- src/event/event.js

in your repository gives a hunk

@@ -108,11 +123,8 @@ jQuery.event = {
-			var handler = element["on" + type ], val,
-				fn = jQuery.isFunction( element[ type ] );
-
-			if ( handler ) {
-				// Pass along a fake event
-				data.unshift( this.fix({ type: type, target: element }) );
-	
-				// Trigger the event
-				if ( (val = handler.apply( element, data )) !== false )
-					this.triggered = true;
-			}
+			var val, ret, fn = jQuery.isFunction( element[ type ] );
+			
+			// Pass along a fake event
+			data.unshift( this.fix({ type: type, target: element }) );
+
+			// Trigger the event
+			if ( (val = this.handle.apply( element, data )) !== false )
+				this.triggered = true;

So I would tend to agree with the blame implementation.  If anything
it's a bug in git-diff when not using any context.

Do you have a reproduction recipe that exhibits the flaw on a
non-whitespace line?  I'm not up to speed on the diff implementation
(maybe someone else can help?), but I wouldn't be too surprised if it
had heuristics that put lines consisting only of whitespace at a lower
importance than "actual" lines.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
