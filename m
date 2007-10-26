From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 8/9] Git.pm: Add hash_and_insert_object and cat_blob
Date: Fri, 26 Oct 2007 08:11:07 -0700
Message-ID: <20071026151107.GA29522@muzzle>
References: <1193307927-3592-1-git-send-email-aroben@apple.com> <1193307927-3592-2-git-send-email-aroben@apple.com> <1193307927-3592-3-git-send-email-aroben@apple.com> <1193307927-3592-4-git-send-email-aroben@apple.com> <1193307927-3592-5-git-send-email-aroben@apple.com> <1193307927-3592-6-git-send-email-aroben@apple.com> <1193307927-3592-7-git-send-email-aroben@apple.com> <1193307927-3592-8-git-send-email-aroben@apple.com> <1193307927-3592-9-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio Hamano <gitster@pobox.com>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 17:11:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlQqM-0004YX-0E
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 17:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbXJZPLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 11:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbXJZPLL
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 11:11:11 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40291 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751933AbXJZPLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 11:11:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 1F6857DC0FE;
	Fri, 26 Oct 2007 08:11:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1193307927-3592-9-git-send-email-aroben@apple.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62414>

Adam Roben <aroben@apple.com> wrote:
> These functions are more efficient ways of executing `git hash-object -w` and
> `git cat-file blob` when you are dealing with many files/objects.
> 
> Signed-off-by: Adam Roben <aroben@apple.com>
> ---
> Eric Wong wrote:
> > > +package Git::Commands;
> > 
> > Can this be a separate file, or a part of Git.pm?  I'm sure other
> > scripts can eventually use this and I've been meaning to split
> > git-svn.perl into separate files so it's easier to follow.
> 
> I ended up making it part of Git.pm, because I realized that made far more
> sense than splitting it into a separate file.
> 
>  perl/Git.pm |   97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 95 insertions(+), 2 deletions(-)

Hi Adam,

Thanks.

> diff --git a/perl/Git.pm b/perl/Git.pm
> index 46c5d10..f23edef 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -39,6 +39,9 @@ $VERSION = '0.01';
>    my $lastrev = $repo->command_oneline( [ 'rev-list', '--all' ],
>                                          STDERR => 0 );
>  
> +  my $sha1 = $repo->hash_and_insert_object('file.txt');
> +  my $contents = $repo->cat_blob($sha1);

I missed this the first time around.  But I'd rather be able to pass a
file handle to cat_blob for writing, instead of returning a potentially
huge string in memory.

> @@ -675,6 +677,93 @@ sub hash_object {
>  }
>  
>  
> +=item hash_and_insert_object ( FILENAME )
> +
> +Compute the SHA1 object id of the given C<FILENAME> and add the object to the
> +object database.
> +
> +The function returns the SHA1 hash.
> +
> +=cut
> +
> +# TODO: Support for passing FILEHANDLE instead of FILENAME

Filenames are fine for this input since they (are/should be) generated
by File::Temp and not from an untrusted repo.

We should, however assert that the caller of this function
isn't using a stupid filename with "\n" in it.

> +sub hash_and_insert_object {
> +	my ($self, $filename) = @_;
> +
> +	$self->_open_hash_and_insert_object_if_needed();
> +	my ($in, $out) = ($self->{hash_object_in}, $self->{hash_object_out});
> +
> +	print $out $filename, "\n";
> +	chomp(my $hash = <$in>);
> +	return $hash;
> +}
> +
> +sub _open_hash_and_insert_object_if_needed {
> +	my ($self) = @_;
> +
> +	return if defined($self->{hash_object_pid});
> +
> +	($self->{hash_object_pid}, $self->{hash_object_in},
> +	 $self->{hash_object_out}, $self->{hash_object_ctx}) =
> +		command_bidi_pipe(qw(hash-object -w --stdin-paths));
> +}
> +
> +sub _close_hash_and_insert_object {
> +	my ($self) = @_;
> +
> +	return unless defined($self->{hash_object_pid});
> +
> +	my @vars = map { 'hash_object' . $_ } qw(pid in out ctx);

It looks like you're missing a '_' in there.

> +	command_close_bidi_pipe($self->{@vars});
> +	delete $self->{@vars};
> +}
> +


> +=item cat_blob ( SHA1 )
> +
> +Returns the contents of the blob identified by C<SHA1>.
> +
> +=cut
> +
> +sub cat_blob {
> +	my ($self, $sha1) = @_;
> +
> +	$self->_open_cat_blob_if_needed();
> +	my ($in, $out) = ($self->{cat_blob_in}, $self->{cat_blob_out});
> +
> +	print $out $sha1, "\n";
> +	chomp(my $size = <$in>);
> +
> +	my $blob;
> +	my $result = read($in, $blob, $size);
> +	defined $result or carp $!;
> +
> +	# Skip past the trailing newline.
> +	read($in, my $newline, 1);
> +
> +	return $blob;
> +}

However, I'd very much like to be able to pass a file handle to this
function.  This should read()/print() to a file handle passed to it in a
loop rather than slurping all of $size at once, since the files we're
receiving can be huge.

I'd also be happier if we checked that we actually read $size bytes in
the loop, and that $newline is actually "\n" to safeguard against bugs
in cat-blob.

> +sub _open_cat_blob_if_needed {
> +	my ($self) = @_;
> +
> +	return if defined($self->{cat_blob_pid});
> +
> +	($self->{cat_blob_pid}, $self->{cat_blob_in},
> +	 $self->{cat_blob_out}, $self->{cat_blob_ctx}) =
> +		command_bidi_pipe(qw(cat-file blob --stdin));
> +}
> +
> +sub _close_cat_blob {
> +	my ($self) = @_;
> +
> +	return unless defined($self->{cat_blob_pid});
> +
> +	my @vars = map { 'cat_blob' . $_ } qw(pid in out ctx);

It looks like you're missing a '_' here, too.

> +	command_close_bidi_pipe($self->{@vars});
> +	delete $self->{@vars};
> +}
>  

One more nit, I'm a bit paranoid, but I personally like to die/croak if
the result of every print()/syswrite() to make sure the pipe we're
writing to didn't die or if there were other error indicators.

Hopefully that's the last of tweaks I'd like to see :)

-- 
Eric Wong
