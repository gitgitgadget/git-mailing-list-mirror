X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Non-ASCII paths and git-cvsserver
Date: Mon, 13 Nov 2006 11:48:10 -0800
Message-ID: <7vzmav6scl.fsf@assigned-by-dhcp.cox.net>
References: <45530CEE.6030008@b-i-t.de> <45587A09.3020605@b-i-t.de>
	<ej9utk$44p$1@sea.gmane.org>
	<200611131930.18300.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 13 Nov 2006 19:48:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611131930.18300.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Mon, 13 Nov 2006 19:30:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31314>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjhmy-0008Iu-PA for gcvg-git@gmane.org; Mon, 13 Nov
 2006 20:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755239AbWKMTsO convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006 14:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755243AbWKMTsO
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 14:48:14 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:14487 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1755239AbWKMTsN
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006
 14:48:13 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061113194811.SEWC5575.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Mon, 13
 Nov 2006 14:48:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id mKnl1V00a1kojtg0000000; Mon, 13 Nov 2006
 14:47:45 -0500
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> m=E5ndag 13 november 2006 15:20 skrev Jakub Narebski:
>> sf wrote:
>> > Thanks, Junio. Paths with umlauts are returned correctly now both =
in
>> > UTF-8 and ISO-8859-1. I guess git-cvsserver is now as encoding agn=
ostic
>> > as git core.
>>
>> By the way, now that git has per user config file, ~/.gitconfig, per=
haps
>> it is time to add i18n.filesystemEncoding configuration variable, to
>> automatically convert between filesystem encoding (somthing you usua=
lly
>> don't have any control over) and UTF-8 encoding of paths in tree obj=
ects.
>
> I'd prefer git to store filenames and comments in UTF-8 and convert o=
n=20
> input/output when and if it is necessary rather than forcing everybod=
y to=20
> take the hit. Most systems, but far from all, already use UTF-8 so it=
's a=20
> noop for them. The only reason I want conversion is for the years to =
come=20
> where we still live in two worlds of non-utf-8 and utf-8 and then for=
get=20
> about everything non-utf-8, rather than carry around the baggage fore=
ver.

Pathnames in git core are encoding agnostic just like UNIX
pathnames are.  As you say, if the project convention is UTF-8
then it would not make any difference either way, so the status
quo is fine for people living in UTF-8 only world.

To people for whom it is inconvenient to work with UTF-8,
including me, it is always wrong to record UTF-8 at the core
level and try to autoconvert.  If (non-git) tools, libraries and
legacy-to-unicode roundtrip conversion were perfect, we would
have already converted and living in UTF-8 only world.  Projects
that choose to run with legacy pathname encoding should be
allowed to do so without taking the roundtrip risk converting to
and from UTF-8.

Interestingly enough, Linus mentioned this once, a lot better
than myself would have, here:

http://thread.gmane.org/gmane.comp.version-control.git/12240/focus=3D12=
279

Having said that, I am not opposed to have an option to make the
external interface to do the pathname conversion.  If your
project chooses to use euc-jp for commit messages, your
configuration variable i18n.commitencoding is set to euc-jp, and
if gitweb always wants to do its thing in utf-8 (which is
probably a sensible thing to do), it would make a lot of sense
to take the commit message and convert it from euc-jp to utf-8
before rendering it in HTML.  Maybe i18n.pathnameencoding could
be used for similar purposes for external interfaces.

But the core will stay encoding agnostic; pathnames stored in
the index and tree are what you can feed stat() and open(), and
what you read from readdir().  Maybe we could revisit this
decision in five years, but not now.

