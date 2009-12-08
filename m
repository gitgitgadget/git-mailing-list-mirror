From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCHv10 01/11] fast-import: Proper notes tree manipulation
Date: Tue, 08 Dec 2009 03:34:39 +0100
Message-ID: <200912080334.39337.johan@herland.net>
References: <1260185254-1523-1-git-send-email-johan@herland.net>
 <1260185254-1523-2-git-send-email-johan@herland.net>
 <7vocma1ppc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 03:34:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHpuj-0005Oh-HG
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 03:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965402AbZLHCei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 21:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965396AbZLHCeh
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 21:34:37 -0500
Received: from smtp.getmail.no ([84.208.15.66]:50476 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S965390AbZLHCeh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2009 21:34:37 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUB00KSAB5VAB20@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Dec 2009 03:34:43 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUB002EXB5SCZ00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Dec 2009 03:34:43 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.8.22416
User-Agent: KMail/1.12.4 (Linux/2.6.31-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <7vocma1ppc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134804>

On Monday 07 December 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > This patch teaches 'git fast-import' to automatically organize note
> > objects in a fast-import stream into an appropriate fanout structure.
> 
> I really hate to sound like a clueless newbie, but that is what I am in
> the area of 'notes', so I have two questions.
> 
>  - What is the semantics of having more than one note to the same commit
>    in the input stream?  Does the 'notes' part also have history and the
>    latest one overwrite the earlier one by creating a new commit that
>    points at the new 'notes' tree?

Yes.

>    I've always thought of 'notes' as an
>    unversioned metainfo, but I realize that versioning them would make
>    sense (you can and obviously would want to inspect the story behind
>    the current note attached to one particular commit).

Correct.  Since the notes themselves are organized in a regular ref pointing 
to a series of commits, the notes for a particular object are indeed 
versioned.  Thus, the first annotation of a commit will happen as part of a 
commit to the notes ref at some point in time, and a change to that 
annotation will happen as part of a subsequent commit to the same notes ref 
at some later point in time.  The latter annotation naturally replaces the 
former, in the same way as a regular file change causes a new blob to 
replace any blob representing the previous version of the same file.

However, if some object is annotated _twice_ in the _same_ notes commit, 
then only the last annotation will be reachable. (again, this is the same 
behaviour as if a regular file is changed twice in the same commit).

>  - If however 'notes' want to have a history, how would it interact with
>    this rebalancing of the tree?  Rebalancing makes a lot of sense if the
>    'notes' mechanism deals with the only one latest version because it
>    can keep the optimal look-up performance.  There were some talks about
>    specialized merge strategies that can be made aware of rebalancing, but
>    is there a plan to deal with "git log -p notes" side, and how?

For now (at least), most use cases concern themselves only with the last 
version of the notes tree, hence no work has been put into prettifying the 
history of the notes tree.

The notes rebalancing will become part of the same notes commit as the note 
addition/removal that triggers the rebalancing. This does indeed make the 
notes commits themselves somewhat uglier, but since the rebalancing only 
moves notes verbatim from one location to another, it's still fairly simple 
(with judicious use of e.g. "-M") to find the "actual" changes in a notes 
commit.

For now, there is no plan to prettify the log of a notes ref, in order to 
mask away the fanout restructuring. For that matter, there is also no plan 
to hide the fanout structure itself of the notes tree. It is assumed that if 
you need to look at a notes tree directly, you can either deal with the 
implementation details yourself, (or by using future extensions to the notes 
API; see later patches for the beginnings of those...).

With regards to specialized merge strategies: When merging two notes trees 
with no specialized strategy, you might end up with two (or more) notes 
objects annotating the _same_ commit (located at different fanout levels). 
However, this has already been taken care of by the concatenation code at 
the tail of the already-merged early part of jh/notes, which automatically 
concatenates (non-identical) note objects annotating the same commit. Thus, 
no special merge strategy is needed in order to administer notes trees.


Hope this helps,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
