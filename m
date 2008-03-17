From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 2/3 v2] gitweb: Support caching projects list
Date: Tue, 18 Mar 2008 00:13:10 +0100
Message-ID: <1205795590-18420-1-git-send-email-jnareb@gmail.com>
References: <Message-ID: <1205766570-13550-3-git-send-email-jnareb@gmail.com>
Cc: "J.H." <warthog19@eaglescrag.net>, Petr Baudis <pasky@suse.cz>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	"Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 00:14:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbOXC-0000JA-9S
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 00:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbYCQXNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 19:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbYCQXNp
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 19:13:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:30124 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbYCQXNo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 19:13:44 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1998731fgb.17
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 16:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WdFjeZrv5msUSvJyC8uUSppjwL4o8bpeDpOHthPe9M0=;
        b=Wsr4xTRqEmcL9DzlR6juDDguwNii9fKp0hfXqAD39X4jR1+sy/HFkx92TY+ftN767yZSCUAu4BEvBJyz+P9Rx8lXnHhQQ+tdcH7FwHQvOMbiMDdxINQ67TMGZvnmAo0w87pXYett3yXWAmHdWIdXL4JmCXK6vP2KOtBzlAKmwTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JPgcfECMD/bKjMOLJQpUUZK3MhLSMht565FluQXArb5fNMHI3fQOJXVN9gREK8HK4Qx22Qv65gmXyNP9Wnx8jIuHh9H8HRiv+5Fv3T7/8UUY5yX0L1TlFVQGS2D11Nm7yRIJlz3XvKbvOg8FIa5HzylmsSjcfjP7FXynj/d20f0=
Received: by 10.86.28.5 with SMTP id b5mr5634294fgb.76.1205795619244;
        Mon, 17 Mar 2008 16:13:39 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.213.235])
        by mx.google.com with ESMTPS id 4sm20169881fgg.4.2008.03.17.16.13.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Mar 2008 16:13:36 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2HNDXPo018442;
	Tue, 18 Mar 2008 00:13:33 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2HNDBFR018439;
	Tue, 18 Mar 2008 00:13:11 +0100
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <Message-ID: <1205766570-13550-3-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77469>

This version uses Storable (which gives binary output), instead of a
bit unsafe, because of need to 'eval' to unserialize, Data::Dumper.

It should also be a bit faster: unscientific comparison gives that
Storable is 3-4 times faster than using Data::Dumper on totally
artificial data of 1050 elements table of hashes.

Below replies to comments for first (or second if you count original
Pasky version) version of this patch.

No interdiff there... on the other hand it includes gitweb/README

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[The message below didn't made it to git mailing list due to not
quoting J.H. name in email: it should be 
  "J.H." <warthog19@eaglescrag.net>
not
   J.H. <warthog19@eaglescrag.net>]

On Mon, 17 Mar 2008, Rafael Garcia-Suarez wrote:
> On 17/03/2008, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>>  The cache itself is stored in /tmp/gitweb.index.cache as a
>>  Data::Dumper dump of the perl data structure with the list of project
>>  details.  When reusing the cache, the file is simply eval'd back into
>>  @projects.
> 
> Correct me if I'm wrong (I haven't read the full source code...) Doesn't
> that mean that anyone who can write this file can make gitweb eval
> arbitrary perl code? And anyone can write a file in /tmp, usually... If
> so, I would strongly advise against including this patch in its current
> state, not without at least checking the ownership of the cache file.

First, this patch is an RFC, mainly meant as better version of Pasky's
patch with (the nearly) the same subject, to help repo.or.cz, when it
can be assumed that installation is secure.
 
Second, it was changed in this version of patch: gitweb now uses
Storable to write Perl data to disk and read it back, so there is no
need to eval to read back the data from cache, as it was when using
Data::Dumper package.  Additionally you can now define where to store
cache; by default it is /tmp/gitweb/, and you can make gitweb write
only for projects with gitweb uid (if directory does not exists,
gitweb would create it if possible with appropriate permissions).

