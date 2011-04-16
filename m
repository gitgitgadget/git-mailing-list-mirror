From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] combine-diff: use textconv for combined diff format
Date: Sat, 16 Apr 2011 12:24:08 +0200
Message-ID: <4DA96E48.3050008@drmicha.warpmail.net>
References: <20110414213006.GA7709@sigill.intra.peff.net> <36a715a966a22207135f60532e723f6d87dd1ffb.1302881295.git.git@drmicha.warpmail.net> <7voc47cqj0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 12:24:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB2g2-0003O3-95
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 12:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759269Ab1DPKYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 06:24:13 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45532 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758554Ab1DPKYL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2011 06:24:11 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E9020210C3;
	Sat, 16 Apr 2011 06:24:10 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 16 Apr 2011 06:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=xkEa/kTA/VeEq3Ckh40s+5FkgVs=; b=tj9nV2bq3yRYGF3KUzi+b+i9QpxUCZRvqZeE5UGDxzVE0NnGOD9/VrEbFrifRJlY8QRuSQ+886EONVVGBNh9k+p0Q5T5BvtrXImjmuks9bPKlWf3dddc+s09EICwOsa2VCcHrJaz+DlsZ7CX3XxBFAEdZDXLc/G73IHMD/4RLxY=
X-Sasl-enc: Te1VKMygBj66HxADHCufrKK6Oqa54P/rL5qqiZl6BbCa 1302949450
Received: from localhost.localdomain (p54858BE4.dip0.t-ipconnect.de [84.133.139.228])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E4D36443878;
	Sat, 16 Apr 2011 06:24:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7voc47cqj0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171668>

Junio C Hamano venit, vidit, dixit 15.04.2011 20:34:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> git diff -m produces a combined diff!
> 
> Hmm, what is the rest of your command line?  I thought -m was a way to ask
> pairwise diff with each parent.

Sure, but it does not always work like that. Just look at the test from
my patch, or do any "git merge --no-commit" and then "git diff -m". I
would expect that to compare the worktree to each parent, but in fact it
runs "diff --cc".

At least I thought that's the only way how combine-diff would ever have
to deal with a merge result in the worktree as opposed to a blob. And it
seems that "diff -m" does not handle this but relays to "diff --cc" for
current git. I have not checked the "-m" codepath.

>> +static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent, int textconv)
>>  {
>>  	struct diff_queue_struct *q = &diff_queued_diff;
>>  	struct combine_diff_path *p;
>> @@ -34,9 +34,13 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
>>  
>>  			hashcpy(p->sha1, q->queue[i]->two->sha1);
>>  			p->mode = q->queue[i]->two->mode;
>> +			if (textconv)
>> +				p->textconv = get_textconv(q->queue[i]->two);
>>  			hashcpy(p->parent[n].sha1, q->queue[i]->one->sha1);
>>  			p->parent[n].mode = q->queue[i]->one->mode;
>>  			p->parent[n].status = q->queue[i]->status;
>> +			if (textconv)
>> +				p->parent[n].textconv = get_textconv(q->queue[i]->one);
> 
> This code attempts to handle different textconv set for each different
> parents.  But I have to wonder if that is really worth it.
> 
> The attribute to decide the content type of the blob is read from the same
> set of .gitattributes files, regardless of which parent you are looking at
> (and this is not likely to change---the exact procedure that is applied
> comes from .git/config that is not even versioned, so there is not much
> point in reading from the .gitattributes from the parent tree, trying to
> be "precise").
> 
> If q->queue[i] is not a rename, p->textconv and p->parent[n].textconv
> would be the same because one and two came from the same path.  If it is a
> rename, they by definition consist of similar contents, and the user would
> want the same textconv conversion applied to them to make them comparable.
> Even though using p->parent[n].textconv to convert q->queue[i]->one->sha1
> blob and using p->textconv to convert q->queue[i]->two->sha1 blob might be
> the right thing to do in theory, doing so wouldn't make a difference in
> practice.  More importantly, even if the two textconvs specify different
> conversions, it is likely that it is an user error (e.g. the preimage had
> "img4433.jqg" that was renamed to img4433.jpg" in the postimage, and the
> attributes mechanism does not say ".jqg" is a JPEG that wants to get
> "exif" run to be texualized for the purpose of diffing, or something).
> 
> Besides, if you really want to support "left hand side and right hand
> side, depending on which parent we are talking about, may use different
> textconv", you would need to defeat the optimization in show_patch_diff()
> that calls reuse_combine_diff() when sha1 are the same from other parent
> we have already compared---the parent we are looking at may be using a
> different textconv procedure.  Even worse, if parent and child have the
> same sha1, the result of running parent textconv on the parent blob may be
> different from that of the child, which you would never even see in this
> codepath.
> 
> So I suspect that using only one textconv per "struct combine_diff_path"
> would make both the code simpler, and more importantly would make the
> result more correct from the end user's point of view.

I'd be happy to take the simpler approach. While I still think the other
one is "more correct" (modulo the reuse issue) it should not matter in
most cases.

> 
>> @@ -777,6 +783,12 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
>>  			close(fd);
>>  	}
>>  
>> +	if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) && elem->textconv) {
>> +		struct diff_filespec *df = alloc_filespec(elem->path);
>> +		fill_filespec(df, elem->sha1, elem->mode);
>> +		result_size = fill_textconv(elem->textconv, df, &result);
>> +	}
> 
> I suspect that these three lines have to become a small helper function to
> be used to convert the final blob (done here), and parent blob (done in
> combine_diff).  With the "binary" support, it would eventually need to be
> enhanced to something like:
> 
> 	if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV)) {
>         	if (textconv) {
>                 	do these three lines;
> 		} else if (is binary) {
>                 	"Binary blob $SHA-1";
> 		}
> 	}
> 

"diff -m --oneline" says something like

aa01ae1 (from 64c0923) Merge branch 'master' into somebranch
diff --git a/a b/a
index 72594ed..d8323da 100644
Binary files a/a and b/a differ
aa01ae1 (from e85049e) Merge branch 'master' into somebranch
diff --git a/a b/a
index 86e041d..d8323da 100644
Binary files a/a and b/a differ


so I'm wondering whether we shouldn't stay closer to that with "--cc
also", e.g.:

aa01ae1 Merge branch 'master' into somebranch
diff --cc a
index 72594ed,86e041d..d8323da
Binary files a/a and b/a differ

BTW: Currently, "--cc --oneline" produces an extra newline before the
diff line, and also note how the diff lines differ ("a/a b/a" vs. "a").
But those are different issues.

> and having a small helper function early in the series would help that
> process.
> 
>> +		paths = intersect_paths(paths, i, num_parent, DIFF_OPT_TST(opt, ALLOW_TEXTCONV));
> 
> As an internal API within this file, I would rather see "opt" as a whole
> passed to intersect_paths().  We may probably want to determine if the
> blob is binary in that function depending on other "opt" fields.

Yep.
Michael

[Resent today, sorry. Couldn't get myself to reboot that box yesterday
after a disk gave up.]
