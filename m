From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [patch] Fix a corner case in git update-index --index-info
Date: Sat, 13 Dec 2008 11:29:12 -0800
Message-ID: <7viqpn6fhz.fsf@gitster.siamese.dyndns.org>
References: <200812131403.08740.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 20:30:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBaCD-0005z9-N5
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 20:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbYLMT3U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Dec 2008 14:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbYLMT3U
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 14:29:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbYLMT3T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Dec 2008 14:29:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B59E87859;
	Sat, 13 Dec 2008 14:29:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E651B87858; Sat,
 13 Dec 2008 14:29:14 -0500 (EST)
In-Reply-To: <200812131403.08740.thomas.jarosch@intra2net.com> (Thomas
 Jarosch's message of "Sat, 13 Dec 2008 14:03:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 558D251C-C94C-11DD-9F52-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103014>

Thomas Jarosch <thomas.jarosch@intra2net.com> writes:

> Fix a corner case in git update-index --index-info:
> If there are no input lines, it won't create an empty index.
>
> Here's a short test for this:
> echo -n "" |GIT_INDEX_FILE=3Dindex.new git update-index --index-info
> -> The index "index.new" won't get created
>
> It failed for me while I was using
> git filter-branch as described in the man page:
>
>     git filter-branch --index-filter \
>             =C2=B4git ls-files -s | sed "s-\t-&newsubdir/-" |
>                     GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
>                             git update-index --index-info &&
>             mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE=C2=B4 HEAD
>
> The conversion aborted because the first commit was empty.
> (created by cvs2svn)

If you are doing a filter-branch and the commits near the beginning of =
the
history did not have any path you are interested in, I do not think you
would want to even create corresponding commits for them that record an
empty tree to begin with, so I do not necessarily agree with the above
command line.  The mv would fail due to absense of index.new file, and =
you
can take it as a sign that you can skip that commit.

Outside the context of your command line above, I am slightly more
sympathetic than neutral to the argument that "update-index --index-inf=
o"
(and "update-index --stdin", which I suspect would have the same issue,
but I did not check) should create an output file if one did not exist.

You should note however that such a change would rob from you a way to
detect that you did not feed anything to the command by checking the la=
ck
of the output.  Such a change would break people's existing scripts tha=
t
relied on the existing behaviour; one example is that the above "The mv
would fail...and you can" would be made impossible.

> @@ -308,6 +309,8 @@ static void read_index_info(int line_termination)
>  		unsigned long ul;
>  		int stage;
> =20
> +		found_something =3D 1;
> +
>  		/* This reads lines formatted in one of three formats:
>  		 *
>  		 * (1) mode         SP sha1          TAB path
> @@ -383,6 +386,11 @@ static void read_index_info(int line_termination=
)
>  	bad_line:
>  		die("malformed index info %s", buf.buf);
>  	}
> +
> +	/* Force creation of empty index - needed by git filter-branch */

As I already mentioned, I do not agree with this "needed by" at all.

> +	if (!found_something)
> +		active_cache_changed =3D 1;
> +
>  	strbuf_release(&buf);
>  	strbuf_release(&uq);
>  }

I think this implementation is conceptually wrong, even if we assume it=
 is
the right thing to always create a new file.  The --index-info mode may
well be fed with the same information as it already records, in which c=
ase
active_cache_changed shouldn't be toggled, and if it is fed something
different from what is recorded, active_cache_changed should be marked =
as
changed, and that decision should be left to the add_cache_entry() that=
 is
called from add_cacheinfo().  What you did is to make it _always_ write
the new index out, even if we started with an existing index, and there
was no change, or even if we started with missing index, and there was =
no
input.  You only wanted the latter but you did both.

If that is what you want to do, you can get rid of found_something logi=
c
altogether and flip active_cache_changed unconditionally to do the same
thing, but it feels wrong to write the index out when nothing changed.

Since I said I am slightly more sympathetic than neutral, here is a pat=
ch
that forces creation of an empty index file without making it write out
the same thing if the index already existed.

But again, this would break people who have been relying on the existin=
g
behaviour that no resulting file, when GIT_INDEX_FILE points at a
nonexistent file, signals no operation.

I think it is a bad idea to do this in -rc period, even if we were to
change the semantics.

 builtin-update-index.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git c/builtin-update-index.c w/builtin-update-index.c
index 65d5775..9abc0b2 100644
--- c/builtin-update-index.c
+++ w/builtin-update-index.c
@@ -566,6 +566,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 	char set_executable_bit =3D 0;
 	unsigned int refresh_flags =3D 0;
 	int lock_error =3D 0;
+	int was_unborn;
 	struct lock_file *lock_file;
=20
 	git_config(git_default_config, NULL);
@@ -580,6 +581,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 	entries =3D read_cache();
 	if (entries < 0)
 		die("cache corrupted");
+	was_unborn =3D is_cache_unborn();
=20
 	for (i =3D 1 ; i < argc; i++) {
 		const char *path =3D argv[i];
@@ -677,7 +679,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 					die("--index-info must be at the end");
 				allow_add =3D allow_replace =3D allow_remove =3D 1;
 				read_index_info(line_termination);
-				break;
+				goto finish;
 			}
 			if (!strcmp(path, "--unresolve")) {
 				has_errors =3D do_unresolve(argc - i, argv + i,
@@ -738,7 +740,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 	}
=20
  finish:
-	if (active_cache_changed) {
+	if (active_cache_changed || was_unborn) {
 		if (newfd < 0) {
 			if (refresh_flags & REFRESH_QUIET)
 				exit(128);
