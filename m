From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [RFC] More diff possibilities in gitweb
Date: Sun, 18 Mar 2007 15:14:51 +0100
Message-ID: <20070318141451.GA9607@auto.tuwien.ac.at>
References: <20070317151731.GA32571@auto.tuwien.ac.at> <Pine.LNX.4.63.0703171902200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 15:15:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSwA0-0000JF-PQ
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 15:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbXCROOy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Mar 2007 10:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbXCROOy
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 10:14:54 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:38361 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbXCROOx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 10:14:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id D755C70FAF33;
	Sun, 18 Mar 2007 15:14:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TXrmzmI0kxBL; Sun, 18 Mar 2007 15:14:51 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 2C62F70FAF2A; Sun, 18 Mar 2007 15:14:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703171902200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42496>

On Sat, Mar 17, 2007 at 07:04:54PM +0100, Johannes Schindelin wrote:
> On Sat, 17 Mar 2007, Martin Koegler wrote:
>=20
> > The whole is implemented in JavaScript on the client side (tested w=
ith=20
> > IE 6 and Mozilla).
>=20
> This is not acceptable for me. There are too many people blindly runn=
ing=20
> JavaScript everywhere, and we should not enforce such bad behaviour.
>
> At least, you need a way to do it with plain old HTML (which is easy=20
> enough).

If the browser supports no JavaScript, the user can use all current
features, except the new diff capabilities.

My first thoughts where also about implementing it inside
gitweb.cgi. This would mean a large change to the code, as all code
which generate links needs to be adapted.

Additionally, selecting a base object would mean, that you must submit
a request to the server and probably return something (probable the
same page, on which you selected the base object).

=46or me, this would be no problem, but for high load servers (eg. gitw=
eb at
kernel.org), it would incread the system load.

With JavaScript, this step needs no server interaction. Infact, a
client could add the diff feature to any gitweb server with
eg. greasemonkey, by injecting the JavaScript code.

> Also I'd like to know: is there any reason you did not send a proper =
diff,=20
> given that you are so interested in diffs?

I'm not interessted in generating patchs via gitweb. I want to examine
and review differences between various branches/tags/commits/... .

The "pseudo" diff for gitweb.cgi was to illustrate, how to integrate
gitweb.js. The whole thing is under development, so I have not created
a clean version.

As I wrote in my last mail, I used blobdiff to generation tree diffs,
which results in wrong/missing file names. In the mean time, I've
create a first version of a treediff function for gitweb.

mfg Martin K=F6gler

--- old/gitweb.js   2007-03-17 15:18:23.284317140 +0100
+++ gitweb.js        2007-03-17 22:25:18.254190096 +0100
@@ -259,7 +259,7 @@
   }
   if(c.t=3D=3D'tree'&&url.a=3D=3D'tree')
   {
-      url.a=3D'blobdiff';
+      url.a=3D'treediff';
       if(c.h&&url.h)
       {
          url.hb=3Dnull;
--- ../mirror/git.git/gitweb/gitweb.perl	2007-03-12 22:06:44.000000000 =
+0100
+++ gitweb.cgi	2007-03-17 18:41:50.000000000 +0100
@@ -446,6 +446,8 @@
 	"tag" =3D> \&git_tag,
 	"tags" =3D> \&git_tags,
 	"tree" =3D> \&git_tree,
+	"treediff" =3D> \&git_treediff,
+	"treediff_plain" =3D> \&git_treediff_plain,
 	"snapshot" =3D> \&git_snapshot,
 	"object" =3D> \&git_object,
 	# those below don't need $project
@@ -1835,6 +1837,7 @@
 		close $fd;
 	}
=20
+	print '<script type=3D"text/javascript" src=3D"gitweb.js"></script>';
 	print "</body>\n" .
 	      "</html>";
 }
@@ -4191,6 +4194,106 @@
 	git_commitdiff('plain');
 }
=20
+sub git_treediff {
+	my $format =3D shift || 'html';
+	$hash ||=3D $hash_base;
+	$hash_parent ||=3D $hash_parent_base;
+	if (!defined $hash_parent || !defined $hash)
+	{
+	    die_error(undef, "Missing one of the tree diff parameters");
+	}
+
+	# we need to prepare $formats_nav before any parameter munging
+	my $formats_nav;
+	if ($format eq 'html') {
+		$formats_nav =3D
+			$cgi->a({-href =3D> href(action=3D>"treediff_plain",
+			                       hash=3D>$hash, hash_parent=3D>$hash_parent)}=
,
+			        "raw");
+		$formats_nav .=3D ' | ';
+		$formats_nav .=3D
+			$cgi->a({-href =3D> href(action=3D>"tree",
+			                       hash=3D>$hash)},
+			        "tree");
+		$formats_nav .=3D ' &lt;-&gt; ';
+		$formats_nav .=3D
+			$cgi->a({-href =3D> href(action=3D>"tree",
+			                       hash=3D>$hash)},
+			        "tree");
+	}
+
+	# read treediff
+	my $fd;
+	my @difftree;
+	if ($format eq 'html') {
+		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
+			"--no-commit-id", "--patch-with-raw", "--full-index",
+			$hash_parent, $hash, "--"
+			or die_error(undef, "Open git-diff-tree failed");
+
+		while (my $line =3D <$fd>) {
+			chomp $line;
+			# empty line ends raw part of diff-tree output
+			last unless $line;
+			push @difftree, $line;
+		}
+
+	} elsif ($format eq 'plain') {
+		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
+			'-p', $hash_parent, $hash, "--"
+			or die_error(undef, "Open git-diff-tree failed");
+
+	} else {
+		die_error(undef, "Unknown treediff format");
+	}
+
+	# non-textual hash id's can be cached
+	my $expires;
+	if ($hash =3D~ m/^[0-9a-fA-F]{40}$/) {
+		$expires =3D "+1d";
+	}
+
+	# write diff message
+	if ($format eq 'html') {
+		git_header_html(undef, $expires);
+
+		print "<div class=3D\"page_nav\"><br/>$formats_nav<br/></div>\n";
+		print "<div class=3D\"title\">$hash vs $hash_parent</div>\n";
+		print "<div class=3D\"page_body\">\n";
+
+	} elsif ($format eq 'plain') {
+		my $filename =3D basename($project) . "-$hash-$hash_parent.patch";
+
+		print $cgi->header(
+			-type =3D> 'text/plain',
+			-charset =3D> 'utf-8',
+			-expires =3D> $expires,
+			-content_disposition =3D> 'inline; filename=3D"' . "$filename" . '"=
');
+		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
+	}
+
+	# write patch
+	if ($format eq 'html') {
+		git_difftree_body(\@difftree, $hash, $hash_parent);
+		print "<br/>\n";
+
+		git_patchset_body($fd, \@difftree, $hash, $hash_parent);
+		close $fd;
+		print "</div>\n"; # class=3D"page_body"
+		git_footer_html();
+
+	} elsif ($format eq 'plain') {
+		local $/ =3D undef;
+		print <$fd>;
+		close $fd
+			or print "Reading git-diff-tree failed\n";
+	}
+}
+
+sub git_treediff_plain {
+	git_treediff('plain');
+}
+
 sub git_history {
 	if (!defined $hash_base) {
 		$hash_base =3D git_get_head_hash($project);
