From: Sam Vilain <sam@vilain.net>
Subject: Re: From P4 to Git
Date: Tue, 04 Aug 2009 08:32:20 +1200
Message-ID: <1249331540.12801.10.camel@maia.lan>
References: <85ljm84lat.fsf@oqube.com>
	 <m3fxcg3473.fsf@localhost.localdomain> <85r5vxbd8e.fsf@oqube.com>
	 <200907311122.43918.jnareb@gmail.com>
	 <81b0412b0907310414x7157fecey947da960ff8be1cc@mail.gmail.com>
	 <4A76967B.7080502@vilain.net>
	 <81b0412b0908030147i34a7440dg982c7a6e7dc51bca@mail.gmail.com>
	 <1249299010.7164.8.camel@maia.lan>
	 <81b0412b0908030650oc39f4a3s7c059e300b65addb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Arnaud Bailly <abailly@oqube.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 22:31:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY4Bz-0002oq-Dd
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 22:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607AbZHCUbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 16:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbZHCUbU
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 16:31:20 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:38939 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752074AbZHCUbT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 16:31:19 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 1897221C5DC; Tue,  4 Aug 2009 08:30:46 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 8EBC621C381;
	Tue,  4 Aug 2009 08:30:30 +1200 (NZST)
In-Reply-To: <81b0412b0908030650oc39f4a3s7c059e300b65addb@mail.gmail.com>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124720>

On Mon, 2009-08-03 at 15:50 +0200, Alex Riesen wrote:
> On Mon, Aug 3, 2009 at 13:30, Sam Vilain<sam@vilain.net> wrote:
> > On Mon, 2009-08-03 at 10:47 +0200, Alex Riesen wrote:
> >> Is it an import-once tool, or can the process be restarted? (because it looks
> >> like the script needs a complicated setup).
> >
> > It's fully restartable.  Not only that but it uses transaction
> > protection to make sure that its internal state doesn't get corrupted
> > when performing the various options.
> 
> "varios options"? Operations? As when working on a live server?
> Aren't P4 changelist numbers always increasing? Or you mean
> the protection against multiple running instances of p4raw,
> so it is also parallelizable?

The "live" parts are never touched - only the write-only files that
perforce writes; and the rcs files are read using rcs.

What I was referring to by "various options" was the commands in the
program which perform the migration.  It's a multi-step process - load
the metadata from perforce 'load', import the file images to git blobs
'export-blobs', trace through the path structure and decide which parts
are the roots, and make parents 'find-branches', etc.  All parts are
fully transaction protected, restartable and rewindable.  It also means
that if a command crashes that you are left in a sane state.  I had to
build it like that to keep my sanity writing and using it :-).  After
all it was something of a reverse engineering of Perforce's internals.

All you need is the RCS backing files, a 'checkpoint' and (optionally)
'journal' files.  No access to the live perforce DBs is required.

> > No, it's server only. ...
> Darn. I hoped it wasn't. Can't play with it, then.

Yeah, in theory you could derive the internal table information by
issuing zillions of 'p4 integrated', 'p4 filelog' commands etc.  I've
written p4raw sub-commands which can produce the output of those
commands but not tried to go the other way; I wasn't interested.

> > ... I think I did get around to implementing not having
> > to go through all the stages for branches you didn't care to import.  It's
> > difficult though, the stage which correlates those thousands of 'integrate'
> > records is never going to be fast.
> Maybe if it is done locally, it can be improved? You seem to use the
> Postgre for lookups, right?

I'm sure that the queries could be improved, but Postgres is actually
quite good at crunching the numbers.  It's just a lot of data to crunch.

> That's were I hoped your project could help. I thought, if I pull in all the
> needed changelists (selected by path/CL), there may be a way to
> recreate a mergeable history out of this dump. At least, one involving less
> labor then I have to do now.

Yeah... well the design of my tool is that it needs to have the perforce
internal information.  But really you can probably consider the
converter orphaned, I have no current need to work on it; it served a
purpose, which was converting perl's perforce to perl.git, and that's
history now.

Sam
