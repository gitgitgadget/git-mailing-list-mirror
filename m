Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A64FC433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 19:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbiBGTJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 14:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbiBGTD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 14:03:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783FDC0401E1
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 11:03:27 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v10-20020a05690204ca00b0061dd584eb83so3897965ybs.21
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 11:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=NLGNt3+8nBGJVL3+CY0XEbxgmPkTYco6xgokFDEwk7I=;
        b=bpmXucFHsXFt50Zf3RtlvrP2dt3UNmMvtdPjoD7eSMRXehWPnLLqAvXgHXlBNtHqNL
         +gPWhjGCxMHYywhmgRMYbCtjhB2glIET20kkylfkPVY+HEKpK5PqeNMKDn8Vc7qJqc2f
         KgtDW8RtYQ4tgbC6JgKyDwQL9y3YfoxXeUi8KAORV1sYuoHHxKYzAa7uhNkY0vKcatuz
         tc7iIsmNLILiCwKTaHToAFt6tilx7iRxWEQRr/CKWw+JWlbli2zo9BQfbDlHth3is0DJ
         jBlIW6WV5Ei4Pp7fF+h0qx0WjTGB847tlaUNQkadt2Cl8f1W81RM6fJBIQJEXllNpqAI
         jcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=NLGNt3+8nBGJVL3+CY0XEbxgmPkTYco6xgokFDEwk7I=;
        b=UB+PuIszNM8GKf5gFcg0CVqAJ75KrnJs6FAWyU0vWt/ddtyiL/0xCpOwbqaGvD4eTZ
         gLgxcBH/+JGhPqTj2nRz2dCuMfzfQncjneAq3R+3CAMYdiF4kWEOdEPNRTWGHYr4PeLJ
         Rt1tt2YguHpBZXJT/LmDgrjVOJXdo0kR7hCV9NTmnHiACqTA3EmUI2lfPO84JxquVOHi
         sK1q9Gr0goZ1cN7+Dc2tS+l0eynagQkQQY3/XTh5/HbgSEuLIcMG6TAdAayOBYifSAXr
         xTkLDDYLz+e5BZnmgr/IvsAhuWvNGkY9o6g1QMee285GVDJ4baWHlhWbpkKTaa6W/sJo
         5KfA==
X-Gm-Message-State: AOAM531LGebkj7QqfD7yF8dnGHQr7xTMU8JOtfvlQ0Zl966mUZXxXztG
        MCOYob8E7L0o5kSyPsdKXcjstDSLo5ZKeL3XYirVjSIG8gLonE5r1D0DL5uubiyw1qe9Ct0o/EN
        Fv48EQB48BC0/KkHM19WSy7PxnBblKJdYvnm8riTH1a94TeaHCLXd3E8YYuNQAIdfGNXnk4h6BY
        ZO
X-Google-Smtp-Source: ABdhPJyTjkREJ5/A7lVCh5G9gqpZFe0SCNXNBP26kNcUnWUjNCLH/2vdo1jLuZUo72RsBH1GyPZuu965iIPkJvC8Zaln
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1022:: with SMTP id
 x2mr1276279ybt.62.1644260606612; Mon, 07 Feb 2022 11:03:26 -0800 (PST)
Date:   Mon,  7 Feb 2022 11:03:19 -0800
Message-Id: <20220207190320.2960362-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [RFC] Bidirectional communication with a long-running Git process
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     jabolopes@google.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a proposal of what we (the Git team at Google) are planning to
build, about bidirectional communication between a long-running Git
process and another long-running process. We're planning to build this
to help with a virtual file system layer that we're also building (as
described below), but we envision this to also be useful for anyone that
needs deeper integration with Git repositories beyond running Git
commands one at a time.
=20
Any comments or suggestions are welcome.
=20
-----
# Git API extensions (external)

Authors: Jose Lopes (jabolopes@google.com), Jonathan Tan
(jonathantanmy@google.com)

## Objective

Google is working to improve development workflows for large Git repositori=
es,
by means of a virtual file system layer (vfsd) which downloads contents laz=
ily.
We have an internal prototype vfsd that we're using to experiment with this=
.

There are a number of correctness and performance challenges in materializi=
ng
the filesystem that we cannot address today with the currently available Gi=
t
APIs. For this reason, this document proposes several Git API extensions to=
:

