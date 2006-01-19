From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Thu, 19 Jan 2006 09:49:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601190938110.3240@g5.osdl.org>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com> 
 <cda58cb80601170932o6f955469y@mail.gmail.com>  <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net>
  <cda58cb80601190251v5251c8bdh@mail.gmail.com>  <20060119130940.GC28365@pasky.or.cz>
  <Pine.LNX.4.64.0601190842270.3240@g5.osdl.org> <cda58cb80601190933o4cedde92x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 18:50:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezdvq-0000Zo-17
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 18:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbWASRuh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 12:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWASRuh
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 12:50:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18849 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161046AbWASRug (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 12:50:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0JHnaDZ030206
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 Jan 2006 09:50:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0JHnZRF016276;
	Thu, 19 Jan 2006 09:49:36 -0800
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80601190933o4cedde92x@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.66__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14919>



On Thu, 19 Jan 2006, Franck wrote:
> 
> that would be great ! something like:
> 
>         git clone --since=v2.6.15 <src> <dst>
> 
> would be very useful for me. How would it work ? Does it automatically
> set up a graft file for me ?

I think we'd have to set up the grafts file, yes. However, it's actually 
less of an advantage than you'd think: especially for long development 
histories, the incremental packing is very very efficient. In contrast, if 
you only get recent versions, there's nothing to be incremental against, 
so the size of the pack will not be that much smaller.

So getting just a tenth of the development history will _not_ cause the 
pack to be just a tenth in size. It's probably closer to half the size of 
the full history.

Anyway, it's _conceptually_ something that git wouldn't have any problems 
with, but that doesn't mean that it's totally trivial either. The easiest 
way to do it (by far) would be to expand the native git protocol with a 
"get all objects of this one version" or something like that, and then 
you'd just do a "pull and mark all unknown commits in the grafts file".

So in effect, instead of getting the whole history pack, you'd get a pack 
that contains _one_ version (no history at all), and then (if you want to) 
you can get a pack that gets all stuff that isn't reachable from that one 
(ie "newer").

That would have the advantage that it's quite possible that many users 
might want to do just

	git clone --only=v2.6.15 <source> <target>

which would do that "one single version" variant of the clone. Then, later 
on, you could just do

	git pull --graft-unknown <source> <target>

to update the history.

Anybody want to try that? It would be a new command to "git-daemon" 
(instead of "git-upoload-pack", you'd do a new "git-upload-version" 
command internally: it would look a lot like upload-pack, and use the same 
unpacking protocol).

> but it's really a pain to run for example git-repack or git-prune commands.

Well, you really don't need to do that very often.

		Linus
