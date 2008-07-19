From: Jakub Narebski <jnareb@gmail.com>
Subject: Statictics on Git.pm usage in git commands (was: [PATCH 2/3] add new Git::Repo API)
Date: Sat, 19 Jul 2008 22:54:24 +0200
Message-ID: <200807192254.24622.jnareb@gmail.com>
References: <4876B223.4070707@gmail.com> <487BD0F3.2060508@gmail.com> <20080718164828.GT10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jul 19 22:55:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKJSn-0001l1-JJ
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 22:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797AbYGSUye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 16:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753725AbYGSUye
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 16:54:34 -0400
Received: from ik-out-1112.google.com ([66.249.90.176]:10655 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532AbYGSUyd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jul 2008 16:54:33 -0400
Received: by ik-out-1112.google.com with SMTP id c28so515316ika.5
        for <git@vger.kernel.org>; Sat, 19 Jul 2008 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=JsQiwvlqe9MBcup+w5Zpjxsgu+vZ91XrQe1rBzyglA8=;
        b=eiwg0ccg03ARckH3g7b5NvXn426GklGDoY85oaLO9Ute/4ICDBgnIBYsavn0tN6y3o
         9UkvbZfaMnzjPzLe2NkbpssYD+ZOGMujWugI2HoEHUs4HpYTR8R+7H9el05ryMqk+05E
         MG9FhVSFS4t+levednV0WAu9F9Akj3SxEFQgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qXglOqVfc8qt6XvqosVODXZliwpprFZpVRLGzbYdjAw8c6E2MxO+hi8oasbiow6UlJ
         2i33EJx4frCFGPytlX4ouDhcU1lZbdWFpz8ZymmND641ve+vwDVEaoy/tdhvtiI8zyGA
         KlHkqChvlQdoNoBepqWZqfIV+34sq8OUiBJ8U=
Received: by 10.210.69.6 with SMTP id r6mr1567058eba.170.1216500871564;
        Sat, 19 Jul 2008 13:54:31 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.237.89])
        by mx.google.com with ESMTPS id c24sm4618821ika.4.2008.07.19.13.54.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 19 Jul 2008 13:54:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080718164828.GT10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89134>

On Fri, 18 July 2008, Petr Baudis wrote:

> But the experience shows that the pipe interface is actually
> the _most_ used part of the Git Perl API.

This made me curious which parts of Git.pm, the current Git Perl API,
are used most.

Here is some statistics on the usage of Git Perl API among built-in
and contrib commands.


>From git commands in Perl the following include "use Git" in their 
sources: git-cvsexportcommit, git-send-email, git-svn, and helper
script git-add--interactive.  There are Perl scripts which do not
use Git.pm: git-archimport (which I think should be obsoleted or
moved to contrib), git-cvsimport, git-cvsserver, git-relink.  This
means that half of Perl scripts use Git Perl API.

The situation is worse for scripts in 'contrib/'.  From those, only
contrib/examples/git-remote.perl uses Git.pm; neither blameview,
continuous, git-import and import-tars in fast-import, setgitperms
and update-paranoid in hooks, stats, nor other Perl scripts in
examples (git-rerere, git-svnimport) include "use Git".

Below there are stats on how different commands from Git.pm are
used in mentioned Perl scripts:

1. git-add--interactive.perl uses Git.pm mainly to access color
   configuration: 2 ->get_colorbool, 8 ->get_color, 1 ->config.
   It also uses once ->repository() constuctor, and once
   ->repo_path().

   This means that future Git::Config _has_ to have support for
   color or colorbool valued configuration values.

2. git-cvsexportcommit.perl uses (besides ->repository() constructor)
   only once ->config; so I guess that current interface wrapping
   git-config should stay, because parsing whole config for such
   situation would be overkill.

   What is strange that git-cvsexportcommit.perl defines its own
   safe_pipe_capture and xargs_safe_pipe_capture (!), and uses
   them, open pipeline, backticks, and system() to call git commands.
   
3. git-send-email.perl uses 5 config, 2 config_bool, 2 ident_person
   (for author and for committer), 1 version, and of course once
   ->repository() constructor.  

   Here we can see how to work around current API to: it uses
   Git::config(@repo, "sendemail.identity") form, where 
   	my $repo = eval { Git->repository() };
   	my @repo = $repo ? ($repo) : ();
   to make it work both with git repository (using repo config), and
   outside/without git repository, using only user and system git
   config.

4. git-svn.perl (which is if I checked correctly third largest scripted
   git command, after gitk-gui/gitk-wish and gitweb/gitweb.perl) uses:

     3  x repository
     28 x command_oneline
     19 x command_noisy
     18 x command
     14 x command_output_pipe
     1  x command_input_pipe
     1  x git_try_cmd  (and many "eval { command()/command_oneline() }")
     2  x cat_blob
     1  x hash_and_insert_object
     1  x get_colorbool

   (The above are all if I have not made mistake when counting commands)

   Side note: git-svn is command which would get most out of
   Git::Config, as it currently uses combination of "git config -l"
   and "git config --get" (I guess that the code in question predates
   machine-parseable "git config -l -z").

Note that all those statictics doesn't count how many times some
Git.pm method was called, only how many times it occurs in the code.

-- 
Jakub Narebski
Poland
