From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] find_unique_abbrev(): honor caller-supplied "len" better
Date: Thu, 10 Mar 2011 15:07:59 -0800
Message-ID: <AANLkTimH9=OWD4+dPsdYaL2VPdDkTsUG_N3GBf168XqD@mail.gmail.com>
References: <E1PBKT9-0004Uk-Sm@tytso-glaptop> <20101028075631.GA7690@elte.hu>
 <AANLkTi=8SbOZizWpxLg=Bgp7atdgr8MsR6tnRDYr1+eW@mail.gmail.com>
 <20101028163854.GA15450@elte.hu> <AANLkTin62vAwJxcsrFk6Yn7Q6tzr-D=EmKKwPazuAJ11@mail.gmail.com>
 <7veiba9ev2.fsf@alter.siamese.dyndns.org> <7vhbba38mm.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Namhyung Kim <namhyung@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 00:08:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxoy2-0005tD-0c
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 00:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434Ab1CJXIV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 18:08:21 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45759 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753146Ab1CJXIU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 18:08:20 -0500
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p2AN8Jh9015719
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 10 Mar 2011 15:08:19 -0800
Received: by iwn34 with SMTP id 34so2046992iwn.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 15:08:19 -0800 (PST)
Received: by 10.231.52.194 with SMTP id j2mr6593537ibg.12.1299798499042; Thu,
 10 Mar 2011 15:08:19 -0800 (PST)
Received: by 10.231.12.10 with HTTP; Thu, 10 Mar 2011 15:07:59 -0800 (PST)
In-Reply-To: <7vhbba38mm.fsf_-_@alter.siamese.dyndns.org>
X-Spam-Status: No, hits=-104.977 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168866>

On Thu, Mar 10, 2011 at 2:37 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> The code however forgot that the function may be called with a "len" =
that
> is long enough. =A0If an object is uniquely identifiable with only 4 =
leading
> characters today, and if the caller gives 7 as len and the guard is s=
et to
> 3, it returned 10 hexdigits, which was 3 characters longer than neces=
sary.
> We should instead return 7 leading characters in such a case, as that=
 is
> in line with the original intention of using 3 characters more than
> absolutely necessary to give the disambiguation we find today a bette=
r
> chance to survive.

The thing is, that just makes the notion of "abbrevguard" pointless.
Why have it?

When you pass in 6 as a len, and that isn't sufficient, it expands it
to (say) 10. And then you pass in 7 as a length, and now it's
sufficient, so it keeps it at 7.

That's just stupid. You gave it a bigger length suggestion, and you
got a smaller end result. That's crazy.

However, I think the _real_ problem is not whether that behavior is
really stupid or not. I think the real problem is that abbrevguard
really isn't a well-defined, and you get this kind of crazy semantics.

So I think the REAL problem is different:

 (a) DEFAULT_ABBREV is just too damn small. 7 made sense as a random
number back when we did this, but we're talking over 5 years ago. The
seven comes from commit 47dd0d595d04e. Back then, a million objects
was a really almost inconceivably big number.  Even the BK tree (that
I was going by as a target) was just 65k revisions for Linux, so with
most changes only touching a few files, "million" was "long time in
the future". Now we're close to 2 million.

It turns out 640kB isn't enough for everybody. For the kernel, we have
several objects that need 10 digits just for uniqeness right NOW.. 12
digits is a _somewhat_ reasonable safe value for the forseeable
future. But 11 would be too short. And I don't think the kernel is the
biggest repo.

 (b) You can't change DEFAULT_ABBREV except with the command line optio=
n.

 (c) Even there it's unnecessarily hard.  Want to see your commit
numbers abbreviated appropriately too? Oh, you have to use
"--abbrev=3D12 --abbrev-commit". We didn't think the interface through.

 (d) some places don't even take the command line option. Grep for
DEFAULT_ABBREV, and notice how often it's just used as-is.

So I would suggest ditching 'unique_abbrev_extra_length' entirely. I
doubt anybody uses it, and the whole concept is simply badly designed
with crazy semantics as per your patch.

                              Linus
