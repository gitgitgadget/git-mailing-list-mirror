From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] diff: funcname and word patterns for perl
Date: Sun, 26 Dec 2010 03:07:31 -0600
Message-ID: <20101226090731.GA21588@burratino>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
 <20101222235459.7998.43333.stgit@localhost.localdomain>
 <20101223015540.GA14585@burratino>
 <201012252314.22541.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 26 10:08:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWma7-0008QF-Sk
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 10:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668Ab0LZJHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 04:07:53 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52482 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536Ab0LZJHu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 04:07:50 -0500
Received: by iyi12 with SMTP id 12so6726991iyi.19
        for <git@vger.kernel.org>; Sun, 26 Dec 2010 01:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1n1LVcN9EX8wqbHwxg4jYkvqE36QdGhAdD+FEPYUPwo=;
        b=URXv6+5xaF3eJYu9xPCVsLKx5XZ7cgpqZr8Bq0FR+BHGo8ZIsklGC+FnQIVMH+7c/N
         aJw5N3X8EpC5ID3V6uah+A4YlPLq4N3UGqRzPamMavOO+aOkFvHg24htVLCbTP95UXnK
         fxBvrbwECEs/8AFcRDYsfTiXNWG7DZJqMZ1dI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=P8FMplUaDBxZ7M6P4SJ3Q5dVhgWCxc2MqjTnEG5GLc548fMEWC0FEsPk15mQE+rB5M
         bg37jV/c5Qc7kZW/444oiJDwRR9lYE0nijMeS1WiPYZZikkfszDaXSMe8XecLG6FmtIJ
         cPYx89n/2m0fY1QrVOTUk6npUBT8jL8XDi3KQ=
Received: by 10.42.219.4 with SMTP id hs4mr11252638icb.418.1293354470276;
        Sun, 26 Dec 2010 01:07:50 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id u5sm9578446ics.18.2010.12.26.01.07.46
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Dec 2010 01:07:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201012252314.22541.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164184>

The default function name discovery already works quite well for Perl
code... with the exception of here-documents (or rather their ending).

 sub foo {
	print <<END
 here-document
 END
	return 1;
 }

The default funcname pattern treats the unindented END line as a
function declaration and puts it in the @@ line of diff and "grep
--show-function" output.

With a little knowledge of perl syntax, we can do better.  You can
try it out by adding "*.perl diff=perl" to the gitattributes file.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jakub Narebski wrote:

> BTW. do you know how such perl support should look like?

Maybe something like this?

 Documentation/gitattributes.txt |    2 ++
 t/t4018-diff-funcname.sh        |    2 +-
 userdiff.c                      |   15 +++++++++++++++
 3 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 5a7f936..e59b878 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -494,6 +494,8 @@ patterns are available:
 
 - `pascal` suitable for source code in the Pascal/Delphi language.
 
+- `perl` suitable for source code in the Perl language.
+
 - `php` suitable for source code in the PHP language.
 
 - `python` suitable for source code in the Python language.
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 0a61b57..3646930 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -32,7 +32,7 @@ EOF
 
 sed 's/beer\\/beer,\\/' < Beer.java > Beer-correct.java
 
-builtin_patterns="bibtex cpp csharp fortran html java objc pascal php python ruby tex"
+builtin_patterns="bibtex cpp csharp fortran html java objc pascal perl php python ruby tex"
 for p in $builtin_patterns
 do
 	test_expect_success "builtin $p pattern compiles" '
diff --git a/userdiff.c b/userdiff.c
index 2d54536..fc2afe3 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -61,6 +61,21 @@ PATTERNS("pascal",
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"
 	 "|<>|<=|>=|:=|\\.\\."
 	 "|[^[:space:]]|[\x80-\xff]+"),
+PATTERNS("perl",
+	 "^[ \t]*package .*;\n"
+	 "^[ \t]*sub .* \\{",
+	 /* -- */
+	 "[[:alpha:]_'][[:alnum:]_']*"
+	 "|0[xb]?[0-9a-fA-F_]*"
+	 /* taking care not to interpret 3..5 as (3.)(.5) */
+	 "|[0-9a-fA-F_]+(\\.[0-9a-fA-F_]+)?([eE][-+]?[0-9_]+)?"
+	 "|=>|-[rwxoRWXOezsfdlpSugkbctTBMAC>]|~~|::"
+	 "|&&=|\\|\\|=|//=|\\*\\*="
+	 "|&&|\\|\\||//|\\+\\+|--|\\*\\*|\\.\\.\\.?"
+	 "|[-+*/%.^&<>=!|]="
+	 "|=~|!~"
+	 "|<<|<>|<=>|>>"
+	 "|[^[:space:]]"),
 PATTERNS("php",
 	 "^[\t ]*(((public|protected|private|static)[\t ]+)*function.*)$\n"
 	 "^[\t ]*(class.*)$",
-- 
1.7.2.3.554.gc9b5c.dirty
