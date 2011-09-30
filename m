From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's keychain
Date: Fri, 30 Sep 2011 15:16:58 -0400
Message-ID: <CAG+J_DwntGc+j3duCVqsnoJGV18FqnwXJ99C1XqKope_zbGHAA@mail.gmail.com>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
	<20110929075627.GB14022@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 30 21:17:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9ia2-0007LY-DO
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 21:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757125Ab1I3TRA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 15:17:00 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40794 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756689Ab1I3TQ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2011 15:16:59 -0400
Received: by yxl31 with SMTP id 31so1838942yxl.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 12:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=c7BtNF7+p7YzP+y6koStuA90C1Xx4Pvfj+I2DffxrMo=;
        b=LQmCaNxXE1ZnpzpoEU1gRdGT3SnfjebrpVYr3UzMxfVVt0vdZvwU3Ed4dS14f0HztZ
         KgDyZAmZqHx3L7DxEFqqf4WMQd/P4UsO5VgjE+qd1e1C/Rdb0KCRCgfMA3NLl/OARX80
         OLrQgHonf/0/yo4exMDYwlwspzHaCeJltIVyk=
Received: by 10.236.155.1 with SMTP id i1mr56875477yhk.8.1317410218504; Fri,
 30 Sep 2011 12:16:58 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Fri, 30 Sep 2011 12:16:58 -0700 (PDT)
In-Reply-To: <20110929075627.GB14022@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182504>

On Thu, Sep 29, 2011 at 3:56 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 14, 2011 at 10:51:53PM -0400, Jay Soffian wrote:
>
>> This credential helper adds, searches, and removes entries from
>> the Mac OS X keychain. The C version links against the Security
>> framework and is probably the best choice for daily use.
>>
>> A python version is also included primarily as a more readable
>> example and uses the /usr/bin/security CLI to access the keychain.
>>
>> Tested with 10.6.8.
>
> So I finally got a nice working OS X setup (10.7) to play around with
> these. Overall, works as advertised. :) I have a few comments, though=
=2E
>
>> Here's a C version that no longer links to git. I also kept the orig=
inal
>> Python version as an example. I decided not to call out to
>> 'git credential-gitpass' as it was simple enough to manage /dev/tty
>> and there's no portability issues since this is OS X specific.
>
> This was my first one. I kind of expected there to be some kind of
> graphical password dialog. Especially because keychain will pop up a
> dialog and ask you "is it OK for git to access this password?". So I
> sort of assumed that people would assume that credentials happened
> outside of the regular terminal session (I see the same thing on Linu=
x,
> for example, with gpg-agent, which will open a new window and grab
> focus).
>
> But I have no idea what's "normal" on OS X.

This makes no sense to me at all. Ignore OS X for the moment. You use
git on the command-line. Why would there be any expectation of it
interacting with the user via anything other than the terminal.

Anyway, I expect the username/password prompt on the command-line, in
the same terminal window where I just ran the git command that needs
credentials.

> I wondered if you were trying to be friendly to people who were
> connecting via ssh. But that doesn't seem to work at all. I couldn't =
get
> either version of your helper to actually do anything in an ssh sessi=
on
> (even with the same user logged in on console). =C2=A0I guess there i=
s some
> magic to hook it into the keychain manager.

I don't understand where you're running ssh from/to in this scenario,
but OS X has a notion of security contexts (this is a bit of a
tangent):

http://developer.apple.com/library/mac/#technotes/tn2083/_index.html

> Also, regarding opening /dev/tty yourself versus using getpass. There
> are a few magic things getpass will do that your helper won't:
>
> =C2=A01. It respects core.askpass, GIT_ASKPASS, and SSH_ASKPASS if th=
ey are
> =C2=A0 =C2=A0 set.
>
> =C2=A02. The "get the username from the config" feature is triggered =
at the
> =C2=A0 =C2=A0 time of prompting the user (so instead of asking for th=
e username,
> =C2=A0 =C2=A0 we check the config and pretend the user told us).
>
> =C2=A0 =C2=A0 I did it this way originally so that helpers would have=
 the first
> =C2=A0 =C2=A0 crack at setting a username, and we would fall back to =
the config.
> =C2=A0 =C2=A0 Thinking on it more, that may be backwards. If the user=
 has told
> =C2=A0 =C2=A0 git "for github.com, I am user 'foo'", then that should=
 probably
> =C2=A0 =C2=A0 take effect first, and --username=3Dfoo get passed to t=
he helper.
>
> =C2=A0 =C2=A0 It doesn't make a big difference with long-term storage=
 helpers,
> =C2=A0 =C2=A0 because you tell them your username once and they remem=
ber it. But
> =C2=A0 =C2=A0 for things like credential-cache, it lets you store the=
 username
> =C2=A0 =C2=A0 for a long time, but only cache the password (which mea=
ns not
> =C2=A0 =C2=A0 typing the username every time).
>
> So I think maybe reason (2) should go away. But (1) is definitely wor=
th
> considering.

