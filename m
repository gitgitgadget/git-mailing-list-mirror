From: Lukas Fleischer <lfleischer@lfos.de>
Subject: Re: [PATCH] Allow hideRefs to match refs outside the namespace
Date: Sun, 01 Nov 2015 00:40:39 +0100
Message-ID: <20151031234039.3799.78352@typhoon.lan>
References: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
 <1446046920-15646-1-git-send-email-lfleischer@lfos.de>
 <xmqq1tcfm09k.fsf@gitster.mtv.corp.google.com>
 <20151031084917.26006.98611@typhoon.lan>
 <xmqqsi4rhrmc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 00:40:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsflP-0004fB-RX
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 00:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbbJaXkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 19:40:43 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:27906 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbbJaXkn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Oct 2015 19:40:43 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id d13d73da;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Sun, 1 Nov 2015 00:40:41 +0100 (CET)
In-Reply-To: <xmqqsi4rhrmc.fsf@gitster.mtv.corp.google.com>
User-Agent: alot/0.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280602>

On Sat, 31 Oct 2015 at 18:31:23, Junio C Hamano wrote:
> [...]
> You earlier (re)discovered a good approach to introduce a new
> feature without breaking settings of existing users when we
> discussed a "whitelist".  Since setting the configuration to an
> empty string did not do anything in the old code, an empty string
> was an invalid and non-working setting.  By taking advantage of that
> fact, you safely can say "if you start with an empty that would
> match everything, we'll treat all the others differently from the
> way we did before" if you wanted to.  I think you can follow the
> same principle here.  For example, I can imagine that the rule for
> the "ref-is-hidden" can be updated to:
> 
>  * it now takes refname and also the fullname before stripping the
>    namespace;
> 
>  * hide patterns that is prefixed with '!' means negative, just as
>    before;
> 
>  * (after possibly '!' is stripped), hide patterns that is prefixed
>    with '^', which was invalid before, means check the fullname with
>    namespace prefix, which is a new rule;
> 
>  * otherwise, check the refname after stripping the namespace.
> 
> Such an update would allow a new feature "we now allow you to write
> a pattern that determines the match before stripping the namespace
> prefix" without breaking the existing repositories, no?
> 

Yes. If I understood you correctly, this is exactly what I suggested in
the last paragraph of my previous email (the only difference being that
I suggested to use "/" as full name indicator instead of "^" but that is
just an implementation detail). I will look into implementing this if
that is the way we want to go.

> [...]
> Assuming other namespaces are forks of the same project as yours
> (and otherwise the repository management strategy needs to be
> rethought--using namespace for them is not gaining anything other
> than making your repack more costly), it is likely that all of them
> share a lot of refs that point at the same object (think "tags").
> Do we end up sending a lot of ".have" for exactly the same object
> number of times?  Even though we cannot dedup show_ref() lines that
> talk about concrete refs (because they talk about what refs exist at
> which value, and the sending side would use them to locally reject
> non-ff pushes, for example), ".have" lines that talk about the same
> object can be safely deduped.  This is not directly related to your
> topic of "what should be included in the advertisement", but a
> potentially good thing to fix, if it indeed turns out that we are
> sending a lot of duplicate ".have"s.  A fix in that would make
> things better for everybody (not just namespace users, but those who
> show the ".have" lines from the refs in the repository we borrow
> objects from).

Yes, I think we currently send a lot of duplicate lines. Would be nice
to have that fixed as well.

Note that we do use Git namespaces to store a lot of different but
similar pseudo repositories (i.e. they do not share any history but the
objects have huge similarities). Even though the pseudo repositories
itself are tiny, having the objects in a shared object storage reduces
the size significantly. Other people probably use separate repositories,
combined with something like GIT_OBJECT_DIRECTORY and preciousObjects
for that. Using Git namespaces, however, allows to run `git gc`/`git
repack` without needing to take care of maintaining back references to
the pseudo repositories and, more importantly, allows for storing all
the refs in a single "packed-refs" file which did reduce the size the
size by another factor of 10 in our tests. That massive difference in
size is probably mostly due to the fact that the actual content of each
repository is just some 100 bytes. Not sure if saving that much space
can currently be achieved with any other approach.
