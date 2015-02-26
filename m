From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad file descriptor
Date: Thu, 26 Feb 2015 05:49:34 -0800
Message-ID: <cbcb926c1b7edd31548a15ea4966a35@74d39fa044aa309eaea14b9f57fe79c>
References: <CAK6Z60ciheWOUGOv1sYcA==B2WR1Rs_eMU+9a=R3FBwc_37CyQ@mail.gmail.com> <CAK6Z60fhyY3wPG6hx7YJ4y7wZsWb=33JhqejmpVBgZLGdB1XMA@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>, Mike <ipso@snappymail.ca>,
	Minty <mintywalker@gmail.com>,
	=?UTF-8?q?Nico=20Schl=C3=B6mer?= <nico.schloemer@gmail.com>,
	Valery Yundin <yuvalery@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 14:49:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQyp2-00033L-QO
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 14:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbbBZNto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 08:49:44 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:40561 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbbBZNtn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 08:49:43 -0500
Received: by pdev10 with SMTP id v10so13120732pde.7
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 05:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EbYxOa4JsluTOklfdj3wv8Crrph+f/s3V/tgbZHNXzM=;
        b=Z9cIHDqIY0bA0rdgQeqhsuFuJDq5CCF5EqXMZE0mC9UtLokugydtk/58nZcKPtIp/4
         xKFv1KWOHg7uNuif1mKtYqj/tfyR9Ady9dz2yPEsZf2uArTWfKk6c6ZfSbynxQRLZlYl
         tDVDrJaldDmEb70OoqdJKTG8EpTzr4G8Yuk3oDd6N0D9SdN214wPmzscqSeR8xAmPkCR
         xSh6/08uhXk9ewL0EuRwOHlAgwS9c3Z/FEUMFkWM378M2bREa9M1ZPRUWLhEzB5GXqrz
         FZlve7LXZNH8Th3UgfMIIVd7MW99u9ehqq1aVCSKbpDQilBjIqn5GBfyCPTpD+IHISMe
         nbjQ==
X-Received: by 10.66.102.4 with SMTP id fk4mr14733997pab.111.1424958582570;
        Thu, 26 Feb 2015 05:49:42 -0800 (PST)
Received: from localhost.localdomain ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id ck2sm1057123pbc.80.2015.02.26.05.49.41
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 26 Feb 2015 05:49:42 -0800 (PST)
In-Reply-To: <CAK6Z60fhyY3wPG6hx7YJ4y7wZsWb=33JhqejmpVBgZLGdB1XMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264442>