I found it ugly that git's native getpass doesn't echo the username
back, and it seems hackish to me for the credential helper to turn
back around and invoke it in any case. :-(

>> + =C2=A0 =C2=A0 =C2=A0 if (!unique)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Must specify=
 --unique=3DTOKEN; try --help");
>
> My test harness checks that this case just asks for the password with=
out
> bothering to do any lookup or storage. It probably doesn't really mat=
ter
> in practice; I think git should always be providing _some_ context.

Okay, that wasn't clear from whatever documentation I read on how
credential helpers should behave. But why invoke the credential helper
just to ask for a password?

>> + =C2=A0 =C2=A0 hostname =3D strchr(unique, ':');
>> + =C2=A0 =C2=A0 if (!hostname)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Invalid token `%s'"=
, unique);
>> + =C2=A0 =C2=A0 *hostname++ =3D '\0';
>
> Hrm. I was really hoping people wouldn't need to pick apart the "uniq=
ue"
> token, and it could remain an opaque blob. If helpers are going to do
> this sort of parsing, then I'd just as soon have git break it down fo=
r
> them, and do something like:
>
> =C2=A0git credential-osxkeychain \
> =C2=A0 =C2=A0--protocol=3Dhttps \
> =C2=A0 =C2=A0--host=3Dgithub.com \
> =C2=A0 =C2=A0--path=3Dpeff/git.git
> =C2=A0 =C2=A0--username=3Dpeff
>
> to just hand over as much information as possible, and let the helper
> throw it all together if it wants to.

Keychain entries have distinct fields. I broke apart the token and
stored it the way other applications mostly do on OS X.

>> + =C2=A0 =C2=A0 /* "GitHub for Mac" compatibility */
>> + =C2=A0 =C2=A0 if (!strcmp(hostname, "github.com"))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hostname =3D "github.com=
/mac";
>
> Nice touch. :)
>
>> + =C2=A0 =C2=A0 if (!strcmp(unique, "https")) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 protocol =3D kSecProtoco=
lTypeHTTPS;
>> + =C2=A0 =C2=A0 } else if (!strcmp(unique, "http")) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 protocol =3D kSecProtoco=
lTypeHTTP;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Unrecognized protoc=
ol `%s'", unique);
>
> My series will also produce "cert:/path/to/certificate" when unlockin=
g a
> certificate. The other candidates for conversion are smtp-auth (for
> send-email) and imap (for imap-send). =C2=A0I guess for certs, you'd =
want to
> use the "generic" keychain type.

Yep, I was punting on certificate for v1.

> I wonder if some people would not want to cache cert passwords. Speak=
ing
> of which, I remember keychain asking me "do you want to let git see t=
his
> password?", but I don't ever remember it asking "do you want to save
> this password?". Is that usually automatic? Again, I was kind of
> expecting a dialog with a "remember this" checkbox.

Each keychain entry has an ACL of applications that are allowed to
access it. When an application asks for an entry and the application
isn't on that entry's ACL, OS X (not the application) presents the
user the dialog you refer to. The application has no control over that
dialog.

Now, I could have the credential helper ask the user "store this
password?" after prompting for it, but why even use a credential
helper if you don't want it to store your credentials?

>> +def add_internet_password(protocol, hostname, username, password):
>> + =C2=A0 =C2=A0# We do this over a pipe so that we can provide the p=
assword more
>> + =C2=A0 =C2=A0# securely than as an argument which would show up in=
 ps output.
>> + =C2=A0 =C2=A0# Unfortunately this is possibly less robust since th=
e security man
>> + =C2=A0 =C2=A0# page does not document how to quote arguments. Empr=
ically it seems
>> + =C2=A0 =C2=A0# that using the double-quote, escaping \ and " works=
 properly.
>> + =C2=A0 =C2=A0username =3D username.replace('\\', '\\\\').replace('=
"', '\\"')
>> + =C2=A0 =C2=A0password =3D password.replace('\\', '\\\\').replace('=
"', '\\"')
>> + =C2=A0 =C2=A0command =3D ' '.join([
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0'add-internet-password', '-U',
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0'-r', protocol,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0'-s', hostname,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0'-a "%s"' % username,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0'-w "%s"' % password,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0'-j default',
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0'-l "%s (%s)"' % (hostname, username),
>> + =C2=A0 =C2=A0]) + '\n'
>> + =C2=A0 =C2=A0args =3D ['/usr/bin/security', '-i']
>> + =C2=A0 =C2=A0p =3D Popen(args, stdin=3DPIPE, stdout=3DPIPE, stderr=
=3DPIPE)
>> + =C2=A0 =C2=A0p.communicate(command)
>
> I noticed that when using the python helper, the dialog asking someth=
ing
> like: "security wants to know this password. Allow it?"
>
> Which was kind of lame. I would hope we could convince it to say "git=
".
> But I didn't see any option in the "security" tool for specifying the
> context[1]. The C helper says "git-credential-osxkeychain". Which isn=
't
> the end of the world, but it would be prettier if it just said "git".

That's partly why I wrote the C version.

> [1] I can kind of see why they might not want you to set this for
> security reasons (because it makes impersonating other programs easy)=
=2E
> On the other hand, saying "security" conveys absolutely nothing. And =
as
> far as I can tell, I could just call my program /tmp/iTunes, and it
> would say "iTunes wants to know this password...".

It is for security reasons. 99% of users will probably just click
"Okay" no matter what. For the 1% that bother to pay attention to the
dialog, it provides the full path to the binary. I'd be suspicious if
/tmp/iTunes wanted a password.

j.
