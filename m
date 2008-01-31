From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Thu, 31 Jan 2008 14:18:42 +1300
Message-ID: <47A121F2.4040400@vilain.net>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org> <479E5021.7010404@vilain.net> <20080129041000.GK24004@spearce.org> <47A01963.1030703@vilain.net> <20080130074758.GT24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 02:19:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKO5O-0006WX-2k
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 02:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbYAaBSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 20:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753415AbYAaBSx
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 20:18:53 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:40528 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753555AbYAaBSv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 20:18:51 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 880B021D191; Thu, 31 Jan 2008 14:18:46 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7-deb
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 1453221D171;
	Thu, 31 Jan 2008 14:18:43 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <20080130074758.GT24004@spearce.org>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72085>

Shawn O. Pearce wrote:
>> Ok - but I think if the client is pushing a signed tag to the tagname
>> listed in the signed body of the tag, that no extra signature should be
>> necessary.  It's only commits that need the extra information.
> 
> Doh.  Of course the standard signed tag case is easily verified,
> without the new authentication extension.  But adding it around
> a signed tag push doesn't really hurt anything, except maybe the
> user who entered her passphrase yet again.
> 
> Signing a tag push is actually relevant in some cases.  For example
> when I mirror Junio's git.git tree into my local server at day-job.
> Junio signed the v1.5.4-rc5 tag.  I pushed it to the same location,
> and although we can validate Junio's signature, it may matter (to
> people who have too much free time on their hands but I digress)
> who at our organization put that v1.5.4-rc5 tag from Junio onto
> that particular system, and when they did that.  Was it me?
> Or another co-worker?

Ok, well if people want to sign those pushes then let them - but
allowing them to be pushed anonymously does have the nice side effect
that absolutely nothing needs to be done for the case of replicating
tagged releases of an existing project.  ie, projects that are just
tagging using existing tools and have no knowledge of this system.

>> And remember, for global replication of the data between untrusted nodes
>> to be possible, the signatures must be saved somewhere.  I have sketched
>> a simple design below.
> 
> Crap.  You mentioned this in your initial email, and I forgot
> about it when I posted the message you are responding to now.
> Its actually an interesting concept.  We can validate the entire
> chain of commits that led up to a signed tag, and we can validate
> that signature on that tag.  So why shouldn't we also be able to
> validate the changes to refs in a distributed fashion?

Yes, you could be lazy about it and throw away signatures that were
obsoleted.

>>    access-keys/
>>      - tree with one key per e-mail address
>>    access
>>      - maps reference globs to e-mail addresses permitted to change
>>        them - with a "+" if the address may rewind the ref
>>    owners
>>      - maps reference globs to e-mail addresses permitted to add entries
>>        to the "access" map above
> 
> This part I get.  Using only globs is a tad limited in my mind.
> I actually abuse regexes on refs at day-job in a few places to get
> the access list to work with just a handful of rules.

Extended POSIX or limited PCRE or something like that will do then.

>>    signatures/
>>      - stores any detached signatures.  only the signatures verifying
>>        updates since the last commit to the access meta-branch need to
>>        be stored
>>    packed-refs
>>      - the new list of references (the refs/access commitid is naturally
>>        absent or the same as the parent), or just the changed
>>        references.
> 
> This I'm not so sure.  Are you suggesting that we save the detached
> signature I described earlier that signed the push command set and
> store it here, in this access state branch?  And that we also store
> a copy of all refs (save this one) as a flat file?

On second thoughts, these are only of interest to the auditing and
replication side of things.

> Someone please stop the madness!  :-)

Ok, I think I see the simple beginning path.  Let's go back to the tree
state idea and not worry about replication and auditing yet.  I think it
should fit in smoothly anyway with the above basics.

This means we can nail down the rules for validating a single push/ref
change.  Handling ACL changes is the second level once this first level
works.  It can be manual initially.

You bring up an idea I didn't think of, which is setting up ACLs for
paths within a tree.  I guess quite a few people want that.

How about this syntax (and using globs for illustrative simplicity only):

  refs/heads/*:path/* = any(email email email)

Also, I think that the point about the debian keyrings requires some
consideration.  Maybe groups;

  access-keys/debian/

That way the debian/ access-keys sub-directory can be shared via
alternates across a number of repositories on a shared system.  Instead
of an email address, a group is listed.  But again I think should fall
into place later, once the basic idea is nailed down.

Sam.
