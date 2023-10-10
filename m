Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F420CD80C0
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjJJMrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjJJMrS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:47:18 -0400
X-Greylist: delayed 566 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Oct 2023 05:47:16 PDT
Received: from st43p00im-ztbu10063601.me.com (st43p00im-ztbu10063601.me.com [17.58.63.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92A9B0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1696941468;
        bh=IDE84O+2Un1sHi/WakN/gdWK4wYJ/dPcw7Dlz5Z2XHo=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=jl6XvPKYXOiS00hTvCgAl1ez0mCMXC94qNqTwxjk4Gmcsco3UNo3lax2Dp+tBTqY0
         fkjC05dbc1p97N3eij1J2wCjla7PhjjqUC/m9bV7IOQIsXJhKO7W+DdO17s65Mjyog
         jP7PqiGLE4RdPG1gz0ZkP1XLdxtLSFy06+TjnDrFSn6ha1e+Udr7ZHOeXDEmPfrrsk
         qt2euZVeVce5/UKgChQw/hQOKUWcygDE5W0tIbpazQ41K2fHVWsrvGrRpqDs21JFLA
         JsA0LPA2YJ+Uso9qaxfdZD7YfuE6yv+6AyrKAIMSU6uridOdUv9/B6BacqPv4gGGa1
         mEqVInOQXcYgQ==
Received: from smtpclient.apple (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-ztbu10063601.me.com (Postfix) with ESMTPSA id DFA108C0352;
        Tue, 10 Oct 2023 12:37:47 +0000 (UTC)
From:   Sebastian Thiel <sebastian.thiel@icloud.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: [RFC] Define "precious" attribute and support it in `git clean`
Message-Id: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
Date:   Tue, 10 Oct 2023 14:37:36 +0200
Cc:     Josh Triplett <josh@joshtriplett.org>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.100.2.1.4)
X-Proofpoint-GUID: bUFCDwowCSmyukfs5lUQ-Jt8-uoFsprg
X-Proofpoint-ORIG-GUID: bUFCDwowCSmyukfs5lUQ-Jt8-uoFsprg
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.591,18.0.957,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2023-07-31=5F15:2023-07-31=5F02,2023-07-31=5F15,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2310100091
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Note: I'm collaborating with Josh Triplett (CCed) on the design.]

I'd like to propose adding a new standard gitattribute "precious".  I've
included proposed documentation at the end of this mail, and I'm happy =
to write
the code.  I wanted to get feedback on the concept first.

What's a 'precious' file?

"Precious" files are files that are specific to a user or local =
configuration
and thus not tracked by Git.  As such, a user spent time to create or =
generate
them, and to tune them to fit their needs.  They are typically also =
ignored by
`git` due to `.gitignore` configuration, preventing them to be tracked =
by
accident.

This proposal suggests to make them known to Git using git-attributes so =
that
`git clean` can be taught to treat them with care.

Example: A Linux Kernel .config file

Users can mark the `.config` file as 'precious' using `.gitattributes`:

    /.config precious

When checking which ignored files `git clean -nx` would remove, we would =
see
the following.

    Would remove precious .config
    Would remove scripts/basic/.fixdep.cmd
    Would remove scripts/basic/fixdep
    Would remove scripts/kconfig/.conf.cmd


This highlights precious files by calling them out, but doesn't change =
the
behaviour of existing flags.  Instead, the new flag `-p` is added which =
lets
`git clean` spare precious files.

Thus `git clean -np` would print:

    Would remove scripts/basic/.fixdep.cmd
    Would remove scripts/basic/fixdep
    Would remove scripts/kconfig/.conf.cmd

The precious file is not part of the set of files to be removed anymore.

`git clean -[n|f] -xp` will fail with an error indicating that `-x` and =
`-p`
are mutually exclusive.  The hope is that people can replace some of =
their
usage of `-x` with `-p` to preserve precious files, while continuing to =
use
`-x` if they want a completely clean working directory.

Additional Benefits

`git clean -fdp` can now be used to restore the user's directory to a =
pristine
post-clone state while keeping all files and directories the project or =
user
identifies as precious.  There is less fear of accidentally deleting =
files
which are required for local development or otherwise represent a time
investment.

Example: A precious IDE configuration directory.

To keep IDE configuration, one can also mark entire directories - the =
following
could go into a user-specific gitattributes file denoted by the
`core.attributesFile` configuration.

    /.idea/** precious

With this attributes file in place, `git clean -ndx` would produce the
following output...

    Would remove .DS_Store
    Would remove precious .idea/

...while `git clean -ndp` would look like this:

    Would remove .DS_Store

Here's a patch showing what the documentation could look like.  Happy to =
write
the corresponding code.

---
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 5e1a3d5148..5b2eab6573 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -60,6 +60,10 @@ OPTIONS
 	Use the given exclude pattern in addition to the standard ignore =
rules
 	(see linkgit:gitignore[5]).
=20
+-p::
+	Remove ignored files as well (like `-x`), but preserve =
"precious"
+	files (see linkgit:gitattributes[5]).
+
 -x::
 	Don't use the standard ignore rules (see linkgit:gitignore[5]), =
but
 	still use the ignore rules given with `-e` options from the =
command
diff --git a/Documentation/gitattributes.txt =
b/Documentation/gitattributes.txt
index 6deb89a296..f68aadc3c2 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1248,6 +1248,20 @@ If this attribute is not set or has an invalid =
value, the value of the
 (See linkgit:git-config[1]).
=20
=20
+Preserving precious files
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+`precious`
+^^^^^^^^^^
+
+A file marked as `precious` will be preserved when running =
linkgit:git-clean[1]
+with the `-p` option. Use this attribute for files such as a Linux =
kernel
+`.config` file, which are not tracked by git because they contain =
user-specific
+or build-specific configuration, but which contain valuable information =
that a
+user spent time and effort to create.
+
+
+
 USING MACRO ATTRIBUTES
 ----------------------
=20

What do you think?

Thanks for your feedback,
Sebastian=
