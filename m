From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Perl gurus: why do we need Scalar::Util?
Date: 10 Jul 2006 06:28:49 -0700
Message-ID: <86k66lsi5q.fsf@blue.stonehenge.com>
References: <Pine.LNX.4.63.0607101343060.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 15:28:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzvon-0004kT-0P
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 15:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWGJN2y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 09:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWGJN2w
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 09:28:52 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:33376 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S964886AbWGJN2v
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 09:28:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 9F1168F322;
	Mon, 10 Jul 2006 06:28:50 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 22049-02-75; Mon, 10 Jul 2006 06:28:50 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 1AD988F33D; Mon, 10 Jul 2006 06:28:50 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
x-mayan-date: Long count = 12.19.13.8.4; tzolkin = 1 Kan; haab = 17 Tzec
In-Reply-To: <Pine.LNX.4.63.0607101343060.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

Johannes> please do not let my die dumb: what is this "blessed" thing all about? And 
Johannes> why do we need it in the private-Error.pm??

Ugh.  Just took a peek for the first time at the "next" branch, and I see the
dangerous syntactic-sugar try { } catch { }.  Sorry for not noticing that
earlier.

While that syntax looks like it would make things easier in theory, in
practice it is a source of leak-after-leak because it creates a closure for
the two blocks, and that can easily lead to a circular reference for
long-running tools.  This would be of some concern if someone writes
a mod_perl module or a standalone webserver that doesn't exec itself
to clean up (which it shouldn't need).

So, if there's going to be rewrite, the first part would be to eliminate
the try { } catch { } sugar, and replace it with more traditional
exception catchers.

        eval { };
        if ($@) { ... }

Note that I'm *not* suggesting not to use Error.pm - that's a great
means by which to create hierarchical error classes that stringify nicely
and carry context on the error.  I'm just saying to throw out the
try/catch syntax helper.

Sorry about that.  If it's any consequence, we got it right in Perl 6. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
