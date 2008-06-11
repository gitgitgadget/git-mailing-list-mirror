From: "Ben Lynn" <benlynn@gmail.com>
Subject: Re: git bugs
Date: Tue, 10 Jun 2008 22:58:15 -0700
Message-ID: <832adb090806102258v3fd63605p8c45513690b78fe8@mail.gmail.com>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
	 <alpine.LFD.1.10.0806101249580.3101@woody.linux-foundation.org>
	 <832adb090806101609q17a21948nb5814c3b22bd832d@mail.gmail.com>
	 <7v1w34dfn3.fsf@gitster.siamese.dyndns.org>
	 <832adb090806101702l79aba80cvba1eaab029e9ecd5@mail.gmail.com>
	 <alpine.LFD.1.10.0806101834460.3101@woody.linux-foundation.org>
	 <832adb090806101904k5eba3bd6p277c955b1782afbe@mail.gmail.com>
	 <alpine.LFD.1.10.0806101909430.3101@woody.linux-foundation.org>
	 <832adb090806101931y754fa6b7nfcb58a9c34f0c582@mail.gmail.com>
	 <alpine.LFD.1.10.0806101935130.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 07:59:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6JMX-0002UK-Ff
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 07:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbYFKF6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 01:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbYFKF6S
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 01:58:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:2916 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbYFKF6R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 01:58:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2012279fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 22:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SO3ra50FIRS6vqOXGxuUxRqh6iiTrT+pkkiTy/kzK6s=;
        b=bNv5kCo9WKfcxQkVryNQgDLDd9bOZVRxYwae7xBga87dqw1MjDrSIABd9o7/oUu/Po
         hSN6uDcCJolbpejVS2ko4DepTP8Nq5TxkWMChV8JtQ2UZ2PJ0ashlTF5UrFBKrCso6OH
         UHbW0Jg+NKej48nEfQ/6J3ZOEjKQBvyr31Tpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AqzcEqgbwtRDuGMsR8EsBzoWP3DxQuvf+eX8nwjkUnOxIthZG5lvV8c/hXBbVYeelI
         8Oyl6pTlpIgvigACL+dZNhqMAlhRFOEQEDKGAcEme64FdiVFpz6qok/skfOrzz2Qo+X1
         aOjvlgmJw7fQsNX8eZcAv4U07mozo4Vw0Nt/U=
Received: by 10.86.59.18 with SMTP id h18mr6672161fga.30.1213163895892;
        Tue, 10 Jun 2008 22:58:15 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Tue, 10 Jun 2008 22:58:15 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806101935130.3101@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84590>

Am I going crazy? All of a sudden I think I can get away without a
size zero hack. How about this smudging routine:

if (!ce_match_stat_basic(ce, &st)) {
  recompute_sha1_and_update_index();  // no other checks required
}

That should be sufficient. I think what happened was the following.
Once upon a time, the race fix was "if (stats_match) cached_size = 0",
which is nice because you don't have to examine file contents. Later,
because of the

 $ echo xyzzy >frotz ; git-update-index --add frotz ; : >frotz
 $ sleep 3
 $ echo filfre >nitfol ; git-update-index --add nitfol

issue, the ce_modified_check_fs was added.

But then if we're going to be examining file contents anyway, we may
as well drop the whole size zero trick and simply update the hash. The
bug I brought up also goes away.

-Ben

P.S: I could go through the history to see, but I bet there was a
stage after the race condition was discovered but before it was
realized that
  $ git update-index 'foo'
  : modify 'foo' in-place without changing its size
  : wait for enough time
  $ git update-index 'bar'
was a problem.

On Tue, Jun 10, 2008 at 7:39 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Tue, 10 Jun 2008, Ben Lynn wrote:
>>
>> Ah, I hadn't seen that. Yes, it is better to use the first write as
>> the timestamp. Would this catch everything? If the filesystem clock is
>> monotonically increasing and consistent then with this setup, you can
>> touch files even as they are being indexed? (Disregarding nonsense
>> like changing sizes by 2^32.)
>
> Yes, I think that at that point it would protect against arbitrary
> modifications even concurrently to index file creation.
>
> That said, I don't think you even need a new index file format. We could
> just do a stat() on starting the index file creation, and then do a
> futimes() system call at the end to re-set the mtime to the beginning
> before we rename it back over the old index file.
>
>                Linus
>
