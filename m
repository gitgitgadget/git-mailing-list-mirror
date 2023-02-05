Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4AEC636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 22:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBEWRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 17:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBEWRe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 17:17:34 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001E61ABD7
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 14:17:32 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C8EBB5A309;
        Sun,  5 Feb 2023 22:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1675635451;
        bh=6luZGz+OueBx/S+bD1WlK2FauZY1OdyZ1ZSSaPfrKg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=C3uH/X/9cKfWdfLwMFZth7jdgvqiVea7wo8CO5Osr66jVo+PxMAh7jFAH0ec+Oo7a
         G/jVzsq8TVaSR0D/8WMrzGQgO+POEgpN+bdkCvFhmq6IYWal+u5BR60s4PJcvkY3oG
         hJk3V4+PO5dG6rsxGsyhEMOb+n3eoX57IAP+ko4fDmE2LwAJ0NxYc6r1P7PofHcz+S
         AqSD4OuQe9yZQqBYEt+ADp0+u6dxk0FCyTU2eqQu+qUWIATVwi7IaDknlTr0z+YK9+
         0ly/SquwIf4Qkufddk2MRYwC3JIKr+NG4QPGHGbiDKsi5O6eAIN4k5iH+PLxV1+zya
         k6Ebh5V+a7JzRFgo9Wez0gDHgEuuld8yPcKbucVXBwEJJEOB14YSuRr13Um5ajbc52
         HdDU1sk3+4YaxrrSq2YGSr8Q+poen8R93OWvjA/75RHI5DnPlUdTw/29pFNzQ8N4T+
         8j7d/wB9tA55s4LjvBX0YnI7BErq8BMPkNIC08jDNHM/IeiVTa8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eli Schwartz <eschwartz93@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 1/1] Document a fixed tar format for interoperability
Date:   Sun,  5 Feb 2023 22:17:28 +0000
Message-Id: <20230205221728.4179674-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230205221728.4179674-1-sandals@crustytoothpaste.net>
References: <20230205221728.4179674-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Right now, many people wish to have archives which are consistent among
Git versions.  That is not something we currently offer, but users often
rely on the fact that our tar format changes rarely and assume it will
never change, which has caused lots of problems with various sites in
the past.

Instead of letting this go on indefinitely, let's explicitly document a
versioned canonical tar format which is completely reproducible and
which we guarantee will be permanently stable.  This format is more
rigid than the current tar format, but it produces identical results for
identical trees, regardless of hash algorithm, and is easy to implement
in other tools.  This is beneficial because lots of people want fixed,
reproducible archives, and there's little reason to duplicate work.

This format, like the existing format, is actually a pax format archive,
which is an extension to the ustar (Unix standard tar) format.  This
format was documented by POSIX in 2001 and is well understood by most
modern tar implementations, including GNU tar and libarchive, which
covers the versions of tar used on most major operating systems,
including Windows, Linux, macOS, and most BSDs.

The format in this document does mandate a pax header for each file,
which slightly increases the size of the archive.  However, to properly
embed timestamps, GNU tar and libarchive's tar also do this when
generating pax archives, and because the data is highly redundant, it
will compress extremely well.  A comparison between the two approaches
using GNU tar and libarchive's tar on Git's working tree shows that with
default gzip compression, the increase in size is about 1.2%, which is
fine for almost every use case.  In return, we get a substantially
simpler (and thus, likely, more correct) implementation which is much
easier to test.
---
 Documentation/technical/tarball.txt | 234 ++++++++++++++++++++++++++++
 1 file changed, 234 insertions(+)
 create mode 100644 Documentation/technical/tarball.txt

