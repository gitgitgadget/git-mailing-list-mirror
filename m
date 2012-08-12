From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Sun, 12 Aug 2012 12:36:40 -0700
Message-ID: <20120812193640.GA4065@mannheim-rule.local>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1447696.eZjtSkvvWp@flomedio>
 <20120801194247.GE24357@copier>
 <1636924.tANzCnKezB@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 21:36:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0dxg-0003Mw-Jq
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 21:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485Ab2HLTg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Aug 2012 15:36:27 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62695 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab2HLTg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2012 15:36:26 -0400
Received: by pbbrr13 with SMTP id rr13so5999755pbb.19
        for <git@vger.kernel.org>; Sun, 12 Aug 2012 12:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X+NoJpiTaTuXnuIVOnu+GCQaIym5uL7+sS/uccTWOss=;
        b=omsNwWA0GvCh09DkhS0AlQxR8OuiHLigpxtQC0FKKrXB+p45vstx93+ewLe8qprGe+
         +HDoqyxg2nJWAv3L38HE+Fnwo8+3cPEBgd8lgjGwi25hW+u5lKp8KRcTIoF+cvgfO3xn
         5rADLlSn4wOpSNONMeqCk5i2k0hqko0xGvUVkdYniEKjkDsCB9QheLYvr8myG1dYSYjK
         ABt7TzZ6Uvi+mfUL775u4NULh3vTQjiEEOrCD/oJ9hM/P6J7PZhIrs12f/Ykn73OS4x/
         hmhbLn75ubEv9QKPQ549RJ5Hhl4/QHeBczObcl4oCmsrPCN97xfQjei+3qi4TF8I/qXW
         tNQg==
Received: by 10.68.212.161 with SMTP id nl1mr14360579pbc.84.1344800186101;
        Sun, 12 Aug 2012 12:36:26 -0700 (PDT)
Received: from mannheim-rule.local (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id sk5sm3810258pbc.7.2012.08.12.12.36.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 12 Aug 2012 12:36:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1636924.tANzCnKezB@flobuntu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203315>

Hi again,

Florian Achleitner wrote:

> Another alternative would be to use the existing --cat-pipe-fd argument. But 
> that requires to open the fifo before execing fast-import and makes us 
> dependent on the posix model of forking and inheriting file descriptors

Let me elaborate on this, which I think is the real point (though I
could easily be wrong).

Probably instead of just sending feedback I should have been sending
suggested patches to compare.  You do not work for me and your time is
not my time, and I would not want to have the responsibility of
dictating how your code works, anyway.  Generally speaking, as long as
code is useful and not hurting maintainability, the best thing I can
do is to make it easy to incorporate.  That has side benefits, too,
like giving an example of what it is like to have your code
incorporated and creating momentum.  Small mistakes can be fixed
later.

Unfortunately here we are talking about two interfaces that need to
be stable.  Mistakes stay --- once there is a UI wart in interfaces
people are using, we are stuck continuing to support it.

To make life even more complicated, there are two interfaces involved
here:

 - the remote-helper protocol, which I think it is very important
   to keep sane and stable.  Despite the remote-helper protocol
   existing for a long time, it hasn't seen a lot of adoption
   outside git yet, and complicating the protocol will not help
   that.

   I am worried about what it would mean to add an additional
   stream on top of the standard input and output used in the current
   remote-helper protocol.  Receiving responses to fast-import
   commands on stdin seems very simple.  Maybe I am wrong?

 - the fast-import interface, which is also important but I'm not
   as worried about.  Adding a new command-line parameter means
   importers that call fast-import can unnecessarily depend on
   newer versions of git, so it's still something to be avoided.

Given a particular interface, there may be multiple choices of how to
implement it.  For example, on Unix the remote-helper protocol could
be fulfilled by letting fast-import inherit the file descriptor
helper->in, while on Windows it could for example be fulfilled by
using DuplicateHandle() to transmit the pipe handle before or after
fast-import has already started running.

The implementation strategy can easily be changed later.  What is
important is that the interface be pleasant and *possible* to
implement sanely.

Hoping that clarifies a little,
Jonathan
