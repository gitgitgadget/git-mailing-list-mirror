From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [RFC/PATCH] gitweb: Use list form of 'open "-|"' pipeline
Date: Tue, 11 Mar 2008 19:59:16 +0100
Message-ID: <20080311185916.GO10103@mail-vs.djpig.de>
References: <20080308165245.15343.62914.stgit@localhost.localdomain> <20080311090100.GN10103@mail-vs.djpig.de> <200803111830.58392.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 20:01:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ9iR-0006O1-Dx
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 20:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbYCKS7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 14:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752965AbYCKS7c
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 14:59:32 -0400
Received: from pauli.djpig.de ([78.46.38.139]:39030 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752865AbYCKS7b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 14:59:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id BD36790071;
	Tue, 11 Mar 2008 19:59:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TOmMPEu7pFFZ; Tue, 11 Mar 2008 19:59:20 +0100 (CET)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 6184F9006E;
	Tue, 11 Mar 2008 19:59:19 +0100 (CET)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1JZ9gz-0003Si-3b; Tue, 11 Mar 2008 19:59:18 +0100
Content-Disposition: inline
In-Reply-To: <200803111830.58392.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76893>

On Tue, Mar 11, 2008 at 06:30:57PM +0100, Jakub Narebski wrote:
> On Tue, 11 March 2008, Frank Lichtenheld wrote:
> > On Sat, Mar 08, 2008 at 05:57:20PM +0100, Jakub Narebski wrote:
> >>
> >> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> >> index a5df2fe..ba97a7b 100755
> >> --- a/gitweb/gitweb.perl
> >> +++ b/gitweb/gitweb.perl
> >> @@ -1455,6 +1455,35 @@ sub git_cmd_str {
> >>  	return join(' ', git_cmd());
> >>  }
> >>  
> >> +# my $fh = output_pipeline(['cmd_1', 'option'], ['cmd_2', 'argument']);
> >> +# is equivalent to (is the "list form" of) the following
> >> +# open my $fh, "-|", "cmd_1 option | cmd_2 argument"
> >> +#
> >> +# Based on http://www.perlmonks.org/?node_id=246397
> 
> Note that this patch is a bit "cargo cult" (copy'n'paste) programming...
>  
> > It might be worthwile to look into how e.g. IPC::Run does this.
> 
> Thanks for the pointer. I look at it.

After taking a look at the IPC::Run code myself I'm not really sure it
is really "worthwile", as I put it, to try to understand that.

Creating a less flexible solution that is readable might be better.

> >> +sub output_pipeline {
> >> +	my @commands_list = @_;
> >> +	exit unless @commands_list;
> >> +
> >> +	my $pid = open(my $fh, "-|");
> >> +	#die "Couldn't fork: $!" unless defined $pid;
> > 
> > Why are all the die's commented out?
> 
> The goal is to have gitweb deal with errors gracefully. It should
> generate some kind of '503 Server Error' page, instead of dieing
> without output, or what would be even worse, in the middle of output.
> 
> I haven't examined how it should be writen for this RFC patch, so
> I have commented out 'die' just in case. In the final version (if it
> will be decided to go this route) it should be cleaned out.

Ok, I guessed as much, but wanted to make sure ;)

> > Thw whole concept of processing the array backwards might be shorter,
> > I personally find it somewhat confusing though.
> 
> I'm not sure if it is not the only possible way, as the (first) parent,
> I think, has to return filehandle. But I might be mistaken.
> 
> > What happens to all these child processes anyway if one of them fails to
> > exec?
> 
> Original snippet returned in addition to filehandle also list of pids.
> Perhaps I have oversimplified this snipped... or it was to simple to
> begin with.

I'm not really convinced yet that dealing with a shell is much worse
than dealing with IPC ;)

Jokes aside, my idea for implementing something like this would be to
use explicit pipe()'s and fork()'s instead of the open() magic. With
better control over the filehandles and pids you might be able to build
a more robust solution.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