>>  Note: instead of using Data::Dumper to serialize data we could use
>>  Storable module (distributed with Perl like Data::Dumper).  From what
>>  I've checked it has larger initial cost, but might be better for
>>  larger number of projects, exactly the situation when projects list
>>  caching is needed.
> 
> Storable would be more secure. (But check file ownership!)

This version uses Storable, which should be more secure (but see
below)... and additionally bit faster.

For the simplicity of patch gitweb does not check cache file
ownership, nor permissions on cache file and on directory it is in,
but this should be fairly easy to add.

BTW. store() and retrieve() from Storable "die" on many errors;
in unsafe environment we would probably want to protect gitweb from
them failing due to incorrect file format, or nonreadable cache file,
etc.

> I don't know how complex are the data structures you're going to
> save.

It is array (list) or array reference (but ordering of items doesn't
matter) of records (hashes / hash references). Fields can be integer,
string (possibly containing quite characters and other strangeness),
or undef.

> My paranoid preference would be to use a text-only format. If CPAN
> modules are out, devise your own dump/load routines, maybe? 

What format should it be? Data::Dumper format looks like this:

  [
          {
            'owner' => 'Jakub Narebski',
            'descr_long' => './t9500-gitweb-standalone-no-errors.sh test repository',
            'mtime' => undef,
            'age_string' => '7 days ago',
            'path' => 'trash.git',
            'age' => 652787,
            'descr' => './t9500-gitweb-standalone... '
          },
          {
            'owner' => 'Jakub Narebski',
            'descr_long' => "git with Jakub Narebski modifications, local copy.",
            'mtime' => undef,
            'age_string' => '80 min ago',
            'path' => 'git.git',
            'age' => 4813,
            'descr' => 'git with Jakub Narebski modif... '
          }
  ]


Another solution would be to use YAML [Tiny], but although Perl
packages for YAML are in contrib repositories, they are not installed
by default with Perl, and most probably are not present on the
system. Additonally at least YAML::Tiny is slower than even
Data::Dumper when retrieving data, around 4-5 times slower... on the
other hand YAML::Tiny is Pure Perl implementation; other solutions
which use C libraries should be much faster.

YAML output looks like this:

  ---
  -
    age: 652787
    age_string: '7 days ago'
    descr: './t9500-gitweb-standalone... '
    descr_long: './t9500-gitweb-standalone-no-errors.sh test repository'
    mtime: ~
    owner: 'Jakub Narebski'
    path: trash.git
  -
    age: 4813
    age_string: '80 min ago'
    descr: 'git with Jakub Narebski modif... '
    descr_long: 'git with Jakub Narebski modifications, local copy.'
    mtime: ~
    owner: 'Jakub Narebski'
    path: git.git


Yet another solution would be to use [much] restricted version of
ini-like git config format, and perhaps reuse git-cvsserver parsing of
this format, or simply call "git-config --file <file> -z -l" and
gitweb code to parse git-config output.

The output whould then look like this:

  [gitweb "trash.git"]
  	age = 652787
  	age_string = "7 days ago"
  	descr = './t9500-gitweb-standalone... '
  	descr_long = "./t9500-gitweb-standalone-no-errors.sh test repository"
  	mtime
  	owner = Jakub Narebski

  [gitweb "git.git"]
  	age = 4813
  	age_string = "80 min ago"
  	descr = "git with Jakub Narebski modif... "
  	descr_long = "git with Jakub Narebski modifications, local copy."
  	mtime
  	owner = Jakub Narebski

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

On Mon, 17 Mar 2008, Frank Lichtenheld wrote:
> On Mon, Mar 17, 2008 at 04:09:29PM +0100, Jakub Narebski wrote:
>>
>> From: Petr Baudis <pasky@suse.cz>
>> $projlist_cache_lifetime gitweb configuration variable is introduced,
>> by default set to zero. If set to non-zero, it describes the number of
>> minutes for which the cache remains valid. Only single project root
>> per system can use the cache. Any script running with the same uid as
>> gitweb can change the cache trivially - this is for secure
>> installations only.
> 
> The more subtle threat is the fact that anyone with writing
> rights to /tmp can give gitweb any data he wants if the file doesn't
> exist yet.