*   List entries from the Git index file that match a certain path prefix
*   Obtain specific fields from the entries stored in the Git index file
*   Batch fetches by sending out a single network request with a variable n=
umber
    of Git objects
*   Obtain file sizes for a variable number of Git objects efficiently (via
    object-info)

The API extensions proposed in this document are not the only ones that we =
will
ever need. As the project development progresses, our developers will need =
to
design, implement and propose new API extensions to Git to address future n=
eeds.

The APIs will be called on a persistent connection between Git and vfsd to =
avoid
the performance cost of running one-off Git commands during filesystem
operations. This communication mechanism will be used for both the APIs pro=
posed
in this doc and future ones, too.

To establish the connection, vfsd spawns Git and runs a new Git command tha=
t we
also propose in this document. Then vfsd and Git can communicate over stdin=
/out.
vfsd can use this to pipe commands to Git and obtain results. Conversely Gi=
t can
also send commands to vfsd and obtain results. vfsd and Git will communicat=
e
using the pkt-line format because it=E2=80=99s already supported by Git.

In summary, this document proposes:

*   a generic RPC protocol based on the pkt-line format, that can be used a=
s the
    basis of communication between Git and vfsd, but it is generic enough s=
o
    that it can be used by any external process to talk to Git.
*   API extensions on top of this pkt-line RPC protocol, which are useful f=
or
    virtual filesystem layers built on top of Git.
*   A new command, called *git-batch*, which implements the pkt-line RPC
    protocol and these API extensions.

## Background

Today vfsd interacts with Git in 2 different ways, namely, via the Git cat-=
file
daemon and by spawning one-off Git processes.

The Git cat-file daemon (i.e., *git cat-file --batch*) is a long-lived proc=
ess
that accepts commands from vfsd via stdin and returns output via stdout /
stderr. The commands accepted by git-cat-file are limited (see
[git-rev-parse](https://git-scm.com/docs/git-rev-parse#_specifying_revision=
s)).
vfsd uses the Git cat-file daemon to obtain file contents for files display=
ed in
the FUSE filesystem. This results in a full connection setup/teardown with =
the
Git remote server for every object that is fetched, which results in user
visible latency and impacts performance.

vfsd needs to read tree objects, obtain object sizes, obtain the contents o=
f the
Git index file, among others, which are not supported by the Git cat-file
daemon. In this case, vfsd ends up running other Git commands, such as,
`git-cat-file -s`, `git-fetch`, `git-ls-files`, etc. These commands are run=
 by
spawning one-off Git processes. This incurs a performance penalty every tim=
e
vfsd needs to run a Git command since it requires creating a new system pro=
cess
(via `fork`/`exec`).

For obtaining file sizes, vfsd uses a one-off Git process (`git-cat-file -s=
`),
but we would like to use the Git cat-file daemon to obtain size information
also. This would allow us to reuse the existing infrastructure for the Git
cat-file daemon and also get better performance by avoiding spawning one-of=
f
processes to obtain size information. Also, vfsd needs a performant API to
obtain size information for a variable number of objects. This API does not
exist yet.

For batch fetching, vfsd uses a one-off Git process (`git fetch`) with seve=
ral
flags, one of which is the `--filter` which tells Git which types of object=
s to
leave out of the fetch. Just like when obtaining file sizes, we would like =
to
move away from one-off Git processes and employ the Git cat-file daemon for
batch fetching.

For parsing the contents of the index file, vfsd also uses a one-off Git pr=
ocess
(`git ls-files -st`). It=E2=80=99s worth mentioning that the `-s` option is=
 used to
obtain the staged contents=E2=80=99 mode bits, object name (aka SHA1 hash),=
 and stage
number. And the `-t` option is used to obtain the file status (`H` - cached=
,
`S` - skip-worktree, `C` - changed, etc). This `ls-files` command parses th=
e
contents of the Git index file in full, but we would like to have the optio=
n to
parse only the entries that match a certain path prefix. This is an importa=
nt
optimization especially when dealing with large repositories.

## Design

We propose to introduce a new command called `git-batch` which is similar t=
o
`git-cat-file --batch` but uses the pkt-line RPC format (described in this
document) instead of `git-rev-parse` patterns.