On Feb 26, 2015, at 01:09, Nico Schl=F6mer wrote:
> All,
>
> I applied Kyle's latest patch
>
>> diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
>> index 622535e2..96888228 100644
>> --- a/perl/Git/SVN/Ra.pm
>> +++ b/perl/Git/SVN/Ra.pm
>> @@ -391,6 +391,7 @@ sub longest_common_path {
>> sub gs_fetch_loop_common {
>>        my ($self, $base, $head, $gsv, $globs) =3D @_;
>>        return if ($base > $head);
>> +       $::_repository->_open_cat_blob_if_needed;
>>        my $gpool =3D SVN::Pool->new_default;
>>        my $ra_url =3D $self->url;
>>        my $reload_ra =3D sub {
>
> alone and this fixes the bug for me. Thanks a lot, Kyle!

The updated patch with the additional fix is below.

There are two symptoms it addresses:

1) the 'Git_svn_hash_... bad file descriptor' failure

2) the 'out pipe went bad' failure

While (1) could probably also be addressed by Eric's alternate
"destroy all tempfiles when reloading RA" patch, that would require re-
opening all the temp files every 100 revisions (or whatever the log
window size is changed to).

I noticed that with the default log window size of 100 revisions, each
time the connection was reset at the 100-revision boundary (to reduce
the overall memory usage) it seemed to take approx. 3 seconds to start
up again processing revisions on that gmsh repository.  If you're
cloning 30000 revisions, that adds 15 minutes to the total clone time
already.  Admittedly opening new temp files will be a lot faster and
hardly noticeable, but doing that 300 times over the course of 30000
revisions will probably add at least a little extra delay and since
blowing away all the temp files does not seem to be necessary, why
incur the extra delay?

Also the "destroy all tempfiles when reloading RA" patch isn't going
to fix the cat_blob 'out pipe went bad' problem since that has nothing
to do with the temp files so another change will still be required for
that.

-Kyle

-- 8< --
Subject: [PATCH v2] Git::SVN::*: avoid premature FileHandle closure

Since b19138b (git-svn: Make it incrementally faster by minimizing temp
files, v1.6.0), git-svn has been using the Git.pm temp_acquire and
temp_release mechanism to avoid unnecessary temp file churn and provide
a speed boost.

However, that change introduced a call to temp_acquire inside the
Git::SVN::Fetcher::close_file function for an 'svn_hash' temp file.
Because an SVN::Pool is active at the time this function is called, if
the Git::temp_acquire function ends up actually creating a new
FileHandle for the temp file (which it will the first time it's called
with the name 'svn_hash') that FileHandle will end up in the SVN::Pool
and should that pool have SVN::Pool::clear called on it that FileHandle
will be closed out from under Git::temp_acquire.

Since the only call site to Git::temp_acquire with the name 'svn_hash'
is inside the close_file function, if an 'svn_hash' temp file is ever
created its FileHandle is guaranteed to be created in the active
SVN::Pool.

This has not been a problem in the past because the SVN::Pool was not
being cleared.  However, since dfa72fdb (git-svn: reload RA every
log-window-size, v2.2.0) the pool has been getting cleared periodically
at which point the FileHandle for the 'svn_hash' temp file gets closed.
Any subsequent calls to Git::temp_acquire for 'svn_hash', however,
succeed without creating/opening a new temporary file since it still has
the now invalid FileHandle in its cache.  Callers that then attempt to
use that FileHandle fail with an error.

We avoid this problem by making sure the 'svn_hash' temp file is created
in the same place the 'svn_delta_...' and 'git_blob_...' temp files are
(and then temp_release'd) so that it can be safely used inside the
close_file function without having its FileHandle end up in an SVN::Pool
that gets cleared.

Additionally the Git.pm cat_blob function creates a bidirectional pipe
FileHandle using the IPC::Open2::open2 function.  If that handle is
created too late, it also gets caught up in the SVN::Pool and incorrectly
closed by the SVN::Pool::clear call.  But this only seems to happen with
more recent versions of Perl and svn.

To avoid this problem we add an explicit call to _open_cat_blob_if_needed
before the first call to SVN::Pool->new_default to make sure the open2
handle does not end up in the SVN::Pool.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 perl/Git/SVN/Fetcher.pm | 8 ++++++++
 perl/Git/SVN/Ra.pm      | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 10edb277..613055a3 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -322,6 +322,14 @@ sub apply_textdelta {
 	# (but $base does not,) so dup() it for reading in close_file
 	open my $dup, '<&', $fh or croak $!;
 	my $base = $::_repository->temp_acquire("git_blob_${$}_$suffix");
+	# close_file may call temp_acquire on 'svn_hash', but because of the
+	# call chain, if the temp_acquire call from close_file ends up being the
+	# call that first creates the 'svn_hash' temp file, then the FileHandle
+	# that's created as a result will end up in an SVN::Pool that we clear
+	# in SVN::Ra::gs_fetch_loop_common.  Avoid that by making sure the
+	# 'svn_hash' FileHandle is already created before close_file is called.
+	my $tmp_fh = $::_repository->temp_acquire('svn_hash');
+	$::_repository->temp_release($tmp_fh, 1);
 
 	if ($fb->{blob}) {
 		my ($base_is_link, $size);
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 622535e2..32e2f19e 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -391,6 +391,9 @@ sub longest_common_path {
 sub gs_fetch_loop_common {
 	my ($self, $base, $head, $gsv, $globs) = @_;
 	return if ($base > $head);
+	# Make sure the cat_blob open2 FileHandle is created before calling
+	# SVN::Pool::new_default so that it does not incorrectly end up in the pool.
+	$::_repository->_open_cat_blob_if_needed;
 	my $gpool = SVN::Pool->new_default;
 	my $ra_url = $self->url;
 	my $reload_ra = sub {
--
