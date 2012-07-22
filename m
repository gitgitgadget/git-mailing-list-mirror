From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: GSOC remote-svn
Date: Sun, 22 Jul 2012 23:03:27 +0200
Message-ID: <4514544.Xip1OCQ7Uj@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: jrnieder@gmail.com, davidbarr@google.com
X-From: git-owner@vger.kernel.org Sun Jul 22 23:03:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St3JS-00049V-4E
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 23:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab2GVVDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 17:03:33 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50028 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab2GVVDc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 17:03:32 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so4650652bkw.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 14:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding:content-type;
        bh=jSb+FWHPl5Zmv0mLNZWYgLpRNs0FFS2+DG5CiBCLgTU=;
        b=bUu9BHLI8vCiPm9LQju5x0nJOeM7mCcrPQdAU1877EeRM4tPuG8Z/W2wEU6oN1iveI
         E2kG5ps9T1khAvq/cVFcz8uNPuyNjWL//EsLoW0cFK9Ur2TVvRG4nQuMq5NOHPl0WRz1
         TvIlMLU3BptK9gjCY5uiNWG6Khis9jzzp92RQA7S2djPI6PxVyfW7GVmg7ijqxWFRSYj
         BPz19qp2ptrBK91IrrTi5sJUfis5NZagrrA5yGBMMHXmxZob/7J+06R9qV4QFRV1uC2r
         40029CXio6tOr7keRTIQUTxc/FlZ9YlQkeGNUCpb7GaXAxmPIW2z0yNExSSFzp57RXSI
         gepA==
Received: by 10.204.130.211 with SMTP id u19mr2886991bks.24.1342991011984;
        Sun, 22 Jul 2012 14:03:31 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id 14sm5738402bkq.12.2012.07.22.14.03.30
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 14:03:30 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201865>

Hi!

Refering to Jonathan's concerns in Saturday night's IRC log:

> [22:59:34] <jrnieder> barrbrain, flyingflo: I'm worried about the remote 
helper project
> [23:00:05] <jrnieder> someone needs to review remote-svn.c to catch things 
like that refspec issue which should be straightforward to an experienced eye

Let me explain the refspec issue:

In the the exisiting code in contrib/svn-fe commits are always imported to 
refs/heads/master, that was hardcoded. So I thought that couldn't be it.
I made the name of the  branch to import variable, depending on the name of 
the remote.
But my remote-helper didn't advertise the refspec capability, so transport-
helper assumed it imports to refs/heads/master, which is the default import 
refspec. The subsequent update of references in store_updated_refs lead to 
wrong values after the fetch, which I considered a bug and tried to fix.

In fact I didn't realize that the actual updating of references is not done by 
the remote-helper. I thought the remote-helper would have to evaluate the 
fetch refspec and tell fast-import the correct target branch.
Furthermore I confused 'private namespace' with refs/remotes/<remote's name>/, 
which I considered somehow private too.

After several mailing iterations, showing me that I was wrong, I found what 
the right point is, namely that the remote helper writes references to a 
really private dir in refs/<remote name>/, it doesn't touch anything else, and 
by advertising the 'refspec' capability, git-fetch knows where the private 
refs are and updates non-private references according to the fetch refspec in 
some post-processing in store_updated_refs. (Ok, you will say "of course!", 
but I didn't know that I was wrong and it's hidden in some 1000 lines of 
code).

For me that was not very easy to figure out, and it took a lot of time, but I 
think now remote-svn does it right.

> [23:00:38] <jrnieder> (also, remote-svn.c should be at the toplevel so it 
can be tested more easily with tests in t/
> [23:01:10] <jrnieder> and it should not be named remote-svn, since we 
haven't pinned down details about the svn:: conversion yet.  That's why 
Dmitry's was called git-remote-svn-alpha)

Ok. Why is that important? I think if it's not called remote-svn git doesn't 
find it as a helper for the 'svn' protocol. Actually in my local git tree, I 
have a symlink in the toplevel (to simpify PATH).

> [23:01:45] <jrnieder> I'm happy to review patches but I don't have a lot of 
time for it, which has been a problem:
> [23:02:11] <jrnieder>  * I think I wasn't cc-ed on earlier discussion so 
they seem to come out of the blue.  That's fine, but
> [23:03:05] <jrnieder>  * I really rely on patches that do one logical thing 
with a commit message describing the context and what the patch is trying to 
accomplish.  That makes review way, way easier when it is happening.

Probably I should stop sending proposals or incomplete stuff to the list/you.
The current state may probably be viewed easier in my github repo.

I think for creating patches that are acceptable I will need to squash and 
split a lot of my development  commits after the code is somehow finished and 
no longer experimental.

> [23:04:42] <jrnieder> Also it seems very chaotic: there are basic things 
about remote-svn.c that need fixing, and then patches for other things are 
appearing on top of that.
> [23:04:49] <jrnieder> Help?
> [23:05:26] <jrnieder> thanks, and hope that helps

About the current state:

Tester:
I wrote a small simulation script in python that mimics svnrdumps behaviour by 
replaying an existing svn dump file from a start rev up to an end rev to test 
incremental imports. I use it together with a little testrepo shell script.
Will need to bring that into t/ later, after figuring out how the test 
framework works. As it's not finished it's not published.

Incremental import:
By reading the latest svn revision number from a note attached to the private 
master ref, it starts future imports from the next svn revision. That 
basically works well.
It doesn't reuse mark files. What's the point of reusing them? Dmitry's svn-
alpha did that.
All I need to know is the revision to start from and the branch i want to add 
commits to, right? It now simply reads that from the note.

This got stuck on another problem:
Incremental update of the note tree doesn't work. fast-import refuses to 
update the notes tree: '<newsha1> doesn't contain <oldsha1>'.
I don't yet know what's the reason for this.
I'm digging into the internals of notes to find out why..
(no problem with the file tree).

This state hasn't hit the list of course, as it's in no way useful nor 
complete.

I often get caught in the traingle of those three processes (git transport-
helper, fast-import, remote-svn) needing to understand a lot about the 
existing two to understand why things don't work and why they need to work 
like they do.

--
Florian
