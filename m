From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git log can not show history before rename
Date: Fri, 30 Jan 2009 09:17:00 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901300910580.3150@localhost.localdomain>
References: <1976ea660901300323n384d3650s3bb5a575accb65d1@mail.gmail.com>  <adf1fd3d0901300329y53e46d91xda75799ce1244ddd@mail.gmail.com> <1976ea660901300429i6d9b3594m91222314c284d184@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 18:19:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSx18-0007AB-AJ
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 18:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbZA3RRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 12:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbZA3RRd
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 12:17:33 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54939 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751090AbZA3RRc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 12:17:32 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0UHH1Ws022385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Jan 2009 09:17:02 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0UHH0EZ010899;
	Fri, 30 Jan 2009 09:17:00 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1976ea660901300429i6d9b3594m91222314c284d184@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107855>



On Fri, 30 Jan 2009, Frank Li wrote:
>
> Does it conflict with --parents?

Yes. --follow and --parents do not play well together.

That's simply because --follow is a total hack, meant to just satisfy 
ex-SVN users who never knew anything about things like parenthood or nice 
revision graphs anyway.

It's not totally fundamental, but the current implementation of "--follow" 
is really a quick preprocessing thing bolted onto the revision walking 
logic, rather than beign anything really integral.

If you want --follow to really work together with --parents (and to do the 
right thing wrt merges etc - different renames coming in through different 
branches), you'd really have to rewrite the whole --follow logic.

One approach is to use --follow as the quick hack it is - and then when 
you see "oh, file X was renamed from file Y", and you want to see the nice 
full history, you go back to the native git model (which is not --follow), 
which is based on pathname pattherns, and then do

	gitk -- X Y

to see the history of _both_ names, and now the rename will show up 
properly (and now you'll get proper parenthood because you're no longer 
using the hackish --follow thing).

If somebody wants to do a more intelligent --follow, I can only applaud, 
but I'm personally not likely to look into it.

			Linus
