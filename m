From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Wed, 18 Jul 2007 18:12:56 -0700
Message-ID: <7vvech42nb.fsf@assigned-by-dhcp.cox.net>
References: <3bbc18d20707171103q262eaa8amb319ca9f835dbf67@mail.gmail.com>
	<1184699486.9831.7.camel@mattlaptop2>
	<200707190140.05235.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Luben Tuikov <ltuikov@yahoo.com>
To: Matt McCutchen <hashproduct@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 03:13:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBKZi-0006KU-G1
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 03:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933297AbXGSBM7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 18 Jul 2007 21:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbXGSBM7
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 21:12:59 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:33653 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932602AbXGSBM6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 21:12:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070719011256.FBTD1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 18 Jul 2007 21:12:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RDCw1X00P1kojtg0000000; Wed, 18 Jul 2007 21:12:57 -0400
In-Reply-To: <200707190140.05235.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 19 Jul 2007 01:40:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52919>

Jakub Narebski <jnareb@gmail.com> writes:

> On Tue, 17 July 2007, Matt McCutchen napisa=C5=82:
> ...
>> Alert for gitweb site administrators: This patch changes the format =
of
>> $feature{'snapshot'}{'default'} in gitweb_config.perl from a list of
>> three pieces of information about a single format to a list of one o=
r
>> more formats you wish to offer from the set ('tgz', 'tbz2', 'zip').
>> Update your gitweb_config.perl appropriately.  The preferred names f=
or
>> gitweb.snapshot in repository configuration have also changed from
>> 'gzip' and 'bzip2' to 'tgz' and 'tbz2', but the old names are still
>> recognized for compatibility.
>
> This alert/warning should probably be put in RelNotes for when it wou=
ld
> be in git.git

Does anybody else worry about the backward imcompatibility, I
wonder...  List?

I really hate to having to say something like that in the
RelNotes.  I do not think this is a good enough reason to break
existing configurations; I would not want to be defending that
change.

>> I thought of another incompatibility: previously bookmarked snapshot
>> URLs will no longer work because they lack the new "sf" parameter.  =
I
>> don't care about this; do any of you?
>
> I think either having good error message, or using first format avaia=
ble
> would be good enough.

I doubt bookmarked snapshot URL would make sense to begin with,
so this would be Ok.

I am wondering if something like this patch (totally untested,
mind you) to convert the old style %feature in configuration at
the site at runtime would be sufficient.

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f17c983..cdec4d0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -236,9 +236,39 @@ our %feature =3D (
 		'default' =3D> [0]},
 );
=20
+# Functions to convert values from older gitweb configuration
+# into the current data format
+sub gitweb_bc_feature_snapshot {
+	my $def =3D $feature{'snapshot'}{'default'};
+	# Older definition was to have either undef (to disable), or
+	# a three-element array whose first element was content encoding
+	# without leading "application/".
+	return if (ref $def ne 'ARRAY');
+	if (!defined $def->[0] && @$def =3D=3D 1) {
+		# Disabled -- the new way to spell it is to have an empty
+		# arrayref.
+		$feature{'snapshot'}{'default'} =3D [];
+		return;
+	}
+	return if (@$def !=3D 3);
+	for ($def->[0]) {
+		if (/x-gzip/) {
+			$feature{'snapshot'}{'default'} =3D ['tgz'];
+		}
+		if (/x-bz2/) {
+			$feature{'snapshot'}{'default'} =3D ['tbz2'];
+		}
+		if (/x-zip/) {
+			$feature{'snapshot'}{'default'} =3D ['zip'];
+		}
+	}
+}
+
 sub gitweb_check_feature {
 	my ($name) =3D @_;
 	return unless exists $feature{$name};
+	eval "gitweb_bc_feature_$name()";
+
 	my ($sub, $override, @defaults) =3D (
 		$feature{$name}{'sub'},
 		$feature{$name}{'override'},
