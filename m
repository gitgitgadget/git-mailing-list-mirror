From: fREW Schmidt <frioux@gmail.com>
Subject: Re: git-fixup-assigner.perl -- automatically decide where to "fixup!"
Date: Wed, 26 Oct 2011 09:37:56 -0500
Message-ID: <CADVrmKT1woYpJoe=L9sAbQ30TUw44zMc7y4WF=PMrT5Gj9kDNw@mail.gmail.com>
References: <201012140309.59378.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 26 16:38:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ4cZ-0002ys-Qo
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 16:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933176Ab1JZOiS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Oct 2011 10:38:18 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64144 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932772Ab1JZOiR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2011 10:38:17 -0400
Received: by vcge1 with SMTP id e1so1484368vcg.19
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 07:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jNQipkQ6e6SYCJeJDJCM500ag+wzjt6ujRMuaZtwfzY=;
        b=AEQxm7oJKcQKeoduYqhsCHWAKYsSja49Zo3SNQTMgz/yaJU7sT2IHf/qT4Yepfxlu0
         XSHuFLsv32ix/DZwTFhGW3NrDV/tQw8A5yU8Py6yhdO7CD7/SfHz6EA2Zq/GSZ4nVzbZ
         yWhFNau5FcfADuFLxOVb7X6B4E1ESlnURFqtM=
Received: by 10.68.33.42 with SMTP id o10mr3989180pbi.52.1319639896114; Wed,
 26 Oct 2011 07:38:16 -0700 (PDT)
Received: by 10.142.155.7 with HTTP; Wed, 26 Oct 2011 07:37:56 -0700 (PDT)
In-Reply-To: <201012140309.59378.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184262>

On Mon, Dec 13, 2010 at 8:09 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
>
> While cleaning up the 'log -L' series I gathered a large number of
> little fixups, and decided it would be smart if git could
> automatically figure out where to put them.
>
> It works like this:
>
> * Split the diff by hunk. =A0I'm using -U1 here for finer splits, but=
 it
> =A0could be tunable.
>
> * For each hunk, run blame to find out which commit's lines were
> =A0affected.
>
> * Group the hunks by this commit, and output them with a suitable
> =A0command to make a fixup.
>
> My git-fixup is
>
> =A0$ g config alias.fixup
> =A0!sh -c 'r=3D$1; git commit -m"fixup! $(git log -1 --pretty=3D%s $r=
)"' -
>
> so that is "suitable".
>
> You would run it with the changes unstaged in your tree as
>
> =A0./git-fixup-assigner.perl > fixups
>
> and can then review with 'less fixups', or run 'sh fixups' to commit
> them.
>
> It's certainly not perfect, notably the detection logic should ignore
> context, but it got the job done.
>
> --- 8< ---
> #!/usr/bin/perl
>
> use warnings;
> use strict;
>
> sub parse_hunk_header {
> =A0 =A0 =A0 =A0my ($line) =3D @_;
> =A0 =A0 =A0 =A0my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) =3D
> =A0 =A0 =A0 =A0 =A0 =A0$line =3D~ /^@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(=
\d+))? @@/;
> =A0 =A0 =A0 =A0$o_cnt =3D 1 unless defined $o_cnt;
> =A0 =A0 =A0 =A0$n_cnt =3D 1 unless defined $n_cnt;
> =A0 =A0 =A0 =A0return ($o_ofs, $o_cnt, $n_ofs, $n_cnt);
> }
>
> sub find_commit {
> =A0 =A0 =A0 =A0my ($file, $begin, $end) =3D @_;
> =A0 =A0 =A0 =A0my $blame;
> =A0 =A0 =A0 =A0open($blame, '-|', 'git', '--no-pager', 'blame', 'HEAD=
', "-L$begin,$end", $file) or die;
> =A0 =A0 =A0 =A0my %candidate;
> =A0 =A0 =A0 =A0while (<$blame>) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$candidate{$1} +=3D 1 if /^([0-9a-f]+)=
/;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0close $blame or die;
> =A0 =A0 =A0 =A0my @sorted =3D sort { $candidate{$b} <=3D> $candidate{=
$a} } keys %candidate;
> =A0 =A0 =A0 =A0if (1 < scalar @sorted) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print STDERR "ambiguous split $file:$b=
egin..$end\n";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0foreach my $c (@sorted) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print STDERR "\t$candi=
date{$c}\t$c\n";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return $sorted[0];
> }
>
> my $diff;
> open($diff, '-|', 'git', '--no-pager', 'diff', '-U1') or die;
>
> my %by_commit;
> my @cur_hunk =3D ();
> my $cur_commit;
> my ($filename, $prefilename, $postfilename);
>
> while (<$diff>) {
> =A0 =A0 =A0 =A0if (m{^diff --git ./(.*) ./\1$}) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (@cur_hunk) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0push @{$by_commit{$cur=
_commit}{$filename}}, @cur_hunk;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@cur_hunk =3D ();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$filename =3D $1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$prefilename =3D "./" . $1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$postfilename =3D "./" . $1;
> =A0 =A0 =A0 =A0} elsif (m{^index}) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# ignore
> =A0 =A0 =A0 =A0} elsif (m{^new file}) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$prefilename =3D '/dev/null';
> =A0 =A0 =A0 =A0} elsif (m{^delete file}) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$postfilename =3D '/dev/null';
> =A0 =A0 =A0 =A0} elsif (m{^--- $prefilename$}) {
> =A0 =A0 =A0 =A0} elsif (m{^\+\+\+ $postfilename$}) {
> =A0 =A0 =A0 =A0} elsif (m{^@@ }) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (@cur_hunk) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0push @{$by_commit{$cur=
_commit}{$filename}}, @cur_hunk;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@cur_hunk =3D ();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0push @cur_hunk, $_;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die "I don't handle this diff" if ($pr=
efilename ne $postfilename);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0my ($o_ofs, $o_cnt, $n_ofs, $n_cnt)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D parse_hunk_header(=
$_);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0my $o_end =3D $o_ofs + $o_cnt - 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$cur_commit =3D find_commit($filename,=
 $o_ofs, $o_end);
