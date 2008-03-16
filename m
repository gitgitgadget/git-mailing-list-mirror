From: "Nazar Aziz" <mcnazar@gmail.com>
Subject: git-svn dcommit fails in a repository with submodules
Date: Sun, 16 Mar 2008 10:50:22 +0000
Message-ID: <60dc6b330803160350o3481b7b5vee1795919101cce2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: mcnazar@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 11:51:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaqSd-0004U5-6g
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 11:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbYCPKu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 06:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbYCPKu0
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 06:50:26 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:54963 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbYCPKuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 06:50:25 -0400
Received: by an-out-0708.google.com with SMTP id d31so1138146and.103
        for <git@vger.kernel.org>; Sun, 16 Mar 2008 03:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=FNIvX+wIOC0gij0ZO9UhldMGfscdlS3GMBSNt2YbUTI=;
        b=EHt74h1DWCPtpnlCupA5yBgsDdYwRfZI6HrrgGKN/72Rw05uaNONYGYJ9qVdighTNoxFNY9CL3280m2EK2ANt5OWNDI2NYGzHAa+li88OiM0hui7quoCaRdtmgtZlgyrZQiKKhAWpA3iP5MR/hLSwuOsfdKlKHEs1WjmqVa9bKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=h7QUNy2ppjz9gebSQKdHZ/9Z/pa5YgpEem42EhOjClclwya1kXbmlX0T754oiRB4sX0SofuY+wUKXfiaRnsStN4P72SKVNyADanuotb8DM9bXe/tNseZCjZ5Tr+q24+l2Rdsh+zG8BVd0WvAPuH60dUY/FHG9MBxQ5OTONmIGrA=
Received: by 10.101.66.14 with SMTP id t14mr28935707ank.114.1205664622598;
        Sun, 16 Mar 2008 03:50:22 -0700 (PDT)
Received: by 10.100.94.17 with HTTP; Sun, 16 Mar 2008 03:50:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77360>

Hi all.

I am struggling with a git repository which I sync with an SVN repos
using git-svn. git-svn dcommit fails with (dump from git-svn 1.5.4.1):

Committing to svn://epia/tmp/Trunc ...
         A       modules/akismet
fatal: git-cat-file 5f726f311613171310226d9bf040765
6ad4a82f4: bad file
 at /usr/bin/git-svn line 3537
        SVN::Git::Editor::chg_file('SVN::Git::Editor=HASH(0xd0c26c)',
'_p_void=SCALAR(0x9aee60)', 'HASH(0x9af340)') called at
/usr/bin/git-svn line 3461
         SVN::Git::Editor::A('SVN::Git::Editor=HASH(0xd0c26c)',
'HASH(0x9af340)') called at /usr/bin/git-svn line 3592
        SVN::Git::Editor::apply_diff('SVN::Git::Editor=HASH(0xd0c26c)')
called at /usr/bin/git-svn line 450
         main::cmd_dcommit() called at /usr/bin/git-svn line 246
        eval {...} called at /usr/bin/git-svn line 244
32768 at /usr/bin/git-svn line 450

Just to explain my setup. I've got an application that has shared
code. This shared code was previously accessed in SVN via an
svn:externals which pointed to a separate "shared code" svn
repository. This setup allowed me to share this code in several apps
whilst also giving me the ability to modify this shared code in any
single application and commit it to the "shared code" repos for use in
my other applications.

I've written an article on it here:
http://panthersoftware.com/articles/view/3/svn-s-svn-externals-to-git-s-submodule-for-rails-plugins

I've tried hacking git-svn but my Perl fu is weak. So I would
appreciate any pointers to help me solve this.

I've done the following hack:

sub valid_object {
  #check if git-cat can process this sha1..if not then return false
   my ($self, $sha1) = @_;
    my $fh = IO::File->new_tmpfile or croak $!;
    defined(my $pid = fork) or croak $!;
    if (!$pid) {
        open STDOUT, '>&', $fh or croak $!;
        exec qw/git-cat-file blob/, $sha1 or croak $!;
     }
    waitpid $pid, 0;
    if ($?) {
     return 0;
    } else {
      return 1;
    }
}

sub A {
    my ($self, $m) = @_;
    if ($self->valid_object($m->{sha1_b}) == 1) {
      my ($dir, $file) = split_path($m->{file_b});
       my $pbat = $self->ensure_path($dir);
      my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
                    undef, -1);
      print "\tA\t$m->{file_b}\n" unless $::_q;
       $self->chg_file($fbat, $m);
      $self->close_file($fbat,undef,$self->{pool});
    }
}

I added sub valid_object to package SVN::Git::Editor. It is a brute
method to see if git-cat-file will choke on a particular sha1. I am
certain there is a more elegant method to check if a sha1 is actually
a submodule... I just haven't found it yet.

The above almost works but not quite:

$ git-svn2 dcommit
Committing to svn://epia/tmp/Trunc ...
fatal: git-cat-file 5f726f311613171310226d9bf0407656ad4a82f4: bad file
Committed r24
W: ea1efb48fb6e03454f9264dd63cd609884c4f780 and refs/remotes/git-svn
differ, using rebase:
 :040000 040000 2bd02aa0d14fd5e16f90d8b9c5322cc101d7f026
36fbd5e7d921cd5fabe32fe857455f7fec26f521 M      modules
Current branch master is up to date.
# of revisions changed
before:


after:
 ea1efb48fb6e03454f9264dd63cd609884c4f780
  If you are attempting to commit  merges, try running:
         git rebase --interactive --preserve-merges  refs/remotes/git-svn
Before dcommitting

"fatal: git-cat-file 5f726f311613171310226d9bf0407656ad4a82f4: bad
file" comes from sub valid_object and is for info only. I can see that
git-svn has bypassed the submodule as I was hoping.

Checking SVN's log I can see an empty commit (ie no files have been
uploaded). In Git, my Master branch is still ahead of of the
remotes/git-svn branch (ie not in synch with remotes/git-svn)

>From the above, I can see that I am so almost there... but just need
one final push to get me to the finishing line.

Is there anyway I can tell git-svn to ignore submodules?

Any hints, tips or help would be greatly appreciated.

Thank you in advance for any help.

Nazar
