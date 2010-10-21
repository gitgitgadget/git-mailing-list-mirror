From: Shawn Pearce <spearce@spearce.org>
Subject: Re: GIT as binary repository
Date: Thu, 21 Oct 2010 10:38:50 -0700
Message-ID: <AANLkTiniQNTBnqQz-p5E3rjoHq9FnpMkzO=B0yh+Sbxq@mail.gmail.com>
References: <2EBB46ACFCD6CF48B45E2B1865BD02338037D36B4E@GVW1098EXB.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Wilson, Kevin Lee (OpenView Engineer)" <kevin.l.wilson@hp.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 19:39:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8z6o-0000ON-De
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 19:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529Ab0JURjM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 13:39:12 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60485 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab0JURjL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 13:39:11 -0400
Received: by ywa8 with SMTP id 8so87049ywa.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 10:39:10 -0700 (PDT)
Received: by 10.42.169.129 with SMTP id b1mr1068320icz.99.1287682750605; Thu,
 21 Oct 2010 10:39:10 -0700 (PDT)
Received: by 10.231.140.97 with HTTP; Thu, 21 Oct 2010 10:38:50 -0700 (PDT)
In-Reply-To: <2EBB46ACFCD6CF48B45E2B1865BD02338037D36B4E@GVW1098EXB.americas.hpqcorp.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159527>

On Thu, Oct 21, 2010 at 5:52 AM, Wilson, Kevin Lee (OpenView Engineer)
<kevin.l.wilson@hp.com> wrote:
> We are investigating the use of GIT as a binary repository solution. =
Our larger files are near 800MB and the total checked out repo size is =
about 3 GB the repo size in SVN is more like 20-30GB, if we could prune=
 the history prior to MR, we could get these sizes down considerably. T=
his binary repo is really for our super project build. =A0From what I h=
ave read and learned, this is not a good fit for the GIT tool. Have the=
re been performance improvements lately? Some of the posts I have read =
have been quite old?

Not really.

Teams who need to store content like this are taking two approaches:

Bite the bullet and use 64 bit systems with a lot of physical memory.
Git allocates/memmaps two memory blocks equal in size to the file you
are trying to work with.  If you have an 800MB file, you need ~1.6G of
physical memory just for the Git executable to touch that file.  For
most modern desktops and server systems, this is pretty easy to deal
with, 4G or 8G of physical memory in a developer workstation is pretty
inexpensive.  If the files aren't delta compressible, you can speed up
delta compressing operations that occur during `git gc` by adding a
gitattribute with the "-delta" flag for the relevant path files to
your .git/info/attributes file.  Unfortunately this may mean that your
Git repository is large (>20G?), and each developer needs to make a
full copy of it when they start to work on the project.  That is a lot
of data to move around, or to store locally.  But again when you look
at the cost of disk on a developer workstation, this may not be an
issue if your team can adopt a workflow where they don't clone the
repository often.  (E.g. the Android repository is about 7G,
developers clone it once and then don't need to again... so it is
doable.)

The other option is to use a different repository for the binary
files.  Some teams are using a REST enabled HTTP server like Amazon S3
(though you probably want something inside your corporate firewall) to
store the large binary files.  Instead of putting the files into Git
the put a small shell script and a pointer to the file into Git.  The
shell script downloads the large binary file when executed, and the
build process (or the developer "start-up" instructions) execute the
script to get the latest versions bootstrapped on the local
workstation.


> I also have some questions, about how the workflow would be for getti=
ng all of the changes merged from several different teams into the one =
repository would operate. Do we setup a shared system for engineers to =
perform the merges onto? Our teams are geographically disbursed.

Yes, this is the common approach.  Actually what I have started to see
with Android is, each distributed office has a shared repository that
the engineers in that office interact with on a daily basis.  And
someone in each office synchronizes that repository with a single
central repository that exists somewhere else.  Because of the nature
of Git, the central repository can be continuously pulled into the
distributed office through a cron script.  Engineers in the office can
therefore always have a "fairly latest" version available, but can
also fork off onto a side-branch and defer merging with the other
offices for a day or two.

Android teams are successfully using this approach by running Gerrit
Code Review[1] as their central server, and using Gerrit's built-in
replication feature to push updates to the distributed office servers.
 In effect there is one central server for writes, but a lot of read
operations are offloaded into the distributed offices local copies.

[1] http://code.google.com/p/gerrit/

--=20
Shawn.
