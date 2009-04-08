From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH] perl: add new module Git::Config for cached 'git config'
 access
Date: Wed, 08 Apr 2009 17:49:17 +1200
Organization: Catalyst IT (NZ) Ltd
Message-ID: <49DC3ADD.5000902@catalyst.net.nz>
References: <1238975176-14354-1-git-send-email-sam.vilain@catalyst.net.nz>	<20090406092942.GW17706@mail-vs.djpig.de>	<1239058276.31863.19.camel@maia.lan> <m3prfo1xh6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 08:33:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrRLk-0004Kb-Rm
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 08:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbZDHGby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 02:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757346AbZDHGby
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 02:31:54 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:54107 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757568AbZDHGbx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 02:31:53 -0400
X-Greylist: delayed 1232 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Apr 2009 02:31:52 EDT
Received: from samv by mail1.catalyst.net.nz with local (Exim 4.63)
	(envelope-from <samv@catalyst.net.nz>)
	id 1LrR08-0008F5-T0; Wed, 08 Apr 2009 18:11:08 +1200
FCC: imap://sam.vilain@mail.catalyst.net.nz/INBOX/Sent
X-Identity-Key: id1
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <m3prfo1xh6.fsf@localhost.localdomain>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116047>

Jakub Narebski wrote:
>> -		my ($item, $value) = m{(.*?)=(.*)};
>> +		my ($item, $value) = m{(.*?)\n((?s:.*))\0}
>> +			or die "failed to parse it; \$_='$_'";
> 
> Errr... wouldn't it be better to simply use 
> 
> +		my ($item, $value) = split("\n", $_, 2)
> 
> here?

Yeah, I guess that's easier to read and possibly faster; both are
using the regexp engine and using COW strings though, so it's probably
not as bad as one might think.

> Have you tested Git::Config with a "null" value, i.e. something
> like
> 
>     [section]
>         noval
> 
> in the config file (which evaluates to 'true' with '--bool' option)?
> Because from what I remember from the discussion on the 
> "git config --null --list" format the lack of "\n" is used to
> distinguish between noval (which is equivalent to 'true'), and empty
> value (which is equivalent to 'false')
> 
>     [boolean]
>         noval        # equivalent to 'true'
>         empty1 =     # equivalent to 'false'
>         empty2 = ""  # equivalent to 'false'

That I didn't consider.  Below is a patch for this.  Any more gremlins?

Subject: perl: fix no value items in Git::Config

When interpreted as boolean, items in the configuration which do not
have an '=' are interpreted as true.  Parse for this situation, and
represent it with an object in the state hash which works a bit like
undef, but isn't.  Various internal tests that items were multiple
values with ref() must become stricter.  Reported by Jakub Narebski.
Sneak a couple of vim footer changes in too.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
  pull 'perl-Config' from git://github.com/samv/git for a rebased
  version without the vim footer changes, and with cleaner whitespace.

 perl/Git/Config.pm |   36 +++++++++++++++++++++++++++---------
 t/t9700/config.t   |   22 +++++++++++++++++++++-
 2 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/perl/Git/Config.pm b/perl/Git/Config.pm
