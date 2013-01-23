From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v3 2/8] git_remote_helpers: fix input when running under
 Python 3
Date: Wed, 23 Jan 2013 19:47:57 +0000
Message-ID: <20130123194757.GQ7498@serenity.lan>
References: <cover.1358686905.git.john@keeping.me.uk>
 <7cd489e5b1b2578b1509232196cd6b21fd684843.1358686905.git.john@keeping.me.uk>
 <CAGdFq_jp3BrS0zgDpmiXGduwu_m4E2CCL+X32P-7T=z9Qk-wuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 20:48:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty6JC-0006hL-14
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 20:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764Ab3AWTsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 14:48:09 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:38041 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab3AWTsH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 14:48:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id B9A6560656E;
	Wed, 23 Jan 2013 19:48:05 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bZK3qyU5C5Zu; Wed, 23 Jan 2013 19:48:05 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 100776064D3;
	Wed, 23 Jan 2013 19:48:05 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 05F54161E581;
	Wed, 23 Jan 2013 19:48:05 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6d6g7hTJ5PnN; Wed, 23 Jan 2013 19:48:04 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 97C9D161E34E;
	Wed, 23 Jan 2013 19:47:59 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAGdFq_jp3BrS0zgDpmiXGduwu_m4E2CCL+X32P-7T=z9Qk-wuQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214348>

On Wed, Jan 23, 2013 at 11:20:39AM -0800, Sverre Rabbelier wrote:
> On Sun, Jan 20, 2013 at 5:15 AM, John Keeping <john@keeping.me.uk> wrote:
> > Although 2to3 will fix most issues in Python 2 code to make it run under
> > Python 3, it does not handle the new strict separation between byte
> > strings and unicode strings.  There is one instance in
> > git_remote_helpers where we are caught by this, which is when reading
> > refs from "git for-each-ref".
> >
> > Fix this by operating on the returned string as a byte string rather
> > than a unicode string.  As this method is currently only used internally
> > by the class this does not affect code anywhere else.
> >
> > Note that we cannot use byte strings in the source as the 'b' prefix is
> > not supported before Python 2.7 so in order to maintain compatibility
> > with the maximum range of Python versions we use an explicit call to
> > encode().
> 
> The three patches that deal with .encode() stuff (2, 7, 8) make me a
> bit uncomfortable, as they add some significant complexity to our
> python code. Is this the recommended way to deal with this (similar to
> the other patch where you linked to the python wiki explaining)?

The best I can offer is this:

http://docs.python.org/3/howto/pyporting.html#deal-with-the-bytes-string-dichotomy

Their recommendation is to use the b() function from the six project,
but given that we don't need it in too many places I prefer the approach
I took here to adding a thirdparty dependency.

> As one datapoint, it seems that it's actually Python 2.6 that
> introduces the b prefix.
> 
> http://www.python.org/dev/peps/pep-3112/
> 
> When did we last revisit what minimal python version we are ok with requiring?

I was wondering if people would weigh in discussing that in response to
[1] but no one has commented on that part of it.  As another datapoint,
Brandon Casey was suggesting patching git-p4.py to support Python 2.4
[2].

[1] http://article.gmane.org/gmane.comp.version-control.git/213920
[2] http://article.gmane.org/gmane.comp.version-control.git/214048


John
