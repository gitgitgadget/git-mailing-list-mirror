From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: Git-SVN on Cygwin: svn+ssh good, https awkward
Date: Fri, 24 Apr 2009 19:31:25 +0200
Message-ID: <op.uswiynhl1e62zd@balu.cs.uni-paderborn.de>
References: <op.usulh7a71e62zd@balu.cs.uni-paderborn.de>
 <20090423190308.GA10437@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Marcus Griep" <marcus@griep.us>, git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 19:33:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxPGq-0007P8-TD
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 19:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757267AbZDXRbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 13:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755993AbZDXRbb
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 13:31:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:47129 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752354AbZDXRba (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 13:31:30 -0400
Received: (qmail invoked by alias); 24 Apr 2009 17:31:27 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp004) with SMTP; 24 Apr 2009 19:31:27 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX18AxkREWp0A8lI58WLlrZmcFm1f+WFs8S6uoBbZ0W
	lwqFMvUyNvQzUF
In-Reply-To: <20090423190308.GA10437@dcvr.yhbt.net>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117472>

Am 23.04.2009, 21:03 Uhr, schrieb Eric Wong <normalperson@yhbt.net>:

> Matthias Andree <matthias.andree@gmx.de> wrote:
>> Hi Eric,
>>
>> === Short story ===
>>
>> git-svn on Cygwin works well with svn+ssh://, but needs some fixes  
>> around
>> tempfile and/or subprocess handling for https:// - please help.
>
> Hi Matthias,
>
> Marcus Griep did a lot of work for more efficiently handling of
> tempfiles in Git.pm a few months ago, so maybe he has more insight into
> how things work...
>
> git-svn used to use IO::File->new_tmpfile() which was much simpler and
> probably less prone to portability problems, but cycled through inodes
> too quickly for Marcus (and probably some other people).

I debugged this a bit further, and the damage (i. e. removal of the  
tempfile) apparently happens
in $pool->clear; in line 4355. I single-stepped it, and the  
apr_pool_clear(...) is the culprit, it unlinks() the tempfile, making this  
location unusable.

The temp file is generated when the Reporter object is created through  
$self->do_update in line 4336.

It remains unclear to me who generates the non-unique filename (it's  
...\Temp\tempfile.tmp for me), I've not found the code that generates the  
file names.

Questions:

- How can I either make sure that the temporary file name for the reporter  
gets either a unique name (near line 4336, through SVN::Ra...)

- or is that the temp file truncated, rather than deleted, near line 4355  
(through SVN::Pool::clear)?

- Is there any way to influence how the SVN::Ra::Reporter obtains  
temporary files?
I seem to be unable to trace this down to the actual functions, but then  
again, my perlboot is rather holey...

Any help?


   4132  package Git::SVN::Ra;
   4133  use vars qw/@ISA $config_dir $_log_window_size/;
   4134  use strict;
   4135  use warnings;
   4136  my ($ra_invalid, $can_do_switch, %ignored_err, $RA);
   4137
   ....
   4324  sub gs_do_update {
   4325          my ($self, $rev_a, $rev_b, $gs, $editor) = @_;
   4326          my $new = ($rev_a == $rev_b);
   4327          my $path = $gs->{path};
   4328
   4329          if ($new && -e $gs->{index}) {
   4330                  unlink $gs->{index} or die
   4331                    "Couldn't unlink index: $gs->{index}: $!\n";
   4332          }
   4333          my $pool = SVN::Pool->new;
   4334          $editor->set_path_strip($path);
   4335          my (@pc) = split m#/#, $path;
: 4336          my $reporter = $self->do_update($rev_b, (@pc ? shift @pc :  
''),
   4337                                          1, $editor, $pool);
   4338          my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef) : ();
   4339
   4340          # Since we can't rely on svn_ra_reparent being available,  
we'll
   4341          # just have to do some magic with set_path to make it so
   4342          # we only want a partial path.
   4343          my $sp = '';
   4344          my $final = join('/', @pc);
   4345          while (@pc) {
   4346                  $reporter->set_path($sp, $rev_b, 0, @lock, $pool);
   4347                  $sp .= '/' if length $sp;
   4348                  $sp .= shift @pc;
   4349          }
   4350          die "BUG: '$sp' != '$final'\n" if ($sp ne $final);
   4351
   4352          $reporter->set_path($sp, $rev_a, $new, @lock, $pool);
   4353
   4354          $reporter->finish_report($pool);
: 4355          $pool->clear;
   4356          $editor->{git_commit_ok};
   4357  }

-- 
Matthias Andree
