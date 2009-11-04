From: Scott Chacon <schacon@gmail.com>
Subject: [PATCH] Update packfile transfer protocol documentation
Date: Tue, 3 Nov 2009 21:58:23 -0800
Message-ID: <d411cc4a0911032158j2a4664e5w2601c4af59ba0837@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 06:58:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Yt7-0005nd-AL
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 06:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbZKDF6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 00:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbZKDF6U
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 00:58:20 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:64457 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbZKDF6S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 00:58:18 -0500
Received: by pzk26 with SMTP id 26so4481371pzk.4
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 21:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=/552ImIcNRyqtJ7NJTjJKmvKlujTJKA2Vw6I5d7IXdo=;
        b=WjvjgAnTzBtA3z0kQIAhHbTtyokqIsRGmJTLKvEuhsPnbuSU6DV4Jajo9a84Jb2Ex8
         1eeKuQzEuZeDbBx6o20aJcn6AMgSabWmeczWiy29Qc6eF2SCvcT0WvhgNh2cW/e+ieEx
         8GPYjI22jGcTNDH+W5J68DG8f7Erntv7iiG50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=PZ2NVPHFq0QYJPPM3bV9QYHX3XjRwX1JcdGpndNCaVQ+pVdAtZnPvq5q9NaMYpihAq
         KXtI6mWgmWUZDfUeJmgxofL51TUvB4cEJMH7A9O+nxhhuDjNHb4Ec8EOMj2SUyl6T4bj
         xYM93LyCngp+dH9imQPrcQItVXt3r13x5F3SQ=
Received: by 10.115.26.13 with SMTP id d13mr1347266waj.210.1257314303882; Tue, 
	03 Nov 2009 21:58:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132040>

The technical documentation for the packfile protocol is both sparse and
incorrect.  This documents the fetch-pack/upload-pack and send-pack/
receive-pack protocols much more fully.

Add documentation from Shawn's upcoming http-protocol docs that is shared
by the packfile protocol. protocol-common.txt describes ABNF notation
amendments, refname rules and the packet line format.

Add documentation on the various capabilities supported by the
upload-pack and receive-pack protocols. protocol-capabilities.txt describes
multi-ack, thin-pack, side-band[-64k], shallow, no-progress, include-tag,
ofs-delta, delete-refs and report-status.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---

OK, I think I've incorporated all the comments from you and Shawn
here.  Let me know if that's cool or you need me to update anything
else.

 Documentation/technical/pack-protocol.txt         |  535 +++++++++++++++++++--
 Documentation/technical/protocol-capabilities.txt |  186 +++++++
 Documentation/technical/protocol-common.txt       |   96 ++++
 3 files changed, 776 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/technical/protocol-capabilities.txt
 create mode 100644 Documentation/technical/protocol-common.txt

