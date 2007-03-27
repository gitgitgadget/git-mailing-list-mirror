From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Support comparing blobs (files) with different names
Date: Tue, 27 Mar 2007 01:56:24 +0100
Message-ID: <200703270256.24295.jnareb@gmail.com>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <200703261912.09445.jnareb@gmail.com> <20070326204116.GB1128@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue Mar 27 02:53:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVzwJ-0007hp-Ls
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 02:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933868AbXC0AxV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 20:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933874AbXC0AxV
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 20:53:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:47606 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933868AbXC0AxU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 20:53:20 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1755691uga
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 17:53:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=V1UzJX1G6b7KWvu0x43gKFzWU5+igZBwBDksMyj0FzA4QR6M3uPP1DgKJy+XbMsdJC2S8fILmQBmbHAGRZWNWp6qlef4XrnIvQ/TGQyLuBPd9wdRdIRyhdYkK8iqCZdzsiKEUxCi87EOg1lIm+5MsEVmYnhIlHlAJptP675JHJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZTMj+GtuEWoR3FYf/k+hLY0Fofw4qayDkVN/+oesV5l6CtfZ19zMEe6W6l2SQfmQQHkC83ZO/kEXTwIGyiBlrLsPqcPFhmADzPfHxcLYHjapE4DTBTUjt7JQm8xq2QP2O+fWqiZ5dtapDQzdCaBTrDVn5HjxubFwwQJkMY72Hhc=
Received: by 10.67.103.7 with SMTP id f7mr42350ugm.1174956799344;
        Mon, 26 Mar 2007 17:53:19 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id y2sm30324634mug.2007.03.26.17.53.17;
        Mon, 26 Mar 2007 17:53:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070326204116.GB1128@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43220>

Martin Koegler wrote:
> On Mon, Mar 26, 2007 at 06:12:09PM +0100, Jakub Narebski wrote:

>> It is done by adding $file_parent ('fp') to the path limiter, meaning
>> that diff command becomes:
>> 
>> 	git diff-tree [options] hpb hb -- fp f
>> 
>> instead of finding hash of a blob using git_get_hash_by_path subroutine
>> or using extended SHA-1 syntax:
>> 
>> 	git diff [options] hpb:fp hp:f
>> 
> 
> As far as I tested, this only works for renames, not
> for comparing different objects, eg:
> 
> git-diff -r -p 08727ea8bba8c81678e5cf15124ada23ad097bc3:grep.h bb95e19c5f1e470d2efe1c0e4e04c291019e4b25:refs.h
> shows differences
> 
> git-diff-tree -r 08727ea8bba8c81678e5cf15124ada23ad097bc3 bb95e19c5f1e470d2efe1c0e4e04c291019e4b25 -- grep.h refs.h
> shows no difference
> 
> As I want gitweb to be able to even do such compares (not just renames),
> I'll still need a solution for this.

Well, I haven't thought about it. Still, it is two lines changed only,
and it fixes a bug in "blobdiff" view for rename diffs.
 
Perhaps mine patch should go to 'maint', and yours to 'master' or 'next'
branch.

> My idea is, that if I got hb:f and hpb:fp, the user exactly specified
> the blobs to be compared. Then I don't want any guessing logic.

I'd rather you reuse the "no hash_parent" code, which also hand-crafts
diffinfo. Perhaps removing "git-diff-tree hpb hb -- f" code entirely.
Besides, code dealing with "blobdiff" coming from "commit", "commitdiff"
and "history" views are tested to work as expected, not so with
arbitrary diffs.

By the way, if you call git_get_hash_by_path (which is expensive, as it
calls git command), you can use resulting hash in place of
hash_base:filename as an argument to git-diff.

-- 
Jakub Narebski
Poland
