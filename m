From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH] Fix overwritten remote ref on with fast-import.
Date: Wed, 18 Jul 2012 00:25:06 +0200
Message-ID: <1827416.SEfKlye8mW@flobuntu>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1571690.jxJy5HzrPO@flobuntu> <20120717210212.GB15624@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 00:25:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrGCk-0008VO-Tk
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 00:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756319Ab2GQWZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 18:25:13 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:59454 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384Ab2GQWZM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 18:25:12 -0400
Received: by wibhr14 with SMTP id hr14so817793wib.1
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 15:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=Y0y561p1EQ7JsT6cDY8FNvZiUOhNl2ygJ+jBjUo7uK0=;
        b=L8uv43ZJmSgYaCyGvPF637R1N9YHgpzX1NikadWQu963SKihCoT5Qqx0mtSXkUxlXw
         ZUloqY09VtbxsgCS9bqtlYSlgAM5ODFZGGOtk1KzHmvROvyhJN+R2aMP199kvPzEPn3s
         v6n35c01qsm7uLvyhGp98s/8ZvyVm683vmaDGWBSFQ5xylsiZiZ7xfFyPY/oqG8yx2O0
         mpjG3uY2etUpbHw3r2RmarWSVi8YlMx26RZXqc9NCjyBM/8ZNZhkFCw4qtnuzXQCCZxt
         MbCuAKIAtozwZDelZMwqP5qapWn8HQ0KFfCVubkMgNxAeWGNTgTl0x9mL7c4rz/I/ot8
         uGKw==
Received: by 10.180.91.1 with SMTP id ca1mr1161960wib.8.1342563910423;
        Tue, 17 Jul 2012 15:25:10 -0700 (PDT)
Received: from flobuntu.localnet (93-82-150-64.adsl.highway.telekom.at. [93.82.150.64])
        by mx.google.com with ESMTPS id el6sm29283408wib.8.2012.07.17.15.25.07
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 15:25:09 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120717210212.GB15624@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201624>

On Tuesday 17 July 2012 16:02:12 Jonathan Nieder wrote:
> Hi,
> 
> Florian Achleitner wrote:
> > So we want the transport-helper to touch only private refs, i.e. some
> > subdir of refs/, ok.
> > On the other hand I thought we expect git-fetch to update the RHS of the
> > passed refspec (or the default one ). How?
> 
> Now I am getting confused by terminology.  By "the transport-helper"
> do you mean the remote helper (e.g., git-remote-svn) or
> transport-helper.c?

I was confused too. It should say remote-helper. 
> 
> By the "default" refspec do you mean the one specified in .git/config
> or some default when none is specified there?  "git fetch" updates
> refs according to the specified fetch refspec in
> builtin/fetch.c::store_updated_refs().

.. and I didn't realize that the two different refspecs involved here can be 
different and shall be different because they get post-processed accordingly.
I thought the remote-helper has to import according to the fetch refspec.

> 
> > Btw, whats FETCH_HEAD for?
> 
> "grep FETCH_HEAD Documentation/*.txt" gives some hints.  Most notably:
> 
> 	git-fetch(1)
> 	------------
> 	The ref names and their object names of fetched refs are stored
> 	in ".git/FETCH_HEAD".  This information is left for a later merge
> 	operation done by 'git merge'.
> 
> 	gittutorial(7)
> 	--------------
> 	Alice can peek at what Bob did without merging first, using the "fetch"
> 	command; this allows Alice to inspect what Bob did, using a special
> 	symbol "FETCH_HEAD", in order to determine if he has anything worth
> 	pulling, like this:
> 
> 	------------------------------------------------
> 	alice$ git fetch /home/bob/myrepo master
> 	alice$ git log -p HEAD..FETCH_HEAD
> 	------------------------------------------------
> 
> Hope that helps,
> Jonathan

Thanks,
Florian
