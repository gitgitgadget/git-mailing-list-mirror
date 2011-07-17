From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Google Code supports Git
Date: Sat, 16 Jul 2011 19:26:11 -0700
Message-ID: <CAJo=hJtqjgvEJzSqhJBUufatCpeLgpMVN0Eqps2W8WNMaQR7Vw@mail.gmail.com>
References: <CACsJy8BMK4UqVVNnhs6riVSS-OKcFKT9=XScrAw5nK2FH_u92A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 04:34:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiHBv-00007N-HY
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 04:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432Ab1GQC0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 22:26:33 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:33430 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277Ab1GQC0c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 22:26:32 -0400
Received: by fxd18 with SMTP id 18so4645625fxd.11
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 19:26:31 -0700 (PDT)
Received: by 10.204.12.68 with SMTP id w4mr1666133bkw.160.1310869591167; Sat,
 16 Jul 2011 19:26:31 -0700 (PDT)
Received: by 10.204.100.7 with HTTP; Sat, 16 Jul 2011 19:26:11 -0700 (PDT)
In-Reply-To: <CACsJy8BMK4UqVVNnhs6riVSS-OKcFKT9=XScrAw5nK2FH_u92A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177290>

On Sat, Jul 16, 2011 at 03:24, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Just out of curiousity and because I happen to know we have Googlers
> here. If it's not confidential, are there any changes in git to make
> it work with Google Code? I am particularly interested in whether
> Google modifies git to use bigtable

A major milestone in Git was adding smart HTTP. If you watch the talk
Sverre linked to, you will learn that Google is based heavily on HTTP.
A fundamental issue at the time Hg on Google Code was added was Git
didn't really work well over HTTP. Adding smart HTTP in Git 1.6.6 made
it more realistic for Google to support Git on Project Hosting. I
added smart HTTP support for kernel.org so their users behind
firewalls could still use an efficient Git protocol to fetch revisions
from kernel.org for projects that are hosted there. Its a nice bonus
that this work made Git on Google Code more realistic for Google.

We are trying to get the engineer responsible for making Git on Google
Code possible to give a recorded tech talk like the one Sverre linked
to. I don't want to steal his thunder, but I can say the Git on Google
Code work is not based on C Git or JGit.  :-)

> (or cassandra, I remember Shawn
> had a prototype).

This was an unrelated project, and is what I deem to be a failure...
quite unlike Git on Google Code. :-)

For some background, at GitTogether in Oct. 2010 I showed a demo of
JGit using the Apache Cassandra database as an object / reference
store. This prototype didn't really scale well; even though I demoed
the linux-2.6 repository being cloned through a JGit daemon using
Cassandra as the backing store, it was slow and used too much CPU and
memory resources to be useful in any context beyond a "Look, I can do
this!" demo. I managed to open source this work, it may still be
laying around somewhere, but I basically threw it out the window and
said "that isn't good, and I can't believe I put my name on it!". (And
for the record I was not the first to try this, Scott Chacon at GitHub
tried something similar first and demoed it at GitTogether in 2009.)

In late Jan/Feb 2011 I released a series of patches for JGit that
added what I called "DHT" (distributed hash table) support. These
patches are now part of the JGit project. Its different from the
original Cassandra prototype. With this work, JGit tries to treat the
DHT as though it were a virtual memory system. Relatively standard
pack files are segmented into ~ 1 MiB chunks, then stored into the DHT
with row keys based on the SHA-1 hash of the content of the "pack
chunk". The bet here is that the locality of data in a pack file is
quite good, so loading a chunk of commits ~1 MiB in size should get us
a number of related commits, amortizing out the round-trip time to the
database. This was to resolve one of the latency problems I saw with
the Cassandra prototype, which stored 1 commit per row and had awful
performance during a major revision traversal like a clone has.

The JGit DHT work lead me to discover the pack locality is not as good
as we think it is. Its good, but it can be better. I added some
patches to JGit's PackWriter to reorder objects in an order that gave
better data locality. After Junio and I started sharing an office, I
began nagging him about this locality problem in Git pack files... and
that nagging lead to a series of patches Junio posted about a week
back to improve pack-objects.c. The improvement is small on local
disk, it reduces some minor page faults, however there isn't much
difference in overall running time. Over higher latency filesystems
however, like an NFS server in another city, it should help reading.

Just recently I posted a message to the jgit-dev mailing list saying I
also now think JGit DHT isn't a viable solution, and am likely to
discard it in the future. Its implementation is very complicated, and
it just doesn't perform as well as I had hoped. FWIW, this work was
not for Google, but was for open source Git hosting sites like
source.android.com, eclipse.org, KDE, etc. where they need to manage a
large number of Git repositories, and want to have hot-failover and
load-balancing to reduce down time caused by hardware failures.
Unfortunately it hasn't been panning out, because the performance loss
is a lot compared to the small administrative improvements it might
bring. Not to mention the additional complexity of running the
clustered database vs. just a bunch of Git repositories in a
directory.


I can tell you that none of this is what Git for Google Code does.

As for how Git on Google Code is implemented... you'll just have to
wait for the tech talk from the engineer responsible. I can say it
wasn't me, and it wasn't Junio. I am too busy with JGit and Gerrit
Code Review, and Junio is too busy being Git maintainer to work on a
major new feature like this.

:-)

-- 
Shawn.
