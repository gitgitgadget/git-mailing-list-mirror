From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Fri, 28 Aug 2015 11:20:08 -0700
Message-ID: <20150828182008.GC8165@google.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
 <1440724495-708-8-git-send-email-sbeller@google.com>
 <CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
 <20150828170141.GB8165@google.com>
 <xmqqfv332v84.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:20:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVOGC-0000AW-CR
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 20:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbbH1SUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 14:20:13 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35398 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbbH1SUM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 14:20:12 -0400
Received: by pacdd16 with SMTP id dd16so70110344pac.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tM/tF/TfdT55EolGuIBxZ1MKtmIoZ81U2/kGqK5esgY=;
        b=diV6ZmjGVkofEFw0b/ShKP56d+30sRJCzmpc7+xoi03Y2jCg19JFYO0sYhucnpQDVB
         FoTCcpoEK9SkhTzSyApqYKSBjZHuMxFor0i+Qvj0I0phU/t1ZHI2hqWNDkUvte8t8MgJ
         pYtymAk8XAmmgzKdrxVr+pxYj7uesU26+BE5culJ7B3VQ6P761SK0g+uvN/Jt94dxmNK
         /PaYwj5HxoLqTI4uBwN65DvOlVmxQTUAHlkYB4Wu72nPff2oCXdQTJGtZPrVJtev4row
         wMi/SHsTiYYNkhcU9FUEIAPVHpQAXRMRzS7eO0JQ6+cV3sHubXo6B+zTBoJ4X3ziDxit
         hirQ==
X-Received: by 10.66.226.12 with SMTP id ro12mr17504911pac.74.1440786011626;
        Fri, 28 Aug 2015 11:20:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:d830:475:d6b6:5fa8])
        by smtp.gmail.com with ESMTPSA id df2sm6475402pad.19.2015.08.28.11.20.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Aug 2015 11:20:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfv332v84.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276744>

Junio C Hamano wrote:

> My preference is still (1) leave standard error output all connected
> to the same fd without multiplexing, and (2) line buffer standard
> output so that the output is at least readable as a text, in a
> similar way a log of an irc channel where everybody is talking at
> the same time.

There is something nice about the immediacy of seeing output from all
the subprocesses at the same time in that model.

But for commands that show progress like "git clone", "git checkout",
and "git fetch", it does not work well at all.  They provide output
that updates itself by putting a carriage return at the end of each
chunk of output, like this:

 remote: Finding sources:  11% (18/155)           \r
 remote: Finding sources:  12% (19/155)           \r

With multiple commands producing such output, they will overwrite each
other's lines, producing a mixture that is confusing and unuseful.

Even with --no-progress, there is a similar sense of confusion in the
intermixed output.  Error messages are hard to find.  This is a
comment complaint about the current "repo sync -j" implementation.

Ideally what I as a user want to see is something like what "prove"
writes, showing progress on the multiple tasks that are taking place
at once:

 ===(     103;1  0/?  8/?  3/?  11/?  6/?  16/?  1/?  1/? )==============

That would require more sophisticated inter-process communication than
seems necessary for the first version of parallel "git submodule
update".  For the first version that people use in the wild, showing
output from one of the tasks at a time, simulating a sped-up
sequential implementation, seems useful to me.

In the degenerate case where only one task is running, it reduces to
the current output.  The output is familiar and easy to use.  I quite
like the approach.

My two cents,
Jonathan
