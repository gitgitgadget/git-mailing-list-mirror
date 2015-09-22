From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: RE: [PATCH] git-svn: make batch mode optional for git-cat-file
Date: Tue, 22 Sep 2015 03:47:45 -0700
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9D8@mail.accesssoftek.com>
References: <1442843498-22908-1-git-send-email-vleschuk@accesssoftek.com>,<xmqqeghraauu.fsf@gitster.mtv.corp.google.com>,<6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9D6@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 12:50:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeL9j-0004Nf-D5
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 12:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757637AbbIVKuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 06:50:35 -0400
Received: from mail.accesssoftek.com ([12.202.173.171]:30575 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757419AbbIVKue convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Sep 2015 06:50:34 -0400
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Tue, 22 Sep 2015 03:50:16 -0700
Thread-Topic: [PATCH] git-svn: make batch mode optional for git-cat-file
Thread-Index: AdD0m8bdz5rcP1t/TkOXjv/23qOXjgAG49gfABsxw48=
In-Reply-To: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9D6@mail.accesssoftek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278390>

As for your remark regarding the option naming: 

> An option whose name begins with no- looks somewhat strange.  You
can even say --no-no-cat-file-batch from the command line, I
suspect.

We already do have some of these: 'no-metadata', 'no-checkout', 'no-auth-cache'. So I was just following the existing convention. Do you think we need to change it and stick with --catch-file-batch=1/--cat-file-batch=0 ?

--
Best Regards,
Victor
________________________________________
From: Victor Leschuk
Sent: Monday, September 21, 2015 3:03 PM
To: Junio C Hamano
Cc: git@vger.kernel.org
Subject: RE: [PATCH] git-svn: make batch mode optional for git-cat-file

Hello Junio,

thanks for your review. First of all I'd like to apologize for sending the patch without description. Actually I was in a hurry and sent it by accident: I planned to edit the mail before sending...

Here is the detailed description:

Last week we had a quick discussion in this mailing list: http://thread.gmane.org/gmane.comp.version-control.git/278021 .

The thing is that git-cat-file keeps growing during work when running in "batch" mode. See the figure attached: it is for cloning a rather small repo (1 hour to clone about ~14000 revisions). However the clone of a large repo (~280000 revisions) took about 2 weeks and git-cat-file has outgrown the parent perl process several times (git-cat-file - ~3-4Gb, perl - 400Mb).

What was done:
 * I have run it under valgrind and mtrace and haven't found any memory leaks
 * Found the source of most number of memory reallocations (batch_object_write() function (strbuf_expand -> realloc)) - tried to make the streambuf object static and avoid reallocs - didn't help
 * Tried preloading other allocators than standard glibc - no significant difference

After that I replaced the batch mode with separate cat-file calls for each blob and it didn't have any impact on clone performance on real code repositories. However I created a fake test repo with large number of small files (~10 bytes each): here is how I created it https://bitbucket.org/vleschuk/svngenrepo

And on this artificial test repo it really slowed down the process. So I decided to suggest to make the batch mode optional to let the user "tune" the process and created a patch for this.

As for your code-style notes, I agree with them, will adjust the code.

--
Best Regards,
Victor
________________________________________
From: Junio C Hamano [jch2355@gmail.com] On Behalf Of Junio C Hamano [gitster@pobox.com]
Sent: Monday, September 21, 2015 11:25 AM
To: Victor Leschuk
Cc: git@vger.kernel.org; Victor Leschuk
Subject: Re: [PATCH] git-svn: make batch mode optional for git-cat-file

Victor Leschuk <vleschuk@gmail.com> writes:

> Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
> ---

Before the S-o-b line is a good place to explain why this is a good
change to have.  Please use it.

>  git-svn.perl |  1 +
>  perl/Git.pm  | 41 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 36f7240..b793c26 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -139,6 +139,7 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
>               'use-log-author' => \$Git::SVN::_use_log_author,
>               'add-author-from' => \$Git::SVN::_add_author_from,
>               'localtime' => \$Git::SVN::_localtime,
> +             'no-cat-file-batch' => sub { $Git::no_cat_file_batch = 1; },

An option whose name begins with no- looks somewhat strange.  You
can even say --no-no-cat-file-batch from the command line, I
suspect.

Why not give an option 'cat-file-batch' that sets the variable
$Git::cat_file_batch to false, and initialize the variable to true
to keep existing users who do not pass the option happy?

>               %remote_opts );
>
>  my ($_trunk, @_tags, @_branches, $_stdlayout);
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 19ef081..69e5293 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -107,6 +107,7 @@ use Fcntl qw(SEEK_SET SEEK_CUR);
>  use Time::Local qw(timegm);
>  }
>
> +our $no_cat_file_batch = 0;
>
>  =head1 CONSTRUCTORS
>
> @@ -1012,6 +1013,10 @@ returns the number of bytes printed.
>  =cut
>
>  sub cat_blob {
> +     (1 == $no_cat_file_batch) ? _cat_blob_cmd(@_) : _cat_blob_batch(@_);

Discard "1 ==" here.  You are clearly using the variable as a
boolean, so writing this as

        $cat_file_batch ? _cat_blob_batch(@_) : _cat_blob_cmd(@_);

or better yet

        if ($cat_file_batch) {
                _cat_blob_batch(@_);
        } else {
                _cat_blob_cmd(@_);
        }

would be more natural.

> +}
> +
> +sub _cat_blob_batch {
>       my ($self, $sha1, $fh) = @_;
>
>       $self->_open_cat_blob_if_needed();
> @@ -1072,7 +1077,7 @@ sub cat_blob {
>  sub _open_cat_blob_if_needed {
>       my ($self) = @_;
>
> -     return if defined($self->{cat_blob_pid});
> +     return if ( defined($self->{cat_blob_pid}) || 1 == $no_cat_file_batch );

Likewise.

        return if (!$cat_file_batch);
        return if defined($self->{cat_blob_pid});

> +sub _cat_blob_cmd {
> +     my ($self, $sha1, $fh) = @_;
> +...

The biggest thing that is missing from this patch is the explanation
of why this is a good thing to do.  The batch interface was invented
because people found that it was wasteful to spawn a new cat-file
process every time the contents of a blob is needed and wanted to
avoid it, and this new feature gives the user a way to tell Git to
do things in a "wasteful" way, so there must be a reason why the
user would want to use the "wasteful" way, perhaps work around some
other issue.  Without explaining that in the documentation what that
issue is, i.e. telling users who reads "git svn --help" when and why
the option might help them, nobody would use the feature to benefit
from it.

I wonder if "cat-file --batch" is leaky and bloats after running for
a while.  If that is the case, I have to wonder if "never do batch"
like this patch does is a sensible way forward.  Instead, "recycle
and renew the process after running it for N requests" (and ideally
auto-adjust that N without being told by the user) might be a better
way to do what you are trying to achieve, but as I already said, I
cannot read the motivation behind this change that is not explained,
so...
