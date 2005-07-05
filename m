From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: Last mile for 1.0 again
Date: Tue, 5 Jul 2005 06:34:48 -0700 (PDT)
Message-ID: <20050705133448.21778.qmail@web26309.mail.ukl.yahoo.com>
References: <7v3bqthiso.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 15:36:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dpna6-00059q-1n
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 15:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVGENfA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 09:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVGENfA
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 09:35:00 -0400
Received: from web26309.mail.ukl.yahoo.com ([217.146.176.20]:28092 "HELO
	web26309.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261829AbVGENet (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2005 09:34:49 -0400
Received: (qmail 21780 invoked by uid 60001); 5 Jul 2005 13:34:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4swtR9DB1wfeeVy1nxeOlA5Ei3TGvRRNng+a5XTFu0ONpeCUHSxQSUxTEfG8bZhiYtJGYx3WTAo4X+3dkpDyEfpqQVRRuwNAYE0dlG/YMabpxcBOA9j4tVluDH4zcxdbvJAQdQhajZCronVDkJR4LU6dsDNg5v7NMEcXHsevoEE=  ;
Received: from [195.103.152.66] by web26309.mail.ukl.yahoo.com via HTTP; Tue, 05 Jul 2005 06:34:48 PDT
To: Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <7v3bqthiso.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



--- Junio C Hamano <junkio@cox.net> wrote:

> >>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> DB> [perl script]
> 
> >> How does this work, and what do we do about merges?
> 

Checking diffs of all the parents can be computational expensive. 

I'am developing a different alghoritm for qgit, where I know,
before to run annotate all the revs that changed a given file.

The revs are saved in the shaHist list according to git-rev-list --merge-order.

The algoritm operates form the oldest to the newst calculating annotation for each 
following rev.

This alghoritm takes advantage of the fact that mostly revs belong to 2 categories:

1) revs of the same development-sequence (e.g. connected without merges)

2) empty merges, i.e. merges where the file we are interested in
 is listed in only one merging branch

If a rev in shaHist does not belong to above categories a reach analisys must be performed
in order to find the direct ancestor among all the previous revs in the list.


So starting from shaHist a ReachList rl is populated by getReachability(): 


void Annotate::getReachability(ReachList& rl, const QString& file, const QStringList& shaHist) {

	rl.clear();
	QStringList::const_iterator it = shaHist.begin();
	Rev* r = revLookup(*it);
	rl.append(ReachInfo(*it, r->id, INITIAL));
	for (it++; it != shaHist.end(); it++) {
		
		Rev* r = revLookup(*it);

		// initial revision case
		if (r->parents.count() == 0) {
			rl.append(ReachInfo(*it, r->id, INITIAL));
			continue;
		}
		// merge case
		if (r->parents.count() > 1) { 

			// check empty merges diffing against previous in list
			QString prevSha = rl.last().sha;
			QString d = getFileDiff(*it, prevSha, file);

			if (d.isEmpty()) { 
				rl.append(ReachInfo(*it, r->id, EMPTY_MERGE));
				rl.last().roots.append(prevSha);
			} else {
				// real merge: we need reach test.
				QStringList roots;
				roots.clear();
				for (uint i = 0; i < r->parents.count(); i++) {

					// here tree walking is performed
					QString root = getRoot(r->parents[i], rl);				
					if (!root.isEmpty())
						roots.append(root);
				}
				rl.append(ReachInfo(*it, r->id, MERGE));
				rl.last().roots = roots;
				}
			}
			continue;
		}
		// normal case: a revision with a single parent
		if (r->id == rl.last().id) { // same development sequence

			QString prevSha = rl.last().sha;
			rl.append(ReachInfo(*it, r->id, SAME_BR)); // same branch
			rl.last().roots.append(prevSha);

		} else { // different development sequence

			QString root = getRoot(*it, rl); // <-- here tree walking is performed
			if (!root.isEmpty()) {
				rl.append(ReachInfo(*it, r->id, DIFF_BR));
				rl.last().roots.append(root);
			} else
				qDebug("ASSERT getReachability: rev %s not reachable",
					(*it).latin1());
		}
	}
}


Then ReachList rl is then used to compute correct annotations:


void Annotate::run(const QString& file, const QStringList& shaHist, AnnotateHistory& ah) {

	QString d, diffTarget;
	QStringList t;
	int pos;
	ReachList rl;
	ah.clear();

	getReachability(rl, file, shaHist);  // <-- here ReachList rl is calculated

	for (uint i = 0; i < rl.count(); i++) {

		switch(rl[i].type) { // <-- here ReachList rl is used to find annotations

		case SAME_BR:
		case DIFF_BR:
			diffTarget = rl[i].roots.first();
			d = getFileDiff(rl[i].sha, diffTarget, file);
			pos = shaHist.findIndex(diffTarget);
			ah.append(processDiff(d, ah[pos], getAuthor(rl[i].sha, shaHist)));
			break;
		case INITIAL:
			pos = shaHist.findIndex(rl[i].sha);
			ah.append(getFirstAnnotation(file, shaHist, pos));
			break;
		case EMPTY_MERGE:
			diffTarget = rl[i].roots.first();
			pos = shaHist.findIndex(diffTarget);
			t = ah[pos]; // copy annotation from previous
			ah.append(t);
			break;
		case MERGE:
			// append annotation calculated on first root
			diffTarget = rl[i].roots.first();
			d = getFileDiff(rl[i].sha, diffTarget, file);
			pos = shaHist.findIndex(diffTarget);
			ah.append(processDiff(d, ah[pos], "Merge"));

			// update annotation with all the others roots
			for (uint j = 1; j < rl[i].roots.count(); j++) {

				diffTarget = rl[i].roots[j];
				d = getFileDiff(rl[i].sha, diffTarget, file);
				pos = shaHist.findIndex(diffTarget);

				// create an annotation calculated between root[i] and
				// the merge.
				QStringList scndAnn = processDiff(d, ah[pos],
						 getAuthor(diffTarget, shaHist));

				// finally we unify the two annotations, so we catch
				// also the case of a 3-way merge
				unify(ah.last(), scndAnn);
			}
			break;
		}
	}
}


Advantage of this algorithm is that reach analisys, i.e. tree walking, is
done, statistically, only for a small subset of revs.

Another side benefit is that correct annotation is calculated for each rev and
not only for newest one.

Of course there are issues:

1) A ordered list of revs (file history) must be known in advance. This is not a problem
   for qgit because file history is calculated while loading revs.

2) Does not takes in account file renames.


Hope this notes can help in ongoing discussion

Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
