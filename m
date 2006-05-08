From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 8 May 2006 02:43:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605080236350.32508@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1147037659.25090.25.camel@dv> <7v4q01jwwg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 02:44:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fctqu-0006Bo-Fu
	for gcvg-git@gmane.org; Mon, 08 May 2006 02:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWEHAnx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 20:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWEHAnw
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 20:43:52 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:58816 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751243AbWEHAnw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 20:43:52 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id E260D12E9;
	Mon,  8 May 2006 02:43:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id D6A1E12D1;
	Mon,  8 May 2006 02:43:50 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id B53A01086;
	Mon,  8 May 2006 02:43:50 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q01jwwg.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19734>

Hi,

On Sun, 7 May 2006, Junio C Hamano wrote:

> Pavel Roskin <proski@gnu.org> writes:
> 
> > In particular, git-repo-config leaves the config file locked in the
> > regex is wrong:
> >
> > $ git-repo-config branch.fetch "master:origin" +
> > Invalid pattern: +
> > $ git-repo-config branch.fetch "master:origin" +
> > could not lock config file
> >
> > To fix it, just add "close(fd); unlink(lock_file);" after "Invalid
> > pattern" in config.c.
> 
> I'd give Johannes the first refusal right to deal with this and
> not touch repo-config.c myself for now, since I suspect I
> tempted him enough to restructure it ;-).

Thanks. Yes, you tempted me real hard :-) Unfortunately, the restructuring 
will have to wait a little, because I really should work for my day job 
these days... :-(

> > I don't quite understand what pattern is needed to add an entry.  "foo"
> > seems to work fine, I don't know why.
> 
> I think the value regexp is "replace the ones that match this",
> and the convention he came up with is to use "^$" to append (see
> some examples in t/t1300-repo-config.sh).
> 
> In any case, Documentation/git-repo-config.txt mentions
> value_regex without explaining what the semantics is.  This
> needs to be fixed, probably like the attached patch.
> 
> > That problem with multiple values is that they are quite fragile and
> > require special options to access them.  Since regex is used, dots in
> > the branch names need to be escaped.  Probably more escapes are needed.
> 
> I have a suspicion that using regex while is more powerful and
> expressive might be a mistake and it would be easier for users
> (both Porcelain and end-users) to use fnmatch() patterns.

I did not know about fnmatch()... It is probably better than regular 
expressions. After all, what I use it for most often is

	git-repo-config --get-all remote.*url

which -- magically -- will continue to work with fnmatch()!

> 	[branch]
> 		defaultremote = origin for master
>                 defaultremote = private for test

FWIW I like that syntax much better. But then, somebody called me weird 
because of how I order the arguments of a comparison... tsk, tsk.

> @@ -23,10 +23,11 @@ You can query/set/replace/unset options 
>  actually the section and the key separated by a dot, and the value will be
>  escaped.
>  
> -If you want to set/unset an option which can occur on multiple lines, you
> -should provide a POSIX regex for the value. If you want to handle the lines
> -*not* matching the regex, just prepend a single exclamation mark in front
> -(see EXAMPLES).
> +If you want to set/unset an option which can occur on multiple
> +lines, a POSIX regexp `value_regex` needs to be given.  Only the
> +existing values that match the regexp are updated or unset.  If
> +you want to handle the lines that do *not* match the regex, just
> +prepend a single exclamation mark in front (see EXAMPLES).

I would actually prefer to go with your suggestion of using shell patterns 
instead of regular expressions. They are not needed, and most users tend 
to positively hate regular expressions.

Thoughts?

Ciao,
Dscho
