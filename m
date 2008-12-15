From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: Re: [patch] Fix a corner case in git update-index --index-info
Date: Mon, 15 Dec 2008 11:52:25 +0100
Organization: Intra2net AG
Message-ID: <200812151152.59451.thomas.jarosch@intra2net.com>
References: <200812131403.08740.thomas.jarosch@intra2net.com> <7viqpn6fhz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 11:54:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCB5k-0003k2-50
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 11:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413AbYLOKxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 05:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753323AbYLOKxF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 05:53:05 -0500
Received: from rs02.intra2net.com ([81.169.173.116]:46775 "EHLO
	rs02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbYLOKxD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 05:53:03 -0500
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rs02.intra2net.com (Postfix) with ESMTP id 1DB2D4C47;
	Mon, 15 Dec 2008 11:53:01 +0100 (CET)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id B02F42AC4B;
	Mon, 15 Dec 2008 11:53:00 +0100 (CET)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id C0F962AC4A;
	Mon, 15 Dec 2008 11:52:59 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27.5-41.fc9.i686; KDE/4.1.3; i686; ; )
In-Reply-To: <7viqpn6fhz.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intranator.com) with AMaViS and F-Secure AntiVirus (fsavdb 2008-12-15_02)
X-Spam-Status: hits=-2.0 tests=[ALL_TRUSTED=-1.8,BAYES_40=-0.185]
X-Spam-Level: 980
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103155>

On Saturday, 13. December 2008 20:29:12 you wrote:
> If you are doing a filter-branch and the commits near the beginning of the
> history did not have any path you are interested in, I do not think you
> would want to even create corresponding commits for them that record an
> empty tree to begin with, so I do not necessarily agree with the above
> command line.  The mv would fail due to absense of index.new file, and you
> can take it as a sign that you can skip that commit.

True. I killed the empty commit later using rebase -i. Great tool :-)

> Outside the context of your command line above, I am slightly more
> sympathetic than neutral to the argument that "update-index --index-info"
> (and "update-index --stdin", which I suspect would have the same issue,
> but I did not check) should create an output file if one did not exist.
>
> You should note however that such a change would rob from you a way to
> detect that you did not feed anything to the command by checking the lack
> of the output.  Such a change would break people's existing scripts that
> relied on the existing behaviour; one example is that the above "The mv
> would fail...and you can" would be made impossible.

That is also true. OTOH there would be no way to create an empty tree,
f.e. if you do positive filtering like --subdirectory-filter
just with multiple subdirs:

git filter-branch --tag-name-filter cat --index-filter \
    'git ls-files -s |grep -P "\t(DIR1|DIR2)" \
    |GIT_INDEX_FILE=$GIT_INDEX_FILE.new git update-index --index-info &&
    mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' -- --all

Later on I removed all empty commits in a second run.

> > +	if (!found_something)
> > +		active_cache_changed = 1;
> > +
> >  	strbuf_release(&buf);
> >  	strbuf_release(&uq);
> >  }
>
> I think this implementation is conceptually wrong, even if we assume it is
> the right thing to always create a new file.  The --index-info mode may
> well be fed with the same information as it already records, in which case
> active_cache_changed shouldn't be toggled, and if it is fed something
> different from what is recorded, active_cache_changed should be marked as
> changed, and that decision should be left to the add_cache_entry() that is
> called from add_cacheinfo().  What you did is to make it _always_ write
> the new index out, even if we started with an existing index, and there
> was no change, or even if we started with missing index, and there was no
> input.  You only wanted the latter but you did both.

The idea was to toggle the active_cache_changed variable only if we didn't get 
a single line of input from stdin. If you feed back the same index information
f.e. via "git ls-tree -s", the active_cache_changed=1 code shouldn't be 
executed. Though I didn't explicitly test this case, so I guess you are right.

> But again, this would break people who have been relying on the existing
> behaviour that no resulting file, when GIT_INDEX_FILE points at a
> nonexistent file, signals no operation.

See my remark about "positive list" filtering above.

> I think it is a bad idea to do this in -rc period, even if we were to
> change the semantics.

Yes, this is something one doesn't want in a -rc :-)

Thanks for your implementation.

btw: I sent a small documentation update to the list and forgot to add you
to the CC: list. The subject line was

"[patch] documentation: Explain how to free up space after filter-branch"

Cheers,
Thomas
