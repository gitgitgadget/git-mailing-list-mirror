From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 00/21] Push support over SFTP and (encrypted) Amazon S3
Date: Sun, 29 Jun 2008 03:59:10 -0400
Message-ID: <1214726371-93520-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:01:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrqh-00005Q-H6
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbYF2H7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 03:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbYF2H7q
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 03:59:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36718 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbYF2H7o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 03:59:44 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrov-0004LV-GQ; Sun, 29 Jun 2008 03:59:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 7A5F020FB65; Sun, 29 Jun 2008 03:59:35 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 350A620FBAE;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86763>

People have often asked on the mailing list if Git can push to
a remote server directly over SFTP, without needing to have Git
installed on the remote system.  This mode of operation can be
useful if the remote server is an inexpensive hosting account
and the user wants to publish over HTTP.

With this series jgit can now push directly over sftp:// style
URI without needing Git to be installed on the remote system.
Both the real refs and the dumb transport support files (such
as info/refs) are updated during the push.


A transport for Amazon S3 (http://aws.amazon.com/s3) is also
included.  S3 is an inexpensive network based storage system
provided as a commerical service by Amazon.  Public data stored
in S3 is available over standard HTTP, making it an inexpensive
hosting provider.

Git repositories pushed to S3 may optionally be transparently
encrypted with an encryption key of the user's choosing, hiding the
repository content from Amazon.  An encrypted repository may only be
accessed by jgit, or by downloading it through jets3t, and accessing
the local copy.  (This is because all encryption/decryption occurs
on the client.)

I wanted the S3 support just so I could backup my repositories as
easily as I can backup through native Git.  Its as simple as:

	touch ~/.s3_ident
	chmod 600 ~/.s3_ident
	cat >~/.s3_ident
	accesskey: <AWSAccessKeyId>
	secretkey: <AWSSecretAccessKey>
	password: <secretpassphrasetoseedencryption>
	^D
	jgit push amazon-s3://.s3_ident@bucket/repo.git refs/heads/master

The bucket must have already been created with another S3 client.
I consider it outside of the scope of jgit to register buckets.
However the repository name can be any string of your choosing and
the repository will be created on S3 during the first push.

You can also clone this branch off S3 using anonymous HTTP:

	git clone http://gitney.s3.amazonaws.com/projects/egit.git

I pushed the above repository with:

	touch ~/.s3_pub
	chmod 600 ~/.s3_pub
	cat >~/.s3_pub
	accesskey: <AWSAccessKeyId>
	secretkey: <AWSSecretAccessKey>
	acl: public
	^D
	git remote add s3 amazon-s3://.s3_pub@gitney/projects/egit.git
	jgit push s3 refs/heads/dumb-push


After writing the full S3 client from scratch and implementing an
encryption scheme that is compatible with jets3t (a popular Java
based S3 client) I've realized that jets3t's encryption scheme is
not as strong as it could be, especially if you can recognize a
pattern in the plain text (such as the format of info/refs, or even
of a pack and pack index).  As such the encryption used by jgit is
"eh, ok".  This may be an area of improvement in future versions,
but at present should at least stop any sort of casual snooping.


This series is based on `pu` as it requires both Marek's push topic
and my index-v2 topic.

----
Robert Harder (1):
  Add Robert Harder's public domain Base64 encoding utility

Shawn O. Pearce (20):
  Remove unused index files when WalkFetchConnection closes
  Do not show URIish passwords in TransportExceptions
  Use PackedObjectInfo as a base class for PackWriter's ObjectToPack
  Refactor PackWriter to hold onto the sorted object list
  Save the pack checksum after computing it in PackWriter
  Allow PackIndexWriter to use any subclass of PackedObjectInfo
  Allow PackWriter to create a corresponding index file
  Allow PackWriter to prepare object list and compute name before
    writing
  Remember how a Ref was read in from disk and created
  Simplify walker transport ref advertisement setup
  Indicate the protocol jgit doesn't support push over
  WalkTransport must allow subclasses to implement openPush
  Support push over the sftp:// dumb transport
  Extract readPackedRefs from TransportSftp for reuse
  Specialized byte array output stream for large files
  Misc. documentation fixes to Base64 utility
  Extract the basic HTTP proxy support to its own class
  Create a really simple Amazon S3 REST client
  Add client side encryption to Amazon S3 client library
  Bidirectional protocol support for Amazon S3

 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    8 +-
 .../spearce/jgit/transport/PushProcessTest.java    |   94 +-
 .../spearce/jgit/transport/RefSpecTestCase.java    |   26 +-
 .../spearce/jgit/errors/TransportException.java    |    4 +-
 .../src/org/spearce/jgit/lib/PackIndexWriter.java  |    6 +-
 .../src/org/spearce/jgit/lib/PackWriter.java       |  216 ++--
 org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java |   91 ++-
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   23 +-
 .../src/org/spearce/jgit/pgm/Main.java             |   36 +-
 .../src/org/spearce/jgit/transport/AmazonS3.java   |  770 ++++++++++
 .../spearce/jgit/transport/BasePackConnection.java |    6 +-
 .../jgit/transport/BasePackPushConnection.java     |    5 +-
 .../src/org/spearce/jgit/transport/Transport.java  |    3 +
 .../spearce/jgit/transport/TransportAmazonS3.java  |  319 +++++
 .../spearce/jgit/transport/TransportBundle.java    |    3 +-
 .../org/spearce/jgit/transport/TransportHttp.java  |   64 +-
 .../org/spearce/jgit/transport/TransportSftp.java  |  162 ++-
 .../src/org/spearce/jgit/transport/URIish.java     |   24 +-
 .../org/spearce/jgit/transport/WalkEncryption.java |  188 +++
 .../jgit/transport/WalkFetchConnection.java        |    2 +
 .../spearce/jgit/transport/WalkPushConnection.java |  296 ++++
 .../jgit/transport/WalkRemoteObjectDatabase.java   |  301 ++++
 .../org/spearce/jgit/transport/WalkTransport.java  |    8 +-
 .../src/org/spearce/jgit/util/Base64.java          | 1465 ++++++++++++++++++++
 .../src/org/spearce/jgit/util/HttpSupport.java     |  165 +++
 .../src/org/spearce/jgit/util/TemporaryBuffer.java |  260 ++++
 26 files changed, 4250 insertions(+), 295 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/AmazonS3.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/WalkEncryption.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/Base64.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/HttpSupport.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
