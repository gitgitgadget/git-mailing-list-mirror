From: Stefan Sperling <stsp@elego.de>
Subject: [PATCH] really plug memory leaks in git-svnimport
Date: Fri, 27 Jul 2007 15:09:41 +0200
Message-ID: <20070727130941.GB55326@ted.stsp.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Cc: subversion@elego.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 15:10:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEPa7-0005Nq-MO
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 15:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbXG0NKI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 09:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbXG0NKI
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 09:10:08 -0400
Received: from fallback-mx.in-berlin.de ([192.109.42.17]:36268 "EHLO
	hirscho.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbXG0NKF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 09:10:05 -0400
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	by fallback-mx.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l6RDA4XR011720
	for <git@vger.kernel.org>; Fri, 27 Jul 2007 15:10:04 +0200
X-Envelope-From: stsp@elego.de
Received: from stsp.lan (stsp.in-vpn.de [217.197.85.96])
	(authenticated bits=128)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l6RD9xXf004377
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 27 Jul 2007 15:09:59 +0200
Received: from ted.stsp.lan (localhost [127.0.0.1])
	by stsp.lan (8.13.8/8.13.8) with ESMTP id l6RD9fOc055593;
	Fri, 27 Jul 2007 15:09:41 +0200 (CEST)
	(envelope-from stsp@elego.de)
Received: (from stsp@localhost)
	by ted.stsp.lan (8.13.8/8.13.8/Submit) id l6RD9fOq055592;
	Fri, 27 Jul 2007 15:09:41 +0200 (CEST)
	(envelope-from stsp@elego.de)
X-Authentication-Warning: ted.stsp.lan: stsp set sender to stsp@elego.de using -f
Mail-Followup-To: git@vger.kernel.org, subversion@elego.de
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53925>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello,

trying to convert the rather large  subversion repo of the DSLinux project
I hit memory leaks in git-svnimport.

The repo has *lots* of files, a workspace is about 2GB in size.
URLs: www.dslinux.org, svnweb at http://dslinux.gits.kiev.ua

Trace showing the program running out of memory:

#0  0x28285f57 in kill () from /lib/libc.so.6
#1  0x28285ef6 in raise () from /lib/libc.so.6
#2  0x282849bb in abort () from /lib/libc.so.6
#3  0x283bd9ea in abort_on_pool_failure (retcode=3D12)
    at subversion/libsvn_subr/pool.c:46
#4  0x285c8f1f in apr_palloc (pool=3D0x2801a018, size=3D53840)
    at memory/unix/apr_pools.c:618
#5  0x28621519 in rep_read_contents (baton=3D0x2800d388, buf=3D0x28026018 "=
",
    len=3D0xbfbfdb38) at subversion/libsvn_fs_fs/fs_fs.c:1881


I know about the patch at http://marc.info/?l=3Dgit&m=3D114345884526971&w=
=3D2
but that is already applied to the version I have here and does not
help because it does not really solve the core of the problem.

The following is rather lengthy, but I guess people applying
my patch want to understand what they're doing so I might just
as well provide all the info upfront.

The core of the problem is that the subversion perl bindings
don't seem to suceed at abstracting dynamic memory handling
away from perl scripts. Ripping out all explicit dynamic memory
handling from git-svnimport (done via the SVN::Pool API) does
not make the problem go away.

