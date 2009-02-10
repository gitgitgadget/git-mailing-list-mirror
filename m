From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Support "\" in non-wildcard exclusion entries
Date: Tue, 10 Feb 2009 15:27:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902101525380.10279@pacific.mpi-cbg.de>
References: <20090210121149.GA1226@pvv.org> <alpine.DEB.1.00.0902101354460.10279@pacific.mpi-cbg.de> <20090210125800.GA14800@pvv.org> <alpine.DEB.1.00.0902101402230.10279@pacific.mpi-cbg.de> <20090210142017.GA16478@pvv.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 15:28:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWtbI-0000fj-Dn
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 15:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548AbZBJO1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 09:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755520AbZBJO1A
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 09:27:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:52576 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755548AbZBJO07 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 09:26:59 -0500
Received: (qmail invoked by alias); 10 Feb 2009 14:26:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp036) with SMTP; 10 Feb 2009 15:26:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18loJklBAclvDX5KfPZKTn/XFGFbZJnQN6RTtVM7X
	IAFjMwN0UDvBKH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090210142017.GA16478@pvv.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109245>

Hi,

On Tue, 10 Feb 2009, Finn Arne Gangstad wrote:

> "\" was treated differently in exclude rules depending on whether a
> wildcard match was done. For wildcard rules, "\" was de-escaped in
> fnmatch, but this was not done for other rules since they used strcmp
> instead.  A file named "#foo" would not be excluded by "\#foo", but would
> be excluded by "\#foo*".
> 
> We now treat all rules with "\" as wildcard rules.
> 
> Another solution could be to de-escape all non-wildcard rules as we
> read them, but we would have to do the de-escaping exactly as fnmatch
> does it to avoid inconsistencies.
> 
> Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
> ---
>  dir.c                                       |    2 +-
>  t/t3003-ls-files-others-escaped-excludes.sh |   37 +++++++++++++++++++++++++++

Thanks, much appreciated!

> diff --git a/t/t3003-ls-files-others-escaped-excludes.sh b/t/t3003-ls-files-others-escaped-excludes.sh
> new file mode 100755
> index 0000000..bce8741
> --- /dev/null
> +++ b/t/t3003-ls-files-others-escaped-excludes.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2009 Finn Arne Gangstad
> +#
> +
> +test_description='git ls-files --others with escaped excludes
> +
> +This test tests exclusion patterns with \ in them and makes sure they
> +are treated correctly and identically both for normal and wildcard rules.
> +'
> +
> +. ./test-lib.sh
> +
> +touch \#ignore1 &&

In other tests, we avoid 'touch' (IIRC it is not available everywhere or 
some such), and we write ': > \#ignore1' instead.

BTW we do not need the # in the name, it could be any letter, right?  
(Just for my understanding, not as a request to change it.)

> +touch \#ignore2 &&
> +touch \#hidden &&
> +touch keep
> +
> +echo keep > expect
> +
> +cat >.gitignore <<EOF

You probably want to use \EOF here.

> +.gitignore
> +expect
> +output
> +\#ignore1
> +\#ignore2*
> +\#hid*n
> +EOF
> +
> +test_expect_success \
> +    'git ls-files --others with escaped excludes.' \
> +    'git ls-files --others \
> +       --exclude-per-directory=.gitignore \
> +       >output &&
> +     test_cmp expect output'
> +
> +test_done

Thanks!
Dscho