Using this new command, we will implement the following new APIs:

*   API to list the contents of the index file
*   API to obtain file sizes
*   API to fetch in batch

### pkt-line RPC

We start by introducing the pkt-line RPC protocol. The external process (i.=
e.,
vfsd) and Git will communicate via stdin/out using the protocol described i=
n
this section, which is embedded in the
[pkt-line format](https://git-scm.com/docs/protocol-common#_pkt_line_format=
):

Syntax:

```
PKT_LINE :=3D $PKT_LEN_HEX $FRAME

FRAME :=3D $ID $STREAM_OP [$MSG]

STREAM_OP :=3D b|e|k|be

MSG =3D $MSG_TYPE [$DATA]

MSG_TYPE :=3D o|E|c
```

The pkt-line RPC protocol is different, e.g., from HTTPv1, in which one pro=
cess
is the client and the other is the server, and only the client can initiate
requests to the server. In pkt-line RPC, both processes act as the sender a=
nd
receiver to exchange frames. So the term sender and receiver is not a role =
of
the process. Rather for each frame that is sent, one process is the sender =
and
the other the receiver.

The protocol is full duplex, i.e., the sender and receiver can exchange fra=
mes
without having to wait for the full request or full response to be sent /
received.

#### Terminology

Terminology used in the subsequent sections that describe the protocol:

*   Frame: piece data of known length containing both protocol metadata and
    application data.
*   Sender: process that sent a frame.
*   Receiver: process that received a frame.
*   Stream: ordered sequence of 1 or more messages
*   Message: ordered sequence of 1 or more frames
*   Stream operation: protocol metadata that indicates if a stream begins,
    continues, or ends.
*   Request: a stream started and completed by the sender.
*   Response: a stream started and completed by the receiver that pairs wit=
h a
    request via `$ID`.
*   Application: either the Git process or the external process talking to =
Git.
*   Control frame: a frame containing only protocol metadata and no message=
.
*   RPC: a pair of request and response with the same ID.

#### FRAME

The `$FRAME` contains a protocol frame and it is embedded in a pkt-line. To
avoid head-of-line blocking problems, frames can be interleaved. Frames are
always sent in streams. Streams group 1 or more frames. The sender and rece=
iver
keep track of open streams. A stream is initiated by a request from either =
side
and terminated by a response with the same `$ID` as the request.

The limit of a pkt-line is 65516 bytes, so large requests / responses / blo=
bs
may not fit in a single frame. To overcome this, messages can span multiple
frames. A continuation mechanism is used to indicate that the message is
incomplete and continues on the next frame of the same stream. The sender a=
nd
receiver keep track of whether there is an active continuation on a stream =
or
not.

#### ID

The `$ID` field is an alphanumeric identifier and it is multi-purpose:

*   Identifies frames belonging to the same stream.
*   Pairs requests with responses.
*   Allows frames to be interleaved.

IDs can be reused provided they are free. The sender and receiver keep trac=
k of
busy IDs. An ID is busy (or not free) if there is an open stream with that =
ID,
which is the same as saying that a request was sent with that ID but the
response was not yet received. An ID is free (or not busy) either because n=
o
request has been sent with that ID or because a response with the same ID h=
as
already been received.

To avoid the sender and receiver accidentally choosing the same ID concurre=
ntly,
the external process will use positive IDs and Git will use negative IDs.

An RPC is a request and response with the same `$ID`. If the sender wants t=
o
initiate a request but does not have a message to send, it can send a contr=
ol
frame (i.e., a frame without `$MSG`) as a request. Conversely, if the recei=
ver
wants to send a response but does not have a message to return, it can send=
 a
control frame. These control frames are essential for senders and receivers=
 to
know when IDs become free.

It is a protocol error to reuse an ID that is still being used. It=E2=80=99=
s a protocol
error to omit a request or response in an RPC.

#### STREAM\_OP

The `$STREAM_OP` field is used to control stream operations:

*   A value of `b` (aka begin) indicates the beginning of a stream.
*   A value of `k` (aka keep) sends a message on an open stream.
*   A value of `e` (aka end) indicates the end of a stream.
*   A value of `be` is an optimization to avoid sending empty frames. This =
is
    only used in streams that have a single message
    <span style=3D"text-decoration:underline;">and</span> a single frame. I=
