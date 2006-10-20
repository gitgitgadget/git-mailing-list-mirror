From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 10:56:53 +0200
Message-ID: <845b6e870610200156w7a676ae5lfcb531fd30139757@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca>
	<BAYC1-PASMTP08A746E5FA6B87BC65BD37AE0E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 11:15:22 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaqTD-0007Vy-NL
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 11:15:15 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GaqT7-0002Xn-8j; Fri, 20 Oct 2006 10:15:09 +0100
Received: from py-out-1112.google.com ([64.233.166.180])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <zindar@gmail.com>) id 1GaqT0-0002XL-2Q
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 10:15:02 +0100
Received: by py-out-1112.google.com with SMTP id z59so135670pyg
	for <bazaar-ng@lists.canonical.com>;
	Fri, 20 Oct 2006 02:15:00 -0700 (PDT)
Received: by 10.35.102.18 with SMTP id e18mr221337pym;
	Fri, 20 Oct 2006 01:56:53 -0700 (PDT)
Received: by 10.35.116.4 with HTTP; Fri, 20 Oct 2006 01:56:53 -0700 (PDT)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP08A746E5FA6B87BC65BD37AE0E0@CEZ.ICE>
Content-Disposition: inline
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29429>

> > - - you can use a checkout to maintain a local mirror of a read-only
> >   branch (I do this with http://bazaar-vcs.com/bzr/bzr.dev).
>
> I'm not sure what you mean here.  A bzr checkout doesn't have any history
> does it?  So it's not a mirror of a branch, but just a checkout of the
> branch head?

In bzr there are two different kind of checkouts.  One is a called a
lightweight checkout and that's really a "normal" checkout in the way
svn for example does it.  In this mode, you have the branch remotely
and only the working tree locally.  So it's just a checkout of the
branch head (of any other revision if using -r when doing the
checkout).

Then there are none lightweight checkouts, heavyweight checkouts.
These are the default type.  A heavyweight checkout is in fact a full
branch locally, but it is "bound" to the remote branch.  What this
means is that all commands such as diff/status/log/etc can be done
locally. So it's really quick.

It acts the same as a lightweight checkout in most regards, so when I
run "bzr update" it actually pulls from the remove branch, and when I
run "bzr commit" it commits the same revision in both the remote
branch and the local branch. It does this in one transaction so one
can't work and the other fail (they would both fail in that case).

What this also gives you is that when you want to clone the branch,
you don't need to go the the remote branch to get the revisions and
also, when being offline, you can commit locally.

Committing locally is a very cool feature in my mind.  If you work in
a centralized manner with checkouts, you normally commit directly to
the central branch, but when you are offline, that will fail (of
course :) ).  So what you can do then is to run "bzr commit --local"
to commit only to your local checkout branch, then when you get online
again you can run "bzr update".  In this case the update will take any
new commits that has been done while you were away, pull them into
your local branch, and make your local commits into something that has
been merged into the "checkout".

I find this REALLY useful.

Don't know if that made sense, here it is in commands.

$ bzr checkout t p
$ cd p
$ echo hej >> hosts
$ bzr commit --local -m 'offline'
$ echo hej >> hosts
$ bzr commit --local -m 'offline 2'

Now I get back, someone has committed new stuff... I run bzr update
$ bzr update
All changes applied successfully.
Updated to revision 2.
Your local commits will now show as pending merges with 'bzr status',
and can be committed with 'bzr commit'.
$ bzr status
modified:
  hosts
pending merges:
  Erik B=E5gfors 2006-10-20 offline 2
    Erik B=E5gfors 2006-10-20 offline
$ bzr commit -m 'my offline stuff'
modified hosts
Committed revision 3.

$ bzr log -r-1
------------------------------------------------------------
revno: 3
committer: Erik B=E5gfors <erik@bagfors.nu>
branch nick: p
timestamp: Fri 2006-10-20 10:51:08 +0200
message:
  my offline stuff
    ------------------------------------------------------------
    merged: erik@bagfors.nu-20061020084949-8bc43db8f5cd449b
    committer: Erik B=E5gfors <erik@bagfors.nu>
    branch nick: p
    timestamp: Fri 2006-10-20 10:49:49 +0200
    message:
      offline 2
    ------------------------------------------------------------
    merged: erik@bagfors.nu-20061020084945-13e5093f98c0c380
    committer: Erik B=E5gfors <erik@bagfors.nu>
    branch nick: p
    timestamp: Fri 2006-10-20 10:49:45 +0200
    message:
      offline

I think that bzr really allows you to work well in a centralized
environment as well as a distrubuted, which is one of the things I
like best about bzr.

Regards,
Erik
--=20
google talk/jabber. zindar@gmail.com
SIP-phones: sip:erik_bagfors@gizmoproject.com
sip:17476714687@proxy01.sipphone.com
