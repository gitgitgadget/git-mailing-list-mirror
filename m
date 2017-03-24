Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 182092095E
	for <e@80x24.org>; Fri, 24 Mar 2017 10:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934929AbdCXKhg (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 06:37:36 -0400
Received: from imap0.codethink.co.uk ([185.43.218.159]:53908 "EHLO
        imap0.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935083AbdCXKhf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 06:37:35 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82])
        by imap0.codethink.co.uk with esmtps (Exim 4.84_2 #1 (Debian))
        id 1crMb0-0007ix-9f; Fri, 24 Mar 2017 10:37:26 +0000
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246] helo=salo)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1crMaz-0002a0-Cq; Fri, 24 Mar 2017 10:37:26 +0000
Date:   Fri, 24 Mar 2017 10:37:23 +0000
From:   Richard Ipsum <richard.ipsum@codethink.co.uk>
To:     git@vger.kernel.org
Cc:     Dave Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>,
        Edwin Kempin <ekempin@google.com>
Subject: [RFC] A Notedb Standard
Message-ID: <20170324103723.GA7324@salo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello again,

Apologies to those who will receive this for a second time,
git@vger.kernel.org rejected the previous mail.

This follows from previous discussion[1].

I must firstly apologise for taking such a long time to produce a
written spec which I believe I promised over a year ago, but better
late than never... :)

This document is nowhere near complete. My hope is that this initial effort
helps start the conversation.

Thanks,
Richard Ipsum

[1]: https://public-inbox.org/git/20160108140831.GA10200@salo/


Network Working Group                                           R. Ipsum
Internet-Draft                                             Codethink Ltd
Intended status: Informational                            March 07, 2017
Expires: September 8, 2017


                                 Notedb
                              draft-ndb-00

Abstract

   This document aims to address the absence of a standard for storing
   review metadata in git.  Notedb is an existing format used in
   production.  This document aims to encourage more widespread adoption
   of Notedb by Code Review and Patch tracking services.

   Items or Changes submitted for review can be described in Notedb
   using a combination of commit message footers and git notes.
   Mutations to changes can be described by adding new commits to an
   ordinary git history.  Other more qualitative content such as
   comments or responses to items submitted for review can be stored in
   git as git notes.  References to this git history can be stored
   within their own git reference hierarchy effectively name-spacing
   them from ordinary git branches.

Status of This Memo

   This Internet-Draft is submitted in full conformance with the
   provisions of BCP 78 and BCP 79.

   Internet-Drafts are working documents of the Internet Engineering
   Task Force (IETF).  Note that other groups may also distribute
   working documents as Internet-Drafts.  The list of current Internet-
   Drafts is at http://datatracker.ietf.org/drafts/current/.

   Internet-Drafts are draft documents valid for a maximum of six months
   and may be updated, replaced, or obsoleted by other documents at any
   time.  It is inappropriate to use Internet-Drafts as reference
   material or to cite them other than as "work in progress."

   This Internet-Draft will expire on September 8, 2017.

Copyright Notice

   Copyright (c) 2017 IETF Trust and the persons identified as the
   document authors.  All rights reserved.





Ipsum                   Expires September 8, 2017               [Page 1]

