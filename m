From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH] gitweb: Add an option for adding more branch refs
Date: Wed, 27 Nov 2013 16:34:42 +0100
Message-ID: <1385566482.2131.22.camel@localhost.localdomain>
References: <1385462243-7898-1-git-send-email-krzesimir@endocode.com>
	 <xmqqr4a2vnqd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 16:34:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlh8d-00069t-3M
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 16:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756443Ab3K0Per convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Nov 2013 10:34:47 -0500
Received: from mail-bk0-f49.google.com ([209.85.214.49]:41213 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab3K0Pep (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 10:34:45 -0500
Received: by mail-bk0-f49.google.com with SMTP id my13so3259441bkb.22
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 07:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=kFxNdIRES4QoSatSaX8yZs4RC1UIhrC7F4uo4HSEOHU=;
        b=GdR1GYne269KxGYX3dIdWH1jPAeH3/zU96Uyfrma4LnwYryL0ywZvkAbMtcoZcVknH
         f6Pf2+6QMAil7gY8r8yeUYSI7EE09BAOuaWHT4KbBxEeFF4GUcXK1O0cnm5MatnT2nkY
         BZSJeEMXBHnbfj+G468nzkcQHl2m7GCnkdopCmk/Dq716uaJS+aA6I/qQt3R++P+tg30
         tqjD56s1MVfEmG/ooAgYj/vwDzvcmNFkaNfnDSZx8JIg7HCNAlJn8F0QhrhwYwXNaHxT
         DJ14GREqVu+K2dLB8rLEZcHyvk5I9XmiaeDx9LseIcVkiURfjROPtb3yir8w0kFCwkF3
         gGhQ==
X-Gm-Message-State: ALoCoQm5S0IazUiEfETp7DhevzwuWvLWgaPsRfdZ4X0i288+LqyPW5Y1gn32lh2P1VZXTqb971iV
X-Received: by 10.205.14.69 with SMTP id pp5mr31426180bkb.14.1385566484342;
        Wed, 27 Nov 2013 07:34:44 -0800 (PST)
Received: from [192.168.1.100] (95-91-241-74-dynip.superkabel.de. [95.91.241.74])
        by mx.google.com with ESMTPSA id qg7sm55961079bkb.6.2013.11.27.07.34.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 27 Nov 2013 07:34:43 -0800 (PST)
In-Reply-To: <xmqqr4a2vnqd.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238442>

On Tue, 2013-11-26 at 13:48 -0800, Junio C Hamano wrote:
> Krzesimir Nowak <krzesimir@endocode.com> writes:
>=20
> > Overriding an @additional_branch_refs configuration variable with
> > value ('wip') will make gitweb to show branches that appear in
> > refs/heads and refs/wip (refs/heads is hardcoded). Might be useful =
for
> > gerrit setups where user branches are not stored under refs/heads/.
> >
> > Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> > ---
> >  gitweb/gitweb.perl | 99 ++++++++++++++++++++++++++++++++++++++++--=
------------
> >  1 file changed, 74 insertions(+), 25 deletions(-)
> >
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 68c77f6..9bfd38b 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -17,6 +17,7 @@ use Encode;
> >  use Fcntl ':mode';
> >  use File::Find qw();
> >  use File::Basename qw(basename);
> > +use List::Util qw(min);
> >  use Time::HiRes qw(gettimeofday tv_interval);
> >  binmode STDOUT, ':utf8';
> > =20
> > @@ -122,6 +123,10 @@ our $logo_label =3D "git homepage";
> >  # source of projects list
> >  our $projects_list =3D "++GITWEB_LIST++";
> > =20
> > +# list of additional "directories" under "refs/" we want to displa=
y as
> > +# branches
> > +our @additional_branch_refs =3D ();
> > +
> >  # the width (in characters) of the projects list "Description" col=
umn
> >  our $projects_list_description_width =3D 25;
> > =20
> > @@ -626,14 +631,29 @@ sub feature_avatar {
> >  	return @val ? @val : @_;
> >  }
> > =20
> > +sub get_branch_refs {
> > +    return ('heads', @additional_branch_refs);
> > +}
> > +
> >  # checking HEAD file with -e is fragile if the repository was
> >  # initialized long time ago (i.e. symlink HEAD) and was pack-ref'e=
d
> >  # and then pruned.
> >  sub check_head_link {
> >  	my ($dir) =3D @_;
> >  	my $headfile =3D "$dir/HEAD";
> > -	return ((-e $headfile) ||
> > -		(-l $headfile && readlink($headfile) =3D~ /^refs\/heads\//));
> > +
> > +	if (-e $headfile) {
> > +		return 1;
> > +	}
> > +	if (-l $headfile) {
> > +		my $rl =3D readlink($headfile);
> > +
> > +		for my $ref (get_branch_refs()) {
> > +			return 1 if $rl =3D~ /^refs\/$ref\//;
> > +		}
> > +	}
> > +	return 0;
>=20
> The change to this function is wrong. A non-detached HEAD that
> points at anything other than refs/heads/ should be considered a
> repository corruption and should not be encouraged.

Ok, I'll get rid of it.

>=20
> > @@ -2515,6 +2535,7 @@ sub format_snapshot_links {
> >  sub get_feed_info {
> >  	my $format =3D shift || 'Atom';
> >  	my %res =3D (action =3D> lc($format));
> > +	my $matched_ref =3D 0;
> > =20
> >  	# feed links are possible only for project views
> >  	return unless (defined $project);
> > @@ -2522,12 +2543,17 @@ sub get_feed_info {
> >  	# or don't have specific feed yet (so they should use generic)
> >  	return if (!$action || $action =3D~ /^(?:tags|heads|forks|tag|sea=
rch)$/x);
> > =20
> > -	my $branch;
> > -	# branches refs uses 'refs/heads/' prefix (fullname) to different=
iate
> > -	# from tag links; this also makes possible to detect branch links
> > -	if ((defined $hash_base && $hash_base =3D~ m!^refs/heads/(.*)$!) =
||
> > -	    (defined $hash      && $hash      =3D~ m!^refs/heads/(.*)$!))=
 {
> > -		$branch =3D $1;
> > +	my $branch =3D undef;
> > +	# branches refs uses 'refs/' + $get_branch_refs()[x] + '/' prefix
> > +	# (fullname) to differentiate from tag links; this also makes
> > +	# possible to detect branch links
> > +	for my $ref (get_branch_refs()) {
> > +		if ((defined $hash_base && $hash_base =3D~ m!^refs/$ref/(.*)$!) =
||
> > +		    (defined $hash      && $hash      =3D~ m!^refs/$ref/(.*)$!))=
 {
> > +			$branch =3D $1;
> > +			$matched_ref =3D $ref;
> > +			last;
> > +		}
> >  	}
> >  	# find log type for feed description (title)
> >  	my $type =3D 'log';
> > @@ -2540,7 +2566,7 @@ sub get_feed_info {
> >  	}
> > =20
> >  	$res{-title} =3D $type;
> > -	$res{'hash'} =3D (defined $branch ? "refs/heads/$branch" : undef)=
;
> > +	$res{'hash'} =3D (defined $branch ? "refs/$matched_ref/$branch" :=
 undef);
> >  	$res{'file_name'} =3D $file_name;
>=20
> OK.
>=20
> > @@ -3184,24 +3210,43 @@ sub git_get_project_owner {
> >  	return $owner;
> >  }
> > =20
> > -sub git_get_last_activity {
> > -	my ($path) =3D @_;
> > -	my $fd;
> > +sub git_get_last_activity_age {
> > +	my ($refs) =3D @_;
> > +	my $fd =3D -1;
> > =20
> > -	$git_dir =3D "$projectroot/$path";
> >  	open($fd, "-|", git_cmd(), 'for-each-ref',
> >  	     '--format=3D%(committer)',
> >  	     '--sort=3D-committerdate',
> >  	     '--count=3D1',
> > -	     'refs/heads') or return;
> > +	     $refs) or return undef;
> > +
> >  	my $most_recent =3D <$fd>;
> > -	close $fd or return;
> > +	close $fd or return undef;
> >  	if (defined $most_recent &&
> >  	    $most_recent =3D~ / (\d+) [-+][01]\d\d\d$/) {
> >  		my $timestamp =3D $1;
> > -		my $age =3D time - $timestamp;
> > -		return ($age, age_string($age));
> > +		return time - $timestamp;
> >  	}
> > +
> > +	return undef;
> > +}
> > +
> > +sub git_get_last_activity {
> > +	my ($path) =3D @_;
> > +	my @ages =3D ();
> > +
> > +	$git_dir =3D "$projectroot/$path";
> > +	for my $ref (get_branch_refs()) {
> > +		my $age =3D git_get_last_activity_age('refs/' . $_);
> > +
> > +		push @ages, $age if defined $age;
> > +	}
> > +	if (@ages) {
> > +		my $min_age =3D min(@ages);
> > +
> > +		return ($min_age, age_string($min_age));
> > +	}
> > +
> >  	return (undef, undef);
> >  }
>=20
> The original runs
>=20
> 	for-each-ref --count=3D1 refs/heads
>=20
> and picks the latest one, so shouldn't it be the matter of running
>=20
> 	for-each-ref --count=3D1 refs/heads refs/extra
>=20
> i.e. something like
>=20
> @@ -3193,7 +3193,7 @@ sub git_get_last_activity {
>  	     '--format=3D%(committer)',
>  	     '--sort=3D-committerdate',
>  	     '--count=3D1',
> -	     'refs/heads') or return;
> +	     map { "refs/$_" } get_branch_refs()) or return;
>  	my $most_recent =3D <$fd>;
>  	close $fd or return;
>  	if (defined $most_recent &&
>=20
> to grab the latest among the refs you care about?

That's simpler, yes.

>=20
> > @@ -3223,7 +3268,7 @@ sub git_get_remotes_list {
> >  		next if $wanted and not $remote eq $wanted;
> >  		my ($url, $key) =3D ($1, $2);
> > =20
> > -		$remotes{$remote} ||=3D { 'heads' =3D> () };
> > +		$remotes{$remote} ||=3D { map { $_ =3D> () } get_branch_refs() }=
;
> >  		$remotes{$remote}{$key} =3D $url;
> >  	}
> >  	close $fd or return;
> > @@ -3237,9 +3282,11 @@ sub fill_remote_heads {
> >  	my @heads =3D map { "remotes/$_" } keys %$remotes;
> >  	my @remoteheads =3D git_get_heads_list(undef, @heads);
> >  	foreach my $remote (keys %$remotes) {
> > -		$remotes->{$remote}{'heads'} =3D [ grep {
> > -			$_->{'name'} =3D~ s!^$remote/!!
> > -			} @remoteheads ];
> > +		foreach my $ref (get_branch_refs()) {
> > +			$remotes->{$remote}{$ref} =3D [ grep {
> > +				$_->{'name'} =3D~ s!^$remote/!!
> > +				} @remoteheads ];
> > +		}
> >  	}
> >  }
>=20
> Hmmm, why?  Aren't these additional ones about the local
> "branch-like" refs?  What makes us think that these names are also
> shared with the names from remote hierarchies?

Might be another place where I had no clue if the change is right.
Sorry.

>=20
> > @@ -3644,7 +3691,7 @@ sub parse_from_to_diffinfo {
> > =20
> >  sub git_get_heads_list {
> >  	my ($limit, @classes) =3D @_;
> > -	@classes =3D ('heads') unless @classes;
> > +	@classes =3D get_branch_refs() unless @classes;
> >  	my @patterns =3D map { "refs/$_" } @classes;
> >  	my @headslist;
> > =20
> > @@ -3662,7 +3709,8 @@ sub git_get_heads_list {
> >  		my ($committer, $epoch, $tz) =3D
> >  			($committerinfo =3D~ /^(.*) ([0-9]+) (.*)$/);
> >  		$ref_item{'fullname'}  =3D $name;
> > -		$name =3D~ s!^refs/(?:head|remote)s/!!;
> > +		my $strip_refs =3D join '|', get_branch_refs();
> > +		$name =3D~ s!^refs/(?:$strip_refs|remotes)/!!;
> > =20
> >  		$ref_item{'name'}  =3D $name;
> >  		$ref_item{'id'}    =3D $hash;
> > @@ -4286,7 +4334,7 @@ sub git_print_page_nav {
> >  # available if the feature is enabled
> >  sub format_ref_views {
> >  	my ($current) =3D @_;
> > -	my @ref_views =3D qw{tags heads};
> > +	my @ref_views =3D ('tags', get_branch_refs());

I'll get rid of that change, too. I just verified that it is wrong too.

> >  	push @ref_views, 'remotes' if gitweb_check_feature('remote_heads'=
);
> >  	return join " | ", map {
> >  		$_ eq $current ? $_ :
> > @@ -7179,7 +7227,8 @@ sub snapshot_name {
> >  		$ver =3D $1;
> >  	} else {
> >  		# branches and other need shortened SHA-1 hash
> > -		if ($hash =3D~ m!^refs/(?:heads|remotes)/(.*)$!) {
> > +		my $strip_refs =3D join '|', get_branch_refs();
> > +		if ($hash =3D~ m!^refs/(?:$strip_refs|remotes)/(.*)$!) {
> >  			$ver =3D $1;
> >  		}
> >  		$ver .=3D '-' . git_get_short_hash($project, $hash);
>=20
> As the elements of @additional_branch_refs are expected by code
> added by this patch to never have any special metacharacters in
> them, it probably is a good idea to sanity check it to catch
> misconfigurations and typos before doing anything else.
>=20

I assume that in case of misconfiguration we are returning 500.

I added a sanity checking for duplicate refs, for explicitly specified
'heads' and refs that fail to pass the validate_ref (which I splitted
from validate_refname).

As for metacharacters - valid ref can contain a '|' which is a
metacharacter in regex, so I wrapped some uses of
@additional_branch_refs members in regexes into \Q and \E or used a
quotemeta on them. That escapes metacharacters.

Also, I added some docs to gitweb.conf.txt.

Patch in "[PATCH v2] gitweb: Add an option for adding more branch refs"

> Other than that, looks good to me.
>=20
> Thanks.

--=20
Krzesimir Nowak
Software Developer
Endocode AG

krzesimir@endocode.com

------
Endocode AG, Johannisstra=C3=9Fe 20, 10117 Berlin
info@endocode.com | www.endocode.com

Vorstandsvorsitzender: Mirko Boehm
Vorst=C3=A4nde: Dr. Karl Beecher, Chris K=C3=BChl, Sebastian Sucker
Aufsichtsratsvorsitzende: Jennifer Beecher

Registergericht: Amtsgericht Charlottenburg - HRB 150748 B