I am still not sure whether the right place to fix this
are the subversion perl bindings or the script.
Handling dynamic memory explicitly in a scripting language
is certainly weird. But I cannot get the subversion perl bindings
=66rom current subversion trunk to build on my system to try to find
out if it is possible to fix the problem there
(see http://svn.haxx.se/users/archive-2007-07/0784.shtml).

So I had to try to solve the problem in the script itself.
I was able to fix the script up to the point where I was
able to import the entire DSLinux repository in a single
go without the script running out of memory.

To understand the fix you need to understand how subversion
handles dynamic memory:

Basically, every function in subversion that needs temporary
scratch space gets handed a pointer to a "memory pool".

It can allocate memory from this pool and does not need to care
about freeing anything because only the scope that created a pool
is responsible for destroying it.

So in C this looks a bit like:

svn_error_t* some_func(struct my_struct **result, apr_pool_t *pool)
{
	/* allocate space for result from pool */
	struct my_struct *res =3D apr_palloc(pool, sizeof(struct my_struct));
=09
	/* compute result and pass pool further down if needed */
=09
	...

	/* don't care about freeing the pool */
	*result =3D res;
	return SVN_NO_ERROR;
}

The caller will know when it does not need the result any longer
and destroy the pool at that moment.

Loops are interesting, since we can also "clear" a pool which does
not deallocate the memory it holds but marks the memory ready for re-use.

So with loops the following idiom is used:

	apr_pool_t *subpool =3D svn_pool_create(pool);	=09

	while (condition) {
		svn_pool_clear(subpool);

		/* do stuff and pass subpool further down if needed */

		...
	}
=09
	svn_pool_destroy(subpool);


So how do these pools work in perl?

Well, the SVN::Core man page states the following:

  The perl bindings significantly simplify the usage of pools, while
  still being manually adjustable.

Great. And what does mean exactly?

  Functions requiring pool as the last argument (which are, almost all of
  the subversion functions), the pool is optionally[sic]. The default pool
  is used if it is omitted. If default pool is not set, a new root pool will
  be created and set as default automatically when the first function
  requiring a default pool is called.

So there's a "default" pool that is used if the caller does not
specify a $pool argument. We can take more control via the way
we create pools in perl:

  Methods
 =20
  new ([$parent])
     Create a new pool. The pool is a root pool if $parent is not sup-
     plied.
 =20
  new_default ([$parent])
     Create a new pool. The pool is a root pool if $parent is not sup-
     plied.  Set the new pool as default pool.
 =20
  new_default_sub
     Create a new subpool of the current default pool, and set the
     resulting pool as new default pool.
 =20
  clear
     Clear the pool.
 =20
  destroy
     Destroy the pool. If the pool is the default pool, restore the pre-
     vious default pool as default. This is normally called automati-
     cally when the SVN::Pool object is no longer used and destroyed by
     the perl garbage collector.
 =20
So pools in perl get destroyed when the garbage collector runs.
The man page gives an example that implies that the garbage collector
runs when the pool falls out of scope:

  # create a root pool and set it as default pool for later use
  my $pool =3D SVN::Pool->new_default;

  sub something {
      # create a subpool of the current default pool
      my $pool =3D SVN::Pool->new_default_sub;
      # some svn operations...

      # $pool gets destroyed and the previous default pool
      # is restored when $pool's lexical scope ends
  }

git-svmimport uses the repository access (RA) layer of the subversion
library to talk to the repository. The SVN::Ra man page states
the following about the 'pool' argument of the SVN::Ra constructor:

  The pool for the ra session to use, and also the member functions
  will be called with this pool. Default to a newly created root
  pool.

The SVN::Ra man page fails to mention what the SVN::Core man page implies.
If a function gets passed an explicit pool, or if we change the
current default pool, our pool will be used instead of the one
specified to the constructor of the RA layer!

So the patch below does the following:

  * Create an explicit one-and-only root pool.

  * Override the default pool SVN::RA is using with our root pool.
    Since the connection to the repo must stay open during the whole
    script, the RA layer will depend on the pool staying alive throughout
    the whole program, so it might as well use the root pool.

  * Closely follow the example in the SVN::Core man page.

    Before calling a subversion function, create a subpool of our
    root pool and make it the new default pool. Then call the
    function without passing $pool argument. The function will use
    our subpool anyway because we made it the current default pool.
    The previous default pool will become default pool again when
    the subpool falls out of scope.

  * A major problem seemed to be that the script keeps creating
    new root pools with

      my $pool =3D SVN::Pool->new();
   =20
    inside a loop in *global* scope instead of using the loop idiom
    described above. These pools are never, ever destroyed.

    So create a subpool for the loop to use and clear (i.e. mark for
    reuse, don't decallocate) the subpool at the start of the loop
    instead of allocating new memory with each iteration.


With this patch, the script never exceeded the memory usage of firefox
to a large extend while converting the DSLinux repo :-)
I hope the patch will help even more stupid and ugly people switch to git.


diff --git a/git-svnimport.perl b/git-svnimport.perl
index b73d649..53526f4 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -54,6 +54,7 @@ my $branch_name =3D $opt_b || "branches";
 my $project_name =3D $opt_P || "";
 $project_name =3D "/" . $project_name if ($project_name);
 my $repack_after =3D $opt_R || 1000;
+my $root_pool =3D SVN::Pool->new_default;
=20
 @ARGV =3D=3D 1 or @ARGV =3D=3D 2 or usage();
=20
@@ -132,7 +133,7 @@ sub conn {
 	my $auth =3D SVN::Core::auth_open ([SVN::Client::get_simple_provider,
 			  SVN::Client::get_ssl_server_trust_file_provider,
 			  SVN::Client::get_username_provider]);
-	my $s =3D SVN::Ra->new(url =3D> $repo, auth =3D> $auth);
+	my $s =3D SVN::Ra->new(url =3D> $repo, auth =3D> $auth, pool =3D> $root_p=
ool);
 	die "SVN connection to $repo: $!\n" unless defined $s;
 	$self->{'svn'} =3D $s;
 	$self->{'repo'} =3D $repo;
@@ -147,11 +148,10 @@ sub file {
=20
 	print "... $rev $path ...\n" if $opt_v;
 	my (undef, $properties);
-	my $pool =3D SVN::Pool->new();
 	$path =3D~ s#^/*##;
+	my $subpool =3D SVN::Pool::new_default_sub;
 	eval { (undef, $properties)
-		   =3D $self->{'svn'}->get_file($path,$rev,$fh,$pool); };
-	$pool->clear;
+		   =3D $self->{'svn'}->get_file($path,$rev,$fh); };
 	if($@) {
 		return undef if $@ =3D~ /Attempted to get checksum/;
 		die $@;
@@ -185,6 +185,7 @@ sub ignore {
=20
 	print "... $rev $path ...\n" if $opt_v;
 	$path =3D~ s#^/*##;
+	my $subpool =3D SVN::Pool::new_default_sub;
 	my (undef,undef,$properties)
 	    =3D $self->{'svn'}->get_dir($path,$rev,undef);
 	if (exists $properties->{'svn:ignore'}) {
@@ -202,6 +203,7 @@ sub ignore {
 sub dir_list {
 	my($self,$path,$rev) =3D @_;
 	$path =3D~ s#^/*##;
+	my $subpool =3D SVN::Pool::new_default_sub;
 	my ($dirents,undef,$properties)
 	    =3D $self->{'svn'}->get_dir($path,$rev,undef);
 	return $dirents;
@@ -358,10 +360,9 @@ open BRANCHES,">>", "$git_dir/svn2git";
=20
 sub node_kind($$) {
 	my ($svnpath, $revision) =3D @_;
-	my $pool=3DSVN::Pool->new;
 	$svnpath =3D~ s#^/*##;
-	my $kind =3D $svn->{'svn'}->check_path($svnpath,$revision,$pool);
-	$pool->clear;
+	my $subpool =3D SVN::Pool::new_default_sub;
+	my $kind =3D $svn->{'svn'}->check_path($svnpath,$revision);
 	return $kind;
 }
=20
@@ -889,7 +890,7 @@ sub commit_all {
 	# Recursive use of the SVN connection does not work
 	local $svn =3D $svn2;
=20
-	my ($changed_paths, $revision, $author, $date, $message, $pool) =3D @_;
+	my ($changed_paths, $revision, $author, $date, $message) =3D @_;
 	my %p;
 	while(my($path,$action) =3D each %$changed_paths) {
 		$p{$path} =3D [ $action->action,$action->copyfrom_path, $action->copyfro=
m_rev, $path ];
@@ -925,14 +926,14 @@ print "Processing from $current_rev to $opt_l ...\n" =
if $opt_v;
 my $from_rev;
 my $to_rev =3D $current_rev - 1;
=20
+my $subpool =3D SVN::Pool::new_default_sub;
 while ($to_rev < $opt_l) {
+	$subpool->clear;
 	$from_rev =3D $to_rev + 1;
 	$to_rev =3D $from_rev + $repack_after;
 	$to_rev =3D $opt_l if $opt_l < $to_rev;
 	print "Fetching from $from_rev to $to_rev ...\n" if $opt_v;
-	my $pool=3DSVN::Pool->new;
-	$svn->{'svn'}->get_log("/",$from_rev,$to_rev,0,1,1,\&commit_all,$pool);
-	$pool->clear;
+	$svn->{'svn'}->get_log("/",$from_rev,$to_rev,0,1,1,\&commit_all);
 	my $pid =3D fork();
 	die "Fork: $!\n" unless defined $pid;
 	unless($pid) {

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (FreeBSD)

iD8DBQFGqe6V5dMCc/WdJfARAv/1AJ0WZTq5heRapbx1R3lxLFfeQpZZbQCeIA4D
/G9pUH50xgMCLOp0xnWNKbY=
=KUzh
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