Internet-Draft                     ndb                        March 2017


   This document is subject to BCP 78 and the IETF Trust's Legal
   Provisions Relating to IETF Documents
   (http://trustee.ietf.org/license-info) in effect on the date of
   publication of this document.  Please review these documents
   carefully, as they describe your rights and restrictions with respect
   to this document.  Code Components extracted from this document must
   include Simplified BSD License text as described in Section 4.e of
   the Trust Legal Provisions and are provided without warranty as
   described in the Simplified BSD License.

Table of Contents

   1.  Introduction  . . . . . . . . . . . . . . . . . . . . . . . .   3
     1.1.  Requirements Notation . . . . . . . . . . . . . . . . . .   4
     1.2.  Terminology . . . . . . . . . . . . . . . . . . . . . . .   4
   2.  Semantic description of entities and relations  . . . . . . .   5
     2.1.  Change  . . . . . . . . . . . . . . . . . . . . . . . . .   5
     2.2.  ChangeId  . . . . . . . . . . . . . . . . . . . . . . . .   5
     2.3.  ChangeRef . . . . . . . . . . . . . . . . . . . . . . . .   5
     2.4.  ChangeHistory . . . . . . . . . . . . . . . . . . . . . .   5
     2.5.  PatchSet  . . . . . . . . . . . . . . . . . . . . . . . .   6
     2.6.  PatchLineComment  . . . . . . . . . . . . . . . . . . . .   6
     2.7.  PatchSetApproval  . . . . . . . . . . . . . . . . . . . .   7
     2.8.  Reviewer  . . . . . . . . . . . . . . . . . . . . . . . .   7
     2.9.  Footer  . . . . . . . . . . . . . . . . . . . . . . . . .   7
       2.9.1.  Branch  . . . . . . . . . . . . . . . . . . . . . . .   8
       2.9.2.  Commit  . . . . . . . . . . . . . . . . . . . . . . .   8
       2.9.3.  Patch-set . . . . . . . . . . . . . . . . . . . . . .   8
       2.9.4.  Status  . . . . . . . . . . . . . . . . . . . . . . .   8
       2.9.5.  Subject . . . . . . . . . . . . . . . . . . . . . . .   8
   3.  Syntactic description of entities and relations . . . . . . .   8
     3.1.  ChangeId  . . . . . . . . . . . . . . . . . . . . . . . .   8
     3.2.  ChangeRef . . . . . . . . . . . . . . . . . . . . . . . .   9
     3.3.  PatchLineComment  . . . . . . . . . . . . . . . . . . . .   9
     3.4.  PatchSet  . . . . . . . . . . . . . . . . . . . . . . . .  12
     3.5.  PatchSetApproval  . . . . . . . . . . . . . . . . . . . .  12
   4.  Appendix  . . . . . . . . . . . . . . . . . . . . . . . . . .  13
     4.1.  Creating a Change . . . . . . . . . . . . . . . . . . . .  13
     4.2.  Inserting a new PatchSet  . . . . . . . . . . . . . . . .  14
     4.3.  Inserting a PatchLineComment  . . . . . . . . . . . . . .  15
     4.4.  Inserting a PatchSetApproval  . . . . . . . . . . . . . .  16
     4.5.  Updating the status of a change . . . . . . . . . . . . .  17
   5.  References  . . . . . . . . . . . . . . . . . . . . . . . . .  17
     5.1.  Normative References  . . . . . . . . . . . . . . . . . .  17
     5.2.  Informative References  . . . . . . . . . . . . . . . . .  18
   Author's Address  . . . . . . . . . . . . . . . . . . . . . . . .  18





Ipsum                   Expires September 8, 2017               [Page 2]

Internet-Draft                     ndb                        March 2017


1.  Introduction

   Reviews occur alongside code, in-between submission of a change and
   merge of that change, git tracks the change that was added but does
   not track the decisions that led to the change being added.

   Presently git lacks any sort of standard for tracking review content,
   and so lacks data critical to any kind of code audit.

   Gerrit provides one solution to this problem in the form of Notedb.
   Notedb is currently an implementation detail of gerrit, this document
   seeks to make it the standard for reviews in git.

   The notedb format provides a standard allowing all notedb
   implementations to reliably obtain and modify review content from git
   repositories.

   Review content, in this document means, comments on a set of patches,
   comments on individual files within a set of patches and comments on
   individual lines and ranges of lines with a set of patches.  The
   state of a review, which describes whether the change is considered
   to be new, abandoned or merged.

   Notedb is so called because it is loosely based around [git-notes].
   If we think of git as a key-value store with shas as keys and values
   of either blob, tree or commit, then notes can be thought of as
   arbitrary blobs keyed on the sha of the commit they belong to.

   When "git notes add" is used to add a note to a commit, git creates a
   new tree with an entry that has the sha of the commit the note
   belongs to as the entry name (or the key), this key maps to a blob
   that contains the contents of this git note.  This tree can be found
   under the ref refs/notes/commits.


















Ipsum                   Expires September 8, 2017               [Page 3]

Internet-Draft                     ndb                        March 2017


   % git notes add -m 'This is the contents of a git note!'

   % git show
   commit 68b41139d0bf2b6b69cdbfb3b5966427d5e6790a
   Author: Alice <alice@floof>
   Date:   Sun Feb 12 23:36:25 2017 +0000

       Add cat

   Notes:
       This is the contents of a git note!

   ...

   % git cat-file -p refs/notes/commits:68b4113...
   This is the contents of a git note!

   Notedb uses this same principal to store review content within the
   git repo itself.

1.1.  Requirements Notation

   In this document, the key words "MUST", "MUST NOT", "REQUIRED",
   "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY",
   and "OPTIONAL" are to be interpreted as described in BCP 14,
   [RFC2119] and indicate requirement levels for compliant Notedb
   implementations.

   All grammars provided in this document are to be interpreted using
   ABNF as described in [RFC5234].

1.2.  Terminology

   A _Change_ is an individual review submission.

   A _ChangeId_ is a unique identifier for a _Change_.

   A _PatchLineComment_ is a comment on a _PatchSet_.

   A _PatchSet_ is a set of commits submitted as part of a _Change_.

   A _PatchSetApproval_ is a special kind of comment on a review that
   assigns a numeric value to a Change.

   A _Reviewer_ is an external entity that submits a _PatchLineComment_
   or a _PatchSetApproval_ to a given _PatchSet_.

   A _ChangeHistory_ is the git history of a _Change_.



Ipsum                   Expires September 8, 2017               [Page 4]

Internet-Draft                     ndb                        March 2017


   A _ChangeRef_ is a git reference that points to the HEAD commit of a
   _ChangeHistory_.

   A _Footer_ is a line of form `Key: Value' at the end of a commit
   message.  A commit message MAY contain multiple Footers.

   A _Revision_ is a commit in a git repository that is the HEAD of a
   git branch submitted for review.

2.  Semantic description of entities and relations

2.1.  Change

   A _Change_ is an individual review submission.  A _Change_ MUST have
   one or more _PatchSet_ objects.  A _Change_ MUST have an associated
   _ChangeRef_.  A _Change_ MAY have one or more _Reviewer_ objects.

   A _Change_ can be considered a container object for other Notedb
   objects such as _PatchSet_ and _Reviewer_ that associates individual
   _Reviewer_ and _PatchSet_ objects with a given review submission.

2.2.  ChangeId

   A _ChangeId_ is a unique identifier for a _Change_.  A _Change_ MUST
   have a _ChangeId_.

2.3.  ChangeRef

   A _ChangeRef_ maps a git reference to a _ChangeId_.  A _ChangeRef_
   MUST point to the HEAD of the _ChangeHistory_ for the given _Change_.

   A _ChangeRef_ is used to track the current HEAD of a change history,
   git references are used by Notedb to locate changes but they also
   ensure that _Change_ metadata is not garbage collected by git.

   _ChangeRef_ objects are stored in their own git reference space: they
   are effectively namespaced from other git references.

2.4.  ChangeHistory

   A _ChangeHistory_ is the git history of a _Change_.

   The history includes every commit from the initial commit to the HEAD
   commit pointed to by the _ChangeRef_.

   Notedb stores all operations made against a _Change_ in a git
   history, this means that any kind of change made to a Notedb _Change_
   is recorded in the git log.



Ipsum                   Expires September 8, 2017               [Page 5]

Internet-Draft                     ndb                        March 2017


   A _ChangeHistory_ references the acts of creating/destroying various
   git notes that store review metadata such as comments.  The commit
   messages themselves are also used to record the state of a change at
   a given point in the history.

   The _Change_ metadata once committed, is immutable, any modifications
   to the change are performed by adding a new commit to the
   _ChangeHistory_.

   The full and current state of a _Change_ is obtained by performing a
   walk from the start of the history to the current HEAD commit of the
   _ChangeHistory_.

2.5.  PatchSet

   A _PatchSet_ is an object that MUST point to a _Revision_.  A
   _PatchSet_ MAY point to one or more _PatchLineComment_ objects.  A
   _PatchSet_ MAY point to one or more _PatchSetApproval_ objects.

   A _PatchSet_ uses a _Revision_ to map content submitted with a
   _Change_ to comments and approvals submitted to the a _Change_ by a
   _Reviewer_.

   When new content is submitted to a _Change_ it is done with a new
   _PatchSet_.

   It MUST be possible to obtain the state of a _Change_ for every
   submission of a new _PatchSet_.

   Submitted review content is never deleted or replaced, there is
   always a complete audit log of anything that is submitted to a
   _Change_.

2.6.  PatchLineComment

   A _PatchLineComment_ is a comment made by a _Reviewer_ on a specific
   section of a file in git.  A _PatchLineComment_ MAY contain comments
   on one or more separate files stored in git.

   A _PatchLineComment_ MUST be associated with the _Reviewer_ that made
   the comment.  See corresponding syntax section for more details.

   A _PatchLineComment_ MUST have content.  The content is the body of
   the comment itself.  See the syntax section, subsection
   _PatchLineComment_ for an example of this.






Ipsum                   Expires September 8, 2017               [Page 6]

Internet-Draft                     ndb                        March 2017


2.7.  PatchSetApproval

   A _PatchSetApproval_ is a special kind of comment on a review that
   assigns a numeric value to a _Change_.

   A _PatchSetApproval_ will be associated with the _Reviewer_ that made
   the approval.  See corresponding syntax section for more details.

2.8.  Reviewer

   A _Reviewer_ is an external entity that MAY submit _PatchLineComment_
   or _PatchSetApproval_ objects to a _Change_.

2.9.  Footer

   A _Footer_ is a key-value pair that is stored at the end of a commit
   message.  A _Footer_ is commonly used for signing off commits, where
   a `Signed-off-by' footer gets appended to the commit message.

   Notedb uses commit _Footer_ objects to store some metadata such as
   the branch a _Change_ is based on, the status of the _Change_ and the
   HEAD commit of the change under review.

   A commit footer MUST match the following grammar,

   FOOTER = 1*WORD ":" SP 1*WORD

   WORD = any CHR but not (SP or TAB or CR or LF)

   CHR = any valid character in the commit message encoding

   The following footers are currently used:

   BRANCH_FOOTER = "Branch" ":" SP 1*WORD

   COMMIT_FOOTER = "Commit" ":" SP 1*WORD

   PS_FOOTER = "Patch-set" ":" SP 1*WORD

   STATUS_FOOTER = "Status" ":" SP 1*WORD

   SUBJECT_FOOTER = "Subject" ":" SP 1*WORD

   LABEL_FOOTER = "Label" ":" SP 1*WORD

   An example _Footer_ in a commit message,





Ipsum                   Expires September 8, 2017               [Page 7]

Internet-Draft                     ndb                        March 2017


   commit 3075b9295ec1d909bfce286bb08c0094b3b51700
   Author: Alice <alice@floof>
   Date:   Sun Feb 12 23:36:25 2017 +0000

       Add cat

       Signed-off-by: Alice <alice@floof>

   _Footer_ objects in Notedb are used to specify several metadata
   items, these include "Branch", "Commit", "PatchSet", "Status" and
   "Subject", the meaning of each of these is defined by the following
   subsections.

2.9.1.  Branch

   This is the name of the git branch the _Change_ should be merged to,
   for example, "master".  Note that this SHOULD NOT include the "refs/
   heads", prefix.

2.9.2.  Commit

   This is a 40 digit sha1 signature of the HEAD commit of the git
   branch that is being submitted for review.

2.9.3.  Patch-set

   This is the Patchset Id.

2.9.4.  Status

   This is the "Status" of a _Change_. A _Change_ can be considered to
   be "New", "Merged" or "Abandoned".

2.9.5.  Subject

   This is the "Subject" of a _Change_. It is used for email.

3.  Syntactic description of entities and relations

3.1.  ChangeId

   There are two types of _ChangeId_, one _ChangeId_ is an Integer
   value, and is described by the following grammar.

   INTCHANGEID = 1*DIGIT

   To support the use of Notedb in distributed systems it is useful to
   have a more flexible _ChangeId_. The second type of _ChangeId_ is a



Ipsum                   Expires September 8, 2017               [Page 8]

Internet-Draft                     ndb                        March 2017


   String value, since the _ChangeId_ is stored in the _ChangeRef_,
   there are some further restrictions on what characters may be used in
   a String _ChangeId_, the following grammar is provided,

   STRCHANGEID = (1*GITREFCHAR) but not BADSTRING
       and does not end with ".lock"
       and does not end with "/"

   GITREFCHAR = not BADCHARACTER

   BADCHARACTER = '.' / ':' / '?' / '[' / '\'
                  / '^' / '~' / '*' / SP / TAB / CL / LF

   BADSTRING = "@{" / ".."

3.2.  ChangeRef

   The exact form of a _ChangeRef_ MUST match the following grammar:

   CHANGEREF = ("refs/" 1*GITREFCHAR "/" GITREFCHAR GITREFCHAR
               "/" 2*GITREFCHAR "/meta")
           and does not end with ".lock"
           and does not end with "/"

   GITREFCHAR = not (BADCHARACTER or BADSTRING)

   BADCHARACTER = '.' / ':' / '?' / '[' / '\'
                  / '^' / '~' / '*' / SP / TAB / CL / LF

   BADSTRING = "@{" / ".."

   An example _ChangeRef_,

   refs/changes/heads/01/1/meta

   Another example _ChangeRef_,

   refs/foobar/heads/ca/cat/meta

3.3.  PatchLineComment

   Data for a _PatchLineComment_ is stored in a git note.

   The contents of a _PatchLineComment_ is stored in a git note on the
   commit the comment applies to.  See [git-notes] for details.

   The order of individual comments within the git note is
   implementation defined, however parsers/emitters of the format MUST



Ipsum                   Expires September 8, 2017               [Page 9]

Internet-Draft                     ndb                        March 2017


   preserve the existing order of any existing comments within the
   notes: the diff between a _PatchLineComment_ before addition of a new
   comment and after addition of a comment SHALL be minimal.

   A _PatchLineComment_ MUST contain the following headers,

   o  Patchset - the patchset id

   o  Revision - the commit sha this comment refers to

   o  File - the file this comment refers

   o  Comment range - the range of lines this comment refers to

   o  DateTime - the date and time this comment was made

   o  Author - the author of the comment

   o  UUID - a unique identifier for the comment

   o  Bytes - the size of the content in bytes

   these headers correspond and MUST match the following grammars,

   PATCHSET_ID = 1*DIGIT

   REVISION = 40*HEXDIGIT

   FILE = 1*ANY

   RANGE = (["-"] DIGIT) / ((DIGIT[":" DIGIT])-(DIGIT[":" DIGIT]))

   DATETIME = TO BE DISCUSSED

   AUTHOR = 1*ANY LEFT_ANGLE AUTHOR_EMAIL RIGHT_ANGLE
   AUTHOR_EMAIL = 1*ANY
   LEFT_ANGLE = "<"
   RIGHT_ANGLE = ">"

   UUID = 40*HEXDIGIT

   BYTES = 1*DIGIT

   where DIGIT, HEXDIGIT, ANY shall be defined as,

   DIGIT = '0' / '1' / '2' / '3' / '4' / '5' / '6' / '7' / '8' / '9'
   HEXDIGIT = DIGIT / 'a' / 'b' / 'c' / 'd' / 'e' / 'f'
   ANY = any valid character or codepoint in the given encoding



Ipsum                   Expires September 8, 2017              [Page 10]

Internet-Draft                     ndb                        March 2017


   The remainder of the blob for a single comment consists of the
   comment content itself.  The number of content bytes MUST be exactly
   that specified in the _Bytes_ header.

   An example _PatchLineComment_.

   Patch-set: 2
   Revision: ff66dd146cacf964671f5373f6e20d7e1b80b70c
   File: simpcat.1

   -1
   Wed Feb 15 15:50:32 2017 +0000
   Author: Alice <alice@floof>
   UUID: 94e69344801b98e2aa07caf2558b587186ddf7af
   Bytes: 58
   This man page looks okay but I don't know troff that well.

   A _PatchLineComment_ MAY contain multiple comments if there are
   multiple comments on a given commit.  Comments MAY be made on
   separate files within a single _PatchLineComment_.

   An example _PatchLineComment_ with multiple comments on different
   files.

   Patch-set: 2
   Revision: ff66dd146cacf964671f5373f6e20d7e1b80b70c
   File: Makefile

   -1
   Wed Feb 15 16:08:15 2017 +0000
   Author: Alice <alice@floof>
   Parent: 94e69344801b98e2aa07caf2558b587186ddf7af
   UUID: c26198375e761bbdc30b45951435a30efcd23f7c
   Bytes: 122
   The makefile looks okay to me.

   Though, do you think it'd be useful to let people install cat without
   all the other tools?

   File: simpcat.1

   -1
   Wed Feb 15 15:50:32 2017 +0000
   Author: Alice <alice@floof>
   UUID: 94e69344801b98e2aa07caf2558b587186ddf7af
   Bytes: 58
   This man page looks okay but I don't know troff that well.




Ipsum                   Expires September 8, 2017              [Page 11]

Internet-Draft                     ndb                        March 2017


3.4.  PatchSet

   A _PatchSet_ object has two footers, the first is the "Patch-set"
   footer, which stores the id of that _PatchSet_. The second is the
   "Commit" footer, which stores the _Revision_ for the _PatchSet_.

   A _PatchSet_ MUST have a "Patch-set" footer and MUST have a "Commit"
   footer.

   o  PatchLineComment - any given Patch-set can have multiple
      PatchLineComments

   o  Commit - a commit sha, to map a PatchSet to a commit in the
      repository

   Below is an example history that includes an initial submission of a
   _Change_, with the first _PatchSet_ object being automatically
   created, followed by a subsequent update to the _Change_ which
   submits a second _PatchSet_.

   commit 0226cb1a85573f1db30c553bcd4397ebd6b05fbd
   Author: Alice <alice@floof>
   Date:   Wed Feb 15 15:39:57 2017 +0000

       This is my second version of the cat program!

       Commit: ff66dd146cacf964671f5373f6e20d7e1b80b70c
       Patch-set: 2

   commit d096d963d491977b497fed4f194adcf315901d39
   Author: Alice <alice@floof>
   Date:   Wed Feb 15 14:20:13 2017 +0000

       This is my cat do you like it?

       Branch: master
       Commit: 68b41139d0bf2b6b69cdbfb3b5966427d5e6790a
       Patch-set: 1
       Status: new
       Subject: cat

3.5.  PatchSetApproval

   A _PatchSetApproval_ represents a vote on a given _Change_.  It is
   stored within a "Label" footer under the "CodeReview" key.

   The value for this key shall be a single + or - sign followed by any
   number of digits, the following grammar applies:



Ipsum                   Expires September 8, 2017              [Page 12]

Internet-Draft                     ndb                        March 2017


   APPROVAL = ["-"] LABEL_FOOTER "CodeReview" ("+" / "-") 1*DIGIT

   An example PatchSetApproval,

   commit 502c5160b89432b0391a184da2727ff1e23eb875
   Author: Alice <alice@floof>
   Date:   Wed Feb 15 14:32:21 2017 +0000

       Vote on patch set 1



       Label: CodeReview=+1
       Patch-set: 1

   The details of the exact voting system are left for the consumer of
   the library to define.

   Once given, a _PatchSetApproval_ can also be removed, this is
   indicated by prefixing the review to be removed with a '-' sign, as
   shown below.

       -Label: CodeReview=+1

4.  Appendix

4.1.  Creating a Change

   Creation of a _Change_ requires:

   o  A metadata repository

   o  A content repository

   o  Change subject

   o  Commit subject

   o  Destination branch (the branch the _Change_ should be merged to)

   o  Author

   o  Revision id (sha of the HEAD of the branch that we wish to merge)

   o  Patchset id

   o  Ref prefix




Ipsum                   Expires September 8, 2017              [Page 13]

Internet-Draft                     ndb                        March 2017


   o  Change Id

   a _Change_ may optionally specify:

   o  A topic

   topics may be used to group related _Change_ objects together.

   Once a _Change_ has been created there shall exist a git reference
   and a single commit.  The reference is a _ChangeRef_ (as defined by
   this document) and points to the commit which contains the initial
   _Change_ metadata in its commit message.

   So in the example used in this document, the git reference is
   "refs/changes/ca/cat/meta" and the commit is as shown below:

   commit d096d963d491977b497fed4f194adcf315901d39
   Author: Alice <alice@floof>
   Date:   Wed Feb 15 14:20:13 2017 +0000

       This is my cat do you like it?

       Branch: master
       Commit: 68b41139d0bf2b6b69cdbfb3b5966427d5e6790a
       Patch-set: 1
       Status: new
       Subject: cat

4.2.  Inserting a new PatchSet

   As stated earlier in this document, the revision a _Change_ points to
   is immutable, it can only be updated by submitting new _PatchSet_
   objects, the _Change_ tracks all _PatchSet_ objects submitted to it,
   meaning that all submissions to a _Change_ are tracked and
   permanently available.

   A new _PatchSet_ is inserted by creating a new commit that contains
   the new patchset id (which is the previous patchset id incremented)
   and a new revision id (this must not be the same id as the previous
   _PatchSet_).  The "Patch-set" footer stores the patchset id.  The
   "Commit" footer stores the revision id.  The history below shows the
   _Change_ after a new _PatchSet_ has been inserted.









Ipsum                   Expires September 8, 2017              [Page 14]

Internet-Draft                     ndb                        March 2017


   commit 0226cb1a85573f1db30c553bcd4397ebd6b05fbd
   Author: Alice <alice@floof>
   Date:   Wed Feb 15 15:39:57 2017 +0000

       This is my second version of the cat program!

       Commit: ff66dd146cacf964671f5373f6e20d7e1b80b70c
       Patch-set: 2

   commit d096d963d491977b497fed4f194adcf315901d39
   Author: Alice <alice@floof>
   Date:   Wed Feb 15 14:20:13 2017 +0000

       This is my cat do you like it?

       Branch: master
       Commit: 68b41139d0bf2b6b69cdbfb3b5966427d5e6790a
       Patch-set: 1
       Status: new
       Subject: cat

   Once the new commit is added, the _ChangeRef_ is subsequently updated
   to point to it.  That is "refs/changes/heads/ca/cat/meta" now points
   to "0226cb1".

4.3.  Inserting a PatchLineComment

   During review people will generally comment on specific sections of a
   patch.  The _PatchLineComment_ facilitates such aspects of a review,
   a _PatchSet_ object can be effectively annotated with
   _PatchLineComment_ objects.

   To create a _PatchLineComment_, first a blob is created containing
   the appropriate headers, for example.

















Ipsum                   Expires September 8, 2017              [Page 15]

Internet-Draft                     ndb                        March 2017


   Patch-set: 2
   Revision: ff66dd146cacf964671f5373f6e20d7e1b80b70c
   File: Makefile

   -1
   Wed Feb 15 16:08:15 2017 +0000
   Author: Alice <alice@floof>
   Parent: 94e69344801b98e2aa07caf2558b587186ddf7af
   UUID: c26198375e761bbdc30b45951435a30efcd23f7c
   Bytes: 122
   The makefile looks okay to me.

   Though, do you think it'd be useful to let people install cat without
   all the other tools?

   The blob is added to a tree, the entry name of the tree being the sha
   of the _Revision_, in this case "ff66dd1", so that we have a tree as
   shown below:

   100644 blob 35e25b2...    ff66dd1...

   finally a commit is then created that points to this tree.

   commit a2ed0172a15f489f9ef10c78d2b734a21287c21e
   Author: Alice <alice@floof>
   Date:   Wed Feb 15 15:50:32 2017 +0000

       Metadata update

       Patch-set: 2

   the _ChangeRef_ is then updated to point to this commit, so
   "refs/changes/heads/ca/cat/meta" now points to "a2ed017".

4.4.  Inserting a PatchSetApproval

   During review people will also generally vote on whether a given
   _Change_ should be merged or not, typically a vote is an annotation
   of +1 meaning "yes this should be merged", or -1 meaning "no this
   should not be merged", some systems also support the idea of +2 or -2
   which are stronger versions of +1 or -1.  As stated earlier in this
   document the Notedb format leaves the exact rules of the voting
   system for the consumer of the format to define, though within
   certain constraints, see the earlier definition of _PatchSetApproval_
   for details.






Ipsum                   Expires September 8, 2017              [Page 16]

Internet-Draft                     ndb                        March 2017


   Essentially a _PatchSetApproval_ has a 'magnitude' in the form of an
   integer.  And a 'sign', positive or negative.  So to represent a +1
   the following commit is added,

   commit 502c5160b89432b0391a184da2727ff1e23eb875
   Author: Alice <alice@floof>
   Date:   Wed Feb 15 14:32:21 2017 +0000

       Vote on patch set 1



       Label: CodeReview=+1
       Patch-set: 1

   the _ChangeRef_ is then updated to point to this commit, so
   "refs/changes/heads/ca/cat/meta" now points to "502c516".

4.5.  Updating the status of a change

   Eventually, once reviews are completed there will be a need to update
   the status of a _Change_. In Notedb changes are either "New",
   "Abandoned", or "Merged".  When a change is merged or abandoned the
   only update to the metadata is to the _ChangeStatus_, as shown below,

   commit d36c719027573435d6f07ce53fe9cfd4b8095612
   Author: Alice <alice@floof>
   Date:   Mon Mar 20 17:33:23 2017 +0000

       Metadata update

       Patch-set: 4
       Status: abandoned

   please note no metadata is destroyed or removed.  This is a very
   important point, all history of all submitted changes is kept in the
   repository for posterity.

5.  References

5.1.  Normative References

   [RFC2119]  Bradner, S., "Key words for use in RFCs to Indicate
              Requirement Levels", BCP 14, RFC 2119, DOI 10.17487/
              RFC2119, March 1997,
              <http://www.rfc-editor.org/info/rfc2119>.





Ipsum                   Expires September 8, 2017              [Page 17]

Internet-Draft                     ndb                        March 2017


   [RFC5234]  Crocker, D., Ed. and P. Overell, "Augmented BNF for Syntax
              Specifications: ABNF", STD 68, RFC 5234, DOI 10.17487/
              RFC5234, January 2008,
              <http://www.rfc-editor.org/info/rfc5234>.

5.2.  Informative References

   [git-notes]
              Git Community, ., "git-notes documentation", n.d.,
              <https://git-scm.com/docs/git-notes>.

Author's Address

   Richard Ipsum
   Codethink Ltd
   Ducie House 37 Ducie Street
   Manchester  M1 2JW
   United Kingdon

   Phone: +44 161 236 5575
   Email: richard.ipsum@codethink.co.uk






























Ipsum                   Expires September 8, 2017              [Page 18]