Right.
 
> At the very least you should:
> 
>  - Allow to override /tmp (via ENV{TMPDIR} or via a configuration
>    variable)

Done.

>  - Advise people to change that to something that is not
>    world-writable

I wrote a bit about this in gitweb/README, feel free to add to it.
Additionally gitweb can create cache directory if it does not exist,
and it does so with restrictive premissions.

>  - Check if the file is owned by the uid gitweb is running under and
>    not word-writable.

Currently not done, to make patch simpler; should be fairly easy to
add. I guess it would be best to create is_cache_safe() or something
like that subroutine.

> [...]
>> +	my @projects;
>> +	my $stale = 0;
>> +	my $now = time();
>> +	if ($cache_lifetime && -f $cache_file &&
>> +	    stat($cache_file)->mtime + $cache_lifetime * 60 > $now &&
>> +	    open(my $fd, '<', $cache_file)) {
>> +		$stale = $now - stat($cache_file)->mtime;
> 
> One stat() call instead of three would be better for performance.

Thanks. Done.

-- >8 --
From: Petr Baudis <pasky@suse.cz>
Subject: [RFC/PATCH 2/3 v2] gitweb: Support caching projects list

On repo.or.cz (permanently I/O overloaded and hosting 1050 project +
forks), the projects list (the default gitweb page) can take more than
a minute to generate. This naive patch adds simple support for caching
the projects list data structure so that all the projects do not need
to get rescanned at every page access.

$projlist_cache_lifetime gitweb configuration variable is introduced,
by default set to zero. If set to non-zero, it describes the number of
minutes for which the cache remains valid. Only single project root
per system can use the cache. Any script running with the same uid as
gitweb can change the cache trivially - this is for secure
installations only.

The cache itself is stored in $cache_dir/$projlist_cache_name using
Storable to store() Perl data structure with the list of project
details.  When reusing the cache, the data is retrieve()'d back into
@projects.

To prevent contention when multiple accesses coincide with cache
expiration, the timeout is postponed to time()+120 when we start
refreshing.  When showing cached version, a disclaimer is shown
at the top of the projects list.

[jn: moved from Data::Dumper to Storable for serialization of data]

Signed-off-by: Petr Baudis <pasky@suse.cz>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/README      |   26 +++++++++++++++++++++++
 gitweb/gitweb.css  |    6 +++++
 gitweb/gitweb.perl |   58 +++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 2163071..efbc52e 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -207,6 +207,32 @@ not include variables usually directly set during build):
    ('-M'); set it to ('-C') or ('-C', '-C') to also detect copies, or
    set it to () if you don't want to have renames detection.
 
+Variables described below deal with caching in gitweb.  If you don't
+run gitweb installation on busy site with large number of repositories
+(projects) you probably don't need caching; by default caching is
+turned off.
+ * $projlist_cache_lifetime
+   Lifetime of in-gitweb cache for projects list page, in minutes.
+   By default set to 0, which means tha projects list caching is
+   turned off.
+ * $cache_dir, $projlist_cache_name
+   The cached list version (cache of Perl structure, not of final
+   output) is stored in "$cache_dir/$projlist_cache_name".  $cache_dir
+   should be writable only by processes with the same uid as gitweb
+   (usually web served uid); if $cache_dir does not exist gitweb would
+   try to create it.  Only single gitweb project root per system is
+   supported, unless gitweb instances for different projects root have
+   different configuration.
+
+   By default $cache_dir is set to "$TMPDIR/gitweb" if $TMPDIR
+   environment variable does exist, "/tmp/gitweb" otherwise.
+   Default name for $projlist_cache_name -s 'gitweb.index.cache';
+
+   NOTE: projects list cache file can be tweaked by other scripts
+   running with the same uid as gitweb; use this ONLY at secure
+   installations!!!
+
+
 Per-repository gitweb configuration
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 446a1c3..1e83896 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -85,6 +85,12 @@ div.title, a.title {
 	color: #000000;
 }
 
