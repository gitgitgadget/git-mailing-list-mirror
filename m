From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Tue, 2 Jun 2009 16:27:24 -0700
Message-ID: <20090602232724.GN30527@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <20090512233450.GY30527@spearce.org> <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com> <200906022339.08639.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 01:27:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBdOF-0005tO-OY
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 01:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbZFBX1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 19:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbZFBX1X
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 19:27:23 -0400
Received: from george.spearce.org ([209.20.77.23]:50252 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbZFBX1W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 19:27:22 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 49BF9381D1; Tue,  2 Jun 2009 23:27:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906022339.08639.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120561>

Jakub Narebski <jnareb@gmail.com> wrote:
> I see that there is (at least beginnings of) description of git pack
> protocol in section "Transfer Protocols"[1][2] of chapter "7. Internals
> and Plumbing" of "Git Community Book".
> 
>  [1] http://book.git-scm.com/7_transfer_protocols.html
>  [2] http://github.com/schacon/gitbook/blob/master/text/54_Transfer_Protocols/0_Transfer_Protocols.markdown
> 
> > ### Fetching Data with Upload Pack ###
> >
> > For the smarter protocols, fetching objects is much more efficient. 
> > A socket is opened, either over ssh or over port 9418 (in the case of
> > the git:// protocol), and the linkgit:git-fetch-pack[1] command on
> > the client begins communicating with a forked
> > linkgit:git-upload-pack[1] process on the server.
> 
> Is fetching over SSH exactly the same as fetching over git:// protocol?

Yes.  Except git:// starts off by sending "git-receive-pack
'repo.git'" on the wire using a pkt-line format, while ssh:// sends
that by way of the remote exec support built into the SSH protocol.
IOW, the only way that git:// differs from SSH is by providing the
smallest shim possible to replace that remote exec feature.
 
> > Let's look at an example.
> >
> > The client connects and sends the request header. The clone command
> >
> > 	$ git clone git://myserver.com/project.git
> >
> > produces the following request:
> >
> > 	0032git-upload-pack /project.git\\000host=myserver.com\\000
> >
> > The first four bytes contain the hex length of the line (including 4
> > byte line length and trailing newline if present). Following are the
> > command and arguments. This is followed by a null byte and then the
> > host information. The request is terminated by a null byte.
> 
> There is a question how to organize this information. Should we describe
> pkt-line format upfront, e.g. using ABNF notation from RFC 5234 used in
> RFC documents:
> 
>   <pkt-line>   = ( <pkt-length> <pkt-payload> [ LF ] ) / <pkt-flush>
>   <pkt-length> = 4HEXDIGIT                  ; length of <pkt-line>
>   <pkt-flush>  = "0000"
> 
> or something like that?

Yes.
 
> Sidenote: wouldn't it be better to use \0 (\\0 in source) for NUL
> character rather than \000 (\\000 in source) octal representation?

Most languages today honor '\0' or "\0" as a means of embedding a
NUL into a char type.  So \0 seems correct to me.

> > The request is processed and turned into a call to git-upload-pack:
> >
> >  	$ git-upload-pack /path/to/repos/project.git
> 
> Is it "git-upload-pack" or "git upload-pack" nowadays?

Sadly, we still invoke "git-upload-pack" IIRC.
 
> > This immediately returns information of the repo:
> 
> To be more exact this is information about references (I guess this
> is information about heads only, is it?)

No, its *all* refs.  `git for-each-ref` plus HEAD.

> , with information about
> server capabilities stuffed in.
> 
> >
> > 	007c74730d410fcb6603ace96f1dc55ea6196122532d HEAD\\000multi_ack thin-pack side-band side-band-64k ofs-delta shallow no-progress
> >       003e7d1665144a3a975c05f1f43902ddaf084e784dbe refs/heads/debug
> >       003d5a3f6be755bbb7deae50065988cbfa1ffa9ab68a refs/heads/dist
> >       003e7e47fe2bd8d01d481f44d7af0531bd93d3b21c01 refs/heads/local
> >       003f74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/master
> >       0000 
> >
> > Each line starts with a four byte line length declaration in hex. The
> > section is terminated by a line length declaration of 0000.
> 
> Should we describe here, or in appendix, or in sidenote, or in footnote
> all currently supported client capabilities and server capabilities?

Yes.

>  * multi_ack (why not mult-ack?)

Hysterical rasins.  ;-)

>  * thin-pack 
>  * side-band 
>  * side-band-64k 
>  * ofs-delta 
>  * shallow 
>  * no-progress
> 
> Is each line terminated by "\n" or "\0"?

Actually, its weird...  Each line is terminated by a "\n" by
convention only, which is included in the 4 byte length declaration.
After reading a line the client slaps a NUL onto the end at the
position indicated by the length declaration, and processes the
line, skipping the "\n" at the end if it is present, and sliently
accepting the line just fine if the "\n" is missing.

This is why the "\0capability" hack works, the client didn't care
that that first ref doesn't end in an LF.  But it stopped where that
"\0" was because it was using a C string style operator.

> Is 'flush' line? This is not
> clear from above description. From simple playing with nc (netcat) it
> looks like each line with exception of '0000' is terminated with "\n".

The only reason we end with "\n" is to make playing with netcat
easier.  There isn't a real practical reason in terms of the protocol
for why you need that "\n" in there.

But.  That flush line is magical.  A length of "0000" means its a
flush packet, which has no data payload.  An "\n" after the "0000"
would break the protocol as the server would read that "\n" in a
context where it is expecting another pkt-line length declaration.
"\n" is not a hex digit, so "0000\n" is horribly horribly broken.
 
> > This is sent back to the client verbatim. The client responds with
> > another request:
> >
> > 	0054want 74730d410fcb6603ace96f1dc55ea6196122532d multi_ack side-band-64k ofs-delta 
> > 	0032want 7d1665144a3a975c05f1f43902ddaf084e784dbe
> > 	0032want 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a
> > 	0032want 7e47fe2bd8d01d481f44d7af0531bd93d3b21c01
> > 	0032want 74730d410fcb6603ace96f1dc55ea6196122532d
> 
> The semantics (meaning) of those 'want' lines is not described here,
> although one can easily guess that those are commits that client does
> not have, and which do want. In the case of "git clone" those are all
> unique sha1 that client got (what happend if server has detached HEAD?)

IIRC, HEAD isn't fetched if its detached.

The client pattern matches the advertisements against the fetch
refspec, which is "refs/heads/*:refs/remotes/origin/*" by default.
HEAD doesn't match the LHS, so it doesn't get wanted by the client.
 
> It is not clear, but one can guess that set of capabilities that client
> sends (without stuffing behind NUL character this time?) is a supported
> by client and wanted subset of server capabilities.

Yes.  Another oddity.  Why the heck we didn't also use the NUL hack
here is a good question.  Basically, the NUL hack wasn't necessary
in the server at the time that capabilities were added, because the
server was parsing the line with a fixed position parser.  It only
looked at the first 45 characters ("want 0x40").  Anything after
that was assumed to be garbage... like that unnecessary LF.
 
> > 	00000009done
> 
> First I thought that this is an error... but not, the 'flush' ("0000")
> is not LF terminated.

Correct.  Again, server only cares that its "done" in a packet.
I think "donedammitsendmeapacknow" is also going to make the current
servers spit back a pack.  :-)
 