diff --git a/Documentation/technical/tarball.txt b/Documentation/technical/tarball.txt
new file mode 100644
index 0000000000..fd23df2f33
--- /dev/null
+++ b/Documentation/technical/tarball.txt
@@ -0,0 +1,234 @@
+Git Canonical Tar Format
+========================
+
+Overview
+--------
+
+Many people find it convenient to have tar archives that are bit-for-bit
+identical between versions.  This can be valuable to validate that an archive
+has not changed using a cryptographic hash without needing to store the archive
+itself.
+
+However, up to now, Git has not guaranteed a consistent format, although people
+often make the assumption that Git's archives will always be bit-for-bit
+identical.  This has led to several notable problems with various forges.
+
+This document proposes a canonical tar format based on the POSIX pax format that
+is bit-for-bit identical.  It is referred to as ctar-v1 (canonical tar version 1).
+
+Goals and Rationale
+-------------------
+
+The goals for this format are that it is first and foremost reproducible, that
+identical trees produce identical results, that it is simple and easy to
+implement correctly, and that it is useful in general.  While we don't consider
+functionality needs beyond Git's at the moment (such as hardlinks, xattrs, or
+sparse files), there is intense interest in reproducible builds, and so it makes
+sense to design something that can see general use for software interchange.
+
+Because the goal is strict reproducibility, this format doesn't honor
+`tar.umask` or other options that can produce different output.  It serializes
+all timestamps as the Epoch, which produces identical results whether the tree
+is serialized as a tree, commit, or tag.  This is consistent with the behaviour
+of some other tar serializers, including the default for modern Rust crates, and
+is not believed to pose any interoperability problems.
+
+Object IDs are not included in this version of the format because this produces
+non-identical data when identical data is serialized with different hash
+algorithms.
+
+Introduction to the Underlying Format
+-------------------------------------
+
+A pax archive is an extended form of the ustar (Unix standard tar) archive, both
+defined in POSIX.1-2001.  Each file in a ustar archive is preceded by a single
+512-byte header block, followed by as many 512-byte data blocks as needed to
+store the data, padded with zeros.  At the end of the archive are two 512-byte
+blocks filled completely with zeros.
+
+A pax archive may additionally contain extended headers.  There is optionally
+one for the entire archive, which is called the global header, and one for each
+file.  If present, the global extended header is the first entry in the archive,
+and the per-file header precedes the file to which it corresponds.  Every
+extended header contains a normal ustar header block with either the `g`
+(global) or `x` (per-file) type, followed by metadata in a textual
+length-key-value form (`%d %s=%s\n`) which is stored as the data of this
+pseudo-file.
+
+A global extended header sets metadata for the entire file, and a per-file
+extended header applies to only the to which it corresponds.  A per-file
+extended header overrides any data specified in the global extended header, and
+all extended headers override any data stored in a normal ustar per-file header
+block.
+
+While pax extensions are widely supported by most modern versions of tar
+(including versions on Windows and all major open-source OSes), some older
+archivers and non-tar implementations which do not understand them typically
+extract the extended headers as regular files.  Thus, it's helpful to have these
+entries have reasonable permissions and unique names.
+
+General Architecture
+--------------------
+
+All canonical tar archives are valid POSIX pax archives as that format is
+defined in POSIX.1-2017.  Every archive will have a global header indicating the
+version and format and what types of data are valid in the archive.
+
+Every file serialized in the archive is serialized in lexicographical order by
+its bytes.  A directory is always serialized before its contents, and a
+directory is never serialized with a trailing slash.  If a system uses a Unicode
+encoding other than UTF-8, it encodes filenames as UTF-8.  Each file shall
+contain a pax extended header record.
+
+It is possible to encode some extended headers in multiple ways because the
+length in the header encodes its own length.  For example, in cases where the
+length value can be encoded as either 99 or 100, both can lead to identical
+header data.  The shortest possible encoding must always be used.
+
+In any event where multiple encodings are possible, the shortest and, if there
+is still confusion, lexicographically first (by byte value) must always be used.
+All unspecified padding is filled with NUL bytes.
+
+Version Number
+--------------
+
+The version number for this version is `ctar-v1`.
+
+Extended Headers
+----------------
+
+Global Extended Header
+~~~~~~~~~~~~~~~~~~~~~~
+
+The global extended header (record `g`) shall contain one header:
+`CTAR.version`, which contains the version number specified above.
+
+The contents of the ustar header for the global extended header are as below,
+except that the `name` field contains `pax_global_header`.
+
+Per-File Extended Header
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Each file has a per-file extended header.
+
+The following per-file extended header fields are included:
+
+|===
+| Field Name   | When Present  | Value
+
+| `atime`      | always        | `0`
+| `mtime`      | always        | `0`
+| `size`       | always        | size of the data in bytes
+| `path`       | always        | full path name of the file
+| `uid`        | always        | `0`
+| `gid`        | always        | `0`
+| `uname`      | always        | `root`
+| `gname`      | always        | `root`
+| `linkpath`   | symbolic link | full path name of the link destination
+| `hdrcharset` | binary path   | `BINARY`
+
+Note that the `hdrcharset` entry appears if and only if the `path` or, if
+present, the `linkpath`, header contains a non-UTF-8 encoded string.  Because
+Git does not store the encoding of file names, it has no way of knowing whether
+a file name which could be valid UTF-8 actually is, but for the purposes of
+compatibility, such file names are assumed to be UTF-8 and are not declared as
+binary.  This improves portability to systems which always use Unicode.
+
+However, we because we do not know for certain whether these values are UTF-8,
+we avoid explicitly declaring them as such and rely on the default archiver
+behavior, which may be more sensible.
+
+The `path` field contains the full path name without a leading slash or leading
+`.` or `..` component.  The path never contains a directory component which is
+`.` or `..`.
+
+The `linkpath` field contains the full symbolic link destination.  `.` and `..`
+components are permitted if the destination contains those values.
+
+In all cases, path names use `/` as the directory separator.
+
+The reason for always including most of the entries in the archive is to aid in
+implementing and testing correct serialization.  If these entries are always
+present, then this process becomes much simpler, whereas if they are only
+included as needed, then errors are more likely.
+
+The `name` field of the ustar header of this extended header is `paxheader.%d`,
+where `%d` represents the shortest-form decimal integer encoding the index of
+this file in the archive, starting with 0.  All files, directories, and links of
+whatever kind are counted, but extended headers are not.
+
+Serialization of Extended Headers
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+When serializing the header block for an extended header, the following values
+should be used.  Note that all text fields are be NUL-padded on the right when
+they do not fill the field, and all octal fields are left-padded with zeros such
+that they fill the field with a single trailing NUL.  An empty field contains
+only NULs.
+
+|===
+| Field Name | Value
+
+| `name`     | `pax_global_header` (global) or `paxheader.%d` (per-file) (see above)
+| `mode`     | `0640`
+| `uid`      | `0`
+| `gid`      | `0`
+| `size`     | the size of the extended header in bytes
+| `mtime`    | `0` (the Epoch)
+| `chksum`   | as specified in the standard
+| `typeflag` | `g` (global) or `x` (per-file)
+| `linkname` | empty
+| `magic`    | as specified in the standard
+| `version`  | as specified in the standard
+| `uname`    | `root`
+| `gname`    | `root`
+| `devmajor` | `0`
+| `devminor` | `0`
+| `prefix`   | empty
+|===
+
+When encoding the data for an extended header, all entries are sorted in order
+by the byte values of their keys as encoded in UTF-8.  Duplicate keys are not
+permitted.
+
+Because the format allows multiple length encodings of some values, the shortest
+possible encoding must always be used.
+
+ustar headers
+-------------
+
+The ustar header for each file is serialized as below.  Note that all text
+fields are be NUL-padded on the right when they do not fill the field, and all
+octal fields are left-padded with zeros such that they fill the field with a
+single trailing NUL.  An empty field contains only NULs.
+
+|===
+| Field Name | Value
+
+| `name`     | the last path component if it fits; otherwise, `path.%d`
+| `mode`     | `0640` (regular file), `0777` (symbolic link), `0750` (directory)
+| `uid`      | `0`
+| `gid`      | `0`
+| `size`     | the size of the data in bytes for regular files if it fits; otherwise, `0`
+| `mtime`    | `0` (the Epoch)
+| `chksum`   | as specified in the standard
+| `typeflag` | `0` (regular file), `2` (symbolic link), `5` (directory)
+| `linkname` | empty
+| `magic`    | as specified in the standard
+| `version`  | as specified in the standard
+| `uname`    | `root`
+| `gname`    | `root`
+| `devmajor` | `0`
+| `devminor` | `0`
+| `prefix`   | all non-trailing path components if they fit; otherwise, empty
+|===
+
+Note that the `size` field is always 0 for non-regular files.  The `typeflag`
+value for regular files is always `0`, not NUL.
+
+`prefix` does not contain a trailing slash.
+
+If the `name` field cannot contain the last path component, then it is
+serialized as `path.%d`, where `%d` represents the shortest-form decimal integer
+encoding the index of this file in the archive, starting with 0.  The `%d` value
+in this case is completely identical to the `%d` in the per-file pax header.
