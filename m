From: Jon Blackburn <gitcommunitysupport@jonathanblackburn.net>
Subject: git svn clones flawlessly on Windows, crashes silently on OS X - status of externals support?
Date: Mon, 29 Feb 2016 16:54:02 +0000 (UTC)
Message-ID: <loom.20160229T173718-868@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 18:05:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaRFx-00029I-AZ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 18:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbcB2RFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 12:05:08 -0500
Received: from plane.gmane.org ([80.91.229.3]:44560 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163AbcB2RFI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 12:05:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aaRFo-000237-5E
	for git@vger.kernel.org; Mon, 29 Feb 2016 18:05:05 +0100
Received: from 208.86.29.5 ([208.86.29.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 18:05:04 +0100
Received: from gitcommunitysupport by 208.86.29.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 18:05:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 208.86.29.5 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287849>

Hello,

tl;dr: Can I get Git/SVN working on my MacBook if there are external references
in the repository? If not, are there alternatives that I can leverage?

I'm trying to use git svn to clone a repository that contains externals. On my 
Windows7 machine it works perfectly. On my Mac (running OSX 10.11.3) 
it fails silently after creating the empty local repository.

The posts that speak to some of the issues surrounding this are over two 
years old, so I'm hoping things have changed.

I've tried with the versions of Git and SVN installed with XCode, and with 
newer versions installed with HomeBrew and MacPorts. The latest version of 
Git (2.7.2) is the one I've done my troubleshooting with.

I found the threads that speak of needing to link the SVN Perl modules into
directories being searched by the Perl runtime, and have done something 
comparable with these:

sudo ln -s /opt/local/lib/perl5/vendor_perl/5.22/darwin-thread-multi-
2level/SVN /opt/local/lib/perl5/site_perl/5.22/darwin-thread-multi-2level/SVN

sudo ln -s /opt/local/lib/perl5/vendor_perl/5.22/darwin-thread-multi-
2level/auto /opt/local/lib/perl5/site_perl/5.22/auto

If I try with Git's debugger turned on, like so:

GIT_TRACE=1 git svn clone -s https://my-remote-repo

I get a bunch of redundant messages that look similar to the below, with 
something suspicious happening right at the time Git encounters its first 
external reference:

... many, many of these
Checked through r45000
16:49:19.677091 git.c:348 trace: built-in: git 'config' 'svn-remote.svn.
branches-maxRev' '45000'
16:49:19.684111 git.c:348 trace: built-in: git 'config' 'svn-remote.svn.tags-
maxRev' '45000'
Checked through r45100
16:49:19.721522 git.c:348 trace: built-in: git 'config' 'svn-remote.svn.
branches-maxRev' '45100'
16:49:19.728460 git.c:348 trace: built-in: git 'config' 'svn-remote.svn.tags-
maxRev' '45100'
16:49:19.784923 git.c:348 trace: built-in: git 'config' 'svn-remote.svn.
reposRoot' 'https://a-remote-external'
... once this line appears, the "Checked through r*" messages disappear.
... The rest of the output looks like these. Then the process dies.
16:49:19.807647 git.c:348 trace: built-in: git 'config' 'svn-remote.svn.
branches-maxRev' '45172'
16:49:19.814647 git.c:348 trace: built-in: git 'config' 'svn-remote.svn.
tags-maxRev' '45172'


If I run with the Perl debugger like so:

PERLDB_OPTS="NonStop frame=5" /opt/local/bin/perl5.22 -d 
$(git --exec-path)/git-svn clone -s https://my-remote-repository

I get the following stacktrace mush right before it crashes. It looks like 
multiple processes are sending output to TTY so the stacktraces are 
interleaved. There is a reference to Error::throw() down at the bottom that 
I hope will be helpful.

  in  .=main::post_fetch_checkout() from /opt/local/libexec/git-core/
            git-svn:387
   in  $=main::verify_ref('HEAD^0') from /opt/local/libexec/git-core/
           git-svn:1716
    in  $=Git::command_oneline(ref(ARRAY), ref(HASH)) from /opt/
           local/libexec/git-core/git-svn:1806
     in  @=Git::command_output_pipe(ref(ARRAY), ref(HASH)) from  
           /opt/local/lib/perl5/site_perl/5.22/Git.pm:314
      in  @=Git::_command_common_pipe('-|', ref(ARRAY), ref(HASH)) from 
           /opt/local/lib/perl5/site_perl/5.22/Git.pm:344
       in  @=Git::_maybe_self(ref(ARRAY), ref(HASH)) from 
           /opt/local/lib/perl5/site_perl/5.22/Git.pm:1561
        in  $=UNIVERSAL::isa(ref(ARRAY), 'Git') from 
           /opt/local/lib/perl5/site_perl/5.22/Git.pm:1549
       in  .=Git::_check_valid_cmd('rev-parse') from 
           /opt/local/lib/perl5/site_perl/5.22/Git.pm:1569 from 
           /opt/local/lib/perl5/site_perl/5.22/Git.pm:1598 
        in  .=Git::_setup_git_cmd_env(undef) from 
           /opt/local/lib/perl5/site_perl/5.22/Git.pm:1608
        in  .=Git::_execv_git_cmd('rev-parse', '--verify', 'HEAD^0') from 
          /opt/local/lib/perl5/site_perl/5.22/Git.pm:1609
     in  @=Error::subs::with(ref(CODE)) from 
          /opt/local/lib/perl5/site_perl/5.22/Git.pm:325
     in  $=Error::catch('Git::Error::Command', ref(CODE)) from 
          /opt/local/lib/perl5/site_perl/5.22/Git.pm:325
     in  .=Error::subs::try(ref(CODE), ref(HASH)) from 
         /opt/local/lib/perl5/site_perl/5.22/Git.pm:325
      in  .=CODE(0x7fa8a367bd40)() from 
         /opt/local/lib/perl5/vendor_perl/5.22/Error.pm:421
       in  .=Git::_cmd_close('rev-parse --verify HEAD^0', ref(GLOB)) from 
          /opt/local/lib/perl5/site_perl/5.22/Git.pm:319
        in  .=Error::throw('Git::Error::Command', 'rev-parse --verify HEAD^0'
          , 128) from /opt/local/lib/perl5/site_perl/5.22/Git.pm:1640
         in  $=Git::Error::Command::new('Git::Error::Command', 'rev-parse 
           --verify HEAD^0', 128) from /opt/local/lib/perl5/vendor_perl/5.22/
                Error.pm:184
          in  $=Error::new('Git::Error::Command', '-text', 'command returned 
            error', '-cmdline', 'rev-parse --verify HEAD^0', '-value', 128, 
            '-outputref', undef) from 
             /opt/local/lib/perl5/site_perl/5.22/Git.pm:1466
      in  $ CODE(0x7fa8a31d3db8)(ref(Git::Error::Command), undef, '') from 
            /opt/local/lib/perl5/vendor_perl/5.22/Error.pm:426
      in  $=Error::subs::run_clauses(ref(HASH), ref(Git::Error::Command), undef, 
            ref(ARRAY)) from /opt/local/lib/perl5/vendor_perl/5.22/Error.pm:432
       in  $=Scalar::Util::blessed(ref(Git::Error::Command)) from 
          /opt/local/lib/perl5/vendor_perl/5.22/Error.pm:324
       in  $=UNIVERSAL::isa(ref(Git::Error::Command), 'Git::Error::Command') 
          from /opt/local/lib/perl5/vendor_perl/5.22/Error.pm:324
       in  .=CODE(0x7fa8a23a74b8)(ref(Git::Error::Command), ref(SCALAR)) 
          from /opt/local/lib/perl5/vendor_perl/5.22/Error.pm:345
        in  .=Error::throw(ref(Git::Error::Command)) from 
           /opt/local/lib/perl5/site_perl/5.22/Git.pm:324
       in  $=CODE(0x7fa8a31d3db8)(ref(Git::Error::Command), undef, '') from 
          /opt/local/lib/perl5/vendor_perl/5.22/Error.pm:354
      in  $=Scalar::Util::blessed(ref(Git::Error::Command)) from 
         /opt/local/lib/perl5/vendor_perl/5.22/Error.pm:440
      in  $=UNIVERSAL::can(ref(Git::Error::Command), 'throw') from 
         /opt/local/lib/perl5/vendor_perl/5.22/Error.pm:440
      in  .=Error::throw(ref(Git::Error::Command)) from 
         /opt/local/lib/perl5/vendor_perl/5.22/Error.pm:442
