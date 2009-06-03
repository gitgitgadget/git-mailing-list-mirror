From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Tue, 2 Jun 2009 18:29:40 -0700
Message-ID: <20090603012940.GA3355@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <200906022339.08639.jnareb@gmail.com> <20090602232724.GN30527@spearce.org> <200906030250.01413.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 03:29:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBfIa-0000LB-Ft
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 03:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbZFCB3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 21:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbZFCB3j
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 21:29:39 -0400
Received: from george.spearce.org ([209.20.77.23]:51772 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbZFCB3i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 21:29:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6A8E8381D1; Wed,  3 Jun 2009 01:29:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906030250.01413.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120570>

Jakub Narebski <jnareb@gmail.com> wrote:
> On Wed, 3 Jun 2009, Shawn O. Pearce wrote:
> >>>
> >>> The client connects and sends the request header. The clone command
> >>>
> >>> 	$ git clone git://myserver.com/project.git
> >>>
> >>> produces the following request:
> >>>
> >>> 	0032git-upload-pack /project.git\\000host=myserver.com\\000
> [...]
> 
> So this mean that when cloning via SSH 
> 
>   $ git clone ssh://myserver.com/project.git
> 
> instead of this first request git would simply invoke [something like]:
> 
>   # ssh myserver.com git-upload-pack project.git

Actually, 

    # ssh myserver.com git-upload-pack /project.git
 
> isn't it? (I am not sure if it uses "project.git" or "/project.git", 
> and how it does generate full pathname for repository).

In an ssh:// format URI, its absolute in the URI, so the / after
the host name (or port number) is sent as an argument, which is then
read by the remote git-upload-pack exactly as is, so its effectively
an absolute path in the remote filesystem.

In a "user@host:path" format URI, its relative to the user's home
directory, because we run:

    # ssh user@host git-upload-pack path

> BTW I wonder why we use stuffing here using "\0" / NUL as separator
> trick, and whether line has to be terminated with "\0", or can it be
> terminated with "\n".

Stuffing here?  What are we talking about again?
 
> >>> The request is processed and turned into a call to git-upload-pack:
> >>>
> >>>  	$ git-upload-pack /path/to/repos/project.git
> >> 
> >> Is it "git-upload-pack" or "git upload-pack" nowadays?
> > 
> > Sadly, we still invoke "git-upload-pack" IIRC.
> 
> So that is why git-upload-pack has to be in $PATH, or is it only because
> new server can be used with old clients (before git-cmd moving outside
> $PATH)?

Both.  :-)

Clients (old and new) ask for git-upload-pack and git-receive-pack,
by SSH as we saw above... so it needs to be in the remote $PATH.
 
> >>> This immediately returns information of the repo:
> >> 
> >> To be more exact this is information about references (I guess this
> >> is information about heads only, is it?)
> > 
> > No, its *all* refs.  `git for-each-ref` plus HEAD.
> 
> You meant probably `git show-ref` plus HEAD, isn't it? 
> `git for-each-ref` has different default output...

Whatever.  I was talking about what we enumerate, not the output
format.  The server code is actually not using either of those
programs, but is instead just making the direct calls to refs.c
functions (for_each_ref function) and formatting the result specially
for the protocol.
 
> > Hysterical rasins.  ;-)
> 
> What does multi_ack capability mean?

It allows the server to return "ACK $SHA1 continue" as soon as
it finds a commit that it can use as a common base, between the
client's wants and the client's have set.

By sending this early, the server can potentially head off the
client from walking any further down that particular branch of the
client's repository history.  The client may still need to walk down
other branches, sending have lines for those, until the server has
a complete cut across the DAG, or the client has said "done".

IIRC, without multi_ack, a client sends have lines in --date-order
until the server has found a common base.  That means the client
will send have lines that are already known by the server to be
common, because they overlap in time with another branch that the
server hasn't found a common base on yet.

E.g. the client has things in caps that the server doesn't; server
has things in lower case:

     +---- u ---------------------- x
    /             +----- y
   /             /
  a -- b -- c -- d -- E -- F
   \
    +--- Q -- R -- S

If the client wants x,y and starts out by saying have F,S, the
server doesn't know what F,S is.  Eventually the client says "have
d" and the server sends "ACK d continue" to let the client know to
stop walking down that line (so don't send c-b-a), but its not done
yet, it needs a base for X.  The client keeps going with S-R-Q,
until a gets reached, at which point the server has a clear base
and it all ends.

Without multi_ack the client would have sent that c-b-a chain anyway,
interleaved with S-R-Q.

Junio, am I right?  I think I am, but I've had to reverse engineer
most of this.  And the above is my understanding of it.

> >>  * thin-pack
> 
> Server can send thin packs, i.e. packs which do not contain base 
> elements, if those base elements are available on clients side.
> Client has thin-pack capability when it understand how to "thicken"
> them adding required delta bases making them independent.

Yes.
 
> Of course it doesn't make sense for client to use (request) this
> capability for git-clone.

No, no it doesn't.  But if the client does request it (and I think
modern clients actually do request it, even on initial clone case)
the server won't produce a thin pack. Why?  There is no common base,
so there is no uninteresting set to omit from the pack.  :-)

