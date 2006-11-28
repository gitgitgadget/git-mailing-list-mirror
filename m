X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS22107 204.16.104.0/24
X-Spam-Status: No, score=2.0 required=3.0 tests=AWL,BAYES_00,
	MSGID_FROM_MTA_HEADER shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Path: news.gmane.org!not-for-mail
From: Michael Haggerty <mhagger@alum.mit.edu>
Newsgroups: gmane.comp.version-control.subversion.cvs2svn.devel,gmane.comp.version-control.git
Subject: Re: Mozilla, git and Windows
Date: Tue, 28 Nov 2006 13:17:17 +0100
Message-ID: <456C28CD.6020800@alum.mit.edu>
References: <9e4733910611270728p36e58e08w6cc7a2989b7843ce@mail.gmail.com>	 <456B057E.4000904@shadowen.org>	 <9e4733910611270813g4ff982b0tbe6b57d1d49ca9f7@mail.gmail.com>	 <20061127221338.GP7201@pasky.or.cz> <9e4733910611271735y14bed29bk70ae67b5d28eb055@mail.gmail.com>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Trace: sea.gmane.org 1164716250 13932 80.91.229.2 (28 Nov 2006 12:17:30 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Tue, 28 Nov 2006 12:17:30 +0000 (UTC)
Cc: Petr Baudis <pasky@suse.cz>, Andy Whitcroft <apw@shadowen.org>,
        Git Mailing List <git@vger.kernel.org>, dev@cvs2svn.tigris.org
Original-X-From: dev-return-1875-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Tue Nov 28 13:17:25 2006
Return-path: <dev-return-1875-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc51.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1Gp1tr-0002PK-PP
	for gcvscd-dev@gmane.org; Tue, 28 Nov 2006 13:17:24 +0100
Received: (qmail 12723 invoked by uid 5000); 28 Nov 2006 12:17:22 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Received: (qmail 12713 invoked from network); 28 Nov 2006 12:17:21 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAABK3a0XAbSoIh2dsb2JhbACMcAEBCQ4q
X-IronPort-AV: i="4.09,468,1157353200"; 
   d="scan'208"; a="47760682:sNHT18853303"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061117 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910611271735y14bed29bk70ae67b5d28eb055@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Xref: news.gmane.org gmane.comp.version-control.subversion.cvs2svn.devel:1840 gmane.comp.version-control.git:32516
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32516>
X-Mailing-List: git@vger.kernel.org

Jon Smirl wrote:
> As was mentioned in the thread about doing CVS to git import, the
> trick is to write your own CVS file parser, parse the file once (not
> once for each revision) and output all of the revisions to the git
> database in a single pass. When code is structured that way I can
> import the whole Mozilla repository into git in two hours. The
> fast-import back end also works with out forking, it just listens to
> command and stdin and acts on them, all of the commands are implement
> in a single binary.

Using cvs2svn, it is now possible to avoid having to invoke CVS/RCS
zillions of times.  Here is a brief description of how the new hooks work.

There is an interface called RevisionReader that is used to retrieve the
contents of a file.  The RevisionReader that should be used for a run of
cvs2svn can be set using the --options file method with a line like:

ctx.revision_reader = MyRevisionReader()

The RevisionReader interface includes a method get_revision_recorder(),
which should return an instance of RevisionRecorder.  The
RevisionRecorder has callback methods that are invoked as the CVS files
are parsed.  For example, RevisionRecorder.record_text() is passed the
log message and text (full text or delta) for each file revision.  The
record_text() method is allowed to return an arbitrary token (for
example, a content hash), and that token is stored into
CVSRevision.revision_recorder_token and carried along by cvs2svn.

The concrete RevisionReaders included with cvs2svn are RCSRevisionReader
and CVSRevisionReader, which have do-nothing RevisionRecorders and which
call rcs or cvs in OutputPass to get the file contents.  (This repeated
invocation of rcs/cvs is the most expensive part of the conversion.)

So what you would do to speed things up is write your own
RevisionRecorder, which constructs the file fulltext from the CVS deltas
and stores the contents in a git store, returning the file revision's
content hash as token.

Then write a RevisionReader that returns an instance of your
RevisionRecorder to be used in the CollectRevsPass of the conversion.
For OutputPass, the RevisionReader has to implement the method
get_content_stream(), which is passed a CVSRevision instance and has to
return a stream object that produces the file revision's contents.  In
your case, you wouldn't need the contents at all, but could just work
with CVSRevision.revision_recorder_token, which contains the hash that
was generated by your RevisionRecorder.

How you actually cook these tokens together into a git repository is up
to you :-)

Michael

