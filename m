From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Sat, 16 May 2009 10:16:58 -0700
Message-ID: <7vtz3lnf1x.fsf@alter.siamese.dyndns.org>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>
	<op.utwdsutn1e62zd@merlin.emma.line.org>
	<7v8wl01iev.fsf@alter.siamese.dyndns.org>
	<op.utwyczlf1e62zd@merlin.emma.line.org>
	<20090514182249.GA11919@sigill.intra.peff.net>
	<op.utxydvnu1e62zd@merlin.emma.line.org>
	<20090515020206.GA12451@coredump.intra.peff.net>
	<op.uty0pjb51e62zd@balu> <m34ovmlcve.fsf@localhost.localdomain>
	<4A0D8211.5010806@viscovery.net>
	<81b0412b0905150851q232b3f6s95df89e72d4dc381@mail.gmail.com>
	<4A0D9696.1040805@op5.se> <7v3ab6uuw4.fsf@alter.siamese.dyndns.org>
	<4A0E67E9.3020208@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthias Andree <matthias.andree@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat May 16 19:24:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5NcX-0004pX-El
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 19:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbZEPRQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 13:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbZEPRQ7
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 13:16:59 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59644 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbZEPRQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 13:16:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090516171657.FOPL20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 16 May 2009 13:16:57 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id sHGy1b00U4aMwMQ03HGyGG; Sat, 16 May 2009 13:16:58 -0400
X-Authority-Analysis: v=1.0 c=1 a=lQuyK5o2kcMA:10 a=f4ZrQ2YIIQcA:10
 a=ybZZDoGAAAAA:8 a=tidPkaDtWIMw-LDwuRQA:9 a=jKcJyTxx-hSip_XEVAAA:7
 a=_AwKnGGHQC-rzjBleYU81X8dbYMA:4 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <4A0E67E9.3020208@op5.se> (Andreas Ericsson's message of "Sat\, 16 May 2009 09\:14\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119366>

Andreas Ericsson <ae@op5.se> writes:

> You re-create all your tag refs with same-name tags that point to the
> old tags.
> Joe Dev fetches from you, but your tags do not get stored as refs.
> Joe Dev publishes a repo somewhere with a bunch of topic-branches and
> requests you merge from those repositories.
> You fetch from Joe.
>
> Now we have two opposite problems.
> If tags aren't updated when Joe Dev fetches from you, his refs will
> not match yours when you fetch from him, and anyone cloning from him
> even after the re-sign will never get the new tags at all.
> If tag refs *do* get updated when fetching from a repo when we already
> have another tag ref with the same name, you fetching from Joe Dev
> could undo all your re-created tags and make the new tag-objects
> garbage-collectable. This assumes Joe Dev published his repo before
> fetching your new tags though.
>
> Perhaps I'm missing something....

No, you did not miss anything.  It illustrates the problem space very
well.

There are two "names" to a tag.  The name of a tag is recorded in the
object itself, in its "tag" header.

        $ git cat-file tag v1.6.3
        object f01f1099f40f24fe6f7802185340a6fa3a3d4f35
        type commit
        tag v1.6.3
        tagger Junio C Hamano <gitster@pobox.com> 1241659007 -0700

        GIT 1.6.3
        -----BEGIN PGP SIGNATURE-----
        Version: GnuPG v1.4.9 (GNU/Linux)
        ...

Anybody can forge, even down to the trailing signature part with a
compromised key, such a tag object that claims to be "tag v1.6.3" and
point anything with it.

But the "name" you usually access a tag object with is not this one.
Instead, you use the name of the ref in refs/tags hierarchy.  These two
names are supposed to match by convention, and I think recent fsck even
checks it.

Unlike the name recorded in tag objects, you can have only one v1.6.3 in
your ref namespace.  And the way git protects users from maliciously made
tags has been by not re-fetching what already exist unless explicitly
asked.  The consequence of this is that you somehow obtained a forged or
vulnerable one first, you will not get corrected ones automatically.

But that is a feature in the current set-up.

If the key that signs release tags were compromised and the tags got
re-signed with a new key (whether I re-tag by pointing at the commit
objects, or pointing at the old-genuine tag objects), that fact needs to
be advertised ("Sorry, but I had to re-tag; if you have old tags, please
re-fetch"), and the user who is currently protected by this "no automatic
re-fetching" mechanism has to somehow assert that "Sorry" is really from
me, and allow git to re-fetch.

The workflow for a such case would be:

 (0) I notice the signing key was somehow compromised; roll a new key,
     re-sign the tags, and send out a "I had to re-tag, and here is a list
     of the old and new tag object names you can use to verify" message;

 (1) You read such a message,  You do "git for-each-ref refs/tags" to see
     the object names to check with my message, and realize that you have
     stale tags.  So does Joe Dev but he may be slower to react;

 (2) You fetch (or ls-remote) from Joe Dev which is your preferrerd mirror
     of my tree and notice he hasn't updated, and let him know.  In the
     meantime you fetch "git fetch --tags" from me, and verify the result
     against my message.

 (3) Joe Dev would do the same.

That's largely manual, cumbersome, and makes everybody involved painfully
aware of what is going on, which may be an advantage over silently
updating with a new tag without telling anybody.

But you can improve the situation without losing security by doing
something like this.

 * Introduce a concept of "trusted signing keys" (similar to the way
   distros sign their binary packages), whose fingerprints are probably
   stored in .git/config of the receiving repositories;

 * Upon 'git tag -v <name>', verify that the signature was made with one
   of the trusted signing keys;

 * Inside 'git fetch':

   - before starting to fetch, see if there are signed tags that exist
     locally but not signed with any of the trusted keys;

   - for the signed tags we find in the above step, if the remote end has
     different tag object at the same refname, ask for them;

   - perform the main 'git fetch' transfer and store things according to
     the refspec as usual (but do not store the tags re-fetched only
     because of the new logic yet);

   - for the tags re-fetched with the new logic, see if they are signed by
     trusted keys, and if so replace the stale tags with them.

The step (0) to issue a "Sorry but I had to re-tag" message with "here is
the fingerprint of new signing key" is still necessary, and you need to
react to it by replacing the old trusted signing key with the fingerprint
of the new key, but after that everything can be made automatic.
