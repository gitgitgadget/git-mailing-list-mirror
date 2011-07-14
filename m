From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: How to force git to use authentication as author
Date: Thu, 14 Jul 2011 13:53:23 +0200
Message-ID: <CABPQNSY3qyQXO4hyM6xhHq2VYhK5369ihuqJ5PDAonN7+UpcGA@mail.gmail.com>
References: <20110714160638.065b6542@shiva.selfip.org> <CACBZZX4X8qRBXqwi70kZ0eZ+mb7rdD6p36xD=GoX6soha0TZcg@mail.gmail.com>
 <20110714161838.1e30893a@shiva.selfip.org> <1310641202.18730.16.camel@bee.lab.cmartin.tk>
 <20110714164547.0b359e60@shiva.selfip.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Thu Jul 14 13:54:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhKUd-00068A-Sv
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 13:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551Ab1GNLyG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jul 2011 07:54:06 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43788 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab1GNLyE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2011 07:54:04 -0400
Received: by ewy4 with SMTP id 4so89481ewy.19
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 04:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=m/EncogxoITgeagsiVjoWTtyz/SS8msi7tNbiDZPO5Q=;
        b=vVLCICYOPQhdm6GhucANM7e0oANDUz1GB4eWCwW0R4CvkS9X29NyLXdYPxA7xMOD6q
         Eps91FCAr82kPhvJZ3lTA4DU8ZZM+veT4+B7VWsghu00kEvcvCZMNpODXALC1Cru/GYr
         99kPkZhX18QhmWGT2nqEUJ0m3FKEAdq0jHFSk=
Received: by 10.204.6.210 with SMTP id a18mr825007bka.180.1310644443160; Thu,
 14 Jul 2011 04:54:03 -0700 (PDT)
Received: by 10.204.58.195 with HTTP; Thu, 14 Jul 2011 04:53:23 -0700 (PDT)
In-Reply-To: <20110714164547.0b359e60@shiva.selfip.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177120>

On Thu, Jul 14, 2011 at 1:15 PM, J. Bakshi <joydeep@infoservices.in> wr=
ote:
> On Thu, 14 Jul 2011 13:00:02 +0200 Carlos Mart=EDn Nieto <cmn@elego.d=
e> wrote:
>> You are misunderstanding either how git works or the nomenclature. T=
he
>> commits all happen locally and need no authentication whatsoever (an=
d
>> usually you're expected to use a real name and email address). When =
you
>> need to authenticate is when yuou push your changes somewhere (a cen=
tral
>> repo, for example). This is where the ~/.netrc file comes into play,=
 as
>> I mentioned in the reply to your other mail.
>>
> Exactly, when we need to push we are asked about authentication.

In Git (as you probably know), authentication is not the same as
authorship. Because of the distributed nature of Git, a certain change
can reach the repo without going through a central repo (e.g by
mailing, pushing to a third-party repo etc).

So to be friendly to different work-flows while retaining authorship,
authorship (both of the change itself and of the commit object) needed
to be decoupled from authentication.

> I like to configure the central git server in a way so that the user-=
name as in authentication, be set as author name by the git server itse=
lf.

There's no way you can setup this from the server-side. Commits are
created without communication with the server, again due to the
distributed nature of Git.

The only thing you can do at the server-side (and it quickly gets
ugly), is to try to validate the pushed commits through a hook. You
could probably verify that the authorship is the same as the
authentication, but this breaks distributed work-flows. A slightly
better approach would be to verify the commiter (as opposed to the
patch-author), as this allows for e-mailed patches to retain the
original authorship. But it still breaks work-flows that use bundles
or pushing between different repos (and probably more), so it's not
exactly elegant.

So let's step back a little bit. Why do you want the author to be
identical to the authenticated user in the first place? Is it to be
able to *prove* (i.e not trust the users that push) who wrote what
code? If so, let's me first tell you that giving someone push-access
while not trusting them is a bit crazy. But if you're happy with being
a bit crazy, you'd might want to somehow cryptographically sign the
commits instead. I'd go for PGP-signing the patch-id, and putting that
in a git-note.

> actually it is how I configured svn server over http. So comparing to=
 that I am trying to achieve the same. Say your user-name is there at h=
tpasswd file as Carlos, so when you authenticate by Carlos to push , th=
e author-name will automatically become as Carlos. No way to customize =
that with specific username. That's the idea.

Being the same as in SVN is not a good thing in itself. I've
personally had lots of pain when moving SVN servers, because users are
a server-local thing (so the repository needs to be rewritten or
whatnot). And I'm not even an SVN "power-user". The beauty about
having the name + e-mail pair in Git is that the commits do not change
no matter what. The history stays the same, you just change the
authentication.