+div.stale_info {
+	display: block;
+	text-align: right;
+	font-style: italic;
+}
+
 div.readme {
 	padding: 8px;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 90ab894..0bc3f19 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -118,6 +118,20 @@ our $fallback_encoding = 'latin1';
 # - one might want to include '-B' option, e.g. '-B', '-M'
 our @diff_opts = ('-M'); # taken from git_commit
 
+# projects list cache for busy sites with many projects;
+# if you set this to non-zero, it will be used as the cached
+# index lifetime in minutes
+#
+# the cached list version is stored in $cache_dir/$cache_name and can
+# be tweaked by other scripts running with the same uid as gitweb -
+# use this ONLY at secure installations; only single gitweb project
+# root per system is supported, unless you tweak configuration!
+our $projlist_cache_lifetime = 0; # in minutes
+# FHS compliant $cache_dir would be "/var/cache/gitweb"
+our $cache_dir =
+	(defined $ENV{'TMPDIR'} ? $ENV{'TMPDIR'} : '/tmp').'/gitweb';
+our $projlist_cache_name = 'gitweb.index.cache';
+
 # information about snapshot formats that gitweb is capable of serving
 our %known_snapshot_formats = (
 	# name => {
@@ -3510,16 +3524,54 @@ sub git_get_projects_details {
 }
 
 sub git_project_list_body {
-	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
+	my ($projlist, $order, $from, $to, $extra, $no_header, $cache_lifetime) = @_;
 
 	my ($check_forks) = gitweb_check_feature('forks');
 
-	my @projects = git_get_projects_details($projlist, $check_forks);
+	use File::stat;
+	use POSIX qw(:fcntl_h);
+	use Storable qw(store_fd retrieve);
+
+	my $cache_file = "$cache_dir/$projlist_cache_name";
+
+	my @projects;
+	my $stale = 0;
+	my $now = time();
+	my $cache_mtime;
+	if ($cache_lifetime && -f $cache_file) {
+		$cache_mtime = stat($cache_file)->mtime;
+	}
+	if (defined $cache_mtime && # caching is on and $cache_file exists
+	    $cache_mtime + $cache_lifetime*60 > $now &&
+	    (my $dump = retrieve($cache_file))) {
+		$stale = $now - $cache_mtime;
+		@projects = @$dump;
+	} else {
+		if (defined $cache_mtime) {
+			# Postpone timeout by two minutes so that we get
+			# enough time to do our job, or to be more exact
+			# make cache expire after two minutes from now.
+			my $time = $now - $cache_lifetime*60 + 120;
+			utime $time, $time, $cache_file;
+		}
+		@projects = git_get_projects_details($projlist, $check_forks);
+		if ($cache_lifetime &&
+		    (-d $cache_dir || mkdir($cache_dir, 0700)) &&
+		    sysopen(my $fd, "$cache_file.lock", O_WRONLY|O_CREAT|O_EXCL, 0600)) {
+			store_fd(\@projects, $fd);
+			close $fd;
+			rename "$cache_file.lock", $cache_file;
+		}
+	}
 
 	$order ||= $default_projects_order;
 	$from = 0 unless defined $from;
 	$to = $#projects if (!defined $to || $#projects < $to);
 
+	if ($cache_lifetime && $stale > 0) {
+		print "<div class=\"stale_info\">Cached version (${stale}s old)</div>\n";
+	}
+
 	print "<table class=\"project_list\">\n";
 	unless ($no_header) {
 		print "<tr>\n";
@@ -3902,7 +3954,7 @@ sub git_project_list {
 		close $fd;
 		print "</div>\n";
 	}
-	git_project_list_body(\@list, $order);
+	git_project_list_body(\@list, $order, undef, undef, undef, undef, $projlist_cache_lifetime);
 	git_footer_html();
 }
 
-- 
1.5.4.4
