From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] archive: fix archive generation for empty trees
Date: Fri, 09 Mar 2012 08:30:14 +0100
Message-ID: <4F59B186.5080600@lsrfire.ath.cx>
References: <1331165362-78065-1-git-send-email-brodie@sf.io> <20120308055520.GB7643@sigill.intra.peff.net> <7vpqcnfvhs.fsf@alter.siamese.dyndns.org> <20120308071559.GF7643@sigill.intra.peff.net> <CAJjwD-2=pEfk2WQ2=cKy8eUSwbx8y86jEo_kyiQWsxVTqVFQEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Brodie Rao <brodie@sf.io>
X-From: git-owner@vger.kernel.org Fri Mar 09 08:30:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5uHY-0002LO-5u
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 08:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678Ab2CIHa1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 02:30:27 -0500
Received: from india601.server4you.de ([85.25.151.105]:39264 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526Ab2CIHa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 02:30:26 -0500
Received: from [192.168.2.105] (p4FFD8D1E.dip.t-dialin.net [79.253.141.30])
	by india601.server4you.de (Postfix) with ESMTPSA id AB5412F8047;
	Fri,  9 Mar 2012 08:30:24 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <CAJjwD-2=pEfk2WQ2=cKy8eUSwbx8y86jEo_kyiQWsxVTqVFQEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192687>

Am 09.03.2012 01:06, schrieb Brodie Rao:
> 2012/3/7 Jeff King<peff@peff.net>:
>> On Wed, Mar 07, 2012 at 10:38:07PM -0800, Junio C Hamano wrote:
>>
>>>> ... However, prefix_pathspec does a lot of magic parsing;
>>>> it's unclear to me whether this is all in support of properly
>>>> adding the prefix, or if its side effects are important.
>>>
>>> These "magic" are for things like :(root)/path that will explicitly
>>> refuse the prefix when run from a subdirectory.
>>
>> Yeah, that was my impression. In that case, I would think we could g=
et
>> rid of the get_pathspec call entirely, as it is purely about fixing-=
up
>> prefixes, and we know that we have none.
>
> Let me see if I've got this right: We're currently passing in ""/NULL
> to get_pathspec() because we handle the prefix beforehand in
> parse_treeish_args(). Once we get the tree object, every path is
> relative to it, so we don't need to continue using a prefix.
>
> Wouldn't it be better to continue using get_pathspec(), passing it th=
e
> real prefix, and looking up tree entries relative to the top-level
> tree? The way it works now, you get weird behavior like this:
>
>    $ cd xdiff
>    $ git archive -v --format=3Dtar HEAD ../t/t5000-tar-tree.sh>  /dev=
/null
>    fatal: '../t/t5000-tar-tree.sh' is outside repository
>    $ git archive -v --format=3Dtar HEAD ..>  /dev/null
>    fatal: '..' is outside repository

With get_pathspec() gone you'd get this instead:

	fatal: path not found: ..

The message could be improved by mentioning the subdirectory and perhap=
s=20
the tree, something like this:

	fatal: path not found in subdir 'xdiff' of 'HEAD': ..

However, you seem to expect such an invocation to succeed.  What should=
=20
go into the created archive in that case and which pathes would be reco=
rded?

Ren=C3=A9
