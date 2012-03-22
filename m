From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC Application [ Parallelism + Git.pm ]
Date: Thu, 22 Mar 2012 14:33:03 +0100
Message-ID: <201203221433.03616.jnareb@gmail.com>
References: <CAB3zAY1cbjmJvPQo2i38Vxv=1CTzcusvtBTPQehi30cYsDe1Zw@mail.gmail.com> <m37gyhlvkz.fsf@localhost.localdomain> <CAB3zAY0atsiXkBDxaRkC+WGzQUSOYgTnRZmOXdqKiXRw_DKkjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Subho Banerjee <subs.zero@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 14:33:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAi8s-0002Af-Ow
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 14:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757115Ab2CVNdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 09:33:15 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39497 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756699Ab2CVNdO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 09:33:14 -0400
Received: by eekc41 with SMTP id c41so693064eek.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 06:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=wAGw+dQGAqxAHa0jIBAsnhClD5wn63ZdWe5d0eLzfc4=;
        b=VR6d7mZitP2X1CWH4MMY2iWeK6XUF9nwVjG0JmurpuITocxweuPi718Rxs6KSLQHv4
         YGgHml53mYGQ6pQtotYe3oHWkkHYKmcCVPEXej7sS6UmeYeEGK0y/udUBUob3Xuh4vTy
         AmdH1+80ZE+FaS0nC6JiJrVqTuNZTM2lTBjQDZfactQkA/l+patb72OVn4PUy5NLz08D
         WseVrxbrwWCC0JkHCCYwFMJIlAMmXWXXm4V/mdSnIQm3zER5CNlNrwbLMIu8sew30H74
         KgU4LxS0DCryiLco+VJds5p9ARN+DklbY5ylgUC+hP0DTqIqfPbAZLWUCb3pkPpd/g1o
         T+oQ==
Received: by 10.14.28.2 with SMTP id f2mr1129971eea.13.1332423193486;
        Thu, 22 Mar 2012 06:33:13 -0700 (PDT)
Received: from [192.168.1.13] (abwe160.neoplus.adsl.tpnet.pl. [83.8.228.160])
        by mx.google.com with ESMTPS id y11sm17165391eem.3.2012.03.22.06.33.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 06:33:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CAB3zAY0atsiXkBDxaRkC+WGzQUSOYgTnRZmOXdqKiXRw_DKkjQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193655>

On Wed, 21 Mar 2012, Subho Banerjee wrote:

> I had some time to look through the perl module in the Git sources and
> I wanted to summarize the changes that need to be made -
> 
> [Primary Task]
> [1] Move exception handling from Error::Simple to Try::Tiny and Exception::Class

Well, that is not as much "primary task" as "minimal scope"...

We have also decide if we want to keep compatibility layer, including
git_cmd_try.  Git commands in Perl can be rewriten to using Try::Tiny
directly, but I wonder if there are out of tree Perl scripts and modules
that use Git module, and would be broken by not preserving backward
compatibility.

Another issue of note is whether we want to have all non-core Git.pm
prerequisites included like private-Error.pm (though I think in 'inc/'
or something).

> [Additional]
> [2] A Git::Config module that parses the .gitconfig file and the
> .git/config file in each repository (Is it one of these files or both?)

I don't think parsing git config file format in Perl is a good idea.
What I had in mind was to use `git config -l -z` output, reading all
configuration at once with a single git command.  

Note that this would require converting to specific types, like e.g.
turning true values of git config (e.g. string "true") into Perl
true (1).  The --int, --bool, --bool-or-int and --path should be easy;
the problem could be with --get-colorbool and --get-color.

Optionally (if possible) make it so Git / Git::Repo object uses either
one "git config --get <key>" for each $git->config(<key>) request, or
cached values from single "git config -l -z" via Git::Config, depending
on constructor options ('lazy_config' => 1).  Then we could fall back
to one command for one access for unknown types...

> [3] Parsing Tree and Commit objects and then traverse the tree
> structure in Perl through a Git::Commit module.

'commit', 'tag' and 'tree', and parsing and formatting ident fields.
Note that there is a difference between 'raw' output format ("git cat-file"),
and  e.g. "git ls-tree" for 'tree' objects.

If by 'traverse the tree structure in Perl through a Git::Commit module.'
you mean traversing DAG of revisions, then I think it is out of scope.

And there is also matter of parsing diff output (raw/tree, numstat,
patchset).

> [4] Cleaning-up improving the API.
> In general move towards an module that can access and change data in
> the configuration and commit status using Perl instead of the fork and
> IPC being used now.

Yes, so that most if not all operations can be done on the level of Git.pm
methods or subroutines, and not having to invoke git commands and parse
their output by hand.

This probably needs to be done by examining what git commands in Perl
need.

> Is this what you expect as a part of the GSoC work? Could you please
> tell me if I am missing something.

Another task could be CPAN-ification of Git.pm.  This _could_ include
creating a separate repository for Git.pm (with all thats entailed),
and subtree-mergeing it into git.git like git-gui and gitk are. 

Yet another task could be making all git commands in Perl use Git.pm
(well, at least those actively maintained).

Perhaps also cleaning those Perl::Critic warnings that make sense.
-- 
Jakub Narebski
Poland
