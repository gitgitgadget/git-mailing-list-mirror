From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] allow 8bit data in email body sent by send-email
Date: Fri, 9 Jan 2009 09:44:04 -0500
Message-ID: <20090109144403.GA12994@coredump.intra.peff.net>
References: <20090109072814.GA21180@coredump.intra.peff.net> <49675C38.8060208@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andre Przywara <andre.przywara@amd.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 15:45:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLIcM-0008Iv-Ro
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 15:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618AbZAIOoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 09:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753996AbZAIOoI
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 09:44:08 -0500
Received: from peff.net ([208.65.91.99]:43365 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753975AbZAIOoH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 09:44:07 -0500
Received: (qmail 21869 invoked by uid 107); 9 Jan 2009 14:44:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 09 Jan 2009 09:44:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Jan 2009 09:44:04 -0500
Content-Disposition: inline
In-Reply-To: <49675C38.8060208@amd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105015>

On Fri, Jan 09, 2009 at 03:16:24PM +0100, Andre Przywara wrote:

>> This should be done already by git-format-patch when you generate the
>> patch to feed to send-email.
> Well, this could be discussed, after all the problem lies in the actual  
> transportation, which should be the responsibility of git-send-email. But 
> I am OK with putting this into format-patch.

I didn't mean "this functionality should go into format-patch" but
rather "this functionality is _already_ in format-patch, and it should
have been triggered".

The reason it has to be in format-patch is that only format-patch knows
what the correct encoding is. It's not that useful to just say "oh, this
is some 8-bit data." You also want to give a content-type header that
specifies the correct encoding. And anything that contains non-ascii
characters should come out of format-patch with such a header.

> > What exactly is the workflow you use to generate this problem?
> I use git format-patch to generate a patch file for a single-mail patch  
> (not a patch series). Then I edit this file manually to add questions and 
> comments and include my signature. During this step the umlauts came in. 
> If you have a suggestion to improve this workflow, I am all ears, I am 
> fairly new to git.

Ah, I see. I'm not sure what the best solution is there. send-email has
intentionally been kept pretty dumb, because implementing full MUA
behavior would make it pretty unwieldy. You could add an option to
send-email to add the 8-bit transfer-encoding header if necessary, but
it will have to guess at (or be configured to know) the correct encoding
of the characters.

Personally, when I want to add information like that to a patch, I pull
the output of format-patch into my MUA (mutt, in my case). I don't know
if that is a workable solution for you.

> Ok, so what about adding a flag to git-format-patch that forces the 8bit  
> headers on? I think a workaround would be to add a --subject-prefix with  
> a special character and later remove this, but this is not really a  
> long-term solution ;-)

Now that you've explained your workflow, I do think send-email is a more
appropriate place to add a header, since format-patch never even sees
the data that is causing the problem. Probably the sanest thing would be
to check each input file for non-ascii characters. If they are found,
and the message does not already have some MIME headers, then add an
8bit content-transfer-encoding and a text/plain content-type. In the
latter, you would need to specify some encoding. Most of git defaults
to utf-8, but it should probably be configurable.

We have to do a similar thing for the --compose option, so looking at
what that does is probably a good starting point.

-Peff
