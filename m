From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH] Fix overwritten remote ref on with fast-import.
Date: Tue, 17 Jul 2012 00:33:21 +0200
Message-ID: <11883284.WI8IR4K6qp@flobuntu>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1342362383-31167-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <20120716003024.GA4246@burratino>
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
X-From: git-owner@vger.kernel.org Tue Jul 17 00:33:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqtrP-0008EG-CW
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 00:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347Ab2GPWdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 18:33:32 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:33585 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333Ab2GPWdb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 18:33:31 -0400
Received: by weyx8 with SMTP id x8so4275499wey.19
        for <git@vger.kernel.org>; Mon, 16 Jul 2012 15:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=I6rp8AJwQUwMovYxirS70CjqNow4rBm4tm+GyrfuAy4=;
        b=TI/SeqqcSPbjAVKXffiB/dhB+bOGVWoz55eqK/c4G9ZY28/E6fAQXHC6CaUVaB6e0m
         XiBolAeMEhjzBSP+cQAoqrlTUIAQ+2WI/FGpwmbLihjYscFQRo6rAcb3w6/KQldg3q9m
         KQd8j+2zPevtHLwDdEkpOa2IBAYy4DzG4Cp+/7mEpYzH4usmMLe3ut6lAOEBcS/JtjYR
         dXtJpxH2cgGk/dogOj0+ahtyNOpwKAIq/dm8hAdh7oZe1ldS19nRaC6RMj9r5XuQ/GAc
         AOV5qlX5Kmddt0lZmc+NNT2e7sqHTRACmdBjxWYBx5rvu4DKANfFNu49yOl0Y8SULVvz
         +jIg==
Received: by 10.180.103.136 with SMTP id fw8mr242913wib.20.1342478009729;
        Mon, 16 Jul 2012 15:33:29 -0700 (PDT)
Received: from flobuntu.localnet (91-115-81-173.adsl.highway.telekom.at. [91.115.81.173])
        by mx.google.com with ESMTPS id l5sm35015844wix.5.2012.07.16.15.33.26
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Jul 2012 15:33:28 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120716003024.GA4246@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201579>

On Sunday 15 July 2012 19:30:25 Jonathan Nieder wrote:
> Hi Florian,
> 
> Florian Achleitner wrote:
> > After importing new commits on top of refs/remotes/* the
> > ref was overwritten with the local refs/heads/master, because the name
> > of the remote reference to fetch, i.e. refs/heads/master, was used to
> > retrieve old_sha1 for it's local counterpart. Therefore, old_sha1 pointed
> > to the local head which was not contained in the remote branch and
> > couldn't
> > be updated (printing a warning ..).
> 
> I assume you are talking about the status quo here.  It's easy to
> forget that others have not already applied your patch, but using the
> present tense would make reading easier.  Think of the patch
> description as a special kind of bug report.
> 
> Unfortunately, as a bug report, the above is lacking some detail.  Do
> I understand correctly that some remote helper is failing when git
> invokes its 'import' command?  What are the symptoms?  If it prints a
> warning, what is the exact warning?

I got that problem when I wanted to make remote-svn fetch
to refs/remotes/ instead of the formerly hardcoded (in fast-export.c)
refs/heads/master. 
I didn't yet have the refspec capability (now I have it), and that seems to be 
a significant part of the problem.
The scenario is as follows:
The fast import stream contains 'commit refs/remotes/svnfile/master' and fast-
import adds all the commits on top of it and updates the ref correctly.
But the string affected by the patch, 'private', contains the remote name of 
the branch because it is duped from ref->name, namely refs/heads/master.
As a consequence, subsequent processing leads to:

fatal: bad object 0000000000000000000000000000000000000000
error: svn::file:///anypath did not send all necessary objects

..because it expects something to have arrived on refs/heads/master.

If ref/heads/master already exists, it works, but the resulting refs are 
wrong.
refs/remotes/svnfile/master points to the same commit as ref/heads/master does, 
which is the one created locally. There is no ref to the remote commits.

It follows that, on re-fetching the same remote it fails and fast-import 
refuses to update the ref:
warning: Not updating refs/remotes/svnfile/master (new tip 
5479b212afab5ef541c142bf75357405b7888e4d does not contain 
4e49b15fcc9797bb90e36ec90c14de3d5437a94d)

That's because the  refs/remotes/svnfile/master points to the wrong local-only 
commit.

After exploring the whole fetch process by inserting dozens of printfs, I 
concluded that it's wrong to retrieve the sha1 to update by passing the branch 
name on the remote side (in private) to read_ref, which gives the sha1 of a 
local branch, but that the correct ref is stored in ->peer_ref. I wasn't 
really sure what peer-ref is meant to be. That's what lead to the patch, but..
> 
> Does that remote helper advertise the 'refspec' capability?  If so,
> what refspec does it use?  If not, why not?

When it does advertise refspec like:
Debug: Remote helper: <- refspec refs/heads/master:refs/remotes/svnfile/master
it all works. Unfortunatly I didn't understand that a day ago.

But I'm still not completely sure about what the line I wanted to patch is 
for.
Doc about git-remote-helpers says: "If no refspec capability is advertised, 
there is an implied refspec *:*."
Hmm..so if the helper doesn't advertise 'refspec' the remote refs/heads/master 
is always fetched to the local refs/heads/master?
If yes, it makes sense now! A little comment in the sources would help a lot.

> 
> It might seem silly to ask for these things when you're providing a
> fix along with the report!  However, if someone else runs into the
> same symptoms, they need to be able to find your patch quickly; if
> your patch has a bad side-effect then we need to know why not to
> revert it; and if someone new starts working on the same area of code,
> they need to know what bugs to avoid reintroducing.

I think we can throw that patch away.

> 
> Curious,
> Jonathan