> >>  * side-band 
> >>  * side-band-64k 
> 
> This probably means that server can send, and client understand 
> multiplexed (muxed) progress reports and error info interleaved
> with the packfile itself.
> 
> But I don't know what is the difference, whether server can provide
> side-band-64k without the other (side-band), and whether client has
> to request only one of those two capabilities.

Yes.  These two options are mutually exclusive. A client should
ask for only one of them, and a modern client always favors
side-band-64k.

Long ago, we only had side-band, which allowed up to 1000 bytes
per packet.  But the packet length field is 4 bytes, in hex, so 16
bits worth of information space.  Limiting it to only 1000 bytes
for a large 800 MiB binary pack file on initial clone is really
quite poor usage of the data stream space.

We couldn't just up the limit the server sends to the full 2^16
because older clients literally had a char[1000] allocated on the
stack, and we'd overflow it.  So "side-band-64k" came about as
another way for the client to request side-band, but to also say
it can handle the much larger packets, packets that are actually
crammed nearly full (65520 bytes).
 
> >>  * ofs-delta 
> 
> Server can send, and client understand PACKv2 with delta refering to
> its base by position in pack rather than by SHA-1... do I understand
> this correctly?

Yes.  Its that they can send/read OBJ_OFS_DELTA, aka type 6 in
a pack file.
 
> >>  * shallow 
> 
> Server can send shallow clone (git clone --depth ...).
> 
> >>  * no-progress
> 
> What that does mean?

The client was started with "git clone -q" or something, and doesn't
want that side brand 2.  Basically the client just says "I do not
wish to receive stream 2 on sideband, so do not send it to me,
and if you did, I will drop it on the floor anyway".
 
> >> Is each line terminated by "\n" or "\0"?
> > 
> > Actually, its weird...  Each line is terminated by a "\n" by
> > convention only, which is included in the 4 byte length declaration.
> > After reading a line the client slaps a NUL onto the end at the
> > position indicated by the length declaration, and processes the
> > line, skipping the "\n" at the end if it is present, and sliently
> > accepting the line just fine if the "\n" is missing.
> 
> This probably should be described... 
> 
> Does git require that each line is terminated by something (e.g. "\n"),
> or does it not?

It doesn't, but convention says to include the "\n" to be nice to
a human.  Junio may argue that it does require it, I don't know,
but if you read through any modern implementation (e.g. C Git or
JGit) the "\n" is entirely optional when parsing the lines.

Actually, it has to be, because that "\n" isn't there on the first
line when the capability data appears either wedged behind the "\0"
or after the " " at the end of the line.
 
> > This is why the "\0capability" hack works, the client didn't care
> > that that first ref doesn't end in an LF.  But it stopped where that
> > "\0" was because it was using a C string style operator.
> 
> It is a bit pity tat git protocol was not created with extendability
> (like capabilities) in mind...

Yes, no doubt.  There are many things I would have done differently,
given that I now have 20/20 hindsight vision into the past's future.

:-)

The protocol (mostly) works fine as-is.  Its widely distributed in
terms of clients using it on a daily basis.  Its likely to continue
to serve our needs well into the future.  So, it is what it is.
 
> BTW. do "0001" - "0003" pkt-lines are reserved, or just invalid?

Invalid.  No clue if they are considered "reserved for future use".
I don't think they are, I think they just out flat out not something
any client can ever sanely produce.

But, hey, look, another back door we can use in the future to
wedge something else into this protocol, after introducing a new
capability for it.  :-)
 
> >>>
> >>> 	"0008NAK\n"
> >> 
> >> What does this server response mean? That served doesn't need more
> >> info?
> > 
> > It means the server is answering a prior flush from the client,
> > and is saying "I still can't serve you, keep tell me more have".
> 
> Hmmm... the communication between server and client is not entirely
> clean. Do I understand correctly that this NAK is response to clients
> flush after all those "want" lines?

Yes.

> And that "0009done" from client
> tells server that it should send everything it has?

Yes.  It means the client will not issue any more "have" lines,
as it has nothing further in its history, so the server just has
to give up and start generating a pack based on what it knows.

> > Yes.  Actually, 2 means "progress messages, most likely suitable
> > for stderr".  1 means "pack data".  3 means "fatal error message,
> > and we're dead now".
> 
> But it is easily extendable, i.e. sideband > 3 would work, although
> be ignored, isn't it?

Correct.
 
> By the way, how client does know that server started to send final
> data, i.e. packfile multiplexed / interleaved with progress reports,
> and should expect <pkt-line-band> rather than <pkt-line> output?

After the client receives a "ACK" or "NAK" for the number of
outstanding flushes it still has, *after* it has sent "done".
This also varies based on whether or not multi_ack was enabled.

Its ugly.  But basically you keep a running counter of each "flush"
sent, and then you send a "done" out, and then you wait until
you have the right number of ACK/NAK answers back, and then the
stream changes format.
 
-- 
Shawn.
