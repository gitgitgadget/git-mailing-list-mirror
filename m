From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] [RFC] Design for pathname encoding gitattribute [RESEND]
Date: Tue, 22 Jan 2008 17:41:59 +1300
Message-ID: <20080122050215.DE198200A2@wilber.wgtn.cat-it.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 06:03:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHBHw-0007bN-LC
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 06:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbYAVFCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 00:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbYAVFCj
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 00:02:39 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:53643 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbYAVFCi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 00:02:38 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=wilber.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <samv@wilber.wgtn.cat-it.co.nz>)
	id 1JHBH5-0002jQ-Uh; Tue, 22 Jan 2008 18:02:15 +1300
Received: by wilber.wgtn.cat-it.co.nz (Postfix, from userid 1000)
	id DE198200A2; Tue, 22 Jan 2008 18:02:15 +1300 (NZDT)
User-Agent: VIM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71418>

Some projects may like to enforce a particular encoding is used for
all filenames in the repository.  Within the UTF-8 encoding, there are
four normal forms (see http://unicode.org/reports/tr15/), any of which
may be a reasonable repository format choice.  Additionally, some
filesystems may have a single encoding that they support when writing
local filenames.  To support this, iconv and a normalization library
must have the information they need to perform the correct conversion.

This is a configuration design proposal, and does not implement any
changes.
---
   Hi all, I think that restating the problem in these terms might be
   more productive than the previous discussion, design critiques?

   It is intended that this doesn't impact at all on users with C
   filesystems without explicit configuration, while adding the feature
   of allowing projects to specify unicode normalisation (so, eg,
   M=C3=A4rchen ends up the same as Ma=CC=88rchen)

   [apologies if this hits the list twice; I sent the first with a bad
    content encoding header and assume it got dropped]

 Documentation/config.txt        |   16 ++++++++++++++++
 Documentation/gitattributes.txt |   19 +++++++++++++++++++
 Documentation/i18n.txt          |    9 ++++++---
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ee08845..9d2567d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -146,6 +146,22 @@ core.symlinks::
 	file. Useful on filesystems like FAT that do not support
 	symbolic links. True by default.
=20
+core.repositoryPathEncoding::
+	Specify the default assumed encoding of repository paths, if
+	not specified in gitlink:gitattributes[3] for that repository.
+	The default value of this is "C".
+
+core.checkoutPathEncoding::
+	Specify the encoding of local filenames.  The default value of
+	this depends on the platform and filesystem, but for most users
+	will be "C", indicating no pathname conversion required.
+
+core.checkoutPathEncodingFromLocale::
+	Specify whether the checkout path encoding should be
+	controlled via environment locale variables.  This may have
+	some bizarre side effects if you switch locales between
+	working with a checkout.  False by default.
+
 core.gitProxy::
 	A "proxy command" to execute (as 'command host port') instead
 	of establishing direct connection to the remote server when
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribute=
s.txt
index cc9c7c5..4136528 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -170,6 +170,25 @@ intent is that if someone unsets the filter driver d=
efinition,
 or does not have the appropriate filter program, the project
 should still be usable.
=20
+`encoding`
+^^^^^^^^^^
+Specifies the valid encoding for file names (does not affect content)
+on the specified path.  Git enforces that all filenames are valid in
+this encoding, and if applicable and possible, will translate from the
+encoding configured (or, on relevant platform and filesystem
+combinations, detected) to this encoding.
+
+The default value of this is "C", which leaves behaviour on
+filesystems which do not support "C" semantics undefined until it is
+set.  For instance, if your filesystem supports only UTF-8, and you
+are trying to check out a repository that is in Latin-1, then you will
+need to configure the repository encoding in `.git/info/attributes`=20
+before you can check files out on that system.
+
+Valid encodings are currently 'ISO-8859-1' and 'UTF-8'.  'UTF-8' may
+be followed by '+NFC', '+NFD', '+NFKD' or '+NFKC' to enforce a
+particular normalization of filenames.
+
=20
 Interaction between checkin/checkout attributes
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index b95f99b..fba0407 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -1,11 +1,14 @@
 At the core level, git is character encoding agnostic.
=20
  - The pathnames recorded in the index and in the tree objects
-   are treated as uninterpreted sequences of non-NUL bytes.
+   are normally treated as uninterpreted sequences of non-NUL bytes.
    What readdir(2) returns are what are recorded and compared
    with the data git keeps track of, which in turn are expected
-   to be what lstat(2) and creat(2) accepts.  There is no such
-   thing as pathname encoding translation.
+   to be what lstat(2) and creat(2) accepts.
+
+However, if there are configured encodings for the checkout and/or
+repository, then the defined conversions will occur between the
+readdir(2) and the index, in both directions.
=20
  - The contents of the blob objects are uninterpreted sequence
    of bytes.  There is no encoding translation at the core
--=20
1.5.3.5
