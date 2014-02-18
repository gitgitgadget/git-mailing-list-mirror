From: Mathy Vanvoorden <mathy@vanvoorden.be>
Subject: Problems while converting complex repository from SVN
Date: Tue, 18 Feb 2014 11:27:33 +0100
Message-ID: <197e3eca78fa1e827466d2a9387db48e@webmail.mvision.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 18 11:27:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFhtu-0006gi-HE
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 11:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948AbaBRK1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 05:27:36 -0500
Received: from mvision01.dco.fusa.be ([81.95.115.46]:55346 "EHLO
	mvision01.dco.fusa.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919AbaBRK1e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 05:27:34 -0500
Received: from localhost ([127.0.0.1] helo=webmail.mvision.be)
	by mvision01.dco.fusa.be with esmtpa (Exim 4.82)
	(envelope-from <mathy@vanvoorden.be>)
	id 1WFhtl-0003SX-Dp
	for git@vger.kernel.org; Tue, 18 Feb 2014 11:27:33 +0100
X-Sender: mathy@vanvoorden.be
User-Agent: Roundcube Webmail/0.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242294>

Hi,

I had some issues while converting our current SVN repository to a GIT 
repository. The old repository has a lot of strange history in it making 
it far from easy to convert it but for some issues I had to modify the 
convert scripts.

As I don't know the internals of GIT or git-svn enough I don't know if 
these are actually bugs or not. I will also not produce and submit 
patches to fix this as I don't know enough Perl to know if maybe it can 
be solved in a better way or that it should be solved at all.

1. issue with git-svn dying because git could not find the refname. I 
noticed that in the function resolve_local_globs it was actually passing 
desanitized names to the cmt_metadata function, so I changed the code to 
use sanitized names, trying to keep the rest of the script (which I 
don't pretend to understand) intact:

sub resolve_local_globs {
     my ($url, $fetch, $glob_spec) = @_;
     return unless defined $glob_spec;
     my $ref = $glob_spec->{ref};
     my $path = $glob_spec->{path};
     foreach (command(qw#for-each-ref --format=%(refname) refs/#)) {
         next unless m#^$ref->{regex}$#;
         my $p = $1;
         my $pathname = $path->full_path($p);
         my $svnpathname = desanitize_refname($pathname);
         my $refname = $ref->full_path($p);
         my $svnrefname = desanitize_refname($refname);
         if (my $existing = $fetch->{$svnpathname}) {
             if ($existing ne $svnrefname) {
                 die "Refspec conflict:\n",
                     "existing: $existing\n",
                     " globbed: $svnrefname\n";
             }
             my $u = (::cmt_metadata("$refname"))[0];
             $u =~ s!^\Q$url\E(/|$)!! or die
               "$svnrefname: '$url' not found in '$u'\n";
             if ($pathname ne $u) {
                 warn "W: Refspec glob conflict ",
                      "(ref: $svnrefname):\n",
                      "expected path: $pathname\n",
                      "    real path: $u\n",
                      "Continuing ahead with $u\n";
                 next;
             }
         } else {
             $fetch->{$svnpathname} = $svnrefname;
         }
     }
}


2. issue with an @ being present in a branch name. A first branch was 
created just fine, but a second branch was created from that branch 
which failed.

The following message (simplified for confidentiality reasons) was 
shown while trying to branch 'blabla bla@bla blabla' to 'blabla blabla'

Found possible branch point: 
svn://localhost/path/to/branch/blabla%20bla@bla%20blabla => 
svn://localhost/path/to/branches/blabla%20blabla, 13486
refs/remotes/origin/branches/blabla bla@bla blabla: 'svn://localhost' 
not found in 'svn://bla%20blabla'

I found out that the git-svn-id was actually being wrongly initiated to 
'svn://bla%20blabla'. This is due to a mistake in the regex that is used 
in remove_username.

It was:
	$_[0] =~ s{^([^:]*://)[^@]+@}{$1};
I changed it to
	$_[0] =~ s{^([^:]*://)[^@/]+@}{$1};

And it works.


I did all this using the standard Git package for Windows, release 
1.8.5.2

PS: I tried to send this from my work email several times but I think 
the mail server can't handle the greylisting so I apologize if the mails 
still end up in the list.

-- 

Met vriendelijke groeten,
Best regards,

Mathy Vanvoorden