> >
> > 	"0008NAK\n"
> 
> What does this server response mean? That served doesn't need more
> info?

It means the server is answering a prior flush from the client,
and is saying "I still can't serve you, keep tell me more have".

> > 	"0023\\002Counting objects: 2797, done.\n"
> > 	"002b\\002Compressing objects:   0% (1/1177)   \r"
> > 	"002c\\002Compressing objects:   1% (12/1177)   \r"
> > 	"002c\\002Compressing objects:   2% (24/1177)   \r"
> > 	"002c\\002Compressing objects:   3% (36/1177)   \r"
> > 	"002c\\002Compressing objects:   4% (48/1177)   \r"
> > 	"002c\\002Compressing objects:   5% (59/1177)   \r"
> > 	"002c\\002Compressing objects:   6% (71/1177)   \r"
> > 	"0053\\002Compressing objects:   7% (83/1177)   \rCompressing objects:   8% (95/1177)   \r" ...
> > 	"005b\\002Compressing objects: 100% (1177/1177)   \rCompressing objects: 100% (1177/1177), done.\n"
> 
> I guess that it is sideband support: after pkt-length there is number
> of stream (multiplexing), where 2 = \002 means stderr.

Yes.  Actually, 2 means "progress messages, most likely suitable
for stderr".  1 means "pack data".  3 means "fatal error message,
and we're dead now".
 
> I wonder why sometimes it is one line per update, and sometimes there
> is more than one update info stuffed in single line.

Buffering.  There are two processes running on the server side,
git-pack-objects is producing these messages on its stderr,
and the pack data on stdout.  Both are actually a pipe read by
git-upload-pack in a select loop.  If pack-objects can write two
messages into the pipe buffer before upload-pack is woken to read
them out, upload-pack might find two (or more) messages ready to
read without blocking.  These get bundled into a single packet,
because, why not, its easier to code it that way.

Its most common on the end like that, where we dump 100%, and
then immediately add the ", done" and start a new progress meter.
Its less likely in the middle, where we try to space out the progress
updates to around 1 per second, or 1 per percentage unit.
 
-- 
Shawn.
