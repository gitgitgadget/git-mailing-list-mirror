From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: GSOC remote-svn: branch detection
Date: Tue, 07 Aug 2012 23:26:26 +0200
Message-ID: <3476983.FSv5Fk2g49@flobuntu>
References: <12682331.q6WHVv9EKU@flomedio> <20120803181728.GA21745@copier> <CALkWK0mu1=NEUZzB1VPAf0DU_nguuq_nJ-9Rn7Pj6zeNfoZGtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	David Michael Barr <davidbarr@google.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 23:26:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyrIS-0006SA-Fs
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 23:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756739Ab2HGV0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 17:26:32 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:48072 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756738Ab2HGV0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 17:26:31 -0400
Received: by wgbdr13 with SMTP id dr13so63765wgb.1
        for <git@vger.kernel.org>; Tue, 07 Aug 2012 14:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=DAbcKPjk2+u557Z4lzDGonhCb1okjOa3lWV89kmzHZ0=;
        b=L6emsKfE1u1qrpluSixaNMevhabkH7F3hXlp07CDoax+1LbKIBIxLZS1cygTdgpOcu
         4qQpRQEVRdigTgyt2nkCP1DOy2UU+LFtcVkjVdYHz67uV0N1PCGnCde8gC79fEliQNcJ
         /OoTJZgFKcvrSvXu38xxeFbR8siqHfhA8gJfpKqaXxJQK6JP2bzKi25+HQ6U1wuIJYAb
         s58reF10ZfxeX/MIhOhrwuBr4aqi5kYzFB8U0xyer3M4IDc+JM/t+HlW1qsULCT5zJDH
         94NZY13MYwZFqEjrgilJE4Xr1guJbQSDbtUp3PLOMud6dcMlUqoAbNZz3ZNm9x5pb3v1
         hxwQ==
Received: by 10.216.85.130 with SMTP id u2mr7922103wee.202.1344374789791;
        Tue, 07 Aug 2012 14:26:29 -0700 (PDT)
Received: from flobuntu.localnet (93-82-148-35.adsl.highway.telekom.at. [93.82.148.35])
        by mx.google.com with ESMTPS id cl8sm1467256wib.10.2012.08.07.14.26.27
        (version=SSLv3 cipher=OTHER);
        Tue, 07 Aug 2012 14:26:28 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-27-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <CALkWK0mu1=NEUZzB1VPAf0DU_nguuq_nJ-9Rn7Pj6zeNfoZGtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203048>

On Saturday 04 August 2012 23:53:58 Ramkumar Ramachandra wrote:
> Hi,
> 
> Florian Achleitner wrote:
> > 1. Import linearly and split later:
> I think this approach will be a lot less messy if you can cleanly
> separate the fetching component from the mapper.  Currently, svndump
> re-creates the layout of the SVN repository.  And the series you
> posted last week contains a patch that attaches a note with SVN
> metadata to each commit.  Do you have thoughts on how the mapping will
> take place?

The mapping itself is currently a black box for me, it's internals could be 
rather complex. It could get a function like is_branch_start, that is called 
with a node ctx and tells if this is likely to be the start of branch. The 
detected branches are stored and upcoming changes in the associated 
directories are mapped to a commit on a branch.
The detection of branch starts and the list of existing branches can be taken 
from whatever logic we want. So that's approx. the idea.

Currently I'm working on more basic preparations. I want to split the creation 
of commits and the creation of blobs in svndump.c.
This is necessary because fast import requires a branch name as an argument to 
the 'commit' command, and
currently a 'commit' command is started when a new revision is encountered in 
the svndump.
But to decide on which branch the commit should go, or even if it will be more 
than one commit, it is necessary to read all the nodes first.
To prevent buffering the node content, I want to replace the inline data format 
(currently used) by 'blob' commands.
While parsing the dump, every node change creates a blob command to feed the 
data immediately into fast-import while the node metadata (struct node_ctx) is 
stored at least until the revision ends. Then the blobs can be put on a linear 
master tree and other branch trees. The node metadata could also be read from 
notes, if remapping branches.
That's not so easy to do, because the current implementation mixes tree-
operations and blob-operations heavily, and relies on only one global 
node_ctx.

> 
> Ram

Flo
