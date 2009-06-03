From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 07:48:37 -0700
Message-ID: <20090603144837.GE3355@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <200906030250.01413.jnareb@gmail.com> <20090603012940.GA3355@spearce.org> <200906031121.38616.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 16:49:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBrm9-0005Jk-E8
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 16:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756942AbZFCOsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 10:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756570AbZFCOsf
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 10:48:35 -0400
Received: from george.spearce.org ([209.20.77.23]:32872 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755700AbZFCOsf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 10:48:35 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2231B381D1; Wed,  3 Jun 2009 14:48:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906031121.38616.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120612>

Jakub Narebski <jnareb@gmail.com> wrote:
> I'm sorry, I was too cryptic here.
> 
> I meant that in the request line for fetching via git:// protocol
> 
> 	0032git-upload-pack /project.git\\000host=myserver.com\\000
> 
> you separate path to repository from extra options using "\0" / NUL
> as a separator. Well, this is only sane separator, as it is path 
> terminator, the only character which cannot appear in pathname 
> (although I do wonder whether project names with e.g. control 
> characters or UTF-8 characters would work correctly).

No, that isn't the reason '\0' is used here.  But yea, that is true.

The reason \0 is used is, git-daemon reads the 4 byte length, decodes
that, then reads that many bytes.  Finally it writes a '\0' at the
end of what it read, so that the entire "line" is NUL terminated.
Then it reads the "command path" part from the resulting C string.

The host=myserver.com part came later, after many daemons were
already running all over the world.  By hiding it behind the '\0'
an old daemon would never see it (but strlen() returned a value that
was less than the length read, but the old daemons didn't care).
Newer daemons look for where strlen() < length, and assume that
the host header follows.

The host header ends with '\0' in case additional headers would
also appear here in the future.  IOW, like HTTP allows new headers
to be added before the "\r\n\r\n" terminator at the body, we allow
them between "\0".

Why '\0'?  The only real Git implementation that matters is C Git,
and its written in C, and that's easy to work with in C.

As far as UTF-8 or other characters... that path is scanned to check
for nasty cases like '../../../../etc/passwd', but is otherwise
handed off to the system's stat() and chdir() functions as-is.  So
like any other path in Git, it had damn well better match what the
host will recognize.

If the host is using SHIFT-JIS on its filesystem, then a client must
request the path in SHIFT-JIS.  And there is no way to specify that
to the client in advance.

In practice, I think most people stick to an latin1 style character
set here, maybe even the commonly acceptable printable characters
for US-ASCII, so it winds up being not that much of an issue.
 
> Is the final terminating character required to be NUL ("\0"), or can
> it be for LF ("\n"), i.e.
> 
> 	0032git-upload-pack /project.git\\000host=myserver.com\\n

The LF thing is like I said before, for a human, not the machine.
Hell, if the LF is present I think it would have to be *after* the
'\0' in the line, otherwise git daemon would assume that the host
name includes an LF at the end of it.

The NUL at the end of the host name is not strictly required, but
must be present if the client were to ever pass additional options
to the server.

See above about why... client reads line, sticks a NUL at the end,
if the host header doesn't end in NUL on the wire, it does now
in memory.
 
> What options besides (required?) "host=<server>[:<port>]" are supported?

Currently only host is supported.  And yea, it takes the :<port> if
the client included the port number in the URL (git://foo:8813/path).

Actually, I just realized JGit isn't compliant here.  It doesn't
send the :<port> like C Git would.

> Do I understand correctly that "host=<host>" information is required
> for core.gitProxy to work, isn't it?

No.  Its for the git-daemon name based virtual hosting.
See --interpolated-path option to git daemon, with the %H/%CH
format characters.
 
> >>>>  * no-progress
> >> 
> >> What that does mean?
> > 
> > The client was started with "git clone -q" or something, and doesn't
> > want that side brand 2.  Basically the client just says "I do not
> > wish to receive stream 2 on sideband, so do not send it to me,
> > and if you did, I will drop it on the floor anyway".
> 
> Does this mean that if server does not support "no-progress" capability
> then client is required to drop diagnostic by itself?

Yes.

> Can client request
> to not use sideband (multiplexing) if it is asking for "no-progress";
> or is multiplexing required for possible signaling of error condition 
> on channel 3?

We still want it for the error condition on channel 3.  But if the
client didn't care about errors, and wanted no-progress, and the
server didn't support no-progress, then yes, the client could just
avoid asking for the side-band capability.

> >> It is a bit pity that git protocol was not created with extendability
> >> (like capabilities) in mind...
> > 
> > Yes, no doubt.  There are many things I would have done differently,
> > given that I now have 20/20 hindsight vision into the past's future.
> > 
> > :-)
> > 
> > The protocol (mostly) works fine as-is.  Its widely distributed in
> > terms of clients using it on a daily basis.  Its likely to continue
> > to serve our needs well into the future.  So, it is what it is.
> 
> I do wonder if existing Internet Standard (in the meaning of RFC) 
> protocols also have such kludges and hacks...

I'm sure they have some... oddities.  But perhaps not as bad as git.

We have a history of not leaving ourselves room for future expansion,
and then needing to find a backdoor in the canonical implementation
parser in order to make it work.

In the protocol suite, its been the strlen() < pktlen trick which
has generally worked.  Oh, and also sticking stuff after a fixed
length record, where we didn't care.

Oh, and send-pack/receive-pack protocol now has ".have" refs, which
work for C Git because the send-pack client was always calling
check_ref_format() on each thing sent by the server, and ".have"
isn't a valid ref name.  Why the hell the send-pack client was doing
that, I have no idea.  But, when the ref failed it was a silent
failure, so we were able to use ".have" for some new capability.

It also broke JGit, which wasn't doing this seemingly pointless
check_ref_format() and silently fail business.  Oh, and IIRC,
GitHub may have been burned around the same time somehow.

In packed-refs, Junio had a hard time adding the "peeled-refs"
support, because the first version of the parser was so strict.
But again, somehow he managed to find a backdoor in the old parser,
and that backdoor is why that file looks the way it does today.

In the loose object format, when we added new-style loose objects
we found a backdoor in the way libz deflate formats the first 2
bytes of the file... and encoded something that shouldn't appear
there to signal it was a new "pack style" loose object.

Pack index v2 uses a hole where old clients would barf on the
'\377t0c' followed by the version '2' not being monotonically
increasing.

I think there's something like that in DIRC too, but that change
(to introduce the current DIRC format) may predate my involvement
with Git, so my memory isn't very good there.
 
> P.S. By the way, is pkt-line format original invention, or was it 
> 'borrowed' from some other standard or protocol?

No clue.  I find it f'king odd that the length is in hex.  There
isn't much value to the protocol being human readable.  The PACK
part of the stream sure as hell ain't.  You aren't going to type
out a sequence of "have" lines against the remote, like you could
with say an HTTP GET.  *shrug*

-- 
Shawn.