t is
    equivalent to sending a `b` frame and an `e` frame, where the `e` frame=
 has
    no `$MSG`.

It is a protocol error to mishandle stream operations, for example, to begi=
n a
stream that is already started, or end a stream that is not started, or sen=
d a
`k` frame on a stream that is not started.

#### MSG

The `$MSG` contains an application message. If this is omitted, then the fr=
ame
is a control frame, containing only protocol data. If `$MSG` is specified, =
then
this frame contains application data meant to be delivered to the receiver
application.

#### MSG\_TYPE

The `$MSG_TYPE` field is the message type.

A value of `o` (aka ok) contains a whole message if there is no active
continuation. Otherwise, it contains the last part of a message and marks t=
he
end of the active continuation.

A value of `E` (aka error) contains a whole error message. If there is an a=
ctive
continuation, this continuation ends, and messages sent in those continuati=
on
frames are discarded. The error is delivered to the application.

A value of `c` (aka continuation) contains part of a message. If there is n=
o
active continuation, this also starts an active continuation. Otherwise, it
indicates that the active continuation continues onto the next frame.

It is a protocol error to start a continuation and not finish it either wit=
h an
`o` frame or an `E` frame. A `be` frame does not automatically finish an ac=
tive
continuation because it does not indicate whether the message is an error o=
r
not.

The `$MSG_TYPE` is optional. If omitted, then `$DATA` must also be omitted,=
 in
which case this frame is a control frame and no message is delivered to the
application.

#### DATA

The `$DATA` field is optional and can contain an empty or non-empty message=
. An
empty message is not given special treatment and it=E2=80=99s delivered to =
the
application like non-empty messages. This allows APIs to return an OK messa=
ge
without any actual data to indicate that the request was successful, for
example:

```
> 1 be o fetch $SHA1
< 1 be o
```

Sender (i.e., >) sends a request to fetch an object. Receiver (i.e. &lt;)
responds with an OK message with empty `$DATA`.

#### Examples

```
1 be o hello world
```

Send a single message. This uses the `be` optimization because it=E2=80=99s=
 a stream
with a single message and single frame.

```
1 be E no such file or directory
```

Send a single error message. This uses the `be` optimization for the same
reasons as above.

```
1 b c $LONG_DATA1
1 k c $LONG_DATA2
1 e o $LONG_DATA3
```

Send a single long message. The `$LONG_DATA` message is too large, therefor=
e
it=E2=80=99s split into `$LONG_DATA1`, `$LONG_DATA2`, and `$LONG_DATA3`, us=
ing `c` to
indicate the continuation frames. The receiver reassembles the continuation
frames and delivers a single message to the application.

```
1 b o $SMALL_BLOB1
1 k o $SMALL_BLOB2
1 e o $SMALL_BLOB3
```

Send 3 individual messages on a stream without errors.

```
1 b o $SMALL_BLOB1
1 k o $SMALL_BLOB2
1 e E $SMALL_ERROR
```

Send 3 individual messages on a stream. The last message is an error messag=
e.
The receiver delivers 3 messages to the application.

```
1 b c $A_DATA1
1 k o $A_DATA2
1 k c $B_DATA1
1 e o $B_DATA2
```

Send multiple long messages without errors. The `$A_DATA` message is split =
into
2 frames ($`A_DATA1` and $`A_DATA2`) using continuation frames. The same is=
 done
for the `$B_DATA` message. The receiver reassembles the continuation frames=
 and
delivers 2 messages to the application.

```
1 b c $A_DATA1
1 k o $A_DATA2
1 k c $B_DATA1
1 e E $ERROR
```

Send multiple long messages with errors. The receiver delivers `$A_DATA`
(`$A_DATA1` + `$A_DATA2`) to the application. The `$B_DATA1` is discarded, =
and
`$ERROR` is delivered to the application.

#### Nuanced cases

There are some nuanced cases, so we want to make sure that the protocol wor=
ks as
expected and that there are no ambiguities.

```
1 b m hello
1 e
```

Send a single message to the receiver in 2 frames. The second frame is empt=
y and
does not contain a message, but it contains a stream operation to end the
stream. This is equivalent to sending a single `be` frame but without the
optimization that saves the empty frame.

