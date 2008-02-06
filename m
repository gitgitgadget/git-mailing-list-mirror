From: Anand Kumria <wildfire@progsoc.org>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Wed, 6 Feb 2008 21:56:35 +0000 (UTC)
Message-ID: <pan.2008.02.06.21.56.35@progsoc.org>
References: <pan.2008.02.04.18.25.26@progsoc.org>
	<20080205050741.GA4624@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 22:57:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMsGk-0003BP-1J
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 22:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbYBFV4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 16:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbYBFV4w
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 16:56:52 -0500
Received: from main.gmane.org ([80.91.229.2]:38508 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791AbYBFV4v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 16:56:51 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JMsG3-0006KC-Tk
	for git@vger.kernel.org; Wed, 06 Feb 2008 21:56:44 +0000
Received: from 82-35-82-57.cable.ubr03.dals.blueyonder.co.uk ([82.35.82.57])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 21:56:43 +0000
Received: from wildfire by 82-35-82-57.cable.ubr03.dals.blueyonder.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 21:56:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 82-35-82-57.cable.ubr03.dals.blueyonder.co.uk
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72858>

On Tue, 05 Feb 2008 00:07:41 -0500, Jeff King wrote:

> On Mon, Feb 04, 2008 at 06:25:25PM +0000, Anand Kumria wrote:
> 
>> $ cat .git/config
>> {{ ... }}
>> [remote "richard"]
>>     url = https://server.example.com/~richard/newfoo.git fetch =
>>     +refs/heads/*:refs/remotes/richard/*
>> 
>> $ git fetch richard
>> error:  (curl_result = 77, http_code = 0, sha1 =
>> 0bc27e5162d0e74053b71fc637cbbf8fc942e969)
> 
> I was unable to reproduce your problem here. However, peeking in curl's

I bisected this down to the patch that makes git-fetch a builtin 
(b888d61c8308027433df9c243fa551f42db1c76a) -- which is where I guessed 
the functionality changed.

> header files, it looks like error 77 is:
> 
>     CURLE_SSL_CACERT_BADFILE,  /* 77 - could not load CACERT file,
>     missing
>                                   or wrong format */
> 
>> Downgrading to git-core in Debian (1.5.3.8) and it works perfectly.
> 
> Since you are running Debian, can you confirm whether you have the
> 'ca-certificates' package installed? 

Yes, I have it installed.

> It creates the
> /etc/ssl/certs/ca-certificates.crt file, which is presumably the source
> of the complaining.

Yes, I have this file.


> That being said, there seems to be some difference between 1.5.3.8 and
> 1.5.4 that made us care more about SSL certs (though I note that the
> SSL_VERIFYPEER curl knob has been set since pre-1.0). Have you tried
> setting GIT_SSL_NO_VERIFY?
> 
> -Peff

With git 1.5.4 I can merrily clone the repository via https without issue.

Only using git-fetch seems to have an issue.

With GIT_SSL_NO_VERIFY defined, it fails with:

$ GIT_SSL_NO_VERIFY=1 ../git/git-fetch richard
error: gnutls_handshake() failed: ASN1 parser: Element was not found. (curl_result = 35, http_code = 0, sha1 = 510567ca41e201253445528ca6eb89ed43e71fce)
Getting pack list for https://server.example.com/~richard/newfoo.git
error: gnutls_handshake() failed: ASN1 parser: Element was not found.
Getting alternates list for https://server.example.com/~richard/newfoo.git
error: Unable to find 510567ca41e201253445528ca6eb89ed43e71fce under https://server.example.com/~richard/newfoo.git
Cannot obtain needed object 510567ca41e201253445528ca6eb89ed43e71fce
fatal: Fetch failed.


I *think* what is happening is that it is it is trying for the object - not seeing it and then not attempting to get the pack file.

But I'm having a hard time debugging this as git-fetch launches git-rev-list internally and it seems to be failing in there, really.

Thanks,
Anand

Bisect log:

git-bisect start
# good: [aadd4efa715f56e0eac5ac459c8ff4933b56d4ce] GIT 1.5.3.8
git-bisect good aadd4efa715f56e0eac5ac459c8ff4933b56d4ce
# bad: [c3c135291a62a01f7fd385f46cde34091767259b] GIT 1.5.4
git-bisect bad c3c135291a62a01f7fd385f46cde34091767259b
# bad: [183f84365de7b4b1fe0e15cebce80a95023aa1d6] git-p4: Fix typo in --detect-labels
git-bisect bad 183f84365de7b4b1fe0e15cebce80a95023aa1d6
# bad: [6ca8b977e4f678050db8fcb0eec2091dd44a2bd0] Bisect: add "skip" to the short usage string.
git-bisect bad 6ca8b977e4f678050db8fcb0eec2091dd44a2bd0
# good: [e66273a6abb8e9cd0967d52113e29c8014a255f8] Merge branch 'lh/merge'
git-bisect good e66273a6abb8e9cd0967d52113e29c8014a255f8
# good: [f5bf6feb05b8c89c448ded6e6fad0eb58ef35463] Merge branch 'maint'
git-bisect good f5bf6feb05b8c89c448ded6e6fad0eb58ef35463
# bad: [2b5a06edca8f7237aad6464b349b79772024d2a2] Restore default verbosity for http fetches.
git-bisect bad 2b5a06edca8f7237aad6464b349b79772024d2a2
# bad: [3278cd0a39c30c6c3082fc5feed0f9bd98b5f628] Properly cleanup in http_cleanup so builtin-fetch does not segfault
git-bisect bad 3278cd0a39c30c6c3082fc5feed0f9bd98b5f628
# good: [c7a8a16239c6bdbb4041dd8a8773ae055d3cccf8] Add bundle transport
git-bisect good c7a8a16239c6bdbb4041dd8a8773ae055d3cccf8
# bad: [7a2bff45937a60d846abf3ccb42015539aedcb40] Replace custom memory growth allocator with ALLOC_GROW
git-bisect bad 7a2bff45937a60d846abf3ccb42015539aedcb40
# bad: [4ad1eada9774a1f340beb4fdf78f1735534741bb] Fix off by one bug in reflog messages written by builtin-fetch
git-bisect bad 4ad1eada9774a1f340beb4fdf78f1735534741bb
# bad: [1aad91f5a715af92892aea7764beb829938ab111] Correct builtin-fetch to handle + in refspecs
git-bisect bad 1aad91f5a715af92892aea7764beb829938ab111
# bad: [b888d61c8308027433df9c243fa551f42db1c76a] Make fetch a builtin
git-bisect bad b888d61c8308027433df9c243fa551f42db1c76a
