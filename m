From: Roman Kagan <rkagan@mail.ru>
Subject: Re: Fwd: Error with git-svn pushing a rename
Date: Wed, 25 Dec 2013 01:11:16 +0400
Message-ID: <1387919476-27921-1-git-send-email-rkagan@mail.ru>
References: <CAM-uYMiLpsQdN41Gs8iJOT-v0qKgod2vEeoC3C+QJ5+wKiVK-Q@mail.gmail.com>
Cc: git@vger.kernel.org, Roman Kagan <rkagan@mail.ru>
To: Benjamin Pabst <benjamin.pabst85@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 24 22:43:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvZbb-0003dF-Fx
	for gcvg-git-2@plane.gmane.org; Tue, 24 Dec 2013 22:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016Ab3LXVd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Dec 2013 16:33:26 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:28882 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab3LXVdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Dec 2013 16:33:25 -0500
X-Greylist: delayed 1317 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Dec 2013 16:33:25 EST
Received: from rkaganb.sw.ru ([10.30.3.95])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id rBOLBG98010154;
	Wed, 25 Dec 2013 01:11:17 +0400 (MSK)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <CAM-uYMiLpsQdN41Gs8iJOT-v0qKgod2vEeoC3C+QJ5+wKiVK-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239669>

Benjamin Pabst <benjamin.pabst85 <at> gmail.com> writes:
> is it possible to debug git-svn or get a more verbose / debug output
> from it? I already tried with the "GIT_TRACE" variable, but it does
> not include any further output on the svn methods.

I've hit this problem too, and tracked it down to what I think is a
bug in svn.  It fails in libsvn_ra_serf/commit.c:close_file() on invalid
->copy_path on the file context.

AFAICT this is do to the ra_serf version of add_file() lacking
apr_pstrdup() on the "copy_path" argument passed to it; as a result it
gets overwritten with garbage on further use:

libsvn_ra_serf/commit.c:
...
1852 static svn_error_t *
1853 add_file(const char *path,
1854          void *parent_baton,
1855          const char *copy_path,
1856          svn_revnum_t copy_revision,
1857          apr_pool_t *file_pool,
1858          void **file_baton)
1859 {
...
1875   new_file->copy_path = copy_path;
..

You can apply this workaround to get it to work:

--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -304,8 +304,9 @@ sub C {
 	my ($self, $m, $deletions) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
 	my $pbat = $self->ensure_path($dir, $deletions);
+	my $upa = $self->url_path($m->{file_a});
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
-				$self->url_path($m->{file_a}), $self->{r});
+				$upa, $self->{r});
 	print "\tC\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
@@ -323,8 +324,9 @@ sub R {
 	my ($self, $m, $deletions) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
 	my $pbat = $self->ensure_path($dir, $deletions);
+	my $upa = $self->url_path($m->{file_a});
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
-				$self->url_path($m->{file_a}), $self->{r});
+				$upa, $self->{r});
 	print "\tR\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
 	$self->apply_autoprops($file, $fbat);
 	$self->chg_file($fbat, $m);


What it does is store the value to be passed to add_file() in a local
variable, and rely on perl to keep it alive through the end of function
scope, beyond the call to close_file() where it's actually used.

I'm going to submit a patch adding apr_pstrdup() to subversion folks.
Meanwhile if people find the above workarond a sensible thing to do in
git, I can submit a properly formed patch here too.

Roman.