index a35d9f3..6b4d928 100644
--- a/perl/Git/Config.pm
+++ b/perl/Git/Config.pm
@@ -144,7 +144,7 @@ sub _config {
 	}
 
 	if (defined wantarray) {
-		my @values = ref $state ? @$state :
+		my @values = ref($state) eq "ARRAY" ? @$state :
 			defined $state ? ($state) : ();
 
 		if ( my $type = $self->type( $item ) ) {
@@ -171,6 +171,8 @@ Reads the current state of the configuration file.
 
 =cut
 
+our $NOVALUE = bless [__PACKAGE__."/NOVALUE"], "Git::Config::novalue";
+
 sub read {
 	my $self = shift;
 	my $which = shift;
@@ -185,13 +187,19 @@ sub read {
 
 	local($/)="\0";
 	while (<$fh>) {
-		my ($item, $value) = m{(.*?)\n((?s:.*))\0}
-			or die "failed to parse it; \$_='$_'";
+		my ($item, $value) = split "\n", $_, 2;
+		if (defined $value) {
+			chop($value);
+		} else {
+			chop($item);
+			$value = $NOVALUE;
+		}
+		my $exists = exists $read_state->{$item};
 		my $sl = \( $read_state->{$item} );
-		if (!defined $$sl) {
+		if (!$exists) {
 			$$sl = $value;
 		}
-		elsif (!ref $$sl) {
+		elsif (!ref $$sl or ref $$sl ne "ARRAY") {
 			$$sl = [ $$sl, $value ];
 		}
 		else {
@@ -325,7 +333,7 @@ sub _write {
 		if ($type ne "string") {
 			push @cmd, "--$type";
 		}
-		if (ref $value) {
+		if (ref $value eq "ARRAY") {
 			$git->command_oneline (
 				"config", @cmd, "--replace-all",
 				 $item, $value->[0],
@@ -378,7 +386,7 @@ sub thaw {
 {
 	package Git::Config::string;
 	sub freeze { shift }
-	sub thaw   { shift }
+	sub thaw   { (shift)."" }
 }
 {
 	package Git::Config::integer;
@@ -408,6 +416,15 @@ sub thaw {
 	}
 }
 {
+	package Git::Config::novalue;
+	sub as_string { "" }
+	sub as_num    {  0 }
+	use overload
+		'""' => \&as_string,
+		'0+' => \&as_num,
+		fallback => 1;
+}
+{
 	package Git::Config::boolean;
 	our @true = qw(true yes 1);
 	our @false = qw(false no 0);
@@ -424,7 +441,8 @@ sub thaw {
 	}
 	sub thaw {
 		my $val = shift;
-		if ($val =~ m{$true_re}) {
+		if (eval{$val->isa("Git::Config::novalue")}
+			    or $val =~ m{$true_re}) {
 			1;
 		}
 		elsif ($val =~ m{$false_re}) {
@@ -464,4 +482,4 @@ Perl Artistic License 2.0 or later, or the GPL v2 or later.
 #   cperl-indent-wrt-brace: nil
 # End:
 #
-# vim: vim:tw=78:sts=0:noet
+# vim: tw=78:sts=0:noet
diff --git a/t/t9700/config.t b/t/t9700/config.t
index f0f7d2d..9d7860f 100644
--- a/t/t9700/config.t
+++ b/t/t9700/config.t
@@ -17,6 +17,14 @@ in_empty_repo sub {
 	$git->command_oneline("config", "foo.false.val", "false");
 	$git->command_oneline("config", "foo.true.val", "yes");
 	$git->command_oneline("config", "multiline.val", "hello\nmultiline.val=world");
+	open(CONFIG, ">>.git/config") or die $!;
+	print CONFIG <<CONF;
+[boolean]
+   noval
+   empty1 =
+   empty2 = ""
+CONF
+	close CONFIG;
 
 	my $conf = Git::Config->new();
 	ok($conf, "constructed a new Git::Config");
@@ -100,6 +108,18 @@ in_empty_repo sub {
 	$git->command_oneline("config", "foo.falseval", "false");
 	$git->command_oneline("config", "foo.trueval", "on");
 
+	is($conf->config("boolean.noval"), "", "noval: string");
+	is($conf->config("boolean.empty1"), "", "empty1: string");
+	is($conf->config("boolean.empty2"), "", "empty2: string");
+
+	$conf->type("boolean.*" => "boolean");
+
+	ok($conf->config("boolean.noval"), "noval: boolean");
+	eval{my $x = $conf->config("boolean.empty1")};
+	ok($@, "empty1: boolean");
+	eval{my $x = $conf->config("boolean.empty2")};
+	ok($@, "empty2: boolean");
+
 	SKIP:{
 		if (eval {
 			$git->command(
@@ -128,4 +148,4 @@ in_empty_repo sub {
 #   cperl-indent-wrt-brace: nil
 # End:
 #
-# vim: vim:tw=78:sts=0:noet
+# vim: tw=78:sts=0:noet
-- 
1.6.0
