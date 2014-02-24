From: ydirson@free.fr
Subject: Re: [RFC/PATCH] Supporting non-blob notes
Date: Mon, 24 Feb 2014 11:27:36 +0100 (CET)
Message-ID: <897120266.591794599.1393237656293.JavaMail.root@zimbra39-e7.priv.proxad.net>
References: <OF15344132.B289BF94-ONC1257C89.003921CB-C1257C89.003E8AF2@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Yann Dirson <dirson@debian.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 24 11:27:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHslK-00036k-OX
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 11:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbaBXK1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 05:27:46 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:60667 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbaBXK1p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 05:27:45 -0500
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
	by smtp1-g21.free.fr (Postfix) with ESMTP id C5A7F940136;
	Mon, 24 Feb 2014 11:27:37 +0100 (CET)
In-Reply-To: <OF15344132.B289BF94-ONC1257C89.003921CB-C1257C89.003E8AF2@local>
X-Originating-IP: [62.23.137.162]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242586>

Johan Herland <johan@herland.net> wrote on 02/24/2014 02:29:10: 
> On Wed, Feb 19, 2014 at 12:10 AM, Duy Nguyen <pclouds@gmail.com> wrote: 
> > On Tue, Feb 18, 2014 at 9:46 PM, Johan Herland <johan@herland.net> wrote: 
> >> On Mon, Feb 17, 2014 at 11:48 AM, <yann.dirson@bertin.fr> wrote: 
> >>> The recent "git-note -C changes commit type?" thread 
> >>> ( http://thread.gmane.org/gmane.comp.version-control.git/241950 ) looks 
> >>> like a good occasion to discuss possible uses of non-blob notes. 
> >>> 
> >>> The use-case we're thinking about is the storage of testrun logs as 
> >>> notes (think: being able to justify that a given set of tests were 
> >>> successfully run on a given revision). 
> >> 
> >> I think this is a good use of notes, and organizing the testrun logs 
> >> into a tree of files seems like a natural way to proceed. 
> > 
> > Notes from the previous attempt to store trees as notes (something to 
> > watch out maybe, when you do it again) 
> > 
> > http://article.gmane.org/gmane.comp.version-control.git/197712 
> 
> Thanks for that link. It is good to see that these issues have been 
> considered/discussed previously. 

Yes, it sheds some useful light on the problem, thanks. 

> I've been thinking about this for a while now, and I find myself 
> agreeing more and more with Junio's argument in the linked thread. 
> 
> I think notes are fundamentally - like file contents from Git's POV - 
> an unstructured stream of bytes. Any real structure in a git note is 
> imposed by the surrounding application/context, and having Git impose 
> its own object model onto the contents of notes would likely be an 
> unnecessary distraction. 

OTOH, it looks like a good idea to allow the surrounding application/context 
to benefit from existing infrastructure. I identified so far: 
(i) diffing/grepping trees 
(ii) efficiency of indexing through notes fanout 
(iii) reachability 
(iv) content packing 

> In Yann's example, the testrun logs are probably best structured as a 
> hierarchy of files, but that does not necessarily mean that they MUST 
> be stored as a Git tree object (with accompanying sub-trees and 
> blobs). For example, one could imagine many different solutions for 
> storing the testrun logs: 
> 
> (a) Storing the logs statically on some server, and putting the 
> corresponding URL in a notes blob. Reachability is manual/on-demand 
> (be retrieving the URL). 

Would require to redo (ii) and (iv) in a way that does not impait (i) 

> (b) Storing the logs in a .tar.gz archive, and adding that archive as 
> a blob note. Reachability is implicit/automatic (by unpacking the 
> archive). 

Interferes with (i) and (iv), ie. does not allow to benefit from similarity 
between the contents of (unpacked) notes. 

> (c) Storing the logs on some ref in an external repo, and putting the 
> repo URL + ref in a notes blob. Reachability is manual/on-demand (by 
> cloning/fetching the repo). 
> (d) Storing the logs on some ref/commit in the same repo, and putting 
> the ref/commit name in a notes blob. Reachability depends on the 
> application/user to sync the ref/commit along with the notes. 

Better than (a), but still does not address (ii). 
And indeed, my intent was to let the notes live in a separate "fork" repo, 
so ordinary users need not fetch the testrun contents systematically with the 
code. 

> (e) Storing the logs in a commit, putting the commit name in a blob 
> note, and then creating/rewriting the notes history to include the 
> commit in its ancestry. Reachability is automatic (i.e.follows the 
> notes), but the application must control/manipulate the notes history. 

And finally, that one does address all points in my case. 

> Whichever of these (or other) solutions is most appropriate depends on 
> the particular application/context, and (from Git's perspective), none 
> of them are inherently superior to any of the other. Even the question 
> of whether testrun logs should or should not be reachable by default, 
> depends on the surrounding application/context. 

Wouldn't it make sense to mention these possibilities in the git-notes 
manpage, to help people use the mechanism as intended ? 

> Now, the intention of Yann's RFC is to store the testrun logs directly 
> in a notes _tree_. This is not too different from alternative (e) 
> above, in that reachability is automatic. However, instead of having 
> the surrounding application manipulate the notes history to ensure 
> reachability, the RFC would rather teach Git's notes code to 
> accomodate the (likely rather special) case of having a note that is 
> BOTH structured like (or at least easily mapped to) a Git tree object, 
> AND that should be automatically reachable. 

Incidently, proposal (e) would allow the use of commits, although 
doing so would probably cause problems, not all of the children of the 
commit used as annotation having the same relationship to their parent. 

Are you suggesting using a slightly different mechanism than 
the "parent" relationship ? 

> Even though there is a certain elegance to storing such a tree object 
> directly as a notes object, there is AFAICS no other inherent 
> advantage (e.g. performance- or functionality-wise) to following that 
> approach. I'm not at all sure that it justifies increasing the 
> complexity of the notes code. 
> 
> Furthermore, considering the RFC's original intention of also making 
> commit and tag objects directly usable as notes, and realizing the 
> fundamental difficulties in teaching Git to handle this (outlined in 
> my previous email in this thread), I must conclude that the simplicity 
> and flexibility of something like alternative (e) above far outweighs 
> the added code complexity to support allowing any object type to be 
> used as a note. 

I was just making the RFC too broad, not having any immediate use for 
commits or tags. You can consider I was just talking about trees :) 

> Maybe we should instead consider making it easier to do alternative 
> (e), by providing a command-line option for supplying additional 
> parents to a notes commit? 

-- 
Yann Dirson - Bertin Technologies / Bertin IT
