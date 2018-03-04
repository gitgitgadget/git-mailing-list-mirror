Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71A581F576
	for <e@80x24.org>; Sun,  4 Mar 2018 08:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbeCDIkc (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 03:40:32 -0500
Received: from mail3.protonmail.ch ([185.70.40.25]:50329 "EHLO
        mail3.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbeCDIkb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 03:40:31 -0500
Date:   Sun, 04 Mar 2018 03:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=urandom.co.uk;
        s=protonmail; t=1520152828;
        bh=1fJIHaWHa0iD/O5lSUcecSYOuqJNZ/Jgj318qfi38DE=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=M61FmxKOwDJ6eFBdnWetDHvIHNU0dXE9GTo4V8kI7KmlYUzrJV77IEq9pRrWnF6Uw
         rDBYdhwuBqOu0MpvAil/TyNWiUBGr9QY6ACRGDPsfrZ7DDfidmLiRz+E44N99azDR2
         pvXzHTeOPsCPBfi0UuP5X8NlHVIAxt/1xUB0pvuw=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Colin Arnott <colin@urandom.co.uk>
Reply-To: Colin Arnott <colin@urandom.co.uk>
Subject: [PATCH] http.c: shell command evaluation for extraheader
Message-ID: <CngnTUCx1pVSyKUzINZV972DlD_JMH53F-L2PZtx0_RKMiwXYY4f2UzDPeJaC5fL-6oJBXAxQ5f0OC76I_fagEWxch5csI716N7bQDh3gR8=@urandom.co.uk>
Feedback-ID: yOOU7P6jxO77HcrFw4SgItADp6aEzrzaBrsweNUU3GchxkXYtI8xYBc21P-ZUn-yQhUSAkQaHpx8GP3vtEZa9g==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The http.extraHeader config parameter currently only supports storing
constant values. There are two main use cases where this fails:

  0. Sensitive payloads: frequently this config parameter is used to pass
     authentication credentials in place of or in addition to the
     Authorization header, however since this value is required to be in
     the clear this can create security issues.

  1. Mutating headers: some headers, especially new authentication
     schemes, leverage short lived tokens that change over time.

There do exist solutions with current tools for these use cases, however
none are optimal:

  0. Shell alias: by aliasing over git with a call to git that includes the
     config directive and evaluates the header value inline, you can
     fake the desired mutability:
       `alias git=3D'git -c http.extraHeader=3D"$(gpg -d crypt.gpg)"'`
     This presents two problems:
     a. aliasing over commands can be confusing to new users, since git
        config information is stored in shell configs
     b. this solution scales only to your shell, not all shells

  1. Global hook: you could implement a hook that writes the config
     entry before fetch / pull actions, so that it is up to date, but
     this does nothing to secure it.

  2. git-credential-helper: the credential helper interface already
     supports shelling out to arbitrary binaries or scripts, however
     this interface can only be used to populate the Authorization
     header.

The optimal solution involves extending the current implementation of
http.extraHeader parsing to allow for arbitrary shell command execution.
There seem to be two paradigms for such features:

  0. Overloading with '!' prefixes: seen in alias.* and credential.helper

  1. New "Cmd" suffix parameters: seen in sendemail.toCmd sendemail.ccCmd

While the latter may be more clear without documentation, the addition
of a new config parameter seemed more complex for the codebase. As such,
new documentation is included.

Several edge cases came up during implementation and the following
design decisions were made:

  0. Stdin and stderr for the child_process are exposed to the user:
     this allows commands that print status information via stderr, and
     accept input to function. The use case considered is text input for
     decryption and error handling that is out of scope for git.

  1. Failure to exec: if either the file does not exist, or any other
     exec related failure occurs, no error is presented to the user,
     and the header is not included

  2. Non-zero return code: if the child_process returns a non-zero
     value, no error is presented to the user, the return value is
     consumed, and the header is not included in the request.

  3. Headers starting with the '!' character require a shell command to
     create: because no escaping syntax was implemented, the following
     is required for such headers: "!printf '!magic: abra'"

Signed-off-by: Colin Arnott <colin@urandom.co.uk>
---
 Documentation/config.txt    |  7 +++++++
 http.c                      | 20 ++++++++++++++++++++
 t/t5551-http-fetch-smart.sh |  6 ++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f57e9cf10..4b2171d60 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1918,6 +1918,13 @@ http.extraHeader::
 =09more than one such entry exists, all of them are added as extra
 =09headers.  To allow overriding the settings inherited from the system
 =09config, an empty value will reset the extra headers to the empty list.
+=09If the value is prefixed with an exclamation point, it will
+=09be treated as a shell command.  For example, defining
+=09"http.extraHeader =3D !gpg -d < secure_header.gpg", will pass the
+=09decrypted header, if the command does not exec cleanly or has a
+=09non-zero return value, no header will be added.  Note that shell
+=09commands will be executed from the top-level directory of a
+=09repository, which may not necessarily be the current directory.
=20
 http.cookieFile::
 =09The pathname of a file containing previously stored cookie lines,
diff --git a/http.c b/http.c
index 31755023a..11103df41 100644
--- a/http.c
+++ b/http.c
@@ -380,6 +380,26 @@ static int http_options(const char *var, const char *v=
alue, void *cb)
 =09=09} else if (!*value) {
 =09=09=09curl_slist_free_all(extra_http_headers);
 =09=09=09extra_http_headers =3D NULL;
+=09=09} else if (value[0] =3D=3D '!') {
+=09=09=09struct child_process cp =3D CHILD_PROCESS_INIT;
+=09=09=09cp.git_cmd =3D 0;
+=09=09=09cp.in =3D 0;
+=09=09=09cp.out =3D -1;
+=09=09=09cp.err =3D 0;
+=09=09=09cp.use_shell =3D 1;
+=09=09=09argv_array_push(&cp.args, value + 1);
+=09=09=09if (!start_command(&cp)) {
+=09=09=09=09struct strbuf output;
+=09=09=09=09strbuf_init(&output, 0);
+=09=09=09=09strbuf_read(&output, cp.out, 0);
+=09=09=09=09close(cp.out);
+=09=09=09=09cp.out =3D -1;
+=09=09=09=09if (!finish_command(&cp)) {
+=09=09=09=09=09extra_http_headers =3D
+=09=09=09=09=09=09curl_slist_append(extra_http_headers, output.buf);
+=09=09=09=09}
+=09=09=09=09strbuf_release(&output);
+=09=09=09}
 =09=09} else {
 =09=09=09extra_http_headers =3D
 =09=09=09=09curl_slist_append(extra_http_headers, value);
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index f5721b4a5..039afc76a 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -351,7 +351,9 @@ test_expect_success 'custom http headers' '
 =09test_must_fail git -c http.extraheader=3D"x-magic-two: cadabra" \
 =09=09fetch "$HTTPD_URL/smart_headers/repo.git" &&
 =09git -c http.extraheader=3D"x-magic-one: abra" \
-=09    -c http.extraheader=3D"x-magic-two: cadabra" \
+=09    -c http.extraheader=3D"!printf \"x-magic-two: cadabra\"" \
+=09    -c http.extraheader=3D"!printf \"x-magic-three: alakazam; exit 2\""=
 \
+=09    -c http.extraheader=3D"!shellcommanddoesnotexist" \
 =09    fetch "$HTTPD_URL/smart_headers/repo.git" &&
 =09git update-index --add --cacheinfo 160000,$(git rev-parse HEAD),sub &&
 =09git config -f .gitmodules submodule.sub.path sub &&
@@ -360,7 +362,7 @@ test_expect_success 'custom http headers' '
 =09git submodule init sub &&
 =09test_must_fail git submodule update sub &&
 =09git -c http.extraheader=3D"x-magic-one: abra" \
-=09    -c http.extraheader=3D"x-magic-two: cadabra" \
+=09    -c http.extraheader=3D"!printf \"x-magic-two: cadabra\"" \
 =09=09submodule update sub
 '
=20
--=20
2.16.2


