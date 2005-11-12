From: Andreas Ericsson <ae@op5.se>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Sat, 12 Nov 2005 13:17:14 +0100
Message-ID: <4375DD4A.5050103@op5.se>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>	<43730E39.6030601@pobox.com> <7v64qzni9c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Nov 12 13:17:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EauK2-00074Q-3A
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 13:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVKLMRQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 07:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVKLMRQ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 07:17:16 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:5557 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932368AbVKLMRQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 07:17:16 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id C57536BD02
	for <git@vger.kernel.org>; Sat, 12 Nov 2005 13:17:14 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7v64qzni9c.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11674>

Junio C Hamano wrote:
> 
>>>Oh, and we will not be moving things out of /usr/bin/ during 1.0
>>>timeframe.
>>
>>:(  bummer.  I do like the elegance of having /usr/bin/git executing 
>>stuff out of /usr/libexec/git.
> 
> 
> Bummer here as well.  This is not my first preference, but more
> or less "all things considered...".  I can go over cogito and
> stgit with Pasky and Catalin and coordinate the transition, but
> at the same time, everybody's existing scripts need to be
> adjusted.  As Linus said, we broke kernel.org snapshot scripts
> number of times.
> 
> Also places we execute git-upload-pack and git-receive-pack over
> an SSH connection need to be updated to execute 'git' with the
> first parameter 'upload-pack' and 'receive-pack' to make sure it
> would keep working with older or newer git on the other end.
> 

I've cooked up a patch that takes care of this if;
	git daemon
is executed (rather than git-daemon). Otherwise we could just mention in 
the docs that git-daemon must be run with the --libdir parameter (or 
whatever we decide to call it). If it prepends the libdir to the path 
everything will work same as always in the rest of the code so it'll be 
a very small change.

> After all that happens, we can start installing things in
> /usr/lib/git/.  During the transition, the C rewrite of git
> wrapper posted by Andreas Ericsson might help, so I am planning
> to merge it before 1.0,> after deciding what the right word for
> the "path to the rest of git executables" should be.
> 

All I really need to finalize it is that name, so It's up to you how 
fast you want it. Perhaps we could take a poll?

The suggestions so far come from the threads "git binary directory?" and 
"[PATCH] C implementation of the 'git' program" and some I just thought 
up. And here are the nominees;

	libdir
	path
	exec-path


Kay Sievers pointed out that libexec is not "LSB conformant" so it might 
be going away and is thus not listed.

exec-path was the last suggested name I got from Junio.

The form will be
	exec_path=$(prefix)/lib/git-@@VERSION@@
	GIT_EXEC_PATH
	--exec-path

for Makefile, environment and 'git', respectively. Substitute the 
obvious part with whatever you prefer.

> So let's say 1.0 will ship with all things in /usr/bin/, with
> updated docs that explain the situation: (1) the dash form
> 'git-frotz' is being deprecated, and you are encouraged to spell
> it as 'git frotz'; (2) if you want to use the dash form in your
> scripts for performance reasons, you need to have something like
> PATH="$(git --exec-path):$PATH" at the beginning of your script.
> 
> And after some time (say 2 months) we can switch.
> 

Sounds sensible, although I'm implementing Linus' idea of prepending the 
GIT_EXEC_PATH to $PATH so the porcelainish scripts in git-core shouldn't 
have to do it. If someone executes git-<script> from command-line I 
think it's safe to assume that they've added the exec-path to $PATH 
themselves. Someone *might* run

	/usr/lib/git-$GIT_VERSION/git-<script>

which should be cautioned against in the documentation.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