diff --git a/Documentation/technical/pack-protocol.txt
b/Documentation/technical/pack-protocol.txt
index 9cd48b4..4b476da 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -1,41 +1,494 @@
-Pack transfer protocols
-=======================
-
-There are two Pack push-pull protocols.
-
-upload-pack (S) | fetch/clone-pack (C) protocol:
-
-	# Tell the puller what commits we have and what their names are
-	S: SHA1 name
-	S: ...
-	S: SHA1 name
-	S: # flush -- it's your turn
-	# Tell the pusher what commits we want, and what we have
-	C: want name
-	C: ..
-	C: want name
-	C: have SHA1
-	C: have SHA1
-	C: ...
-	C: # flush -- occasionally ask "had enough?"
-	S: NAK
-	C: have SHA1
-	C: ...
-	C: have SHA1
-	S: ACK
-	C: done
-	S: XXXXXXX -- packfile contents.
-
-send-pack | receive-pack protocol.
-
-	# Tell the pusher what commits we have and what their names are
-	C: SHA1 name
-	C: ...
-	C: SHA1 name
-	C: # flush -- it's your turn
-	# Tell the puller what the pusher has
-	S: old-SHA1 new-SHA1 name
-	S: old-SHA1 new-SHA1 name
-	S: ...
-	S: # flush -- done with the list
-	S: XXXXXXX --- packfile contents.
+Packfile transfer protocols
+===========================
+
+Git supports transferring data in packfiles over the ssh://, git:// and
+file:// transports.  There exist two sets of protocols, one for pushing
+data from a client to a server and another for fetching data from a
+server to a client.  All three transports (ssh, git, file) use the same
+protocol to transfer data.
+
+The processes invoked in the canonical Git implementation are 'upload-pack'
+on the server side and 'fetch-pack' on the client side for fetching data;
+then 'receive-pack' on the server and 'send-pack' on the client for pushing
+data.  The protocol functions to have a server tell a client what is
+currently on the server, then for the two to negotiate the smallest amount
+of data to send in order to fully update one or the other.
+
+Transports
+----------
+There are three transports over which the packfile protocol is
+initiated.  The Git transport is a simple, unauthenticated server that
+takes the command (almost always 'upload-pack', though Git
+servers can be configured to be globally writable, in which 'receive-
+pack' initiation is also allowed) with which the client wishes to
+communicate and executes it and connects it to the requesting
+process.
+
+In the SSH transport, the client just runs the 'upload-pack'
+or 'receive-pack' process on the server over the SSH protocol and then
+communicates with that invoked process over the SSH connection.
+
+The file:// transport runs the 'upload-pack' or 'receive-pack'
+process locally and communicates with it over a pipe.
+
+Git Transport
+-------------
+
+The Git protocol starts off by sending the command and repository
+on the wire using the pkt-line format, followed by a null byte and a
+hostname paramater, terminated by a null byte.
+
+   0032git-upload-pack /project.git\0host=myserver.com\0
+
+--
+   git-proto-request = request-command SP pathname NUL [ host-parameter NUL ]
+   request-command   = "git-upload-pack" / "git-receive-pack" /
+                       "git-upload-archive"   ; case sensitive
+   pathname          = *( %x01-ff ) ; exclude NUL
+   host-parameter    = "host=" hostname [ ":" port ]
+--
+
+Only host-parameter is allowed in the git-proto-request. Clients
+MUST NOT attempt to send additional parameters. It is used for the
+git-daemon name based virtual hosting.  See --interpolated-path
+option to git daemon, with the %H/%CH format characters.
+
+Basically what the Git client is doing to connect to an 'upload-pack'
+process on the server side over the Git protocol is this:
+
+   $ echo -e -n \
+     "0039git-upload-pack /schacon/gitbook.git\0host=example.com\0" |
+     nc -v example.com 9418
+
+
+SSH Transport
+-------------
+
+Initiating the upload-pack or receive-pack processes over SSH is
+executing the binary on the server via SSH remote execution.
+It is basically equivalent to running this:
+
+   $ ssh git.example.com "git-upload-pack '/project.git'"
+
+For a server to support Git pushing and pulling for a given user over
+SSH, that user needs to be able to execute one or both of those
+commands via the SSH shell that they are provided on login.  On some
+systems, that shell access is limited to only being able to run those
+two commands, or even just one of them.
+
+In an ssh:// format URI, it's absolute in the URI, so the '/' after
+the host name (or port number) is sent as an argument, which is then
+read by the remote git-upload-pack exactly as is, so it's effectively
+an absolute path in the remote filesystem.
+
+       git clone ssh://user@example.com/project.git
+                    |
+                    v
+    ssh user@example.com "git-upload-pack '/project.git'"
+
+In a "user@host:path" format URI, its relative to the user's home
+directory, because the Git client will run:
+
+     git clone user@example.com:project.git
+                    |
+                    v
+  ssh user@example.com "git-upload-pack 'project.git'"
+
+The exception is if a '~' is used, in which case
+we execute it without the leading '/'.
+
+      ssh://user@example.com/~alice/project.git,
+                     |
+                     v
+   ssh user@example.com "git-upload-pack '~alice/project.git'"
+
+A few things to remember here:
+
+- The "command name" is spelled with dash (e.g. git-upload-pack), but
+  this can be overridden by the client;
+
+- The repository path is always quoted with single quotes.
+
+Fetching Data From a Server
+===========================
+
+When one Git repository wants to get data that a second repository
+has, the first can 'fetch' from the second.  This operation determines
+what data the server has that the client does not then streams that
+data down to the client in packfile format.
+
+
+Reference Discovery
+-------------------
+
+When the client initially connects the server will immediately respond
+with a listing of each reference it has (all branches and tags) along
+with the object name that each reference currently points to.
+
+   $ echo -e -n "0039git-upload-pack
/schacon/gitbook.git\0host=example.com\0" |
+      nc -v example.com 9418
+   00887217a7c7e582c46cec22a130adf4b9d7d950fba0 HEAD\0multi_ack
thin-pack side-band side-band-64k ofs-delta shallow no-progress
include-tag
+   00441d3fcd5ced445d1abc402225c0b8a1299641f497 refs/heads/integration
+   003f7217a7c7e582c46cec22a130adf4b9d7d950fba0 refs/heads/master
+   003cb88d2441cac0977faf98efc80305012112238d9d refs/tags/v0.9
+   003c525128480b96c89e6418b1e40909bf6c5b2d580f refs/tags/v1.0
+   003fe92df48743b7bc7d26bcaabfddde0a1e20cae47c refs/tags/v1.0^{}
+   0000
+
+Server SHOULD terminate each non-flush line using LF ("\n") terminator;
+client MUST NOT complain if there is no terminator.
+
+The returned response is a pkt-line stream describing each ref and
+its known value.  The stream MUST be sorted by name according to
+the C locale ordering.
+
+If HEAD is a valid ref, HEAD MUST appear as the first advertised
+ref.  If HEAD is not a valid ref, HEAD MUST NOT appear in the
+advertisement list at all, but other refs may still appear.
+
+The stream MUST include capability declarations behind a NUL on the
+first ref. The peeled value of a ref (that is "ref^{}") MUST be
+immediately after the ref itself, if presented. A conforming server
+MUST peel the ref if its an annotated tag.
+
+----
+  advertised-refs  =  (no-refs / list-of-refs)
+                      flush-pkt
+
+  no-refs          =  PKT-LINE(zero-id SP "capabilities^{}"
+                      NUL capability-list LF)
+
+  list-of-refs     =  first-ref *other-ref
+  first-ref        =  PKT-LINE(obj-id SP refname
+                      NUL capability-list LF)
+
+  other-ref        =  PKT-LINE(other-tip / other-peeled)
+  other-tip        =  obj-id SP refname LF
+  other-peeled     =  obj-id SP refname "^{}" LF
+
+  capability-list  =  capability *(SP capability)
+  capability       =  1*(LC_ALPHA / DIGIT / "-" / "_")
+  LC_ALPHA         =  %x61-7A
+----
+
+Server and client SHOULD use lowercase for SHA1, both MUST treat SHA1
+as case-insensitive.
+
+See protocol-capabilities.txt for a list of allowed server capabilities
+and descriptions.
+
+Packfile Negotiation
+--------------------
+After reference and capabilities discovery, the client can decide
+to terminate the connection by sending a flush-pkt, telling the
+server it can now gracefully terminate (as happens with the ls-remote
+command) or it can enter the negotiation phase, where the client and
+server determine what the minimal packfile necessary for transport is.
+
+Once the client has the initial list of references that the server
+has, as well as the list of capabilities, it will begin telling the
+server what objects it wants and what objects it has, so the server
+can make a packfile that only has the objects that the client needs.
+The client will also send a list of the capabilities it supports out
+of what the server said it could do with the first 'want' line.
+
+----
+  upload-request    =  want-list
+                       have-list
+                       compute-end
+
+  want-list         =  first-want
+                       *additional-want
+                       flush-pkt
+
+  first-want        =  PKT-LINE("want" SP obj-id SP capability-list LF)
+  additional-want   =  PKT-LINE("want" SP obj-id LF)
+
+  have-list         =  *have-line
+  have-line         =  PKT-LINE("have" SP obj-id LF)
+  compute-end       =  flush-pkt / PKT-LINE("done")
+----
+
+Clients MUST send all the obj-ids it wants from the reference
+discovery phase as 'want' lines. Clients MUST send at least one
+'want' command in the request body. Clients MUST NOT mention an
+obj-id in a 'want' command which did not appear in the response
+obtained through ref discovery.
+
+If client is requesting a shallow clone, it will now send a 'deepen'
+line with the depth it is requesting.
+
+Once all the "want"s (and optional 'deepen') are transferred,
+clients MUST send a flush-pkt. If the client has all the references
+on the server, client flushes and disconnects.
+
+TODO: shallow/unshallow response and document the deepen command in the ABNF.
+
+Now the client will send a list of the obj-ids it has using 'have'
+lines.  In multi_ack mode, the canonical implementation will send up
+to 32 of these at a time, then will send a flush-pkt.  The canonical
+implementation will skip ahead and send the next 32 immediately,
+so that there is always a block of 32 "in-flight on the wire" at a
+time.
+
+If the server reads 'have' lines, it then will respond by ACKing any
+of the obj-ids the client said it had that the server also has. The
+server will ACK obj-ids differently depending on which ack mode is
+signaled by the client.
+
+In multi_ack mode:
+
+  * the server will respond with 'ACK obj-id continue' for any common
+    commits.
+
+  * once the server has found an acceptable common base commit and is
+    ready to make a packfile, it will blindly ACK all 'have' obj-ids
+    back to the client.
+
+  * the server will then send a 'NACK' and then wait for another response
+    from the client - either a 'done' or another list of 'have' lines.
+
+In multi_ack_detailed mode:
+
+  * the server will differentiate the ACKs where it is signaling
+    that it is ready to send data with 'ACK obj-id ready' lines, and
+    signals the identified common commits with 'ACK obj-id common' lines.
+
+Without multi_ack:
+
+ * upload-pack sends "ACK obj-id" on the first common object it finds.
+   After that it says nothing until the client gives it a "done".
+
+ * upload-pack sends "NAK" on a flush-pkt if no common object
+   has been found yet.  If one has been found, and thus an ACK
+   was already sent, its silent on the flush-pkt.
+
+After the client has gotten enough ACK responses that it can determine
+that the server has enough information to send an efficient packfile
+(in the canonical implementation, this is determined when it has received
+enough ACKs that it can color everything left in the --date-order queue
+as common with the server, or the --date-order queue is empty), or the
+client determines that it wants to give up (in the canonical implementation,
+this is determined when the client sends 256 'have' lines without getting
+any of them ACKed by the server - meaning there is nothing in common and
+the server should just send all it's objects), then the client will send
+a 'done' command.  The 'done' command signals to the server that the client
+is ready to receive it's packfile data.
+
+However, the 256 limit *only* turns on in the canonical client
+implementation if we have received at least one "ACK %s continue"
+during a prior round.  This helps to ensure that at least one common
+ancestor is found before we give up entirely.
+
+Once the 'done' line is read from the client, the server will either
+send a final 'ACK obj-id' or it will send a 'NAK'. The server only sends
+ACK after 'done' if there is at least one common base and multi_ack or
+multi_ack_detailed is enabled. The server always sends NAK after 'done'
+if there is no common base found.
+
+Then the server will start sending it's packfile data.
+
+----
+  server-response = *ack_multi ack / nak
+  ack_multi       = PKT-LINE("ACK" SP obj-id ack_status LF)
+  ack_status      = "continue" / "common" / "ready"
+  ack             = PKT-LINE("ACK SP obj-id LF)
+  nak             = PKT-LINE("NAK" LF)
+----
+
+A simple clone may look like this (with no 'have' lines):
+
+----
+   C: 0054want 74730d410fcb6603ace96f1dc55ea6196122532d\0multi_ack \
+     side-band-64k ofs-delta\n
+   C: 0032want 7d1665144a3a975c05f1f43902ddaf084e784dbe\n
+   C: 0032want 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a\n
+   C: 0032want 7e47fe2bd8d01d481f44d7af0531bd93d3b21c01\n
+   C: 0032want 74730d410fcb6603ace96f1dc55ea6196122532d\n
+   C: 0000
+   C: 0009done\n
+
+   S: 0008NAK\n
+   S: [PACKFILE]
+----
+
+An incremental update (fetch) response might look like this:
+
+----
+   C: 0054want 74730d410fcb6603ace96f1dc55ea6196122532d\0multi_ack \
+     side-band-64k ofs-delta\n
+   C: 0032want 7d1665144a3a975c05f1f43902ddaf084e784dbe\n
+   C: 0032want 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a\n
+   C: 0000
+   C: 0032have 7e47fe2bd8d01d481f44d7af0531bd93d3b21c01\n
+   C: [30 more have lines]
+   C: 0032have 74730d410fcb6603ace96f1dc55ea6196122532d\n
+   C: 0000
+
+   S: 003aACK 7e47fe2bd8d01d481f44d7af0531bd93d3b21c01 continue\n
+   S: 003aACK 74730d410fcb6603ace96f1dc55ea6196122532d continue\n
+   S: 0008NAK\n
+
+   C: 0009done\n
+
+   S: 003aACK 74730d410fcb6603ace96f1dc55ea6196122532d\n
+   S: [PACKFILE]
+----
+
+
+Packfile Data
+-------------
+
+Now that the client and server have done some negotiation about what
+the minimal amount of data that can be sent to the client is, the server
+will construct and send the required data in packfile format.
+
+See pack-format.txt for what the packfile itself actually looks like.
+
+If 'side-band' or 'side-band-64k' capabilities have been specified by
+the client, the server will send the packfile data multiplexed.
+
+Each packet starting with the packet-line length of the amount of data
+that follows, followed by a single byte specifying the sideband the
+following data is coming in on.
+
+In 'side-band' mode, it will send up to 999 data bytes plus 1 control
+code, for a total of up to 1000 bytes in a pkt-line.  In 'side-band-64k'
+mode it will send up to 65519 data bytes plus 1 control code, for a
+total of up to 65520 bytes in a pkt-line.
+
+The sideband byte will be a '1', '2' or a '3'. Sideband '1' will contain
+packfile data, sideband '2' will be used for progress information that the
+client will generally print to stderr and sideband '3' is used for error
+information.
+
+If no 'side-band' capability was specified, the server will stream the
+entire packfile without multiplexing.
+
+
+Pushing Data To a Server
+========================
+
+Pushing data to a server will invoke the 'receive-pack' process on the
+server, which will allow the client to tell it which references it should
+update and then send all the data the server will need for those new
+references to be complete.  Once all the data is received and validated,
+the server will then update it's references to what the client specified.
+
+Authentication
+--------------
+
+The protocol itself contains no authentication mechanisms.  That is to be
+handled by the transport, such as SSH, before the 'receive-pack' process is
+invoked.  If 'receive-pack' is configured over the Git transport, those
+repositories will be writable by anyone who can access that port (9418) as
+that transport is unauthenticated.
+
+Reference Discovery
+-------------------
+
+The reference discovery phase is done nearly the same way as it is in the
+fetching protocol. Each reference obj-id and name on the server is sent
+in packet-line format to the client, followed by a flush packet.  The only
+real difference is that the capability listing is different - the only
+possible values are 'report-status', 'delete-refs' and 'ofs-delta'.
+
+Reference Update Request and Packfile Transfer
+----------------------------------------------
+
+Once the client knows what references the server is at, it can send a
+list of reference update requests.  For each reference on the server
+that it wants to update, it sends a line listing the obj-id currently on
+the server, the obj-id the client would like to update it to and the name
+of the reference.
+
+This list is followed by a flush packet and then the packfile that should
+contain all the objects that the server will need to complete the new
+references.
+
+----
+  update-request    =  command-list [pack-file]
+
+  command-list      =  PKT-LINE(command NUL capability-list LF)
+                       *PKT-LINE(command LF)
+                       flush-pkt
+
+  command           =  create / delete / update
+  create            =  zero-id SP new-id  SP name
+  delete            =  old-id  SP zero-id SP name
+  update            =  old-id  SP new-id  SP name
+
+  old-id            =  obj-id
+  new-id            =  obj-id
+
+  pack-file         = "PACK" 28*(OCTET)
+----
+
+If the receiving end does not support delete-refs, the sending end MUST
+NOT ask for delete command.
+
+The pack-file MUST NOT be sent if the only command used is 'delete'.
+
+A pack-file MUST be sent if either create or update command is used,
+even if the server already has all the necessary objects.  In this
+case the client MUST send an empty pack-file.   The only time this
+is likely to happen is if the client is doing something like creating
+a new branch that points to an existing obj-id.
+
+The server will receive the packfile, unpack it, then validate each
+reference that is being updated that it hasn't changed while the request
+was being processed (the obj-id is still the same as the old-id), and
+it will run any update hooks to make sure that the update is acceptable.
+If all of that is fine, the server will then update the references.
+
+Report Status
+-------------
+
+After receiving the pack data from the sender, the client sends a
+report if 'report-status' capability was sent to the server.
+It is a short listing of what happened in that update.  It will first
+list the status of the packfile unpacking as either 'unpack ok' or
+'unpack [error]'.  Then it will list the status for each of the references
+that it tried to update.  Each line be either 'ok [refname]' if the
+update was successful, or 'ng [refname] [error]' if the update was not.
+
+----
+  report-status     = unpack-status
+                      1*(command-status)
+                      flush-pkt
+
+  unpack-status     = PKT-LINE("unpack" SP unpack-result LF)
+  unpack-result     = "ok" / error-msg
+
+  command-status    = command-ok / command-fail
+  command-ok        = PKT-LINE("ok" SP refname LF)
+  command-fail      = PKT-LINE("ng" SP refname SP error-msg LF)
+
+  error-msg         = 1*(OCTECT) ; where not "ok"
+----
+
+Updates can be unsuccessful for a number of reasons.  The reference can have
+changed since the reference discovery phase was originally sent, meaning
+someone pushed in the meantime.  The reference being pushed could be a
+non-fast-forward reference and the update hooks or configuration could be
+set to not allow that, etc.  Also, some references can be updated while others
+can be rejected.
+
+An example client/server communication might look like this:
+
+----
+   S: 007c74730d410fcb6603ace96f1dc55ea6196122532d
refs/heads/local\0report-status delete-refs ofs-delta\n
+   S: 003e7d1665144a3a975c05f1f43902ddaf084e784dbe refs/heads/debug\n
+   S: 003f74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/master\n
+   S: 003f74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/team\n
+   S: 0000
+
+   C: 003e7d1665144a3a975c05f1f43902ddaf084e784dbe
74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/debug\n
+   C: 003e74730d410fcb6603ace96f1dc55ea6196122532d
5a3f6be755bbb7deae50065988cbfa1ffa9ab68a refs/heads/master\n
+   C: 0000
+   C: [PACKDATA]
+
+   S: 000aunpack ok\n
+   S: 0014ok refs/heads/debug\n
+   S: 0026ng refs/heads/master non-fast-forward\n
+----
diff --git a/Documentation/technical/protocol-capabilities.txt
b/Documentation/technical/protocol-capabilities.txt
new file mode 100644
index 0000000..f4bf986
--- /dev/null
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -0,0 +1,186 @@
+Git Protocol Capabilities
+=========================
+
+Servers SHOULD support all capabilities defined in this document.
+
+On the very first line of the initial server response of either
+receive-pack and upload-pack the first reference is followed by
+a null byte and then a list of space delimited server capabilities.
+These allow the server to declare what it can and cannot support
+to the client.
+
+Client will then send a space separated list of capabilities it
+can support. The client SHOULD NOT ask for capabilities the server
+did not say it supports.
+
+Server MUST ignore capabilities it does not understand.  Server MUST
+NOT ignore capabilities that client requested and server advertised.
+
+The 'report-status' and 'delete-refs' capabilities are sent and
+recognized by the receive-pack (push to server) process.
+
+The 'ofs-delta' capability is sent and recognized by both upload-pack
+and receive-pack protocols.
+
+All other capabilities are only recognized by the upload-pack (fetch
+from server) process.
+
+multi_ack
+---------
+
+The 'multi_ack' capability allows the server to return "ACK obj-id
+continue" as soon as it finds a commit that it can use as a common
+base, between the client's wants and the client's have set.
+
+By sending this early, the server can potentially head off the client
+from walking any further down that particular branch of the client's
+repository history.  The client may still need to walk down other
+branches, sending have lines for those, until the server has a
+complete cut across the DAG, or the client has said "done".
+
+Without multi_ack, a client sends have lines in --date-order until
+the server has found a common base.  That means the client will send
+have lines that are already known by the server to be common, because
+they overlap in time with another branch that the server hasn't found
+a common base on yet.
+
+For example suppose the client has commits in caps that the server
+doesn't and the server has commits in lower case that the client
+doesn't, as in the following diagram:
+
+       +---- u ---------------------- x
+      /              +----- y
+     /              /
+    a -- b -- c -- d -- E -- F
+       \
+        +--- Q -- R -- S
+
+If the client wants x,y and starts out by saying have F,S, the server
+doesn't know what F,S is.  Eventually the client says "have d" and
+the server sends "ACK d continue" to let the client know to stop
+walking down that line (so don't send c-b-a), but its not done yet,
+it needs a base for x. The client keeps going with S-R-Q, until a
+gets reached, at which point the server has a clear base and it all
+ends.
+
+Without multi_ack the client would have sent that c-b-a chain anyway,
+interleaved with S-R-Q.
+
+thin-pack
+---------
+
+This capability implies that the server can send 'thin' packs, packs
+which do not contain base objects; if those base objects are available
+on client side. Client requests 'thin-pack' capability when it
+understands how to "thicken" them adding required delta bases making
+them self contained.
+
+Client MUST NOT request 'thin-pack' capability if it cannot turn thin
+packs into proper independent packs.
+
+
+side-band, side-band-64k
+------------------------
+
+This means that server can send, and client understand multiplexed
+progress reports and error info interleaved with the packfile itself.
+
+These two options are mutually exclusive. A modern client always
+favors 'side-band-64k'.
+
+Either mode indicates that the packfile data will be streamed broken
+up into packets of up to either 1000 bytes in the case of 'side_band',
+or 65520 bytes in the case of 'side_band_64k'. Each packet is made up
+of a leading 4-byte pkt-line length of how much data is in the packet,
+followed by a 1-byte stream code, followed by the actual data.
+
+The stream code can be one of:
+
+ 1 - pack data
+ 2 - progress messages
+ 3 - fatal error message just before stream aborts
+
+The "side-band-64k" capability came about as a way for newer clients
+that can handle much larger packets to request packets that are
+actually crammed nearly full, while maintaining backward compatibility
+for the older clients.
+
+Further, with side-band and its up to 1000-byte messages, it's actually
+999 bytes of payload and 1 byte for the stream code. With side-band-64k,
+same deal, you have up to 65519 bytes of data and 1 byte for the stream
+code.
+
+The client MUST send only maximum of one of "side-band" and "side-
+band-64k".  Server MUST diagnose it as an error if client requests
+both.
+
+ofs-delta
+---------
+
+Server can send, and client understand PACKv2 with delta refering to
+its base by position in pack rather than by SHA-1.  That is, they can
+send/read OBJ_OFS_DELTA (aka type 6) in a packfile.
+
+shallow
+-------
+
+This capability adds "deepen", "shallow" and "unshallow" commands to
+the  fetch-pack/upload-pack protocol so clients can request shallow
+clones.
+
+no-progress
+-----------
+
+The client was started with "git clone -q" or something, and doesn't
+want that side band 2.  Basically the client just says "I do not
+wish to receive stream 2 on sideband, so do not send it to me, and if
+you did, I will drop it on the floor anyway".  However, the sideband
+channel 3 is still used for error responses.
+
+include-tag
+-----------
+
+The 'include-tag' capability is about sending annotated tags if we are
+sending objects they point to.  If we pack an object to the client, and
+a tag object points exactly at that object, we pack the tag object too.
+In general this allows a client to get all new annotated tags when it
+fetches a branch, in a single network connection.
+
+Clients MAY always send include-tag, hardcoding it into a request when
+the server advertises this capability. The decision for a client to
+request include-tag only has to do with the client's desires for tag
+data, whether or not a server had advertised objects in the
+refs/tags/* namespace.
+
+Servers MUST pack the tags if their referrant is packed and the client
+has requested include-tags.
+
+Clients MUST be prepared for the case where a server has ignored
+include-tag and has not actually sent tags in the pack.  In such
+cases the client SHOULD issue a subsequent fetch to acquire the tags
+that include-tag would have otherwise given the client.
+
+The server SHOULD send include-tag, if it supports it, regardless
+of whether or not there are tags available.
+
+report-status
+-------------
+
+The upload-pack process can receive a 'report-status' capability,
+which tells it that the client wants a report of what happened after
+a packfile upload and reference update.  If the pushing client requests
+this capability, after unpacking and updating references the server
+will respond with whether the packfile unpacked successfully and if
+each reference was updated successfully.  If any of those were not
+successful, it will send back an error message.  See pack-protocol.txt
+for example messages.
+
+delete-refs
+-----------
+
+If the server sends back the 'delete-refs' capability, it means that
+it is capable of accepting an all-zeroed SHA-1 value as the target
+value of a reference update.  It is not sent back by the client, it
+simply informs the client that it can be sent zeroed SHA-1 values
+to delete references.
+
diff --git a/Documentation/technical/protocol-common.txt
b/Documentation/technical/protocol-common.txt
new file mode 100644
index 0000000..2dca642
--- /dev/null
+++ b/Documentation/technical/protocol-common.txt
@@ -0,0 +1,96 @@
+Documentation Common to Pack and Http Protocols
+===============================================
+
+ABNF Notation
+-------------
+
+ABNF notation as described by RFC 5234 is used within the protocol documents,
+except the following replacement core rules are used:
+----
+  HEXDIG    =  DIGIT / "a" / "b" / "c" / "d" / "e" / "f"
+----
+
+We also define the following common rules:
+----
+  NUL       =  %x00
+  zero-id   =  40*"0"
+  obj-id    =  40*(HEXDIGIT)
+
+  refname  =  "HEAD"
+  refname /=  "refs/" <see discussion below>
+----
+
+A refname is a hierarichal octet string beginning with "refs/" and
+not violating the 'git-check-ref-format' command's validation rules.
+More specifically, they:
+
+. They can include slash `/` for hierarchical (directory)
+  grouping, but no slash-separated component can begin with a
+  dot `.`.
+
+. They must contain at least one `/`. This enforces the presence of a
+  category like `heads/`, `tags/` etc. but the actual names are not
+  restricted.
+
+. They cannot have two consecutive dots `..` anywhere.
+
+. They cannot have ASCII control characters (i.e. bytes whose
+  values are lower than \040, or \177 `DEL`), space, tilde `~`,
+  caret `{caret}`, colon `:`, question-mark `?`, asterisk `*`,
+  or open bracket `[` anywhere.
+
+. They cannot end with a slash `/` nor a dot `.`.
+
+. They cannot end with the sequence `.lock`.
+
+. They cannot contain a sequence `@{`.
+
+. They cannot contain a `\\`.
+
+
+pkt-line Format
+---------------
+
+Much (but not all) of the payload is described around pkt-lines.
+
+A pkt-line is a variable length binary string.  The first four bytes
+of the line, the pkt-len, indicates the total length of the line,
+in hexadecimal.  The pkt-len includes the 4 bytes used to contain
+the length's hexadecimal representation.
+
+A pkt-line MAY contain binary data, so implementors MUST ensure
+pkt-line parsing/formatting routines are 8-bit clean.
+
+A non-binary line SHOULD BE terminated by an LF, which if present
+MUST be included in the total length.
+
+The maximum length of a pkt-line's data component is 65520 bytes.
+Implementations MUST NOT send pkt-line whose length exceeds 65524
+(65520 bytes of payload + 4 bytes of length data).
+
+Implementations SHOULD NOT send an empty pkt-line ("0004").
+
+A pkt-line with a length field of 0 ("0000"), called a flush-pkt,
+is a special case and MUST be handled differently than an empty
+pkt-line ("0004").
+
+----
+  pkt-line     =  data-pkt / flush-pkt
+
+  data-pkt     =  pkt-len pkt-payload
+  pkt-len      =  4*(HEXDIG)
+  pkt-payload  =  (pkt-len - 4)*(OCTET)
+
+  flush-pkt    = "0000"
+----
+
+Examples (as C-style strings):
+
+----
+  pkt-line          actual value
+  ---------------------------------
+  "0006a\n"         "a\n"
+  "0005a"           "a"
+  "000bfoobar\n"    "foobar\n"
+  "0004"            ""
+----
-- 
1.6.5.2.340.g000a3e
