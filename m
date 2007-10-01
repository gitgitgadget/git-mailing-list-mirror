From: "David Tweed" <david.tweed@gmail.com>
Subject: what's a useful definition of full text index on a repository?
Date: Mon, 1 Oct 2007 17:33:47 +0100
Message-ID: <e1dab3980710010933u6a7324f0wa8230d67ee0846e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 18:34:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcODY-0005Rm-BZ
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 18:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbXJAQdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 12:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbXJAQdx
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 12:33:53 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:40443 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbXJAQdw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 12:33:52 -0400
Received: by nz-out-0506.google.com with SMTP id s18so2621457nze
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=ed398oEBUu9uyHHfMovvB48f6OvZ7/Sa7gWNmpG604A=;
        b=APoyVKcnUWhEgROsQtzEHvoH6ZAcQvtMWhmyeYaOqMH6Hg37uiyfc9WGn7zZ/wd3anDDaQfdwgQwv4RcwXrzFbatBNiu5iU+2zS2IYnGlDvKOgYl+EGw7pONwlcBKQOqPj4l4z8+fxpUwUo5Nz09cqlPIZ9w9XmU212B4SkQyGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bfkdyeOUKhR0RG5xLlnTYXIT5SR2Q960nc91oZ6zHqdRfucL51Wrd0B/o4i84NbihvLpuVteP2b26jEp8XMiMbm5WU/p3fCD/MbagszMBYZxr8kpNrXtivqtJim0aIy/GrtGkrmvqUDQ1UXnaA9pftxCxmK3BncVrblom0pt1hE=
Received: by 10.65.115.4 with SMTP id s4mr15411111qbm.1191256427476;
        Mon, 01 Oct 2007 09:33:47 -0700 (PDT)
Received: by 10.64.181.10 with HTTP; Mon, 1 Oct 2007 09:33:47 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59626>

Basically a "blue sky" question about full-text indexing git repositories.

A while back, whilst talking about overall git structure
(see

http://marc.info/?l=git&m=118891945402778&w=2

), Jon Smirl raised the question of putting a full-text index on a
repository. I doubt I full text index is of much use on a code
repository because the question tends to be focussed around either
released versions or immediate git-blame stuff. However, for
repositories of things like evolving documents/presentations/notes
where content is deleted because it doesn't fit the context rather
than being superceded by better stuff, it might be more natural to
search for "where's that paragraph I wrote on 'human' 'vision' and
'kinematic' 'feedback' ?". So I got to thinking about experimenting
with a full text index and even started writing some code. However, I
then realised that it's not obvious what the most useful definition of
a full text index is on evolving files. (To be clear, I'm _not_
thinking about changing the database fundamentals as discussed in the
referenced thread and indeed would put the full-text index into a
different file that just references the existing git db stuff
precisely because I doubt the text index will be of use to most
people.)

A "classical" full-text index seems inappropriate because, if I've got
a long text document that in a blob in commit n1 uses word 'x' in one
section and the corresponding file in descendant commit n2 has the
same text using word 'x' but has changes to a different section of the
document, there's probably no point showing me both documents (and I
can always track through the history once I've got one (commit-id,file
pair)). So in the case of a single word, a "useful" definition would
be the entry for word w in the full-text index should consist of those
(commit-id,file) pairs whose diff with their parent contains an
addition of text containing word w. (This will catch the creation of
the text containing w and then precisely those files which are close
modifications of it but ignore changes to other areas.) This seems to
make sense for a single word. Let's call this the "appearance diff"
definition of a full text index.

However, things become unclear if you consider a query with multiple
words. Consider the simplest case of a linear history where commit n0
adds word "vision" to file p1.tex (with respect to its single parent),
there are some intermediate commits and then commit n7 adds word
"feedback" to p1.tex. Then there's no commit whose diff with its
single parent contains both words "vision" and "feedback". In the
linear history case you could imagine trying to find the first commit
which is a child of _all_ the commits under the "appearance diff"
definition. However, that clearly doesn't "obviously" extend to
general full DAG histories, and in any case it's probably not fully
correct even in the linear case. So maybe a different definition would
be better. So I'm just throwing the question out to the list in case
anyone has any better ideas for what a full-text index on an evolving
set of files ought to be.

(One question is "why do you want to build a table rather than
actively search the full git repo for each query (ie, combination of
words) as you make it?" My primary motivation is that I might in the
future like to do queries on some sort of low processor power
UMPC-type thing, having built the file containing a "full text index"
data structure for the index on a quite beefy desktop. The other point
is that searching natural language text based on a fallible memory
you're more likely to try different combinations of search terms
iteratively to try and hit the right one, so there might be some point
in trying to build an index.)

Anyway, it's currently an idle speculation,

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
