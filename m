From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 02/10] Documentation for time-stamping functionality
Date: Thu, 17 Mar 2016 19:46:53 +0100
Message-ID: <1458240421-3593-3-git-send-email-anton.wuerfel@fau.de>
References: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, i4passt@cs.fau.de,
	Phillip Raffeck <phillip.raffeck@fau.de>,
	Anton Wuerfel <anton.wuerfel@fau.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:48:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agcxs-0007lV-EL
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936539AbcCQSrj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 14:47:39 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:43310 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935230AbcCQSrg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 14:47:36 -0400
Received: from faui49man2 (faui49man2.informatik.uni-erlangen.de [131.188.42.190])
	by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 340BA58C4CE;
	Thu, 17 Mar 2016 19:47:33 +0100 (CET)
Received: by faui49man2 (sSMTP sendmail emulation); Thu, 17 Mar 2016 19:47:33 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289151>

This commit adds documentation for newly introduced helper commands,
configuration variables and the certificate storage file `.git_tsa_stor=
e`. The
documentation pages for `git tag` and git `verify-tag` are altered to d=
escribe
the new command line options for time-stamping.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
---
 Documentation/config.txt             | 20 +++++++++++
 Documentation/git-http-timestamp.txt | 32 +++++++++++++++++
 Documentation/git-tag.txt            | 30 +++++++++++-----
 Documentation/git-timestamp-util.txt | 52 +++++++++++++++++++++++++++
 Documentation/git-tsa-store.txt      | 68 ++++++++++++++++++++++++++++=
++++++++
 Documentation/git-verify-tag.txt     | 28 ++++++++++++---
 6 files changed, 218 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/git-http-timestamp.txt
 create mode 100644 Documentation/git-timestamp-util.txt
 create mode 100644 Documentation/git-tsa-store.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..8be5fe6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2774,6 +2774,26 @@ transfer.unpackLimit::
 	not set, the value of this variable is used instead.
 	The default value is 100.
=20
+ts.capath::
+	This variable contains a path to a directory with trusted certificate=
s.
+	This is necessary to verify the authenticity of RFC3161 time-stamps i=
n
+	time-stamped tags with `git tag -v` or `git verify-tag`. There is no
+	default value.
+
+ts.failonverify::
+	This variable controls the return value semantics of `git verify-tag`=
=2E
+	If set, both the return values of the gpg signature and the time-stam=
p
+	verification are reported. If the least significant bit is set, it
+	indicates a failure during the gpg signature verification, while the
+	second lowest bit reports the return value of the time-stamp verifica=
tion.
+	Per default, only the return value of the gpg signature verification =
is
+	reported to remain consistent with legacy code.
+
+ts.tsaurl::
+	This variable contains the URL of the Time Stamping Authority from wh=
ich
+	RFC3161 time-stamps should be obtained when creating time-stamped tag=
s
+	with `git tag`. There is no default value.
+
 uploadarchive.allowUnreachable::
 	If true, allow clients to use `git archive --remote` to request
 	any tree, whether reachable from the ref tips or not. See the
