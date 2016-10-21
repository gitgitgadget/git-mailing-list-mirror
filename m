Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B19020229
	for <e@80x24.org>; Fri, 21 Oct 2016 18:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755111AbcJUSX6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 14:23:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53957 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753620AbcJUSX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 14:23:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4533145F1D;
        Fri, 21 Oct 2016 14:23:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W+RMT7UtrvpP1MpX4OF9e9I6Fh0=; b=qDBsOV
        lwIeS/OQC8M6MwqayWhkEjS1Vl8ADE/U6v+EOp9iZZ5A+brBYk+YPW3sjVF1bFE2
        eYo74hPMoxPOHM8PF5OsrEAbSQRMZNbgx0rSo6PYn/0HYo0cjxvtsnI2AAmobnrJ
        CYZ5gje1MrOpf25xNzETT6gURLNb413kyKVvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l0GAB7VSvJTmQuhpLgE38fBT2j3wgaZA
        v5gFg4HVwv6pCHxQseIwfa7ysprBEDjrMk6Z6+oi8ioPC0as9BxCvi5Pm/lXWc8t
        Izy50ASZV8WJJovJdvOiGdSG1NoFXqr+I/GO4Tx7HUFrusilcaLiFMlOT5LfJuoY
        9zToVYcgCog=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38FE045F1B;
        Fri, 21 Oct 2016 14:23:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A55B745F1A;
        Fri, 21 Oct 2016 14:23:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Luke Shumaker <lukeshu@sbcglobal.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon, path.c: fix a bug with ~ in repo paths
References: <20161018150629.23205-1-lukeshu@sbcglobal.net>
        <xmqqvawppote.fsf@gitster.mtv.corp.google.com>
        <87pomxildc.wl-lukeshu@sbcglobal.net>
        <CACsJy8AzWqJ_9JQ_BGnAB3E3GrGSTS40z8umbtO6mQJukWOooQ@mail.gmail.com>
        <xmqqlgxhd77u.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 21 Oct 2016 11:23:53 -0700
In-Reply-To: <xmqqlgxhd77u.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 21 Oct 2016 08:58:45 -0700")
Message-ID: <xmqqvawlblxi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86C23D16-97BB-11E6-81E9-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> The amount of changes is unbelievable for fixing such a rare case
>> though. I wonder if we can just detect this in daemon.c and pass
>> "./~foo/bar" instead of "~foo/bar" to enter_repo() in non-strict mode
>> to "disable" expand_user_path(). If it works, it's much simpler
>> changes (even though a bit hacky)
>
> Conceptually, it ought to be updating the code that says "Does it
> begin with a tilde?  Then try to do user-path expansion and fail if
> that is not enabled and if it succeeds use the resulting directory"
> to "Is user-path enabled and does it begin with a tilde?  Then try
> to do user-path expansion and if it succeeds use the resulting
> directory".  Compared to that mental model we have with this
> codepath, I agree that the change does look quite invasive and
> large.
>
> It is OK for a change to be large, as long as the end result is
> easier to read and understand than the original.  I am undecided if
> that is the case with this patch, though.

I am still not convinced that this is a bugfix (as opposed to "add a
new feature to please Luke while regressing it for others"), but the
"this looks too invasive" made me look at the codepath involved.

There is this code in daemon.c::path_ok() that takes "dir" and ends
up calling enter_repo().

	if (*dir == '~') {
		if (!user_path) {
			logerror("'%s': User-path not allowed", dir);
			return NULL;
		}

At first glance, it ought to be a single-liner

-	if (*dir == '~') {
+	if (user_path && *dir == '~') {

to make 'git://site/~foo.git" go to "/var/scm/~foo.git" when base
path is set to /var/scm/.  

Unfortunately that is not sufficient.

A request to "git://<site>/<string>", depending on <string>, results
in "directory" given to path_ok() in a bit different forms.  Namely,
connect.c::parse_connect_url() gives

    URL				directory
    git://site/nouser.git	/nouser.git
    git://site/~nouser.git	~nouser.git

by special casing "~user" syntax (in other words, a pathname that
begins with a tilde _is_ special cased, and tilde is not considered
a normal character that can be in a pathname).  Note the lack of
leading slash in the second one.

Because that is how the shipped clients work, the daemon needs a bit
of adjustment, because interpolation and base-path prefix codepaths
wants to accept only paths that begin with a slash, and relies on
the slash when interpolating it in the template or concatenating it
to the base (e.g. roughly "sprintf(buf, "%s%s", base_path, dir)").

I came up with the following as a less invasive patch.  There no
longer is the ase where "user-path not allowed" error is given,
as treating tilde as just a normal pathname character even when it
appears at the beginning is the whole point of this change.

As I said already, I am not sure if this is a good change, though.
 daemon.c              |  9 +++++----
 t/t5570-git-daemon.sh | 11 +++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index afce1b9b7f..e560a535af 100644
--- a/daemon.c
+++ b/daemon.c
@@ -160,6 +160,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 {
 	static char rpath[PATH_MAX];
 	static char interp_path[PATH_MAX];
+	char tilde_path[PATH_MAX];
 	const char *path;
 	const char *dir;
 
@@ -170,11 +171,11 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 		return NULL;
 	}
 
+	if (!user_path && *dir == '~') {
+		snprintf(tilde_path, PATH_MAX, "/%s", dir);
+		dir = tilde_path;
+	}
 	if (*dir == '~') {
-		if (!user_path) {
-			logerror("'%s': User-path not allowed", dir);
-			return NULL;
-		}
 		if (*user_path) {
 			/* Got either "~alice" or "~alice/foo";
 			 * rewrite them to "~alice/%s" or
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 225a022e8a..b6d2b9a001 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -65,6 +65,17 @@ test_expect_success 'remote detects correct HEAD' '
 	)
 '
 
+test_expect_success 'tilde is a normal character without --user-path' '
+	nouser="~nouser.git" &&
+	nouser_repo="$GIT_DAEMON_DOCUMENT_ROOT_PATH/$nouser" &&
+	mkdir "$nouser_repo" &&
+	git -C "$nouser_repo" --bare init &&
+	>"$nouser_repo/git-daemon-export-ok" &&
+	git push "$nouser_repo" master:master &&
+
+	git ls-remote "$GIT_DAEMON_URL/$nouser"
+'
+
 test_expect_success 'prepare pack objects' '
 	cp -R "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo.git "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git &&
 	(cd "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git &&
