From: jcorbin@node1.wunjo.org (Joshua T. Corbin)
Subject: semi-useful git perl file
Date: Mon, 2 May 2005 01:33:49 -0400
Message-ID: <20050502053349.GF31862@node1.wunjo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
X-From: git-owner@vger.kernel.org Mon May 02 07:28:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSTTq-00082w-Pb
	for gcvg-git@gmane.org; Mon, 02 May 2005 07:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVEBFea (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 01:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVEBFea
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 01:34:30 -0400
Received: from node1.wunjo.org ([64.62.190.230]:31171 "EHLO node1.wunjo.org")
	by vger.kernel.org with ESMTP id S261716AbVEBFdv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 01:33:51 -0400
Received: by node1.wunjo.org (Postfix, from userid 1001)
	id 363B0436D6; Mon,  2 May 2005 01:33:50 -0400 (EDT)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've been playing around with driving git from perl land. The attached
allows you to easily access git objects from perl as:

	tie %git, 'GIT::ObjectDB';
	print Dumper( $git{ $commit_id } );

Looks like:
{
	type    => 'commit',
	sha     => $commit_id,
	tree    => '0000000000000000000000000000000000000000',
	parents => [ ... ],
	mess    => "\nbla bla bla\n"
}

And corresponding for trees, tags, and blobs.

If you want to see use of this in action, you can pull my (incomplete)
translation of cogito into perl from:

	http://node1.wunjo.org/~jcorbin/yagf.git

	or

	rsync://node1.wunjo.org/yagf.git

Josh

--uAKRQypu60I7Lcqm
Content-Type: text/x-perl; charset=us-ascii
Content-Disposition: attachment; filename="GIT.pm"

package GIT;
use strict;
our %cmd;

sub cmdpath {
	my $cmd = shift;
	unless ( defined $cmd{$cmd} ) {
		local $/ = "\n";
		chomp( $cmd{$cmd} = `which $cmd` );
		return undef if $cmd{$cmd} eq '';
	}
	return $cmd{$cmd};
}

sub cmd {
	my $cmd = shift;
	cmdpath( $cmd ) || die "command '$cmd' not found\n";
	my $r = system( $cmd{$cmd}, @_ );
	die "$cmd failed: " . cmderrmsg( $cmd ) . "\n"
		if $r != 0;
	return 1;
}

sub cmdinout {
	my $infh = shift;
	my $cmd = shift;
	cmdpath( $cmd ) || die "command '$cmd' not found\n";
	my ( $r, $w );
	pipe( $r, $w ) || die "Failed to pipe: $!";
	my $pid = fork();
	die "Failed to fork: $!" unless defined $pid;
	if ( $pid ) {
		close $w;
		my $kid = waitpid( $pid, 0 );
		die "Hmm, auto reaping in place?" if $kid == -1;
		die "$cmd failed: " . cmderrmsg( $cmd ) . "\n"
			if $? & 127 || $? >> 8 != 0;
		local $/;
		local $_ = <$r>;
		close $r;
		if ( wantarray ) {
			return split( "\n", $_ );
		} else {
			return $_;
		}
	} else {
		close $r;
		close STDOUT;
		close STDIN;
		open STDIN, '<&', $infh || die "Failed to rediret STDIN";
		open STDOUT, '>&', $w || die "Failed to redirect STDOUT";
		exec( $cmd{$cmd}, @_ );
	}
}

sub cmdout {
	my $callback = shift if ref $_[0] eq 'CODE';
	my $cmd = shift;
	cmdpath( $cmd ) || die "command '$cmd' not found\n";
	my ( $r, $w );
	pipe( $r, $w ) || die "Failed to pipe: $!";
	my $pid = fork();
	die "Failed to fork: $!" unless defined $pid;
	if ( $pid ) {
		close $w;
		if ( defined $callback ) {
			local $_;
			while ( <$r> ) {
				if ( &$callback() ) {
					kill 15, $pid;
					last;
				}
			}
			close $r;
			waitpid( $pid, 0 );
			return 1;
		} else {
			my $kid = waitpid( $pid, 0 );
			die "Hmm, auto reaping in place?" if $kid == -1;
			die "$cmd failed: " . cmderrmsg( $cmd ) . "\n"
				if $? & 127 || $? >> 8 != 0;
			if ( wantarray ) {
				my @r = <$r>;
				close $r;
				chomp @r;
				return @r;
			} else {
				local $/;
				my $r = <$r>;
				close $r;
				return $r;
			}
		}
	} else {
		close $r;
		close STDOUT;
		open STDOUT, '>&', $w || die "Failed to redirect STDOUT";
		exec( $cmd{$cmd}, @_ );
	}
}

sub cmderrmsg {
	my $cmd = shift;
	my $e;
	if ( $? == -1 ) {
		$e = "failed to execute $cmd{$cmd}: $!";
	} elsif ( $? & 127 ) {
		$e = sprintf( 'child died from signal %d', ( $? & 127 ) );
		$e .= ' (with coredump)' if $? & 128;
	} else {
		$e = sprintf( 'child exit value: %d', $? >> 8 );
	}
	return $e;
}

package GIT::ObjectDB;
use strict;
# Cache this many commit/tree/tag objects, blobs are not cached because they are (possibly) huge.
our $CacheMax = 20;
our $MissingFatal;
use Carp qw( croak );

sub TIEHASH {
	my ( $class, $dir ) = @_;
	$dir ||= $ENV{SHA1_FILE_DIRECTORY} || '.git/objects';
	$ENV{SHA1_FILE_DIRECTORY} = $dir
		if $dir ne '.git/objects';

	( -d $dir ) || croak "No such directory $dir";
	bless my $self = {
		dir    => $dir,
		types  => {},
		cache  => {}, # What we're caching
		cachea => []  # The order we cached it in so
	} => $class;
	return $self;
}

sub FETCH {
	my ( $self, $key ) = @_;
	croak "Invalid sha1 key '$key'" unless $key =~ /^[A-Za-z0-9]{40}$/;
	return $self->{ cache }->{ $key }
		if defined $self->{ cache }->{ $key };
	my $type = $self->objectType( $key );
	unless ( defined $type ) {
		die "no such object $key" if $MissingFatal;
		return undef;
	}

	if ( $type eq 'blob' ) {
		return new GIT::ObjectDB::Blob( $key );
	} else {
		if ( $type eq 'tree' ) {
			$self->{ cache }->{ $key } =
				GIT::ObjectDB::Tree->new_fromkey( $key );
		} elsif ( $type eq 'commit' ) {
			$self->{ cache }->{ $key } =
				GIT::ObjectDB::Commit->new_fromkey( $key );
		} elsif ( $type eq 'tag' ) {
			$self->{ cache }->{ $key } =
				GIT::ObjectDB::Tag->new_fromkey( $key );
		} else {
			croak "Unrecognized object($key) type '$type'";
		}
		push @{ $self->{ cachea } }, $key;
		while ( scalar @{ $self->{ cachea } } > $CacheMax ) {
			my $k = shift @{ $self->{ cachea } };
			delete $self->{ cache }->{ $k };
		}
		return $self->{ cache }->{ $key };
	}
}

sub STORE {
	my ( $self, $key, $value ) = @_;
	croak "Will not overwrite an object"
		if defined $self->objectType( $key );
	if ( UNIVERSAL::isa( $value, 'GIT::ObjectDB::Commit' ) ) {
		my $mess = $value->{ mess };
		$mess =~ /^\s*$/s && croak "Won't commit an empty message";
		my $fh;
		open $fh, '<', \$mess;
		chomp( $value->{ sha } = GIT::cmdinout( $fh,
			'git-commit-tree', $value->{ tree },
			map { ( '-p', $_ ) } @{ $value->{ parents } }
		) );
		close $fh;
	} elsif ( UNIVERSAL::isa( $value, 'GIT::ObjectDB::Tag' ) ) {
		my $type = $self->objectType( $value->{ object } ) ||
			croak "No such object $value->{object}";
		croak "Tagging a tag?" if $type eq 'tag';
		my $tag =
			"object $value->{object}\n" .
			"type $type\n" .
			"tag $value-{tag}\n" .
			$value->{ sig };
		my $fh;
		open $fh, '<', \$tag;
		chomp( $value->{ sha } = GIT::cmdinout( $fh, 'git-mktag' ) );
		close $fh;
	} else {
		croak "Only support storing commits and tags";
	}
	push @{ $self->{ cachea } },
		$self->{ cache }->{ $value->{ sha } } = $value;
	while ( scalar @{ $self->{ cachea } } > $CacheMax ) {
		my $k = shift @{ $self->{ cachea } };
		delete $self->{ cache }->{ $k };
	}
}

sub EXISTS {
	my ( $self, $key ) = @_;
	return defined( $self->objectType( $key ) ) ? 1 : 0;
}

sub FIRSTKEY {
	my ( $self ) = @_;
	if ( defined $self->{ dh } ) {
		closedir $self->{ dh };
		delete $self->{ dh };
	}
	$self->{ i } = -1;
	return $self->NEXTKEY;
}

sub NEXTKEY {
	my ( $self ) = @_;
	my $r;
	until ( defined $r ) {
		if ( defined $self->{ dh } ) {
			$r = readdir $self->{ dh };
			unless ( defined $r ) {
				closedir $self->{ dh };
				delete $self->{ dh };
				next;
			}
			$r = undef if $r !~ /^[A-Za-z0-9]{38}$/;
			$r = sprintf( '%02x%s', $self->{ i }, $r ) if defined $r;
		} else {
			$self->{ i }++;
			last if $self->{ i } > 0xff;
			my $dh;
			my $dir = sprintf( '%s/%02x', $self->{ dir }, $self->{ i } );
			opendir $dh, $dir ||
				die "Failed to opendir $dir: $!";
			$self->{ dh } = $dh;
			next;
		}
	}
	return $r;
}

sub SCALAR {
	my ( $self ) = @_;
	return $self->{ dir };
}

sub UNTIE {
	my ( $self ) = @_;
	closedir $self->{ dh } if defined $self->{ dh };
}

sub objectType {
	my ( $self, $key ) = @_;
	eval {
		chomp(
			( $self->{ types }->{ $key } ) =
				GIT::cmdout( 'git-cat-file', '-t', $key )
		) unless defined $self->{ types }->{ $key };
	};
	return undef if $@;
	return $self->{ types }->{ $key };
}

package GIT::ObjectDB::Blob;
use strict;

sub new {
	my ( $class, $key ) = @_;
	bless {
		type => 'blob',
		sha => $key
	} => $class;
}

sub contents {
	my ( $self ) = @_;
	return GIT::cmdout( 'git-cat-file', 'blob', $self->{ sha } );
}

sub write_to_filehandle {
	my ( $self, $fh ) = @_;
	GIT::cmdout( sub {
		print $fh $_;
		return 0;
	}, 'git-cat-file', 'blob', $self->{ sha } );
	return 1;
}

package GIT::ObjectDB::Commit;
use strict;
use Carp qw( croak );

sub new {
	my $class   = shift;
	my $mess    = shift          || croak "Missing message";
	my $tree    = shift          || croak "Missing tree";
	$tree =~ /^[A-Za-z0-9]{40}$/ || croak "Invalid tree id";
	my @parents = @_             or croak "Missing parent(s)";
	for my $parent ( @parents ) {
		$parent =~ /^[A-Za-z0-9]{40}$/ || croak "Invalid parent id '$parent'";
	}

	return bless {
		type    => 'commit',
		parents => \@parents,
		tree    => $tree,
		mess    => $mess
	} => $class;
}

sub new_fromkey {
	my ( $class, $key ) = @_;
	bless my $self = {
		type    => 'commit',
		sha     => $key,
		parents => [],
		mess    => ''
	} => $class;

	local $/ = "\n";
	my $no_more_parents;
	GIT::cmdout( sub {
		chomp;
		if ( ! defined $self->{ tree } && /^tree ([A-Za-z0-9]{40})$/ ) {
			$self->{ tree } = $1;
		} elsif ( ! $no_more_parents && /^parent ([A-Za-z0-9]{40})$/ ) {
			push @{ $self->{ parents } }, $1;
		} else {
			$no_more_parents = 1;
			if ( ! defined $self->{ author } && /^author (.+) (\d+ [-+]\d{4})$/ ) {
				$self->{ author } = [ $1, $2 ];
			} elsif ( ! defined $self->{ committer } && /^committer (.+) (\d+ [-+]\d{4})$/ ) {
				$self->{ committer } = [ $1, $2 ];
			} else {
				$self->{ mess } .= "$_\n";
			}
		}
		return 0;
	}, 'git-cat-file', 'commit', $key );

	return $self;
}

package GIT::ObjectDB::Tree;
use strict;

sub new_fromkey {
	my ( $class, $key ) = @_;

	bless my $self = {
		type => 'tree',
		sha  => $key,
		ent  => []
	} => $class;

	my $raw = GIT::cmdout( 'git-cat-file', 'tree', $key );

	my @raw = unpack( '(Z*H40)*', $raw ); 
	$raw = undef;
	while ( @raw ) {
		push @{ $self->{ ent } },
			[ split( ' ', shift @raw, 2 ), shift @raw ];
	}

	return $self;
}

package GIT::ObjectDB::Tag;
use strict;
use Carp qw( croak );

sub new {
	my $class  = shift;
	my $object = shift             || croak "Missing object";
	$object =~ /^[A-Za-z0-9]{40}$/ || croak "Invalid object id";
	my $tag    = shift             || croak "Missing tag";
	my $sig    = shift             || croak "Missing signature";

	return bless {
		type   => 'tag',
		object => $object,
		tag    => $tag,
		sig    => $sig
	} => $class;
}

sub new_fromkey {
	my ( $class, $key ) = @_;
	bless my $self = {
		type => 'tag',
		sha  => $key,
		sig  => ''
	} => $class;
  
	local $/ = "\n";
	GIT::cmdout( sub {
		if ( /^object ([A-Za-z0-9]{40})$/ ) {
			$self->{ object } = $1;
		} elsif ( /^type (.+)$/ ) {
			$self->{ object_type } = $1;
		} elsif ( /^tag (.+)$/ ) {
			$self->{ tag } = $1;
		} else {
			$self->{ sig } .= $_;
		}
		return 0;
	}, 'git-cat-file', 'tag', $key );

	return $self;
}

--uAKRQypu60I7Lcqm--
