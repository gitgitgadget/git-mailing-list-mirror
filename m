From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Resumable clone/Gittorrent (again)
Date: Wed, 5 Jan 2011 23:23:32 +0700
Message-ID: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 05 17:24:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaW9k-000660-4k
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 17:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801Ab1AEQYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 11:24:06 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63458 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab1AEQYE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 11:24:04 -0500
Received: by wwa36 with SMTP id 36so16461893wwa.1
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 08:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:cc:content-type;
        bh=YiR6V7U7+91skgoYk2G1eB7jIvsgKUwoniamxpixvyQ=;
        b=MHSpUvvflu+twXHj54RBAU7dDpRNpLUkLxO0ECNGVyCF2TbaVD31nGQVAoeWX4/Oi8
         19qSGsxS69IdxtHngoQi+wSY92kcKqarZQAfmlfUcND13QmjnV//AY2pdqze+O/zMacu
         OZTDzWTP7FtO75uGQiXAC6dcQyOOCjgzdedk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=cOD7Z+hcmg/JcLQAoWUN+q3ALV4/rBwcm8uNf3CoR4bJm9zhQOPjHNWj7JEUD4mxzP
         acBAHmHT24nEBN8rHgM37x62WOua2+2jEnqkZQYBTt12j/o9vegf+oG4SihSDG1XQ+jO
         xGa8QjwGTnZ7bcNV0ngi1bDR0HfmNsdd6rPBo=
Received: by 10.216.59.143 with SMTP id s15mr6535232wec.49.1294244642594; Wed,
 05 Jan 2011 08:24:02 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Wed, 5 Jan 2011 08:23:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164569>

Hi,

I've been analyzing bittorrent protocol and come up with this. The
last idea about a similar thing [1], gittorrent, was given by Nicolas.
This keeps close to that idea (i.e the transfer protocol must be around git
objects, not file chunks) with a bit difference.

The idea is to transfer a chain of objects (trees or blobs), including
base object and delta chain. Objects are chained in according to
worktree layout, e.g. all objects of path/to/any/blob will form a
chain, from a commit tip down to the root commits. Chains can have
gaps, and don't need to start from commit tip. The transfer is
resumable because if a delta chain is corrupt at some point, we can
just request another chain from where it stops. Base object is
obviously resumable.

We start by fetching all commit contents reachable from a commit tip.
This is a chain, therefore resumable. From there each commit can be
examined. Missing trees and blobs will be fetched as chains. Everytime
a delta is received, we can recreate the new object and verify it (we
should have its SHA-1 from its parent trees/commits).

Because these chains are quite independent, in a sense that a blob
chain is independent from another blob chain (but requires tree
chains, of course). We can fetch as many as we want in parallel, once
we're done with the commit chain.

The last thing I like about these chains is that the number of chains
is reasonable. It won't increase too fast over time (as compared to
the number of commits). As such it maps well to BitTorrent's "pieces".
When a new gittorrent comes in, a running client can advertise what
chain it has with a bitmap (*).

So it all looks good to me. It is resumable and verifiable. It can be
fetched in parallel from many servers. It maps pretty good to
BitTorrent (which means we can reuse BitTorrent design). All transfer
should be compressed so the amount of transfer is also acceptable (not
as optimized as upload-pack, but hopefully overhead is low). A minor
point is latest commit (in full) will be available as soon as
possible.

One thing about reachability test. In order to avoid this test in an
expensive way every time a chain is requested, the requested chain
must be in SHA-1 extended form, starting from commit tip (e.g.
$SHA1~12^2~34...). Parsing and following that syntax is cheaper, I
hope.

Comments?

[1] http://article.gmane.org/gmane.comp.version-control.git/155222

(*) BitTorrent stores list of pieces in .torrent file. The bitmap
reflects what pieces a client has so other clients can ask for pieces
from it. If we follow the same way, we can create a list of all
possible directories/files in a repository in .gittorrent file, then
gittorrent client can advertise with bitmaps too, perhaps two-bit map
(not fetched, fetching, fully fetched).
-- 
Duy
