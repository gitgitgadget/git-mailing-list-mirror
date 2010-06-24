From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update extra!] git-remote-svn: Week 8
Date: Thu, 24 Jun 2010 15:33:28 +0200
Message-ID: <1277386408-29943-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Shahaf <d.s@daniel.shahaf.name>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 24 15:32:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORmXA-0002rG-DA
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 15:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312Ab0FXNbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 09:31:55 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:50722 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754822Ab0FXNby (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 09:31:54 -0400
Received: by wwi17 with SMTP id 17so216224wwi.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 06:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=bJovJaw2XoJxB1dgsYEoC9+Cp2q6YhmgCv6iMr9/BuQ=;
        b=mFSwujGd/zKEC0IKByYj/jexqpPeNjNtDTgXNVnmF6dRAFmnNThq1NF+L3ei8EzMUf
         gotHYpqIQoEDFjlGwXUl3eBwrRf6N2jzZNuWAU1mg2sjmWu8uLr3J1IedUTFuNNN9Mgr
         03rZ8WZwg+kzfrs5H0LdEVbyGtiYwTo9soZwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=a1SqGqVkKLSB5EReTQWImOSSukRV7owUTH2d3+CZi+qkvQU9iYqkAKPT34Fp+WFelY
         5v7UhaBWhFNScVnfy7w7VgPuOfDt6cTl0y/HtH6Bj2Y7uuxPsBZFLrVATYssyA9Le7Ym
         OrretyUTvqY9jPGRaG7PywHY9HZzGKZNFlC34=
Received: by 10.227.69.71 with SMTP id y7mr8936697wbi.123.1277386311666;
        Thu, 24 Jun 2010 06:31:51 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id n31sm31858844wba.9.2010.06.24.06.31.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 06:31:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149594>

Hi,

I built a client that generates a deltified dumpfile, but David's
exporter can't build full text from it. We got an idea, brought Sverre
into the loop and discussed it. David and I felt that the chatlog was
valuable enough to go on the Git mailing list for later reference, so
here it is.

This proposal will take a lot of time to implement. The current plan
is to get my client to dump full text (rather inefficiently), and get
something working while Sverre (and possibly others) work on this
proposal in the meantime.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 notes |  117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 117 insertions(+), 0 deletions(-)
 create mode 100644 notes

diff --git a/notes b/notes
new file mode 100644
index 0000000..224a5be
--- /dev/null
+++ b/notes
@@ -0,0 +1,117 @@
+14:19 *** SRabbelier JOIN
+14:19 <barrbrain> artagnon: backstory please :)
+14:20 <barrbrain> SRabbelier: welcome
+14:20 <SRabbelier> sup :)
+14:20 <artagnon> SRabbelier: Background -- I generated a delta dumpfile fine. barrbrain's exporter can't build full text from that, and I can't do it in my client either. We are looking for some kind of filesystem -- the Git
+                 store is the answer. Can we import revisions one by one through fast-import and ask Git to generate the full text?
+14:22 <artagnon> SRabbelier: Note that barrbrain's recent work on persistence makes it support incremental dumps, so throwing it into fast-import is not the problem at all.
+14:22 <SRabbelier> artagnon: well, that kind of goes against fast-import's nature, since if you do one revision at a time you lose the benefits of using it (low memory profile, etc)
+14:22 <artagnon> Hm.
+14:23 <artagnon> Is there some option to tweak it to create just loose objects and not pack them for every revision?
+14:23 <artagnon> And then pack them all together after we produce a full text in the end?
+14:23 <SRabbelier> artagnon: it doesn't create a packfile until you call 'checkpoint'
+14:24 <artagnon> Excellent. Then what's the problem? I won't call checkpoint until we get the full text out.
+14:25 <SRabbelier> perhaps I'm not quite understanding the problem then
+14:25 <SRabbelier> you can definitely call 'git cat-file' after each exported file
+14:25 <SRabbelier> and fast-import would just hang waiting for more input I guess
+14:26 <artagnon> barrbrain: Does that ^^ sound good?
+14:26 <barrbrain> artagnon: sounds good
+14:27 <artagnon> SRabbelier: Thanks, that's what we wanted to know :)
+14:27 <barrbrain> SRabbelier: how does the exporter know when the checkpoint has completed?
+14:27 <SRabbelier> barrbrain: it doesn't matter
+14:27 <SRabbelier> barrbrain: the object is available regardless of whether you checkpoint
+14:28 <barrbrain> oh really?
+14:28 <SRabbelier> barrbrain: it doesn't matter if the object is loose or in a pack
+14:28 <SRabbelier> barrbrain: it's transparent to whoever is calling git
+14:28 <artagnon> loose object and pack are equivalent to Git infrastructure
+14:28 <SRabbelier> right, only packs are faster
+14:28 <barrbrain> even in the middle of a fast-import?
+14:28 [artagnon nods]
+14:29 <barrbrain> the catch is that the only reference we have for a blob is a mark
+14:29 <artagnon> You have to keep all the marks until the fulltext is built?
+14:30 <SRabbelier> barrbrain: ah, well, that is a problem
+14:30 <SRabbelier> also, remind me why you need the fulltext?
+14:30 <barrbrain> the only way out of that is to hash them as we go
+14:31 <barrbrain> input stream is in deltas
+14:32 <artagnon> barrbrain: ... also, what about text-content-length? You need that to parse the dumpfile, right?
+14:32 <barrbrain> yeah
+14:32 <artagnon> Erm.
+14:32 <artagnon> It'll be horrible if replay doesn't supply that.
+14:32 <barrbrain> indeed
+14:33 <artagnon> I told SRabbelier about that too... loading the whole thing into memory is a terrible option.
+14:34 <SRabbelier> artagnon: well, git cat-file-ing it will require it to be loaded too?
+14:34 <artagnon> Oh, damn.
+14:35 <artagnon> SRabbelier: Is there a way to keep dynamically write it from a stream? I don't want git-cat-file then.
+14:35 <SRabbelier> artagnon: oh like that
+14:35 <SRabbelier> artagnon: uhm, I assume it streams it
+14:35 <SRabbelier> artagnon: but you'd have to double check that
+14:35 [artagnon checks]
+14:40 <barrbrain> so, if you have pipes to fast-import and cat-file --batch, can you read-write from the repo safely?
+14:40 <SRabbelier> barrbrain: yes, git is concurrency safe
+14:41 <barrbrain> what about the timing issue - if I write to fast import the blob might be delayed in a buffer somewhere
+14:41 <SRabbelier> barrbrain: I think what we'll need to do is to extend fast-import to also write the object names to stdout
+14:42 <SRabbelier> barrbrain: as soon as it's done writing the object
+14:42 <barrbrain> nvm, that's what the checkpoint/progress comment is all about
+14:42 <SRabbelier> barrbrain: and then you can wait till you get the name on stdout, and then you'll be sure that it's safe to git cat-file that object
+14:42 <SRabbelier> barrbrain: no
+14:42 <SRabbelier> barrbrain: checkpoint is only about packing
+14:42 <barrbrain> except no need for all that work
+14:42 <SRabbelier> barrbrain: you don't want to do checkpoint after each commit though
+14:43 <barrbrain> SRabbelier: I totally agree
+14:43 <SRabbelier> barrbrain: but, you can read the marks from the export file after a checkpoint, that is true
+14:43 <SRabbelier> so what I guess you could do
+14:43 <SRabbelier> is to keep feeding it commits till you need to get the hashes
+14:44 <SRabbelier> then do a checkpoint and a progress
+14:44 <SRabbelier> watch it's stdout till you see the progress message
+14:44 <barrbrain> it'd be nice to have a command to write the hash of a mark to stdout
+14:44 <SRabbelier> (so that you know that the checkpoint has completed)
+14:44 <SRabbelier> and then you can read the markfile
+14:44 <SRabbelier> barrbrain: if it would make things easier I could probably fairly easily hack fast-import to do that always
+14:45 <SRabbelier> barrbrain: so the other workflow I described, where it prints the hash of each mark ti stdiyt as it processes it
+14:45 <barrbrain> that's potentially a lot of detail in the output though :)
+14:45 <SRabbelier> barrbrain: yes, so it would be guarded by a flag
+14:45 <barrbrain> SRabbelier: oh, nice
+14:45 <SRabbelier> barrbrain: --print-marks
+14:45 <SRabbelier> or of cvourse
+14:45 <SRabbelier> barrbrain: in the stream you could say
+14:46 <SRabbelier> barrbrain: option git print-marks
+14:46 <artagnon> Better.
+14:46 <barrbrain> this is why we talk :)
+14:46 <artagnon> IRC is superb for some discussions :)
+14:46 <SRabbelier> ok, so you'd have to capture fast-import's stdout
+14:47 <SRabbelier> and you'd have to wait till you got the mark line
+14:47 <SRabbelier> and then you could feed that to the `git cat-file --batch` pipe
+14:47 <artagnon> SRabbelier: I hope it doesn't break the workflow of the remote helper.
+14:47 <SRabbelier> artagnon: ah, hmmm
+14:48 <SRabbelier> that's a problem
+14:48 <artagnon> I thought so.
+14:48 <artagnon> :|
+14:48 <SRabbelier> since in that case git starts the fast-import stream
+14:48 <artagnon> Exactly.
+14:48 <SRabbelier> **the fast-improt process
+14:49 <SRabbelier> well, I guess we could add a capability to the remote-helper
+14:49 <SRabbelier> that would make git just forward those marks to the remote-helper process?
+14:49 <SRabbelier> (on it's stdin)
+14:50 <SRabbelier> artagnon, barrbrain: that would work, no?
+14:50 [artagnon is thinking]
+14:51 <barrbrain> I think I've lost track of which pipe goes where
+14:51 <SRabbelier> artagnon: the remote-helper could just read from it's stdin, instead of from fast-import's stdout
+14:51 <artagnon> Right, got it.
+14:51 <artagnon> Yeah, a new capability should work.
+14:51 <SRabbelier> barrbrain: git-remote-svn would be hooked up both stdin and stdout to git
+14:51 <SRabbelier> barrbrain: when it starts, it tells git through a capability that it needs to have the marks hashes
+14:52 <SRabbelier> barrbrain: when git tells it to start exporting, git-remote-svn will write it's stream to stdout
+14:52 <SRabbelier> barrbrain: after each mark, git will read from the stdout of the fast-import process that it starts, and write that mark back to git-remote-svn's stdin
+14:53 <SRabbelier> barrbrain: so git-remote-svn can then read from it's stdin, and write that hash back to git cat-file --batch
+14:53 <barrbrain> right, can it then request blobs to be received on stdin later?
+14:53 <SRabbelier> barrbrain: yeah, that would work to, but I think it'd be better to keep it generic
+14:53 <SRabbelier> barrbrain: and instead have git write the hashes to git-remote-svn's stdin
+14:53 <SRabbelier> barrbrain: since then you can do whatever you want with those hashes
+14:54 <SRabbelier> barrbrain: for example, you might want to create a tag for those hashes, or such, in which case a hash is useful, and the contents of the blob isn't
+14:54 <barrbrain> or it just gets hashes and opens its own cat-file process?
+14:54 <SRabbelier> barrbrain: right
+14:54 <SRabbelier> barrbrain: that
+14:55 <SRabbelier> artagnon, barrbrain: anyway, if this is what we want, please mail the git list (especially Shawn), and propose this
+14:55 <SRabbelier> see what he thinks of it
+14:55 <SRabbelier> ask Shawn if he's ok with having git-fast-import learn a new '--print-marks' flag
+14:55 <SRabbelier> if so, I'll get on that :)
-- 
1.7.1
