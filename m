From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach fmt-patch to write individual files.
Date: Fri, 5 May 2006 02:56:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605050249050.25249@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0605050115440.12795@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vhd452uzn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 02:56:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbocN-0005pY-To
	for gcvg-git@gmane.org; Fri, 05 May 2006 02:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWEEA4S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 20:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWEEA4S
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 20:56:18 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:64455 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751493AbWEEA4R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 20:56:17 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 19C71D07;
	Fri,  5 May 2006 02:56:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 0DC95CBF;
	Fri,  5 May 2006 02:56:16 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id DC4A6B51;
	Fri,  5 May 2006 02:56:15 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd452uzn.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19590>

Hi,

On Thu, 4 May 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When called with "--stdout", it still writes to standard output.
> >
> > Notable differences to git-format-patch:
> >
> > 	- since fmt-patch uses the standardized logging machinery, it is
> > 	  no longer "From nobody", but "From <commit_sha1>",
> 
> Yes, and the date on that UNIX-From line has been updated ;-).

Right.

> > 	- the empty lines before and after the "---" just before the
> > 	  diffstat are no longer there,
> 
> Personally, I find this the most annoying myself.  I am not
> complaining to you because as you know you inherited this
> behaviour from my code.

How about this?

-- snip --
diff --git a/log-tree.c b/log-tree.c
index d92abaf..6379d43 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -86,7 +86,7 @@ int log_tree_diff_flush(struct rev_info 
 	}
 
 	if (opt->loginfo && !opt->no_commit_id)
-		show_log(opt, opt->loginfo, opt->diffopt.with_stat ? "---\n" : "\n");
+		show_log(opt, opt->loginfo, opt->diffopt.with_stat ? "\n---\n\n" : "\n");
 	diff_flush(&opt->diffopt);
 	return 1;
 }
-- snap --

> > 	- git-format-patch outputs the commit_sha1 just before the first
> > 	  diff, which fmt-patch does not,
> 
> Which should be fine.

Yeah, I just wanted to mention it in case people rely on it.

> > 	- the file names are no longer output to stdout, but to stderr
> > 	  (since stdout is freopen()ed all the time), and
> 
> Which might be a bigger deal; I suspect people capture that while
> dumping patches into individual files, and do their
> postprocessing using the list of filenames.

I hoped it is not necessary to "FILE *realstdout = fdopen(dup(1));" but I 
can do it if this is wanted.

> > 	- "git fmt-patch HEAD^" does not work as expected: it outputs
> > 	  *all* commits reachable from HEAD^!
> 
> If we really wanted to handle this, you could do something like
> what builtin-diff does before letting the revision machinery
> start walking the revision tree.  Look at pending objects, and
> if you find only one UNINTERESTING commit, add_object the
> current HEAD there as well.  Personally I do not think it is
> worth it; rather we would probably want to standardize on rev-list
> syntax.

Well, I have to get used to add ".." after HEAD^, but that is probably not 
very difficult. I would like fmt-patch to error out without a range, 
though.

> Two major differences you forgot to mention.
> 
> One is that it does not do the "git cherry" filtering.  It is
> not a big deal for me personally, but some people may be
> depending on it.  I dunno.

Oops. I really did not think of that.

> Another is -o outdir, which should be trivial to add once you
> have implemented output switching with freopen().

Yes, this becomes easy now. I'll do that next.

Ciao,
Dscho