diff --git a/Documentation/git-http-timestamp.txt b/Documentation/git-h=
ttp-timestamp.txt
new file mode 100644
index 0000000..1c7781e
--- /dev/null
+++ b/Documentation/git-http-timestamp.txt
@@ -0,0 +1,32 @@
+git-http-timestamp(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-http-timestamp - Helper program to communicate with a RFC3161 Time
+Stamping Authority.
+
+
+SYNOPSIS
+--------
+[verse]
+'git http-timestamp'
+
+DESCRIPTION
+-----------
+Offers an interface for the communication with a RFC3161 Time Stamping=
 Authority
+to obtain a trusted time-stamp signature for a Time Stamping Query. Th=
e Time
+Stamping Query is read from stdin in DER format.
+The response received from the Time Stamping Authority is written to s=
tdout.
+The URL of the Time Stamping Authority must be given using the configu=
ration
+variable `ts.tsaurl`.
+
+NOTES
+-----
+The main purpose of this command is to be called from the internal mec=
hanism of
+`git tag` or `git verify-tag`. Some commands are implemented in this s=
eparate
+binary to allow the usage of libcurl without building all of git again=
st it.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index abab481..940676e 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -9,7 +9,7 @@ git-tag - Create, list, delete or verify a tag object s=
igned with GPG
 SYNOPSIS
 --------
 [verse]
-'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>]
+'git tag' [-a | -s | -t | -u <keyid>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
@@ -25,12 +25,12 @@ to delete, list or verify tags.
=20
 Unless `-f` is given, the named tag must not yet exist.
=20
-If one of `-a`, `-s`, or `-u <keyid>` is passed, the command
+If one of `-a`, `-s`, `-t`, or `-u <keyid>` is passed, the command
 creates a 'tag' object, and requires a tag message.  Unless
 `-m <msg>` or `-F <file>` is given, an editor is started for the user =
to type
 in the tag message.
=20
-If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <keyid>`
+If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, `-t`, and `-u <k=
eyid>`
 are absent, `-a` is implied.
=20
 Otherwise just a tag reference for the SHA-1 object name of the commit=
 object is
@@ -42,10 +42,14 @@ committer identity for the current user is used to =
find the
 GnuPG key for signing. 	The configuration variable `gpg.program`
 is used to specify custom GnuPG binary.
=20
-Tag objects (created with `-a`, `-s`, or `-u`) are called "annotated"
+A tag containing a time-stamp according to RFC3161 will be created whe=
n `-t` is
+used. The configuration variable `ts.tsaurl` is used to specify the UR=
L of the
+Time Stamping Authority from which the time-stamp should be obtained.
+
+Tag objects (created with `-a`, `-s`, `-t`, or `-u`) are called "annot=
ated"
 tags; they contain a creation date, the tagger name and e-mail, a
-tagging message, and an optional GnuPG signature. Whereas a
-"lightweight" tag is simply a name for an object (usually a commit
+tagging message, an optional GnuPG signature, and an optional RFC3161 =
time-stamp.
+Whereas a "lightweight" tag is simply a name for an object (usually a =
commit
 object).
=20
 Annotated tags are meant for release while lightweight tags are meant
@@ -64,6 +68,10 @@ OPTIONS
 --sign::
 	Make a GPG-signed tag, using the default e-mail address's key.
=20
+-t::
+--time-stamp::
+	Add a RFC3161 time-stamp to the tag.
+
 -u <keyid>::
 --local-user=3D<keyid>::
 	Make a GPG-signed tag, using the given key.
@@ -78,7 +86,13 @@ OPTIONS
=20
 -v::
 --verify::
-	Verify the gpg signature of the given tag names.
+	Verify, if present, the gpg signature and the RFC3161 time-stamp of t=
he
+	given tag names. The configuration variable `ts.failonverify` specifi=
es
+	if the return value of the time-stamp verification should be reported=
=2E
+	If set, the return values of both the gpg signature and the time-stam=
p
+	verfification are considered. Per default, only the return value of t=
he
+	gpg signature verfification is reported to remain consistent with leg=
acy
+	code.
=20
 -n<num>::
 	<num> specifies how many lines from the annotation, if any,
@@ -128,7 +142,7 @@ This option is only applicable when listing tags wi=
thout annotation lines.
 	Use the given tag message (instead of prompting).
 	If multiple `-m` options are given, their values are
 	concatenated as separate paragraphs.
-	Implies `-a` if none of `-a`, `-s`, or `-u <keyid>`
+	Implies `-a` if none of `-a`, `-s`, `-t`, or `-u <keyid>`
 	is given.
=20
 -F <file>::
diff --git a/Documentation/git-timestamp-util.txt b/Documentation/git-t=
imestamp-util.txt
new file mode 100644
index 0000000..4724e6f
--- /dev/null
+++ b/Documentation/git-timestamp-util.txt
@@ -0,0 +1,52 @@
+git-timestamp-util(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-timestamp-util - Helper tool to manage RFC3161 time-stamps.
+
+
+SYNOPSIS
+--------
+[verse]
+'git timestamp-util' [-c <sha1>] [-v <sha1>]
+
+DESCRIPTION
+-----------
+Offers an interface to obtain a time-stamp signature for a given SHA1 =
hash or to
+verify the time-stamp of a given SHA1 hash. The signing certificates o=
f the
+response sent by the Time Stamp Autority are stripped and stored in a =
separate
+`git_tsa_store` file to avoid duplicates.
+
+OPTIONS
+-------
+-c sha1::
+	Create a RFC3161 time-stamp over the given hash. The response from th=
e
+	Time Stamping authority is stripped from the signing certificate and
+	then written to stdout as base64.
+
+-v sha1::
+	Verify a time-stamp for the given hash. The corresponding TSR, encode=
d
+	in base64, is read from stdin and merged with its signing certificate
+	from a separate certificate store. To allow the verification of the
+	signing certificate, the configuration variable `ts.capath` must cont=
ain
+	a path to a directory with trusted certificates. The configuration
+	variable `ts.failonverify` controls the return value semantics. If se=
t,
+	the return values of both the gpg signature and the time-stamp
+	verification are reported. The return value of the time-stamp
+	verification is reported using the second lowest bit, the return valu=
e
+	of the gpg signature verification using the least significant bit. Pe=
r
+	default, only the return value of the gpg signature verification is
+	reported to remain consistent with legacy code.
+
+NOTES
+-----
+The main purpose of this command is to be called from the internal
+mechanism of `git tag` or `git verify-tag`. Some commands are implemen=
ted in
+this separate binary to allow the usage of libcrypto without building =
all of git
+against it. While it is possible to is it on its own, the interface is=
 highly
+tailored to the needs of the internal storage mechanisms.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-tsa-store.txt b/Documentation/git-tsa-st=
ore.txt
new file mode 100644
index 0000000..2ce015e
--- /dev/null
+++ b/Documentation/git-tsa-store.txt
@@ -0,0 +1,68 @@
+git-tsa-store(5)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-tsa-store - Stores certificates of RFC3161 Time Stamping Authoriti=
es
+
+DESCRIPTION
+-----------
+A `.git_tsa_store` file stores certificates of RFC3161 Time Stamping A=
uthorities
+from which time-stamps were obtained using `git tag` or `git timestamp=
-util`. To
+avoid unnecessary pollution by large git objects, each RFC3161 time-st=
amp is
+stripped from the signing certificate of the Time Stamping Authority b=
efore it
+is stored in the tag object. These signing certificates are then manag=
ed in the
+`.git_tsa_store` file for each repository.
+
+Each certificate is only stored once in a `.git_tsa_store` file. The c=
omparison
+criterion for equality is the pair of the serial number of the certifi=
cate and
+the common name of the issuer. Therefore it is possible to manage mult=
iple
+certificates for one Time Stamping Authority if for some reason a cert=
ificate
+should change.
+
+The certificates stored in a `.git_tsa_store` file are only used to co=
rrectly
+identify the issuer of a time-stamp. They are not considered trustwort=
hy. For
+verification purposes it is therefore necesssary to specify trusted ce=
rtificates
+using the configuration variable `ts.capath`.
+
+All certificates in a `.git_tsa_store` file are stored using the patte=
rn
+described below.
+
+PATTERN FORMAT
+--------------
+ - The string '-----BEGIN ENTRY-----' marks the beginning of a certifi=
cate
+   entry.
+
+ - The next line is of the format 'Version: <version>'. The current ve=
rsion
+   number is 1.
+
+ - The next line is of the format 'Serial: <serial>', containing the s=
erial
+   number of the certificate. Together with the common name of the iss=
uer it
+   forms the identifying tuple.
+
+ - The next line is of the format 'Issuer: <common name>', containing =
the common
+   name of the issuer of the time-stamp. Together with the serial numb=
er of the
+   certificate it forms the identifying tuple.
+
+ - The next line contains only a new line to separate metadata from th=
e
+   certificate itself.
+
+ - The certificate itself follows in PEM format surrounded by the usua=
l
+   delimiters '-----BEGIN CERTIFICATE-----' and '-----END CERTIFICATE-=
----'.
+
+ - A closing '-----END ENTRY-----' marks the end of an entry.
+
+NOTES
+-----
+The main purpose of a `.git_tsa_store` file is to be managed exclusive=
ly by `git
+timestamp-util`. Nevertheless it is possible to fill in certificates m=
anually as
+long as the above specified format is observed. Manually editing this =
file might
+be necessary in the unlikely case of non-resolvable merge conflicts.
+
+SEE ALSO
+--------
+linkgit:git-timestamp-util[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verif=
y-tag.txt
index d590edc..539e545 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -3,7 +3,7 @@ git-verify-tag(1)
=20
 NAME
 ----
-git-verify-tag - Check the GPG signature of tags
+git-verify-tag - Check the GPG signature and RFC3161 time-stamp of tag=
s
=20
 SYNOPSIS
 --------
@@ -12,13 +12,33 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
-Validates the gpg signature created by 'git tag'.
+Validates the gpg signature and RFC3161 time-stamp created by 'git tag=
'. To
+validate the signing certificate of the Time Stamping Authority of a R=
=46C3161
+time-stamp, a path to a directory of trusted certificates must be give=
n using
+the configuration variable `ts.capath`. The containing files must foll=
ow the
+OpenSSL naming convention `<issuer-hash>.0`. The configuration variabl=
e
+`ts.failonverify` specifies if the return value of the time-stamp veri=
fication
+should be reported.  If set, the return values of both the gpg signatu=
re and the
+time-stamp verfification are considered. Per default, only the return =
value of
+the gpg signature verfification is reported to remain consistent with =
legacy
+code. Using the `-s` or `-t` options overrides the behaviour set by
+`ts.failonverify`.
=20
 OPTIONS
 -------
 --raw::
-	Print the raw gpg status output to standard error instead of the norm=
al
-	human-readable output.
+	Print the raw gpg status output and time-stamp verification output to
+	standard error instead of the normal human-readable output.
+
+-s::
+--signature::
+	Report the return value of the gpg signature verification. If the lea=
st
+	significant bit is set, an error occurred.
+
+-t::
+--timestamp::
+	Report the return value of the time-stamp verification. If the second
+	lowest bit is set, an error occurred.
=20
 -v::
 --verbose::
--=20
2.8.0.rc0.62.gfc8aefa.dirty
