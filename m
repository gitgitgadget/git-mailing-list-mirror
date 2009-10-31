From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Fri, 30 Oct 2009 19:06:34 -0700
Message-ID: <20091031020634.GL10505@spearce.org>
References: <d411cc4a0910291035m45ba0a8egd8a991acfbf6d5a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 03:06:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N43MX-0006JA-Dk
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 03:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757639AbZJaCGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 22:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757627AbZJaCGb
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 22:06:31 -0400
Received: from george.spearce.org ([209.20.77.23]:49256 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757615AbZJaCGa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 22:06:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0F6B4381FF; Sat, 31 Oct 2009 02:06:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <d411cc4a0910291035m45ba0a8egd8a991acfbf6d5a7@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131824>

Scott Chacon <schacon@gmail.com> wrote:
> The protocol-common.txt is taken from Shawns
> http-protocol.txt that was in common with packfile protocol.  Shawn,
> is that the best way to share that info?

Yup, I think that's the easiest way to do it.

> diff --git a/Documentation/technical/pack-protocol.txt
> +
> +Transports
> +----------
> +The file:// transport simply runs the 'upload-pack' or 'receive-pack'
> +process locally.

You may want to mention that a pipe is used to communicate with
the local process.

> +Git Protocol
> +------------
> +   git-proto-request = request-command SP pathname NUL [ host-parameter NUL ]
> +   request-command   = 'git-upload-pack' / 'git-receive-pack' /
> +                       'git-upload-archive'   ; case sensitive
> +   pathname          = *( %x01-ff ) ; exclude NUL
> +   host-parameter    = 'host' "=" hostname [ ":" port ]

Use double quotes for the request-command items and for the host
literal in host-parameter.

> +Currently only 'host' is allowed in the extra information.  It's

No.  We should make this a MUST.  As in:

	Only host-parameter is allowed in the git-proto-request.
	Clients MUST NOT attempt to send additional parameters.

Sending another header can cause older git-daemons to lock up.

> +   $ echo -e -n \
> +     "0039git-upload-pack /schacon/gitbook.git\0host=github.com\0" |
> +     nc -v github.com 9418

I guess a decent example, but lets use example.com in the
documentation.

> +SSH Protocol
> +------------
> +
> +   $ ssh git.example.com 'git-upload-pack /project.git'

/project.git may be wrapped in single quotes if it contains shell
unsafe characters, like spaces.  So really the invocation is
more like:

  $ ssh git.example.com "git-upload-pack '/my project.git'"

> +In an ssh:// format URI, it's absolute in the URI, so the '/' after

Unless its ssh://user@example.com/~alice/project.git, in which case
we execute

  ssh user@example.com 'git-upload-pack ~alice/project.git'.

> +Reference Discovery
> +-------------------
> +
> +When the client initially connects the server will immediately respond
> +with a listing of each reference it has (all branches and tags) along
> +with the commit SHA that each reference currently points to.
> +
> +   $ echo -e -n \
> +     "0039git-upload-pack /schacon/gitbook.git\0host=github.com\0" |
> +      nc -v github.com 9418

Same remark about example.com in docs.

> +HEAD is not included if its detached - that is, if HEAD is not a
> +symbolic reference, a pointer to another branch, it is not included
> +in the initial server response.

Really?  I thought it was.

> +Packfile Negotiation
> +--------------------
> +After reference and capabilities discovery, the client can decide
> +to terminate the connection (as happens with the ls-remote command)

In this case the client SHOULD send flush-pkt before closing so
the server can gracefully terminate, rather than ungracefully exit
while waiting on input.

I don't know why this is, the server should be more robust here,
but its historical precendent and there are older servers still,
so we should document it.

> +----
> +	upload-request    =  want-list
> +	                     have-list
> +	                     compute-end

The shallow stuff goes between want-list and have-list, and actually
has a full round trip between the client and the server.  I didn't
get to documenting that yet.  We'll need to do that soon.

> +Once all the "want"s (and optional 'deepen') [...]
> +
> +TODO: shallow/unshallow response

Also document the deepen command above in the ABNF.

> +Now the client will send a list of the obj-ids it has.  In multi-ack
> +mode, the canonical implementation will send up to 32 of these at a

Also, in multi_ack mode the canonical implementation will skip
ahead and send the next 32 immediately, so that there is always
a block of 32 "in-flight on the wire" at a time.

This means some pipe buffering is required, at least 1604 bytes
on the client side.  IIRC POSIX pipes (and some pure-software ones
e.g. the Java default in-memory pipe) only promise 512 bytes.

But for some reason I recall I had computed this out at just over
2100 bytes, but right now I can't recall why that is.

> +If the server reads 'have' lines, it then will respond by ACKing any
> +of the obj-ids the client said it had that the server also has.  Or,
> +once the server has found an acceptable common base commit and is
> +ready to make a packfile, it will blindly ACK all 'have' obj-ids back
> +to the client.  Then it will send a 'NACK' and then wait for
> +another response from the client - either a 'done' or another list of
> +'have' lines.

If this is a description of non-multi_ack mode, its wrong.

Without multi_ack:

  * upload-pack sends "ACK %s\n" on the first common object it finds.
    After that it says nothing until the client gives it a "done".

  * upload-pack sends "NAK\n" on a flush-pkt if no common object
    has been found yet.  If one has been found, and thus an ACK
    was already sent, its silent on the flush-pkt.

> +In multi-ack mode, the server will respond with 'ACK obj-id continue'
> +for common commits, otherwise it will just respond with 'ACK obj-id'
> +lines.  In multi-ack-detailed mode, it will differentiate the ACKs

Its multi_ack and mulit_ack_detailed.  For historical reasons we
use _ in these not -.

Also, in multi_ack mode we never use "ACK %s\n", only the newer
"ACK %s continue\n" gets used.  This is also true in multi_ack_detailed,
where we only use common/ready and none of the other forms.

> +After the client has gotten 'ACK obj-id' responses for all it's
> +references, or has sent more than 256 references and decides to give
> +up, it will send a 'done' command, which signals to the server that it
> +is ready to receive it's packfile data.

This isn't really correct.  The client won't get an "ACK obj-id"
for its refs.  Really the client's termination condition is that
it has received enough "ACK obj-id"'s that it can color everything
left in the --date-order queue as common with the server, or the
--date-order queue is empty.

The 256 thing isn't 256 references.  Its the client SHOULD abort if
it has 256 have lines without receiving a single ACK, of any kind,
from the server.  In such a case the client has just walked down
some long path where there is nothing in common, and maybe that
really is the case, so it should just give up.

Unfortunately this rule is dicey because if a client is really far
ahead of the remote peer its fetching from it could go down that
256 commit chain and give up too soon, and download the entire
project all over again.

Fortunately, the 256 limit *only* turns on in the canonical client
implementation if we have received at least one "ACK %s continue"
during a prior round.  This helps to ensure that at least one common
ancestor is found before we give up entirely.

> +Once the 'done' line is read from the client, the server will either
> +send a final 'ACK obj-id' line if it is in multi-ack mode and has found
> +a common base, or it will send a 'NAK' if it has still not found a common
> +base; then the server will start sending it's packfile data.

This needs to be more clear.

It always sends NAK after done if there is no common base found.

It only sends ACK after done if there is at least one common base
and multi_ack or multi_ack_detailed is enabled.

> +----
> +	server-response   =  *acks
> +	                     nack

NAK is optional if ACKs were sent, so really I think this entire block is:

  server-response = *ack_multi ack / nak
  ack_multi       = PKT-LINE("ACK" SP obj-id ack_status LF)
  ack_status      = "continue" / "common" / "ready"
  ack             = PKT-LINE("ACK SP obj-id LF)
  nak             = PKT-LINE("NAK" LF)

> +    acks              =  *ack

Some sort of tab/space error on leading indent, but I'd drop this rule.

> +	nack              =  PKT-LINE("NACK" LF)

This is actually spelled "NAK" (no C).  See my rewrite above.


> +Packfile Data
> +-------------
> +
> +If 'side-band' or 'side-band-64k' capabilities have been specified by
> +the client, the server will send the packfile data multiplexed - it
> +will be sent in packets of either 1000 bytes or 64k, depending on which

Its 999 data bytes, 1 control code, for a total of 1000 bytes in
a pkt-line, or 65519 data bytes, 1 control code, for a total of
65520 bytes in a pkt-line.  You imply 65536 bytes of data here by
saying 64k.  Don't round up.

> +sideband type was specified, with each packet starting with the packet-line
> +format of the amount of data that follows, followed by a single byte

Not format, length.

> +If no 'side-band' capability was specified, the server will simply
> +stream the entire packfile.

Without multiplexing.

> +Reference Discovery
> +-------------------
> +
> +instead of following a null byte, the capabilities follow a space.

No, the follow a NUL.

> +	capability-list  =  capability *(SP capability)
> +    capability       =  1*(ALPHA / DIGIT / "-" / "_")

Tab/space error on indent.

> +Reference Update Request and Packfile Transfer
> +----------------------------------------------
> +
> +This list is followed by a flush packet and then the packfile that should
> +contain all the objects that the server will need to complete the new
> +references.

The pack-file MUST NOT be sent if the only command used is 'delete'.

A pack-file MUST be sent if either create or update command is used.
An empty pack-file MUST be sent if a create or update command is
used, and the server already obviously has the object (e.g. the
SHA-1 is already pointed to by another ref that was listed in the
advertisement).

> +----
> +	update-request    =  command-list pack-file

Add [] around pack-file to make it optional.

> +An example client/server communication might look like this:
> +
> +----
> +   S: 007c74730d410fcb6603ace96f1dc55ea6196122532d HEAD report-status
> delete-refs ofs-delta\n

There's a NUL before the capabilities.  Also, HEAD usually is not
sent in the advertisement, its weird to update HEAD via push.

> +   S: 000aunpack ok\n
> +   S: 000aok refs/heads/debug\n
> +   S: 000ang refs/heads/master non-fast-forward\n

Your pkt-len is all wrong here, there's no way each of those is 10
bytes long.  :-)

Please double check all of the pkt-lens used in the document, its
annoying, but if we are trying to really document the protocol its
a good idea that all examples presented are accurate.

> diff --git a/Documentation/technical/protocol-capabilities.txt
> +
> +multi-ack
> +---------
> +
> +The 'multi-ack' capability allows the server to return "ACK $SHA1

Its spelled 'multi_ack'.

Otherwise, nice writeup of this capability.

> +side-band, side-band-64k
> +------------------------

You need to explain how the packet length is actually 1 byte larger
than the data payload, with a stream code in that first byte of:

  1 - pack data
  2 - progress messages
  3 - fatal error message just before stream aborts

Further, with side-band and its 1000 byte messages, its actually
999 bytes of payload and 1 byte for the stream code.

With side-band-64k, same deal, you have 65519 bytes of data and 1
byte for the stream code.

> +shallow
> +-------

This capability also adds "shallow" and "unshallow" commands to
the fetch-pack/upload-pack protocol.  I haven't had time to study
what impact this has, as we haven't implemented shallow support
yet in JGit.

> +no-progress
> +-----------
> +
> +The client was started with "git clone -q" or something, and doesn't
> +want that side brand 2.  Basically the client just says "I do not

s/brand/band/

> +include-tag
> +-----------
> +
> +The 'include-tag' capability is about sending tags if we are sending
> +objects they point to.  If we pack an object to the client, and a tag
> +points exactly at that object, we pack the tag too.  In general this
> +allows a client to get all new tags when it fetches a branch, in a
> +single network connection.

Elaborate to say "annotated tag" at least once here.

> +Servers SHOULD support all capabilities defined in this document.

This should be at the top of this document, not inside of the
include-tag section.

We should also document the following from receive-pack:

 * report-status
 * delete-refs

> diff --git a/Documentation/technical/protocol-common.txt
...
> +	data-pkt     =  pkt-len pkt-payload
> +    pkt-len      =  4*(HEXDIG)
> +	pkt-payload  =  (pkt-len - 4)*(OCTET)

Some sort of odd tab/space error here on the pkt-len line.

-- 
Shawn.
