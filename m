From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Proposed git mv behavioral change
Date: Sat, 20 Oct 2007 13:02:32 +0200
Message-ID: <B6FFD723-83FF-459B-AD00-89DD2A3113DB@wincent.com>
References: <1192859753.13347.147.camel@g4mdd.entnet>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@MIT.EDU>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Ari Entlich <lmage11@twcny.rr.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 13:11:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IjCEO-0008S6-VZ
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 13:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299AbXJTLD0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Oct 2007 07:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756321AbXJTLDZ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 07:03:25 -0400
Received: from wincent.com ([72.3.236.74]:32971 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756247AbXJTLDZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Oct 2007 07:03:25 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9KB3GZl014607;
	Sat, 20 Oct 2007 06:03:17 -0500
In-Reply-To: <1192859753.13347.147.camel@g4mdd.entnet>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61817>

El 20/10/2007, a las 7:55, Ari Entlich escribi=F3:

>> I'm thinking of occasions where you just want to do something
>> like:
>>
>> git mv --cached foo bar
>> git add --interactive bar
>
> I think it would be the other way around, since the only time this
> change would effect anything is when there are changes still =20
> waiting to
> be staged.

Well, my point was that sometimes you want to rename a dirty file =20
*right now* without having your modifications staged in the index =20
yet, and only later go ahead and stage the hunks (or the whole file) =20
when they're ready.

Basically, without this feature you have to manually unstage the =20
stuff that you don't want staged:

[hack on dirty foo]
git mv foo bar
[oops... you just staged unfinished changes]
git reset HEAD bar
[hack until bar is ready]
git add bar

So in order to unstage the stuff that wasn't ready you unstaged the =20
whole file and had to re-add it later, in which case what was the =20
point of using "git-mv" in the first place? You may as well have just =20
done:

[hack on dirty foo]
mv foo bar
[hack until bar is ready]
git rm foo
git add bar

The other alternative is to use git-stash:

[hack on dirty foo]
git stash
git mv foo bar
git stash apply
[hack until bar is ready]
git add bar

So, yes, you can do this with git-stash. It just means that "git-mv --=20
cached" would be a convenient short-cut.

> Are you talking about REALLY only changing the index?

No, sorry, I didn't make that clear. I meant that "git mv --cached =20
foo bar" would have the following effect (which if I understand it =20
correctly is basically what you proposed in your first email):

1. Copying "foo" directly to "bar" (even if dirty).

2. When adding "bar" to the the index add the blob corresponding to =20
"foo" as it is staged in the index (or at the HEAD if there are no =20
staged changes).

3. Removing the old file "foo".

The actual mechanics of this don't matter; those are just the =20
perceived effects. You could get exactly the same perceived effects =20
by doing it this way:

1. Creating a new file (or overwriting an existing one) named "bar", =20
whose contents would match those of the file "foo" not as it appears =20
in the working tree but as it is staged in the index.

2. If "foo" has unstaged changes, they should be applied to "bar" as =20
well (but not staged).

3. Removing the old file "foo".

> In addition, I don't think giving
> --interactive a filename is meaningful...

Whoops. I think I just inadvertently proposed a feature... my most =20
common use of "git-add --interactive" is when I want to stage only =20
specific hunks of a particular file, and so instead of typing "git =20
add bar" I want to type "git add -i bar" and have it jump straight to =20
the "patch" subcommand (5) for that file. Would anyone else find this =20
useful?

Cheers,
Wincent
