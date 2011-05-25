From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Support multiple virtual repositories with a single
 object store and refs
Date: Wed, 25 May 2011 09:56:47 -0700
Message-ID: <BANLkTi=WTbEbRoR7pEzja9e5hfoApFhw_w@mail.gmail.com>
References: <20110524010252.GA5368@leaf> <20110524195937.GE584@sigill.intra.peff.net>
 <20110524224711.GA2527@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jamey Sharp <jamey@minilop.net>
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Wed May 25 18:57:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPHOW-0000Sy-D5
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 18:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613Ab1EYQ5J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 12:57:09 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44678 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab1EYQ5I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 12:57:08 -0400
Received: by vxi39 with SMTP id 39so5908064vxi.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 09:57:07 -0700 (PDT)
Received: by 10.52.173.108 with SMTP id bj12mr7165606vdc.177.1306342627101;
 Wed, 25 May 2011 09:57:07 -0700 (PDT)
Received: by 10.52.167.228 with HTTP; Wed, 25 May 2011 09:56:47 -0700 (PDT)
In-Reply-To: <20110524224711.GA2527@leaf>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174428>

On Tue, May 24, 2011 at 15:47, Josh Triplett <josh@joshtriplett.org> wr=
ote:
> On Tue, May 24, 2011 at 03:59:37PM -0400, Jeff King wrote:
>> You have a namespace clash if a repo is named "heads" or "tags" or
>> "remotes". Should we give it its own namespace, like:
>>
>> =A0 refs/virtual/repo1/heads/*

Yes, I strongly agree with Peff here. We should "standardize" the
prefix of "refs/virtual/" for these things, to keep them from
inteferring with the other "standard" namespaces of refs/heads,
refs/remotes, refs/tags, refs/notes, and if Gerrit Code Review is
used, refs/changes.

>> Also, it seems conceptually simpler to me if it's a straight prefix.
>> IOW, "refs/heads/foo" in repo1 becomes:
>>
>> =A0 refs/virtual/repo1/refs/heads/foo

I also think this is a great idea. It vastly simplifies the operations
involved and allows each virtual namespace to have its own HEAD within
the virtual namespace, as a sibling of "refs", just like in a normal
repository. It may seem a little ugly to put two refs in there, but I
think this is easily understood by repository owners/administrators
and will keep the implementation much more simple.

>> Then if we are operating in the virtual repo1 space, then:
>>
>> =A0 1. It is an easy test to know whether we are allowed to see a re=
f:
>> =A0 =A0 =A0"does it start with refs/virtual/$repo/ ?"
>>
>> =A0 2. Converting back and forth is simple. You just prepend or stri=
p the
>> =A0 =A0 =A0refs/virtual/$repo prefix.
>
> Both of the namespaces you suggested work with our current patch:
> --ref-prefix=3Dvirtual/repo1/, or --ref-prefix=3Dvirtual/repo1/refs/.=
 =A0We'd
> like to leave the exact choice of paths up to the policies of the hos=
t,
> but your suggestion does seem like a good general namespacing policy.

Ideally your implementation would only add/remove the prefix and
wouldn't muck around with the "refs/" part. Then step 1 and step 2 are
trivial.

Don't forget that a lot of Git usage comes from shell scripts. Being
able to use git for-each-ref with a simple sed script to process these
virtual namespaces is really important. If the sed script just needs
to remove a prefix, this easy. If it needs to remove part of the
prefix and replace with something else, its a bit more complicated for
the script writer to work with.

--=20
Shawn.
