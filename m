From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Q: rebasing (moving) a whole tree (not just one branch)
Date: Fri, 18 Mar 2011 16:34:18 -0500
Message-ID: <20110318213417.GB23407@elie>
References: <4D83BB0A.8070307@dirk.my1.cc>
 <20110318202637.GA23255@elie>
 <7vaagsw2qb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 22:34:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0hJb-0000VR-HQ
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 22:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582Ab1CRVe2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 17:34:28 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44587 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472Ab1CRVeZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 17:34:25 -0400
Received: by gwaa18 with SMTP id a18so1755220gwa.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 14:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/UJf2KqckojKMPII3hS8BWA4cF2vRA6nL2/8jKH3/wE=;
        b=RWXfxyinqpRSlE/f8u8WJt5sPSzYJtAiGaEmnbrZZ+gsNCFlMae8sYsgAQUu7vIjks
         E13clxADw4a/bgldvd7YYMkwT0LNhZVRjJUtbn5EYcqhOSKRc6XHIBN0JFTDve/r4QKX
         UD8ZDhtdYqxmSfdCyEgVy4awrDrNqz/Pej9Do=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=C6QTnA6ooAKsytFhv9nvlG72UuvKCNU0aQvst3Rci8tqW3BrLNSugo0yvUTFITattl
         XLGgNI+jtlNnwQa554iUD24j9l7HPgbrNBKCSNjsE9I+IVqQrvvtiLDVFBf6ESlvzfl/
         l3PmEDhvROxCQOR3/bWpB2b/VP7XXwRKiFNYI=
Received: by 10.150.215.16 with SMTP id n16mr1683618ybg.224.1300484063695;
        Fri, 18 Mar 2011 14:34:23 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id t5sm248123ybe.29.2011.03.18.14.34.21
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 14:34:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vaagsw2qb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169365>

Junio C Hamano wrote:
>> Dirk S=C3=BCsserott wrote:

>>> I'd like to rebase a whole tree from A to B. Not just a single
>>> branch, but a whole tree. Let's say I have the following history:
>>>
>>> --- A --- B
>>>     |
>>>     + -- C -- D
>>>          |
>>>          + E -- F
>>>=20
>>> I'd like to rebase C and its descendants from A to B
[...]
> I am not a huge fan of filter-branch, but shouldn't you be able to
> filter-branch D and F (and no other branch) on top of B?

Yes, something like

	git filter-branch \
		--commit-filter '
			if test "$GIT_COMMIT" =3D '"$(git rev-parse A^{commit})"'
			then
				git rev-parse B^{commit}
			else
				git_commit_non_empty_tree "$@"
			fi
		' \
		--index-filter '
			if test -n "$(git rev-list -1 "$GIT_COMMIT"..A)"
			then
				# descends from A
				git merge-recursive A -- "$GIT_COMMIT" B
			fi
		' -- --all --not A^

might do it, assuming the diff from A to B is simple enough for a
fully automatic rebase.

But in practice, something may well be much better.  It depends why we
are performing this mass-rebasing --- do A and B have the same content
in the moment and different histories?  How did the topics we are
rebasing get tangled, and is their history going to remain meaningful
after this operation?

Jonathan