```
1 be
```

Send a control frame without any messages. No messages are delivered to the
application.

```
1 be o
```

Send an empty message. An empty message is delivered to the application.

Now that we have the protocol basics (framing, interleaving and streaming),=
 we
can now define the APIs. The APIs below fit in the `$DATA` part shown in th=
e
syntax above.

### API to list contents of the index file

vfsd needs an API to parse the Git index file, to extract certain fields fr=
om
it, and match only certain paths.

Request syntax:

```
ls-index [path:$PATH\0] [fields:%($FIELD1)%($FIELD2)...]
```

Response syntax:

```
[$FIELD1:$VALUE1] [file:$PATH\0] [$FIELD2:$VALUE2 ...]
```

The command `ls-index` lists the contents of the index file.

The argument `path:` is a path selector to list paths that match the given
prefix. The wildcard `*` matches immediate subentries. The wildcard `**`
recursively matches all subentries.

The argument `fields:` is a field selector to select which fields to return=
 from
the matched entries.

In the response, the filename has a variable length so it=E2=80=99s termina=
ted by NULL
('\0').

Examples:

```
path:dir/*
```

matches all immediate children of `dir/` and returns the Git index entries =
for
the paths `dir/myfile` and `dir/mydir`, but not for `dir/mydir/file`.

```
path:*
```

matches all immediate children of the root directory, e.g., `myfile` and
`mydir`, but it doesn=E2=80=99t match `mydir/file`.

```
path:dir/**
```

matches all entries from the Git index file that have the prefix `dir/` in =
their
path, so all of `dir/myfile`, `dir/mydir`, and `dir/mydir/file` match.

```
fields:%(status)%(mode)%(name)%(stage)%(file)
```

returns the file status (H, S, C, etc), file mode, object name (aka SHA1 ha=
sh),
stage number (0, 1, 2) and file name (e.g., README). This uses the
[git-log format string](https://git-scm.com/docs/git-log).

For performance reasons, wildcards are employed in path selectors instead o=
f
regular expressions. Wildcards can only appear as the last component of a p=
ath
and they cannot be combined with other stanzas, so a pattern like `myfile*`=
 with
the intention of matching `myfile1` and `myfileabc` is not allowed, and a
pattern like `dir/*/myfile` with the intention of matching all intermediate
subdirectories is also not allowed.

### API to get blob size

vfsd needs this API either to obtain file sizes. For performance reasons, i=
t=E2=80=99s
critical that vfsd can batch requests, i.e., send a single network request =
for a
number of objects in parallel.

Request syntax:

```
size $NAME1 [$NAME2 ...]
```

Response syntax:

```
$SIZE1 [$SIZE2 ...]
```

Example:

```
size 6363ba80dc6f90ac2b016adef8b9186cec3e431e
```

Returns the size of the blob with the given name.

```
size 6adef8b9186cec3e431e6363ba80dc6f90ac2b01 cec3e431e6363ba80dc6f90ac2b01=
6adef8b9186
```

returns the sizes of the blobs with the given names.

### API to fetch in batch

vfsd needs this API to fetch several objects in a batch so that subsequent
commands that interact with those objects do not block on the network.

Request syntax:

```
fetch $NAME1 [$NAME2 ...]
```

Response syntax:

```
No response.
```

Example:

```
fetch 6adef8b9186cec3e431e6363ba80dc6f90ac2b01 cec3e431e6363ba80dc6f90ac2b0=
16adef8b9186
```

fetches the given objects in a single network request from the remote and s=
tores
them locally. It may be necessary to extend this with the name of the remot=
e in
order to accommodate Git repositories with multiple remotes.

## Experimental

The new Git command `git-batch` will be first released as
`git-batch-experimental` because it:

*   Communicates to the users that the API is in development, it can drasti=
cally
    change or even be removed
*   Communicates to the users that backwards compatibility for this API is =
not
    guaranteed
*   Allows the Git maintainers to accept a feature in Git for development
    purposes but without the risk of maintaining backwards compatibility fo=
r a
    feature that is not useful
*   Allows our developers to continue developing these APIs incrementally /
    iteratively.

When these APIs are stable, we can then start a discussion to stabilize the=
se
APIs and define a path to remove the experimental bit.
