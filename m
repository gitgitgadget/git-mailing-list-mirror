From: John Keeping <john@keeping.me.uk>
Subject: Re: git config --get-urlmatch does not set exit code 1 when no match
 is found
Date: Sun, 28 Feb 2016 11:52:27 +0000
Message-ID: <20160228115227.GU1766@serenity.lan>
References: <CAMDzUtzNKAYSKYkt3WagkUrA2mKaoDu1rT6Nhf89pXSMg0wZwA@mail.gmail.com>
 <20160228104557.GT1766@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Guilherme <guibufolo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 12:52:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZzu1-0005QM-LX
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 12:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757053AbcB1Lwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 06:52:36 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:35300 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756975AbcB1Lwg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 06:52:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 1DD67CDA5B7;
	Sun, 28 Feb 2016 11:52:35 +0000 (GMT)
X-Quarantine-ID: <9d15IfKsGcUB>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9d15IfKsGcUB; Sun, 28 Feb 2016 11:52:34 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 9BC99CDA5AE;
	Sun, 28 Feb 2016 11:52:29 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20160228104557.GT1766@serenity.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287768>

On Sun, Feb 28, 2016 at 10:45:57AM +0000, John Keeping wrote:
> On Sun, Feb 28, 2016 at 10:09:12AM +0530, Guilherme wrote:
> > My current woes are with multi-valued configuration values. More
> > specifically credential.helper
> > 
> > The documentation of git config says that when a value is not matched
> > it should return 1.
> > 
> > To reproduce make sure that credential.helper is not set.
> > 
> > git config --get-urlmatch credential.helper http://somedomain:1234/
> > echo %ERRORLEVEL%
> > 0
> > 
> > git config --get credential.helper
> > echo %ERRORLEVEL%
> > 1
> > 
> > git config --get credential.http://somedomain:1234/.helper
> > echo %ERRORLEVEL%
> > 1
> > 
> > The documentation says that for credential.helper is not found for a
> > domain it should fall back to credential.helper if it is set. So I
> > think that all those tests above should have returned 0. Am i right?

I misread this as "should have returned 1", which is what the text below
agrees with.

The "git config" command does not know anything about the semantics of
particular config keys.  It is purely an interface to parse and query
the config file format and it is up to the consumer to know what to do
if a key doesn't exist.

Both of the "git config --get" examples you give are behaving as
documented in git-config(1).

> It looks to me like a simple bug that --get-urlmatch doesn't return 1 if
> the key isn't found, but git-config(1) isn't entirely clear.  The
> overall documentation on exit codes at the end of DESCRIPTION says that
> exit code 1 means:
> 
> 	the section or key is invalid (ret=1)
> 
> Then the documentation for the --get option says:
> 
> 	Returns error code 1 if the key was not found.
> 
> and --get-all says:
> 
> 	Like get, but does not fail if the number of values for the key
> 	is not exactly one.
> 
> although it does return 1 if there are zero values.  --get-regexp
> behaves in the same way.
> 
> Overall I think that the fact that --get-urlmatch is the outlier here
> means that it should change to match the other --get* options (ignoring
> --get-color and --get-colorbool which are very different).  Although I
> wonder if anyone is relying on the current behaviour and will find their
> workflow broken if we change this.
> 
> The documentation could also use some clarification since most of the
> return codes only apply for the "set" options and in some cases this
> isn't clear from the existing descriptions.
