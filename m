From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Support comparing blobs (files) with different names
Date: Wed, 28 Mar 2007 00:58:54 +0100
Message-ID: <200703280158.54929.jnareb@gmail.com>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <200703270256.24295.jnareb@gmail.com> <20070327195627.GA23205@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Wed Mar 28 01:56:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWLWd-0004Qw-2P
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 01:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbXC0X4Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 19:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752703AbXC0X4Y
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 19:56:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:6526 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbXC0X4X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 19:56:23 -0400
Received: by nf-out-0910.google.com with SMTP id o25so3430635nfa
        for <git@vger.kernel.org>; Tue, 27 Mar 2007 16:56:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mE3tyBY82dvmDIB5Qv6FXwN5aKu7HKjI40g6nktimVcbu07iaknPTqfLeIJ4zdqqUze1wpYjrc4s6XfvoRXA7r1KqSy0joZjp5pJEbLbs50hLu9MD/gH0kp3kwg13IqsqFnFNyGviD0RMutHASiTFrS3wKT4XVuehWthO4PaJUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hPobEWu4R5Ie4oIWlmKo3+qHaHrefpfTc3oF/MXC5VV4M3IQRKtbiKtVBiTkD/7zp1WC48kLraB4zqrMzfQlPpJteqczipbnfO+mmQNw934nzh0ccqOpOXtwbFbMDU93aqvxIKHdb2cUjo4HIAraNAYZIyAj8GFgTXVyZGeiryE=
Received: by 10.82.177.3 with SMTP id z3mr16944836bue.1175039781606;
        Tue, 27 Mar 2007 16:56:21 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id y6sm28041399mug.2007.03.27.16.56.20;
        Tue, 27 Mar 2007 16:56:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070327195627.GA23205@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43327>

On Thu, Mar 27, 2007, Martin Koegler wrote:
> On Tue, Mar 27, 2007 at 01:56:24AM +0100, Jakub Narebski wrote:
>> Martin Koegler wrote:
>>> My idea is, that if I got hb:f and hpb:fp, the user exactly specified
>>> the blobs to be compared. Then I don't want any guessing logic.
>> 
>> I'd rather you reuse the "no hash_parent" code, which also hand-crafts
>> diffinfo. Perhaps removing "git-diff-tree hpb hb -- f" code entirely.
>> Besides, code dealing with "blobdiff" coming from "commit", "commitdiff"
>> and "history" views are tested to work as expected, not so with
>> arbitrary diffs.
> 
> I don't like the whole rename detection code, so I offer to simplify
> git_blobdiff. For all calls to git_blobdiff (except those from git_history),
> I'm sure, that I can assume $file_parent ||= $file_name.

That was the idea. Perhaps I haven't said it clearly, but I wanted to
suggest to remove the whole git-diff-tree code, and use git-diff to
generate diff between blobs.

> If you think, its safe, I can simplify git_blobdiff. I propose
> doing the following way (pseudo-code):

> $file_parent ||= $file_name;
[...]
> $hash=git_get_hash_by_path($hash_base,$file_name);
[...]
> $hash_parent=git_get_hash_by_path($hash_parent_base,$file_parent);
[...]
>  open $fd, "-|", git_cmd(), "diff", '-p', @diff_opts,
>     $hash_parent, $hash
>     or die_error(undef, "Open git-diff failed");
[...]
> Else I will keep a reworked version of my patch.

The trouble with this is that we may lose mode change (symlink to
ordinary file etc.) because we hand-generate %diffinfo.

>> By the way, if you call git_get_hash_by_path (which is expensive, as it
>> calls git command), you can use resulting hash in place of
>> hash_base:filename as an argument to git-diff.
>  
> I must check, if we need to resolve $hash ($hash_parent) by
> git_get_hash_by_path, if we construct it out of $hash_base and
> $file_name. Maybe we can avoid this call.

We can use "$hash_base:$file_name" as second parameter to git-diff etc.,
but I don't think we want to create links with "$hash_base:$file_name"
instead of sha-1 id of a blob as 'h' parameter.

It can be first implementation, thought, and later we can try to use
"index <hash>..<hash> <mode>" lines from extended header to get $hash
and $hash_parent (with exception of pure rename, but then we need only
one invocation of git_get_hash_by_path subroutine).

But I think it is better left for later patch.
-- 
Jakub Narebski
Poland