> =A0 =A0 =A0 =A0} elsif (m{^[-+ \\]}) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0push @cur_hunk, $_;
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die "unhandled diff line: '$_'";
> =A0 =A0 =A0 =A0}
> }
>
> close $diff or die;
>
> if (@cur_hunk) {
> =A0 =A0 =A0 =A0push @{$by_commit{$cur_commit}{$filename}}, @cur_hunk;
> =A0 =A0 =A0 =A0@cur_hunk =3D ();
> }
>
> print "#!/bin/sh\n\n";
>
> foreach my $commit (keys %by_commit) {
> =A0 =A0 =A0 =A0print "git apply --cached <<EOF\n";
> =A0 =A0 =A0 =A0foreach my $filename (keys %{$by_commit{$commit}}) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print "diff --git a/$filename b/$filen=
ame\n";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print "--- a/$filename\n";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print "+++ b/$filename\n";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print @{$by_commit{$commit}{$filename}=
};
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0print "EOF\n\n";
> =A0 =A0 =A0 =A0print "git fixup $commit\n\n";
> }
> --- >8 ---

This is super neat, but I'm having trouble getting it to work.

=46irst, I made one small change:

  -=A0=A0 =A0 =A0=A0 print "git fixup $commit\n\n";
  +=A0 =A0 =A0=A0 print "git commit --fixup $commit\n\n";

To try it out I made a very simple change:

  $ git diff
  diff --git a/App/lib/MyApp/Controller/DashboardTemplates.pm
b/App/lib/MyApp/Controller/DashboardTemplates.pm
  index aefdc3c..a53b534 100644
  --- a/App/lib/MyApp/Controller/DashboardTemplates.pm
  +++ b/App/lib/MyApp/Controller/DashboardTemplates.pm
  @@ -13,7 +13,7 @@ cat_has $_ =3D> ( is =3D> 'rw' ) for qw(set);

   sub base : Chained('/') PathPart('dashboard_templates') CaptureArgs(=
0) {
      my ($self, $c) =3D @_;
  -   $self->set($c,
$c->model('DB')->schema->kiokudb_handle->lookup('dashboard
templates'));
  +   $self->set($c, $c->model('Kioku')->lookup('dashboard templates'))=
;
   }

   my $renderer =3D sub {


Then I tried it out

  $ git fixup-assigner.pl > fixups && less fixups
  #!/bin/sh

  git apply --cached <<EOF
  diff --git a/App/lib/MyApp/Controller/DashboardTemplates.pm
b/App/lib/MyApp/Controller/DashboardTemplates.pm
  --- a/App/lib/MyApp/Controller/DashboardTemplates.pm
  +++ b/App/lib/MyApp/Controller/DashboardTemplates.pm
  @@ -15,3 +15,3 @@ sub base : Chained('/')
PathPart('dashboard_templates') CaptureArgs(0) {
      my ($self, $c) =3D @_;
  -   $self->set($c,
$c->model('DB')->schema->kiokudb_handle->lookup('dashboard
templates'));
  +   $self->set($c, $c->model('Kioku')->lookup('dashboard templates'))=
;
   }
  EOF

  git commit --fixup 7765cbd2

Looks fine to me.  But then I try to use it:

  $ git checkout . && sh fixups
  error: patch failed: App/lib/MyApp/Controller/DashboardTemplates.pm:1=
5
  error: App/lib/MyApp/Controller/DashboardTemplates.pm: patch does not=
 apply

Any ideas what I'm doing wrong?

--
fREW Schmidt
http://blog.afoolishmanifesto.com
